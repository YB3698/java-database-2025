/*
 * 서브쿼리
 * */

SELECT * FROM student;

SELECT * FROM department;

-- 단일행 서브쿼리 : = <> > >= < <=
-- join으로 두 테이블 검색
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.deptno1 = d.DEPTNO
   AND s.deptno1 = 103; -- 고정된 값

-- Anthony Hopkins 학생과 같은 학과에 다니는 학생을 모두 조회
   SELECT * FROM student;
SELECT s.name, d.dname
  FROM student s , department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = (SELECT deptno1
   					  FROM student
   					  WHERE name = 'Anthony Hopkins'); -- 학생 이름 따라 학과번호가 변경 가능
-- WHERE절 서브쿼리에 =로 비교할 때 주의점
-- WHERE절 서브쿼리는 다중행이 되면 안됨
SELECT s.name, d.dname
  FROM student s , department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = (SELECT deptno1
   					  FROM student);

-- 특정 교수의 입사일보다 뒤에 입사한 교수들의 정보 출력
SELECT *
  FROM professor;

SELECT *
  FROM department;


-- 내가 작성한 코드
SELECT p.name AS "PROF_NAME"
	 , TO_CHAR(p.hiredate, 'YYYY-MM-DD') AS "HIREDATE"
	 , d.dname AS "DEPT_NAME"
  FROM PROFESSOR p, DEPARTMENT d 
 WHERE p.deptno = d.deptno
   AND hiredate > (SELECT HIREDATE
 					 FROM PROFESSOR
 					WHERE NAME = 'Meg Ryan');
 
SELECT HIREDATE
  FROM PROFESSOR
 WHERE NAME = 'Meg Ryan';
 
-- 선생님이 작성한 코드
SELECT p.name AS "PROF_NAME"
	 , p.hiredate
	 , d.dname AS "DEPT_NAME"
  FROM professor p, department d
 WHERE p.deptno = d.deptno
   AND p.hiredate > (SELECT hiredate -- 처음엔 *로 전부 조회하고 필요한 컬럼 넣어주기
					   FROM PROFESSOR
					  WHERE name = 'Meg Ryan');

-- 위에 서브쿼리에 넣어줄 값
SELECT hiredate -- 처음엔 *로 전부 조회하고 필요한 컬럼 넣어주기
  FROM PROFESSOR
 WHERE name = 'Meg Ryan';  -- 스칼라값(단일값, 단 하나의 값을 의미)

-- 다중행 서브쿼리
-- IN 서브쿼리 결과와 같은 값. 여러개(OR와 동일)
-- EXISTS 서브쿼리의 값이 있는 경우 메인쿼리를 수행
 -- any, all보단 min, max로 많이 씀
-- >ANY 서브쿼리 최소값보다 메인쿼리의 큰 값을 조회
-- <ANY 서브쿼리 최대값보다 메인쿼리의 작은 값을 조회
-- <ALL 서브쿼리 최소값보다 메인쿼리의 작은 값을 조회 
-- >ALL 서브쿼리 최대값보다 메인쿼리의 큰 값을 조회
 
-- 지역이 Pohang Main Office인 부서코드에 해당하는 직원들의 사번, 이름, 부서번호를 출력하시오
-- 아래 서브쿼리에 넣어줄 값 
 
SELECT *
  FROM emp2;
 
SELECT *
  FROM dept2;

SELECT *
  FROM EMP2 e, DEPT2 d
 WHERE e.deptno = d.dcode(+)

SELECT dcode  
 FROM DEPT2
 WHERE area = 'Pohang Main Office';

SELECT dcode
  FROM DEPT2
 WHERE area = 'Pohang Main Office';


-- 완성된 서브쿼리
SELECT empno, name, deptno
  FROM emp2
 WHERE deptno IN (SELECT dcode
					FROM DEPT2
				   WHERE area = 'Pohang Main Office');

-- emp2 테이블에서 'Section head' 직급의 최소 연봉보다 연봉이 높은 사람의 이름, 직급, 연봉을 출력하시오.
-- 단, 연봉은 $75,000,000 식으로 출력할 것
DELETE FROM EMP2 
 WHERE empno = '2000019';

COMMIT;

SELECT *
  FROM emp2;

SELECT *
  FROM emp2
 WHERE POSITION = 'Section head';

SELECT *
  FROM EMP2
 WHERE EXISTS (SELECT *         -- exists는 자주 쓰는 애는 아님
				 FROM emp2
				WHERE POSITION = 'Section head');
-- 방법1
SELECT name
	 , POSITION
	 , '$' || To_char(pay,'999,999,999') AS "SALARY"
  FROM EMP2
 WHERE pay > (SELECT min(pay)  -- 서브쿼리가 단일행
				FROM emp2
			   WHERE POSITION = 'Section head');
-- 방법2
SELECT name
	 , POSITION
	 , '$' || To_char(pay,'$999,999,999') AS "SALARY"
  FROM EMP2
 WHERE pay >ANY (SELECT pay  -- 서브쿼리가 다중행
				   FROM emp2
			      WHERE POSITION = 'Section head');

-- 다중 컬럼 서브쿼리, 파이썬 튜플과 동일
-- 1~4학년 중 몸무게가 가장 많이 나가는 학생의 정보를 출력하라(4행)
-- 아래에 넣을 서브쿼리
SELECT grade, max(weight)
FROM student
GROUP BY grade;
-- 서브쿼리 넣어줌
SELECT grade, name, height, weight
  FROM student
 WHERE (grade, weight) IN (SELECT grade, max(weight)
							 FROM student
						    GROUP BY grade);

-- 교수 테이블과 학과 department 테이블 조회하여 학과별로 입사일이 가장 오래된 교수의
-- 교수번호, 이름, 학과명을 출력하시오. 입수일 순으로 오름차순
-- 아래에 넣을 서브쿼리
SELECT deptno, min(hiredate)
  FROM professor
 WHERE deptno IS NOT null
GROUP BY deptno;
-- 서브쿼리 넣은 결과
SELECT p.profno AS "교수번호"
     , p.name AS "교수명"
     , d.dname AS "학과명"
     , to_char(p.hiredate, 'YYYY-MM-DD') AS "입사일"
  FROM professor p, department d
 WHERE p.deptno = d.deptno
   AND (p.deptno, p.hiredate) IN (SELECT deptno, min(hiredate)
									FROM professor
								   WHERE deptno IS NOT null
								   GROUP BY deptno)
ORDER BY p.hiredate ASC; -- 정렬

-- 상호연관 쿼리 : 메인쿼리의 컬럼이 서브쿼리의 조건에 들어가는 경우
-- 전체 20명의 평균 연봉
-- 아래에 넣을 서브쿼리 값
SELECT b.POSITION, avg(b.pay)
  FROM emp2 b
GROUP BY b.position;

-- 상호연관 쿼리로 작성
SELECT a.name
     , a.POSITION
     , a.pay
FROM emp2 a
 WHERE a.pay >= (SELECT avg(b.pay)
				   FROM emp2 b
				 WHERE b.POSITION = a.POSITION);

COMMIT;

-- 여기까지가 WHERE절 서브쿼리 --

-- 스칼라 서브쿼리, SELECT절 서브쿼리
-- 부서명을 같이 보려면 join 해야 됨
SELECT *
  FROM emp2 e;
-- 만약 건수가 700만건이라 해도 조인은 한번만 수행함
SELECT e.empno, e.name, e.deptno, d.dname
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.dcode;

-- 조인 없이 스칼라 서브쿼리로 해결
-- 그런데 조인으로 되는 값을 서브쿼리를 쓸 경우 성능에 악영향을 끼침
-- 스칼라 서브쿼리를 쓰면 where 검색을 700만건 수행해야 됨
SELECT e.empno
     , e.name
     , e.deptno
     , (SELECT dname FROM dept2 WHERE dcode = e.deptno) AS "부서명"
  FROM emp2 e;

-- 여기까지가 FROM절 서브쿼리

-- 아래 코드 FROM절 서브쿼리 값
SELECT empno
     , name
     , birthday
     , deptno
     , emp_type
     , tel
FROM emp2;     

-- from절 서브쿼리 작성 방식
SELECT es.empno
     , es.name
  from(SELECT empno
		     , name
		     , birthday
		     , deptno
		     , emp_type
		     , tel
		FROM emp2) es

-- 각 부서별 평균연봉
-- ① 아래 from절 서브쿼리 값
SELECT deptno, sum(pay)
  FROM emp2
  GROUP BY deptno;

-- ② from절 서브쿼리 작성
SELECT grap.deptno, grap.payAvg
  FROM (SELECT deptno, sum(pay) AS payAvg
		  FROM emp2
		GROUP BY deptno) grap;

-- emp2와 위에서 구한 값을 조인해서 평균 연봉보다 얼마씩 차이가 나는지 조회
SELECT e.name
     , e.empno
     , e.POSITIONd
     , e.pay
     , g.payavg
     , (e.pay - g.payavg) AS "평균연봉차액"
  FROM emp2 e, (SELECT deptno, avg(pay) AS payAvg
  				  FROM emp2
  				 GROUP BY deptno) g
 WHERE e.deptno = g.deptno;

-- with절 가상테이블 형태 서브쿼리
-- with절은 파이썬 def절이랑 비슷한 기능을 한다.(with는 가상테이블을, def는 함수를 정의)
WITH g1 AS
(
  SELECT deptno, avg(pay) AS payAvg
    FROM EMP2
  GROUP BY deptno
  )
SELECT e.name
     , e.empno
     , e.POSITION
     , e.deptno
     , e.pay
     , g1.payavg
     , (e.pay - g1.payavg) AS "평균연봉차액"
  FROM emp2 e, g1
 WHERE e.deptno = g1.deptno;

-- 11번 12번은 차이가 없음
-- 사용 빈도 : WHERE절 서브쿼리 > FROM절 서브쿼리 > SELECT절 서브쿼리(사용자정의 함수로 대체)

-- 서브쿼리 사용 시 NULL 값 처리
INSERT INTO emp2(empno, name, birthday, deptno, emp_type, tel)
VALUES (2020000219, 'Ray Osmond', '1988-03-22', '999','Intern','02)909-2345');
COMMIT; -- commit해야 저장됨

SELECT * FROM emp2;

-- 각 직원의 부서명을 같이 출력하라.
-- NULL은 출력을 안하는게 좋음
SELECT name
     , deptno
     , nvl((SELECT dname FROM dept2 WHERE dcode = EMP2.deptno), '부서명없음') AS "부서명"
  FROM emp2
ORDER BY deptno, name;

-- 위 코드 쿼리 조인으로 변경가능
SELECT e.name
     , e.deptno
     , nvl(d.dname, '부서명없음') AS "부서명"
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.dcode(+)
ORDER BY deptno, name;

