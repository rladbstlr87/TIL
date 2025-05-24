### Hadoop/hive/dbeaver 설치 후 접속 루틴
1. hadoop 실행
   `~/hadoop-3.3.6/sbin/start-all.sh`
2. hive 서버 실행 (metastore_db 있는 폴더에서)
   `hiveserver2 --hiveconf hive.server2.thrift.port=10000 --hiveconf hive.root.logger=DEBUG,console`
3. 새로운 터미널 생성 ⇒ beeline 실행
   `!connect jdbc:hive2://localhost:10000`
4. DBeaver 실행
   > localhost 연결
   > HDFS 웹 UI보고싶으면 브라우저에서 `localhost:9870` 접속
