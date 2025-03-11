-- 내장함수

-- 문자(열)함수

-- INTTCAP() : 단어 첫글자 대문자로 변환
SELECT initcap('hello oracle') AS "result"
  FROM dual; -- 실제하지 않는 테이블(Oracle만!)
  
-- LOWER() : 모든 글자를 소문자로, UPPER() : 모든 글자를 대문자로 변환
SELECT LOWER(first_name) AS "first_name"  -- 함수를 사용하면 컴럼에 함수도 같이 출력되기때문에 AS 써주기
     , UPPER(last_name) AS "last_name"
  FROM employees;

-- LENGTH() / LENGTHB() 함수
SELECT LENGTH('Hello oracle')  -- 영어는 글자길이 12
     , LENGTHB('Hello oracle') -- 12bytes
     , LENGTH('반가워요 오라클')   -- 한글 글자길이 8
     , LENGTHB('반가워요 오라클')  -- 22bytes, 한글 7자 * 3bytes = 21byte + 공백 1byte
     , ASCII('A')
     , ASCII('a')
     , ASCII('가')
  FROM dual;

-- CONCAT() == ||와 동일기능
SELECT CONCAT(CONCAT(first_name,' '), last_name) AS "full_name"
  FROM employees;