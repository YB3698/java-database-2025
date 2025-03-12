/*
 * SQL - DML - SELECT 학습
 */

-- 01. HR.employees 테이블의 모든 데이터를 조회하기.(107건 나옴)
SELECT * -- asterik -> all로 발음. 모든 컬럼을 다 보여라.
  FROM employees;

-- 02. HR.employees 중 employee_id, first_name, last_name, email, hire_date를 출력하기 (107행 11열 출력)
SELECT employee_id, first_name, last_name, email, hire_date -- 보고싶은 열의 내용만 출력
  FROM employees;

-- 03. 02번의 쿼리를 컬럼명을 변경해서 출력하기. -> '직원번호', '이름', '성', '이메일','입사일자'로 변경하시오 (107행 11열 출력)
SELECT employee_id AS "직원번호" -- 오라클은 큰따옴표 써주기
     , first_name AS "이름"     -- ,마다 엔터 쳐주기
     , last_name AS "성"
     , email AS "이메일"
     , hire_date AS "입사일자"
  FROM employees;

-- 04. employees에서 job_id가 중복되지 않게 출력하기. (19행 출력)
-- distinct - 중복제거, all(걍 *써주면 됨) - 전부 다
SELECT DISTINCT job_id 
  FROM employees;

-- 05. employees 테이블의 이름과 성을 붙여서 full_name으로, phone_number 출력하기. (107행)
SELECT first_name || ' ' || last_name AS "full_name" -- first_name(성), last_name(이름) ||기호로 열값 합쳐주고 사이에 공백 만들어준뒤(||기호 하나 더 추가해주면 됨) 컬럼이름 변경해주기
	 , phone_number
  FROM employees;

-- 06. employees 테이블 직원들 정보를 아래 주석과 같이 나오도록 출력하기. (107행)
/*
 * full_name(employee_id_ - job_id[hire_data] / phone_number 하나의 컬럼에
 * Steven king(100) - AD_PRES[2023-06-17 00:00:00] / 515.123.4567
 * ...
 */
SELECT first_name || ' ' || last_name || '(' || employee_id || ') -' 
        || job_id || '[' || hire_date || '] / ' || phone_number AS "total info" 
  FROM employees;

/*
 * 조건절 - WHERE
 */ 
-- 연습. employees 테이블에서 employee_id가 110인 직원 출력하기.(1행)
SELECT *
  FROM employees
  WHERE employee_id = 110;

-- 연습. first_name이 John인 직원 출력하기 (3행)
SELECT *
  FROM employees
  WHERE first_name = 'John';

-- 연습. hire_date가 2006-02-12인 직원 출력하기
SELECT *
  FROM employees
  WHERE hire_date = '2006-02-12'; -- 날짜 타입은 문자열처럼 비교하면 됨
  
-- 데이터타입 숫자형, 문자형, 날짜형 등
/*
 * WHER절에 사용하는 연산자
 * ● = : equal. 타 프로그래밍 언어와 달리 = 하나만 사용
 * ● !=, <> : not equal, 같지 않다는 뜻
 * ● >, >=, <, <= : 크다, 크거나 같다, 작다, 작거나 같다
 * ● BETWEEN a AND b : 특정값이 a 이상, b 이하에 포함되어 있다.
 * ● IN(a,b,c) : 특정값이 a이거나 b이거나 c중 하나임
 * ● LIKE : SQL에서 문자 비교시 특화된 연산
 * ● NULL 비교, IS NULL, IS INT NULL : NULL값을 검색할 때, NULL 값이 아닌 걸 검색할 때
 * ● a AND b : a와 b조건 모두 만족해야 True
 * ● a OR b : a와 b 둘 중 하나라도 조건을 만족하면 True
 * ● NOT a : a가 아닌 조건. 반대조건
 */ 
SELECT *
  FROM employees
  WHERE salary BETWEEN 9000 AND 15000;

 -- and와 >= < 똑같이 구현가능(위 코드 결과와 같음)
SELECT *
FROM employees
WHERE salary >= 9000 AND salary <= 15000

SELECT * 
FROM employees
WHERE first_name IN ('John', 'steven', 'Neena');

SELECT *
  FROM employees
  WHERE first_name = 'John' 
  OR first_name = 'Steven'
  OR first_name = 'Neena';

-- NULL 비교

SELECT *
  FROM employees
  WHERE commission_pct = NULL;

SELECT *
  FROM employees
  WHERE commission_pct = NULL;

SELECT *
  FROM employees
 WHERE commission_pct IS NOT NULL;

-- LIKE : 문자열 패턴으로 검색
SELECT *
  FROM employees 
 WHERE job_id IN ('ST_MAN', 'MK_MAN', 'PU_MAN');

-- % 앞에 무슨 글자들이 있던지 상관없이
SELECT *
  FROM employees 
 WHERE job_id LIKE '%man'; -- job_id에서 앞쪽 문자열이 뭐든지 상관없고 man으로 끝나는 문장을 가진 걸 찾아라
 
 SELECT *
   FROM employees
   WHERE last_name LIKE 'Ra%'; -- last_name에서 뒤쪽 문자열이 뭐든 상관없고 Ra로 시작하는 패턴을 가진 문자열을 찾아라
   
 SELECT *
   FROM employees
   WHERE job_id LIKE 'Ra__'; -- job_id에서 총 4글자 중 Ra로 시작하는 패턴을 찾아라
   
SELECT *
  FROM employees
  WHERE job_id LIKE '%MAN%'; -- job_id에서 문자열 내 어디든지 MAN이 들어가는 문자열은 다 찾아라
  
-- 07. employees에서 hire_date 2005-01-01 이후에 입사했고, salary가 10000이상인 직원 출력하기. (9행)
--     이름과 이메일, 전화번호, 입사일, 급여를 표시
SELECT first_name
	 , last_name
	 , phone_number
	 , salary
  FROM employees
 WHERE hire_date > '2005-01-01'
   AND salary >= 10000;

/*
 * 정렬 - ORDER BY
 * ASC - 오름차순
 * DESC - 내림차순
 */
SELECT *
  FROM employees
 ORDER BY salary ASC;

SELECT *
  FROM employees
 ORDER BY commission_pct ASC; -- commision에서 null이 나오면 0.0이라는 뜻. null값은 정렬 안됨
 
 SELECT *
  FROM employees
 ORDER BY job_id ASC, salary DESC; -- 여러개의 컬럼으로 정렬하는 방법
 
/*
 * 집합, UNION, UNION ALL, (IMTERSECT, MINUS : 얘넨 있지만 SQL에서 별로 안씀)
 */
-- SELECT * FROM DEPARTMENTS d
-- departments에서 department_id가 50 이하인 부서아이디와 부서명 데이터
-- employees에서 employee_id가 110에서 150 사이인 직원아이디와 직원명(first_name || last_name)을 합쳐서 출력하기
SELECT department_id, department_name
  FROM departments
 WHERE department_id <= 50
  UNION -- ALL 써줘도 값은 똑같음
SELECT employee_id, first_name || last_name AS "full_name"
  FROM employees
  WHERE employee_id BETWEEN 110 AND 150;
 
