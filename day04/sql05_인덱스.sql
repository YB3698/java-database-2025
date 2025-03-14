/*
 * 인덱스 - DB검색을 효율적으로 빠르게 처리하는 기술
 * */
-- 기본 테이블 생성
CREATE TABLE test_noindex(
  id NUMBER NOT NULL,
  name varchar(20) NOT NULL,
  phone varchar(20) NULL,
  rdate DATE DEFAULT sysdate
);

-- 인덱스 테이블 생성
CREATE TABLE test_index(
  id NUMBER NOT NULL PRIMARY KEY,
  name varchar(20) NOT NULL,
  phone varchar(20) NULL,
  rdate DATE DEFAULT sysdate
);

-- 유니크 인덱스 테이블 생성
CREATE TABLE test_unqindex(
  id NUMBER NOT NULL,
  name varchar(20) NOT NULL UNIQUE,
  phone varchar(20) NULL,
  rdate DATE DEFAULT sysdate
);

-- 인덱스 생성 쿼리 테스트용 테이블 생성
CREATE TABLE test_index2(
  id NUMBER NOT NULL,
  name varchar(20) NOT NULL,
  phone varchar(20) NULL,
  rdate DATE DEFAULT sysdate
);

-- 인덱스 생성 쿼리
CREATE INDEX idx_id ON test_index2(id);

CREATE INDEX idx_id_name2 ON test_index2(id, name);

CREATE INDEX idx_name_phone ON test_index2(name, phone);

/*
 * 인덱스 테스트. 인덱스가 없을 때 검색 쿼리 실행 소요시간,
 *            인덱스 구성 후 검색 쿼리 실행 소요 시간 비교
 * */
-- 인덱스 테스트 sample_t
-- 번호가 중복된게 있는지 확인하는 쿼리
SELECT count(ID1)
  FROM sample_t
 GROUP BY ID1
 HAVING count(ID1) > 1;

SELECT *
  FROM sample_t WHERE ID1 = 10000000;

-- 검색
SELECT *
  FROM sample_t
 WHERE ID1 IN (976453,934564,174555,6785,146789,897554);

SELECT *
  FROM SAMPLE_T;

-- sample_t에 PK추가
ALTER TABLE sample_t ADD PRIMARY KEY(id1);

-- date1번에서 조회
SELECT *
FROM sample_t
WHERE date1 = '20171206';
-- 0.45초 소요. 인덱스 생성 후는 0.019초 소요

CREATE INDEX idx_date1 ON sample_t(date1);

-- test3 컬럼 값 조회
SELECT *
  FROM sample_t
  WHERE test3 = 'A678';

-- autocommit을 끄고 나면 DDL, DML
