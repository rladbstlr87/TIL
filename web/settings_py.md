# timezone
## USE_I18N
Internationalization (국제화) 시간 표시. 이 옵션이 True이면 Django는 다국어 번역 시스템(gettext)을 활성화함.
- LOCALE_PATHS, LANGUAGE_CODE, makemessages, gettext_lazy() 등과 함께 사용
'''py
LANGUAGE_CODE = 'ko'
TIME_ZONE = 'Asia/Seoul'
USE_I18N = True
USE_TZ = True
```
