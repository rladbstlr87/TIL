# ELK Stack
![elk_stack](https://www.guru99.com/images/tensorflow/082918_1504_ELKStackTut1.png)

처음에는 로그를 가져오는게 목적이었고 파일에도 접근할 수 있게 되었음
- 그 외의 플러그인으로 여러가지 방법으로 접근 가능해짐 [input plugin](https://www.elastic.co/docs/reference/logstash/plugins/input-plugins)

## 실행
```
bin/logstash -f ~/damf2/logstash/django_log.conf
```
