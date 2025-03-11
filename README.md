# java-database-2025
Java개발자 과정 Database 리포지토리

## 1일차
- Github Desktop 설치
    - https://desktop.github.com/download/ 다운로드
    - 기존 Github 계정으로 SignIn with Browser
    - Git 명령어 없이 사용가능
- DB(Database) 개요
    - 데이터를 저장하는 장소, 서비스를 하는 서버
    - 데이터베이스를 관리하는 프로그램 DBMS
    - 가장 유명한 것이 Oracle(엑셀이랑 비슷한데 훨씬 더 많은걸 할 수 있음)
    - 사용자는 SQL로 요청, DB서버는 처리결과를 테이블로 리턴
    - SQL 배우기!
- Docker에서 Oracle 설치
    1. powershell 열기
    2. pull 내려받기
    > docker pull oracleinanutshell/oracle-xe-11g
    ```
    3. 다운로드 이미지 확인
    > PS C:\Users\Admin> docker image ls
    REPOSITORY              TAG       IMAGE ID       CREATED        SIZE
    ```
    4. 도커 컨테이너 실행
    > docker run --name oracle11g -d -p 1521:1521 --restart=always oracleinanutshell/oracle-xe-11g
                                                    컴퓨터를 키고 도커를 따로 실행하지 않아도 자동 실행시켜주는 명령어
    ```
    - 1522 - 오라클 기본포트
    - 아이디 : system / oracle
    5. 도커 실행확인
    - Docker Desktop > Containers 확인
    6. powershell 열기
    > docker exec -it oracle11g bash
    
    <img src="./image/dv0001.png" width="650">
    7. DBeaver 접속
        - Connection > Select your DB > Oracle
- DBeaver 툴 설치
    - https://dbeaver.io/download/
- DML, DDL, DCL
    - 언어의 특징을 가지고 있음
        - 프로그래밍 언어와의 차이 - 어떻게(How)
        - SQL - 무엇(What)
    - SQL의 구성요소 3가지
    - DDL(Data Definition Lang) - 데이터베이스 생성, 테이블 생성, 객체 생성, 수정, 삭제
        - CREATE, ALTER, DROP ...
    - DCL(Data Control Lang) - 사용자 권한 부여, 해제, 트랜잭션 시작, 종료
        - GRANT, REVOKE, BEGIN TRANS, COMMIT, ROLLBACK
    - DML(Data Manupulation Lang) - 데이터 조작언어(핵심!), 데이터 삽입, 조회, 수정, 삭제
        - INSERT, SELECT, UPDATE, DELETE
- SELECT 기본
    - 데이터 조회 시 사용하는 기본 명령어
        ```sql
        -- : 기본 주석(한줄일때)
        /* : 여러줄 주석
            여러줄로 주석 작성이 가능하다.*/
            SELECT [ALL|DISTINCT] [*|컬럼명(들)] -- 대소문자 상관없음
                FROM 테이블명(들)
            [WHERE 검색조건(들)]
            [GROUP BY 속성명(들)]
            [HAVING 집계함수조건(들)]
            [ORDER BY 정렬속성(들)]
            [WITH ROLLUP]

- 기본 쿼리 학습 : [SQL](./day01/sql01_select기본.sql)
   1. 기본 SELECT
   2. WHARE 조건절
   3. NULL(!)
   4. ORDER BY 정렬
   5. 집합


## 2일차