# ELK Stack
![elk_stack](https://www.guru99.com/images/tensorflow/082918_1504_ELKStackTut1.png)

## 1. LogStash(데이터 수집)
처음에는 로그를 가져오는게 목적이었고 여러 종류의 파일에도 접근할 수 있게 되었음
- 그 외의 플러그인으로 여러가지 방법으로 접근 가능해짐 [input plugin](https://www.elastic.co/docs/reference/logstash/plugins/input-plugins)
- 특히나 로그를 수집해서 저장하고 분류하며 시각화하면 서비스의 어느 부분에서 어떤 에러가 발생 중인지 즉시 확인 가능한 플로우를 구축할 수 있기 때문에 상당히 중요한 부분이라고 생각한다
### 실행
conf에서 데이터가 어떤 형태로 되어있는지와 어디로 보낼건지를 설정하고 엘라스틱 서치로 밀어넣는 단계
```
bin/logstash -f ~/damf2/logstash/django_log.conf
```

## 2. Elastic Search(데이터 저장 및 검색)

## 3. Kibana(데이터 시각화 및 관리)
로그 데이터를 시각화한다고 하면 특히 대시보드에서 유용하게 사용할 수 있다.
- 500단위의 에러가 어느 경로에서 발생하는지
- 방문자의 전체 요청 중에서 얼마나 많은 비율로 발생하는지 등으로 에러를 즉각적으로 발견하고 조치에 임할 수 있다
