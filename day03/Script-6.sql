/*
 * JOIN
 */
-- 개념
-- 정규화되어 나누어진 테이블의 데이터를 한꺼번에 모아서 쉽게 출력하기 위한 기법
SELECT *
  FROM departments e, departments d
 WHERE e.department_id = d.department_id;

-- 총 데이터수가 2889개 출력
-- 카테시안 곱
SELECT *
  FROM employees e, departments d;

-- 오라클 방식. 표준방식 아님. 편하게 쿼리를 작성하라고 만든 편법.
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;

-- ANSI 표준 문법
SELECT *
  FROM employees e
 INNER JOIN departments d
    ON e.department_id  = d.department_id;

-- 필요 컬럼만 명세
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.department_name
  FROM employee e, departments d
 WHERE e.department_id = d.department_id;

-- 내부 조인(INNER JOIN)
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.department_name
	 , l.city, l.STATE_PROVINCE, l.STREET_ADDRESS
  FROM employee e, departments d, location l
 WHERE e.department_id = d.department_id
   AND l.location_id = d.location_id;
   AND d.department_id = 60;

-- ANSI 표준은 오라클 방식보다 복잡.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
	 , e.email, e.phone_number
	 , e.hire_date, e.job_id
	 , d.department_name
	 , l.city, l.STATE_PROVINCE, l.STREET_ADDRESS
  FROM employee e, departments d, location l
 INNER JOIN departments d
    ON e.department_id = d.department_id
 INNER JOIN locations l  
    ON l.location_id = d.location_id
 WHERE d.department_id =60;

-- 외부조인
-- 보콩 PK와 FK간의 일치하는 조건의 데이터를 찾는 것 - 내부조인
-- PK와 FK간의 일치하지 않는 조건의 데이터도 찾는 것 - 외부조인
-- 테이블1, OUTER JOIN 테이블2
-- 테이블 1번을 기준으로 외부조인 LEFT OUTER JOIN
-- 테이블 2번을 기준으로 외부조인 RIGIHT OUTER JOIN

-- ANSI 표준문법
-- 원하는 값 안뜸
-- employees 테이블에는 있는데 departments테이블에는 없는 데이터를 같이 출력해줌
SELECT *
  FROM employees e
  inner JOIN departments d   
    ON e.department_id = d.department_id
 WHERE e.DEPARTMENT_ID IS NULL;

-- outer join하니까 나옴
SELECT *
  FROM employees e
  LEFT OUTER JOIN departments d  -- OUT 빼도 출력되지만 표준 문법이기 때문에 넣어주기
    ON e.department_id = d.department_id
 WHERE e.DEPARTMENT_ID IS NULL;

-- departments 테이블엔 있는데 employees 테이블에 없는 데이터를 같이 출력해줘
SELECT *
  FROM employees e
  LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id;
	 
-- Oracle 문법
-- (+) 만족하지 않는 조건도 더 나오게 한다는 뜻
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id(+);

-- RIGHT OUTER JOIN
SELECT *
  FROM employees e, departments d
 WHERE e.department_id(+) = d.department_id;

-- INNER JOIN은 INNER 생략 가능
-- OUTER JOIN에만 LEFT, RIGHT 존재하므로 OUTER 생략 가능

-- 셀프조인 : 자기자신을 두번 사용하는 조인
SELECT *
  FROM EMPLOYEES e1, employees e2
 WHERE e1.manager_id = e1.employee_id;



SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
  FROM employees
  
  -- Oracle 문법
 WHERE department_id BETWEEN 30 AND 90
 GROUP BY ROLLUP(department_id, job_id);

SELECT *
  FROM departments;