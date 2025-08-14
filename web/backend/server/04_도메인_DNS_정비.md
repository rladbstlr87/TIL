# 도메인/DNS 정비 — 상황·문제·해결

## 목적과 요구
- 권한 네임서버 기반의 진단 루틴 확립
- www 레코드의 CNAME 혼선을 제거하고 A 레코드로 안정화
- DNS-01용 TXT 전파 이슈의 원인 파악과 운영 기준 수립

---

## 초기 상황
- 도메인 `totheballpark.info`의 권한 네임서버가 `ns1~ns4.hosting.co.kr` 임을 확인해야 함
- 관리자 콘솔에서 www 레코드가 CNAME `@` 형태로 설정되어 공개 리졸버 일부에서 비정상 응답(`\@.`) 관찰
- DNS-01 인증을 위해 여러 차례 TXT를 교체/추가했으나 권한 NS 응답이 최신 토큰을 반영하지 않는 문제 발생

### 관련 명령
```bash
# 권한 네임서버 확인
dig +short NS totheballpark.info @1.1.1.1

# 권한 NS 각각에 직접 질의
for ns in ns1 ns2 ns3 ns4; do
  echo "== ${ns}.hosting.co.kr =="
  dig @${ns}.hosting.co.kr +short A www.totheballpark.info
  dig @${ns}.hosting.co.kr +short TXT _acme-challenge.totheballpark.info
  dig @${ns}.hosting.co.kr +short TXT _acme-challenge.www.totheballpark.info
done
```

---

## 문제 증상
- 공개 리졸버에서 `www.totheballpark.info` 조회 시 `\@.` 응답으로 해석 오류 발생
- TXT 값이 최신 토큰으로 교체되었음에도 권한 NS 응답에 예전 값만 지속 노출
- certbot DNS-01 검증은 권한 NS의 최신 TXT를 요구하므로 반복적으로 `unauthorized` 또는 `incorrect TXT record` 에러 발생

---

## 진단 루틴 확립
- **모든 판단은 권한 네임서버 응답을 기준으로 함**
- 변경 후에는 **ns1~ns4 각각에 직접 질의**하여 동일 응답인지 확인
- 공개 리졸버 캐시와 혼동하지 않도록 1.1.1.1, 8.8.8.8 확인은 보조로만 사용

샘플
```bash
for ns in ns1 ns2 ns3 ns4; do
  echo "== ${ns}.hosting.co.kr =="
  dig @${ns}.hosting.co.kr +short A www.totheballpark.info
done
```

---

## www 레코드 문제 해결
- CNAME `www → @` 구성이 콘솔 및 일부 리졸버에서 비표준 응답을 유발
- www를 **A 레코드 125.243.101.110** 로 명시하여 혼선을 제거
- 권한 NS에서 네 곳 모두 동일 A 응답이 확인될 때까지 전파 확인 절차 수행

검증
```bash
for ns in ns1 ns2 ns3 ns4; do
  echo "== ${ns}.hosting.co.kr =="
  dig @${ns}.hosting.co.kr +short A www.totheballpark.info
done
# 기대값: 각 NS에서 125.243.101.110
```

---

## TXT 전파 이슈 분석과 운영 기준
- 동일 이름의 TXT에 **여러 값이 동시에 존재 가능**하지만, hosting.co.kr 콘솔 동작 특성상 **기존 행을 그대로 두면 예전 값만 퍼블리시되는 케이스**가 관찰됨
- 해결은 아래 두 가지 절차 중 상황에 맞춰 선택
  - 기존 TXT **행을 직접 편집**하여 값을 최신 토큰으로 교체
  - 혹은 새 값 **추가 후 전파 확인**, 권한 NS에서 새 값이 보이면 예전 값 삭제
- certbot은 실행 시점마다 **새 토큰을 요구**하므로, 콘솔 저장과 권한 NS 전파가 끝나기 전에는 certbot을 재시작하지 않도록 절차 고정

체크리스트
- 호스트 이름은 `_acme-challenge` 와 `_acme-challenge.www` 로 정확히 입력
- 값은 따옴표 없이 토큰만 입력
- 저장 후 **ns1~ns4 직접 질의로 일치 확인**
- 실패 로그에 과거 토큰 문자열이 보이면 **예전 값 미삭제 또는 전파 지연**으로 판단

---

## 결과
- 권한 NS 기준의 점검 루틴이 확립되어 변경 직후 상태를 신뢰성 있게 파악 가능
- www 레코드를 A로 고정하여 공개 리졸버 캐시 혼선 제거
- TXT 전파 문제의 재발을 방지하기 위한 콘솔 조작 순서와 검증 절차가 정립

---

## 운영 체크리스트
- `dig +short NS totheballpark.info @1.1.1.1` 로 권한 NS 확인
- 레코드 변경 후 `ns1~ns4` 각각에 직접 질의해 값 일치 확인
- TXT는 기존 행 편집 또는 추가 후 전파 확인 뒤 구행 삭제
- DNS-01을 다시 쓸 경우 certbot 재시작 전 **권한 NS 응답 일치**를 반드시 확인