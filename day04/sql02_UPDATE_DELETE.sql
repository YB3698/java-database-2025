/*
 * UPDATE/DELETE
 * 데이터 변경 / 데이터 삭제
 * */
SELECT count(*) FROM professor_new;
SELECT * FROM professor_new;

DELETE FROM PROFESSOR_NEW
WHERE profno = 1001;

-- 삭제하면 다시 만들기
CREATE TABLE professor_new
AS
SELECT * FROM professor;

-- 삭제시 WHERE절을 빼는 것은 극히 주의!!!!
DELETE FROM PROFESSOR_NEW; -- 삭제 - TRUNCATE 기능과 동일하지만 DELETE는 테이블 초기화가 안됨

-- 변경
-- PROFNO 4002인 수잔 서랜드의 아이드를 기존 Shrandon에서 SusnaS로, 급여를 330에서 350으로 올리기
UPDATE professor_new SET
	   ID = 'SusanS'
     , PAY = 350
 WHERE PROFNO = 4002;

/*
 * 트랜잭션, COMMIT, ROLLBACK
 * */
UPDATE professor_new SET
	   ID = 'SusanS';


   
  