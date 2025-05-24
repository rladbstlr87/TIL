## Command

- `ls`
    > `hdfs dfs -ls /`
    - hdfs dfs =ls <확인하고 싶은 경로>

- `mkdir`
    > `hdfs dfs -mkdir /input`
    - hdfs dfs -mkdir <생성하고 싶은 폴더명>

- `put`
    > `hdfs dfs -put 
    - hdfs dfs -put <(어디에 있는/) 어떤파일을> <어디로>

- `cat`
    - hdfs dfs -cat <출력하고 싶은 파일경로>

- `head`, `tail`
    - hdfs dfs -cat <출력하고 싶은 파일경로>

- `rm`
    > `hdfs dfs -rm /ratings.csv`
    > `hdfs dfs -rm -r /input`
    - hdfs dfs -rm <지울 파일 경로/파일명>
    - 폴더를 삭제할 경우 -r 옵션 추가

- `|`
    > `cat text.txt | python3 mapper.py`
    - 왼쪽의 결과를 | 이쪽으로 넘겨주세요

## 하둡 실행
```shell
hadoop jar ~/hadoop-3.3.6/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar -input /input/text.txt -output /output/wordcount -mapper /home/ubuntu/damf2/hadoop/0.wordcount/mapper.py -reducer /home/ubuntu/damf2/hadoop/0.wordcount/reducer.py
```
- hadoop jar ~/hadoop-3.3.6/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar -input 파일경로/파일명 -output 파일경로/폴더명 -mapper