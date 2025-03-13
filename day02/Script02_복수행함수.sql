/*
 * 복수행, GROUP BY와 가장 많이 사용
 * COUNT(), SUM(), AVG(), MIN/MAX(), STDDEV(), ...
 * ROLLUP, CUBE, BANK ...
 * */
-- COUNT() -- 무지무지 많이 슴
SELECT count(*) -- scalar value
  FROM employees;

-- COUNT() -- 무지무지 많이 씀
SELECT count(employee_id) -- scalar value
  FROM employees;

-- SUM(컬럼값) 합계. 컬럼은 숫자형만
-- 노멀 -> hr -> employees -> data -> 206번째(마지막) 8300 값 삭제
SELECT SUM(salary)
  FROM employees;

-- AVG(숫자형컬럼) 평균
-- 컬럼에 NULL값이 있으면 제외하고 계산하기 때문에 잘못된 값이 도출
-- 금액이나 수량을 계산하는 컬럼의 NULL값은 전처리
SELECT avg(salary)
  FROM employees;

SELECT count(salary)
  FROM employees;

-- MIN(숫자형컬럼), MAX()
SELECT max(first_name), min(salary)
  FROM employees;

/*
 * GROUP BY 연계, 그룹화.
 * GROUP BY를 사용하면 SELECT절에는 GROUP BY 사용한 컬럼과 집계함수 및 일반함수만 사용할 수 있음
 * */
-- 아래의 경우 department_id 이외의 컬럼은 사용불가
SELECT department_id
 	 , avg(salary) AS 부서별평균급여
 	 , to_char(round(avg(salary),1), '99,999.9') AS 부서별평균급여
  FROM employees
 GROUP BY department_id
 ORDER BY avg(salary) DESC;

-- employees에서 부서와 직군별 급여총액과 직원수를 출력하는데
-- department_id가 30에서 90사이이고, 부서직군별급여총액
SELECT department_id, job_id, sum(salary) AS 부서별직군별급여총액
	 , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
-- 	AND sum(salary) >= 20000 -- 집계함수는 where에 사용불가
 GROUP BY department_id, job_id
 ORDER BY department_id;

-- ORDER BY에는 컬럼의 순번(1부터 시작)으로 컬럼명을 대체 가능
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
  GROUP BY department_id, job_id
 HAVING sum(salary) >= 20000
  ORDER BY 3 DESC;

-- ROLLUP 그룹별 소계와 총계를 표시해주는 기능
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
     , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
 GROUP BY ROLLUP (department_id, job_id);

SELECT *
FROM employees;

-- PIVOT() 엑셀에 동일한 기능
-- PIVOT 안쓰고 각 달별로 입사한 사원의 수를 표시. 12행
-- 각 입사일자에서 달만 추출
SELECT to_char(hire_date, 'MM')
 FROM employees;

-- 입사 달별로 그룹핑
SELECT to_char(hire_date, 'MM')
  FROM employees
 GROUP BY to_char(hire_date, 'MM');

-- 1월달에 입사한 사람 카운팅
SELECT CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월" 
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "2월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "3월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "4월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "5월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "6월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "7월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "8월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "9월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "10월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "11월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "12월"
  FROM employees
 GROUP BY to_char(hire_date, 'MM')
 ORDER BY to_char(hire_date, 'MM');

-- decode
SELECT decode(to_char(hire_date, 'MM'), '01', count(*), 0) AS "1월"
	 , decode(to_char(hire_date, 'MM'), '02', count(*), 0) AS "2월"
	 , decode(to_char(hire_date, 'MM'), '03', count(*), 0) AS "3월"
	 , decode(to_char(hire_date, 'MM'), '04', count(*), 0) AS "4월"
	 , decode(to_char(hire_date, 'MM'), '05', count(*), 0) AS "5월"
	 , decode(to_char(hire_date, 'MM'), '06', count(*), 0) AS "6월"
	 , decode(to_char(hire_date, 'MM'), '07', count(*), 0) AS "7월"
	 , decode(to_char(hire_date, 'MM'), '08', count(*), 0) AS "8월"
	 , decode(to_char(hire_date, 'MM'), '09', count(*), 0) AS "9월"
	 , decode(to_char(hire_date, 'MM'), '10', count(*), 0) AS "10월"
	 , decode(to_char(hire_date, 'MM'), '11', count(*), 0) AS "11월"
	 , decode(to_char(hire_date, 'MM'), '12', count(*), 0) AS "12월"
  FROM employees
 GROUP BY to_char(hire_date, 'MM')
 ORDER BY to_char(hire_date, 'MM');

-- RANK() 등수 공동등수 번호 띄우기, DENSE_RNAL() 등수번호가 순차적으로 올라감
-- ROW_NUMBER() 현재 데이터 행번호 출력
SELECT employee_id, last_name, salary
	 , rank() OVER (ORDER BY salary desc) AS "랭크"
	 , dense_rank() OVER (ORDER BY salary desc) AS "덴스랭크" -- 일반적으로 많이 사용
	 , row_number() OVER (ORDER BY salary desc) AS "행번호"
  FROM employees;

SELECT *
FROM (
  SELECT TO_CHAR(hire_date, 'MM') AS hire_month, employee_id
  FROM employees
)
PIVOT (
  COUNT(employee_id)
  FOR hire_month IN (
    '01' AS "1월", 
    '02' AS "2월", 
    '03' AS "3월", 
    '04' AS "4월", 
    '05' AS "5월", 
    '06' AS "6월", 
    '07' AS "7월", 
    '08' AS "8월", 
    '09' AS "9월", 
    '10' AS "10월", 
    '11' AS "11월", 
    '12' AS "12월"
  )
);
SELECT *
  FROM employees;



SELECT employee_id,
       CASE department_id
           WHEN 10 THEN 'Accounting'
           WHEN 20 THEN 'HR'
           ELSE 'Other'
       END AS department_name
FROM employees;


  

	 



 