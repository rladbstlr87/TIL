# TIL - 2025.06.27

## python manage.py collectstatic

Django에서 정적 파일을 STATICFILES_DIRS에서 STATIC_ROOT로 복사하는 명령어. 배포 전에 정적 파일을 하나로 모아 웹 서버가 접근할 수 있도록 준비하는 데 사용.

## settings.py 예시

STATIC_URL = '/static/'
STATICFILES_DIRS = [BASE_DIR / 'static']
STATIC_ROOT = BASE_DIR / 'staticfiles'

## 명령어

python manage.py collectstatic

--noinput 옵션을 사용하면 사용자 확인 없이 자동 실행 가능

python manage.py collectstatic --noinput

## 흔한 오류

PermissionError: staticfiles 디렉토리에 쓰기 권한이 없을 때 발생. 권한 확인 필요

OSError: No such file or directory - STATICFILES_DIRS나 STATIC_ROOT 경로가 잘못되었을 때 발생

같은 파일명이 여러 디렉토리에 있을 경우 어떤 것이 복사될지 예측 어려움

정상 실행했는데도 브라우저에 반영되지 않는 경우는 웹 서버 설정 문제나 캐시 문제일 수 있음

## 기타
- static 디렉토리는 소스코드와 함께 버전관리 함
- staticfiles 디렉토리는 보통 .gitignore에 추가해서 Git으로 버전 관리하지 않음
  - staticfiles는 운영서버에서만 사용되고 명령어에 의한 산출믈이기 때문
  ```
  # If your build process includes running collectstatic, then you probably don't need or want to include staticfiles/
  # in your Git repository. Update and uncomment the following line accordingly.
  # <django-project-name>/staticfiles/
  ```
  라고 gitignore에도 나와있음
