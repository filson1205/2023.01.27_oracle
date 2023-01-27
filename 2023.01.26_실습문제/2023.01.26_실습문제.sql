-- 함수 연습 문제
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT 
       EMP_NAME 직원명
     , RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
  FROM EMPLOYEE;

--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT
       EMP_NAME 직원명
     , JOB_CODE 직급코드
     , TO_CHAR(((SALARY + SALARY*NVL(BONUS, 0))) * 12, 'L999,999,999')연봉
  FROM EMPLOYEE;
       

--3. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 
--	사번 사원명 부서코드 입사일 조회
SELECT
       EMP_ID 사번
     , EMP_NAME 사원명
     , DEPT_CODE 부서코드 
     , HIRE_DATE 입사일
  FROM EMPLOYEE
  WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2004
  AND DEPT_CODE IN('D5','D9');

--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--  단, 주말도 포함함
SELECT 
       EMP_NAME 직원명
     , HIRE_DATE 입사일
     , LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 근무일수
     FROM EMPLOYEE;

--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--     ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
SELECT 
       EMP_NAME 직원명
     , DEPT_CODE 부서코드
     , TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'), 'YY"년" MM"월" DD"일"') 생년월일
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD')) 나이
     FROM EMPLOYEE
     WHERE SUBSTR(EMP_NO, 3, 2) <= 12
       AND SUBSTR(EMP_NO, 5, 2) <= 31;

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, COUNT 사용
--
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------

--SELECT 
--       TO_CHAR(HIREDATE, 'YYYY') AS 년도별
--       , COUNT(*) AS 입사자수 
--       FROM EMPLOYEE
--       GROUP BY TO_CHAR(HIREDATE, 'YYYY')
--       ORDER BY 년도별

--SELECT
--       EXTRACT(YEAR FROM HIRE_DATE) "입사년도"
--     , COUNT(*) 인원수 
--       FROM EMPLOYEE
--       GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
--       ORDER BY "입사년도";
    

--7.  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
--  => case 사용
--	부서코드 기준 오름차순 정렬함.



-- JOIN 연습문제

-- 1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT
       TO_CHAR(TO_DATE('20201225', 'YYYYMMDD'), 'DAY')
       FROM DUAL;
 

-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- ANSI 표준
SELECT
       E.EMP_NAME 사원명
     , E.EMP_NO 주민번호
     , D.DEPT_TITLE 부서명
     , J.JOB_NAME 직급명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE)
  JOIN JOB J ON (J.JOB_CODE = E.JOB_CODE)
  WHERE SUBSTR(EMP_NO, 1, 1) = 7
  AND SUBSTR(EMP_NO, 8, 1) = 2
  AND EMP_NAME LIKE '전%';
       

-- 오라클 전용
SELECT
       E.EMP_NAME 사원명
     , E.EMP_NO 주민번호
     , D.DEPT_TITLE 부서명
     , J.JOB_NAME 직급명
  FROM EMPLOYEE E
     , DEPARTMENT D
     , JOB J 
  WHERE 
  SUBSTR(EMP_NO, 1, 1) = 7
  AND SUBSTR(EMP_NO, 8, 1) = 2
  AND EMP_NAME LIKE '전%'
  AND D.DEPT_ID = E.DEPT_CODE
  AND J.JOB_CODE = E.JOB_CODE;


-- 3. 가장 나이가 적은 직원의 사번, 사원명, 
--    나이, 부서명, 직급명을 조회하시오.
-- ANSI 표준

              
-- ORACLE 전용


-- 4. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 부서명을 조회하시오.
-- ANSI 표준


-- 오라클 전용


-- 5. 해외영업팀에 근무하는 사원명, 
--    직급명, 부서코드, 부서명을 조회하시오.
-- ANSI표준


-- 오라클 전용


-- 6. 보너스포인트를 받는 직원들의 사원명, 
--    보너스포인트, 부서명, 근무지역명을 조회하시오.
-- ANSI표준


-- 오라클 전용


-- 7. 부서코드가 D2인 직원들의 사원명, 
--    직급명, 부서명, 근무지역명을 조회하시오.
-- ANSI 표준

-- 오라클 전용


-- 8. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
--    연봉에 보너스포인트를 적용하시오.
-- ANSI 표준


-- 오라클 전용


-- 9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.
-- ANSI 표준


-- 오라클 전용


-- 10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 
--     동료이름을 조회하시오.self join 사용
-- ANSI 표준


-- 오라클 전용


-- 11. 보너스포인트가 없는 직원들 중에서 직급코드가 
--     J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
--     단, join과 IN 사용할 것
-- ANSI 표준


-- 오라클 전용


--12. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.