# 오늘 정리 (WSL + cron 동작 조건)

- 로컬 WSL에서 crontab이 돌려면 **3가지**가 동시에 충족돼야 합니다.  
  1) **PC가 켜져 있고 깨어 있음**(절전/최대절전 금지)  
  2) **WSL 배포판 상태 = Running**  
  3) **WSL 내부 cron 서비스 = Active(running)**  
- 24/7 필요 시: **EC2**에서 실행하거나, **Windows 작업 스케줄러 + 깨우기**를 함께 구성하는 방법이 안정적입니다.

---

## 상태 확인/시작

### Windows PowerShell → `PS C:\>`
```powershell
wsl -l -v        # STATE가 Running이면 WSL 배포판이 실행 중
wsl -d Ubuntu    # 배포판 실행(또는 시작 메뉴에서 Ubuntu 열기)
```

### WSL Ubuntu 셸 → `user@...:~$`
```bash
# systemd 사용 시
systemctl status cron

# systemd 미사용 시(WSL 옛 구성)
service cron status
```

---

## systemd로 cron 상시 구동 (권장)

### WSL Ubuntu 셸 → `user@...:~$`
```bash
sudo nano /etc/wsl.conf
# 아래 내용 추가/확인
# [boot]
# systemd=true
```

### Windows PowerShell → `PS C:\>`
```powershell
wsl --shutdown    # WSL 전체 종료
wsl               # 다시 시작
```

### WSL Ubuntu 셸 → `user@...:~$`
```bash
sudo systemctl enable --now cron
systemctl is-active cron   # 'active'면 정상
```

---

## systemd 없이 유지해야 할 때(임시 유지 요령)

### WSL Ubuntu 셸 → `user@...:~$`
```bash
# 세션 유지 트릭(터미널 닫아도 백그라운드 유지)
nohup sleep infinity >/dev/null 2>&1 &
# 또는 tmux/screen 사용
```

---

## 참고

- **전원 관리**에서 절전 진입을 막아야 예약 작업이 끊기지 않습니다.  
- cron 동작 확인은 작업 로그를 남기게 설정하거나(예: 스크립트에서 `>> /path/log 2>&1`)  
  Ubuntu 기준 `/var/log/syslog`에서 `CRON` 키워드로 확인 가능합니다.
