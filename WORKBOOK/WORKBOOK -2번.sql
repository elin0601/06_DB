-- 1번
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를
-- 입학 년도가 빠른 순으로 표시하는 SQL을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, 
	TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD') 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;


-- 2번 
-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다. 
-- 그 교수의 이름과 주민번호를 조회하는 SQL을 작성하시오.
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';


-- 3번 *
-- 춘 기술대학교의 남자 교수들의 이름과 나이를 나이 오름차순으로 조회하시오.
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름"으로 한다. 
-- 나이는 '만'으로 계산한다.)
SELECT PROFESSOR_NAME 교수이름, 
FROM TB_PROFESSOR;


-- 4번 *
-- 교수들의 이름 중 성을 제외한 이름만 조회하시오. 출력 헤더는 "이름"이 찍히도록 한다.
-- (성이 2자인 경우의 교수는 없다고 가정)
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_NAME, 2, 3) ;


-- 5번 *
-- 춘 기술대학교의 재수생 입학자를 조회하시오.
-- (19살에 입학하면 재수를 하지 않은 것!)
SELECT STUDENT_NO ,STUDENT_NAME, 
	TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD'),
	TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')
FROM TB_STUDENT;







