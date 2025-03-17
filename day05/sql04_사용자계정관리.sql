/*
 * 사용자 생성, 기존 사용자 사용해제, 권한주기
 * */

-- HR 계정 잠금해제
ALTER USER hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY 12345;

SELECT * 
  FROM employees;

-- PRIVILEGES 권한
-- CREATE SESSION - 접속권한
-- CREATE TABLE, ALTER ANY TABLE, DROP ANY TABLE, ..
-- 권한은 하나하나 다 부여해야됨

/*
-- SCOTT 계정 잠금해제
-- 무조건 할 수 있는게 아님
- SCOTT은 CREATE SESSION 권한 없음. LOGON DENIED.
- 계정이 없음
ALTER USER scott ACCOUNT UNLOCK;

-- scott에 접속 권한 부여
GRANT CREATE SESSION TO scott;
*/

SELECT *
FROM jobs;

CREATE VIEW JOBS_VIEW
AS
SELECT *
  FROM jobs;

-- hr 계정에 어떤 권한이 있는지 조회
SELECT *
  FROM USER_TAB_PRIVS;

-- HR로 테이블 생성
CREATE TABLE TEST(
	id NUMBER PRIMARY KEY,
	name varchar(20) NOT null
);

-- Role(역할) 관리
-- 여럭 권한을 묶어 놓은 개념
-- role 확인
-- CONNECT - DB 접속 및 테이블 생성 조회 권한
-- RESOURCE - PL/SQL 사용권한
-- DBA - 모든 시스템 권한
-- EXP_FULL_DATABASE - DB 익스포트 권한...
SELECT *
  FROM user_role_privs;

SELECT *
  FROM dba_role_privs;


-- HR에게 DBA 역할 roel 부여
GRANT DBA TO hr;
-- SAMPLEUSER 조회되는지 확인
SELECT * FROM SAMPLEUSER.MEMBER;

-- HR에게 DBA역할 권한 해제
REVOKE DBA FROM hr;

