-- TB_GRADE 테이블 생성
CREATE TABLE TB_GRADE (
    GRADE_CODE VARCHAR2(10) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20)
);

-- TB_AREA 테이블 생성
CREATE TABLE TB_AREA (
    AREA_CODE VARCHAR2(10) PRIMARY KEY,
    AREA_NAME VARCHAR2(20)
);

-- TB_MEMBER 테이블 생성
CREATE TABLE TB_MEMBER (
    MEMBERID VARCHAR2(20) PRIMARY KEY,
    MEMBERPWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(50),
    GRADE VARCHAR2(10),
    AREA_CODE VARCHAR2(10),
    FOREIGN KEY (GRADE) REFERENCES TB_GRADE(GRADE_CODE),
    FOREIGN KEY (AREA_CODE) REFERENCES TB_AREA(AREA_CODE)
);

-- 데이터 삽입
-- TB_GRADE 테이블 데이터 삽입
INSERT INTO TB_GRADE (GRADE_CODE, GRADE_NAME) VALUES ('10', '일반회원');
INSERT INTO TB_GRADE (GRADE_CODE, GRADE_NAME) VALUES ('20', '우수회원');
INSERT INTO TB_GRADE (GRADE_CODE, GRADE_NAME) VALUES ('30', '특별회원');

-- TB_AREA 테이블 데이터 삽입
INSERT INTO TB_AREA (AREA_CODE, AREA_NAME) VALUES ('02', '서울');
INSERT INTO TB_AREA (AREA_CODE, AREA_NAME) VALUES ('031', '경기');
INSERT INTO TB_AREA (AREA_CODE, AREA_NAME) VALUES ('032', '인천');

-- TB_MEMBER 테이블 데이터 삽입
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('hong01', 'pass01', '홍길동', '10', '02');
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('leess99', 'pass02', '이순신', '10', '032');
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('SS50000', 'pass03', '신사임당', '30', '031');
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('1u93', 'pass04', '아이유', '30', '02');
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('pcs1234', 'pass05', '박철수', '20', '031');
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('you_is', 'pass06', '유재석', '10', '02');
INSERT INTO TB_MEMBER (MEMBERID, MEMBERPWD, MEMBER_NAME, GRADE, AREA_CODE) VALUES ('kyh9876', 'pass07', '김영희', '20', '031');


-- 모든 회원의 이름과 등급을 조회하기
SELECT MEMBER_NAME , GRADE_NAME
FROM TB_MEMBER m
JOIN TB_GRADE g ON m.GRADE = g.GRADE_CODE;

-- 등급이 일반회원인 회원을 조회
SELECT *
FROM TB_MEMBER 
WHERE GRADE = 10;

-- 경기 지역에 거주하는 회원이 아이디와 이름 조회하기
SELECT MEMBERID , MEMBER_NAME
FROM TB_MEMBER
WHERE AREA_CODE = 031;

-- 등급이 우수회원이고 
-- 이름에 '이'가 포함된 회원의 이름을 조회하기

-- SELECT 문을 사용해서 회원의 이름만 조회하기
SELECT MEMBER_NAME 
FROM TB_MEMBER
WHERE GRADE = 20 
AND MEMBER_NAME LIKE '%이%';
-- 어디서 회원의 이름을 가져올 것인가?
--> TB_MEMBER 테이블에서 회원의 이름을 FROM 을 사용해서 가져옴

-- 등급이 우수회원이고 이름에 '이'가 포함되어야함
--> 어떻게 우수회원이고 이름에 '이'가 포함되는지 확인할 것인가?


-- 등급이 '일반회원'인 회원의 이름을 알파벳 순으로 정렬해서 조회하기
SELECT MEMBER_NAME
FROM TB_MEMBER 
WHERE GRADE = 10
ORDER BY MEMBER_NAME;

-- 등급이 '특별회원' 이고 이름에 '신'이 포함된 회원의 아이디와 이름 조회하기
SELECT MEMBERID , MEMBER_NAME
FROM TB_MEMBER 
WHERE GRADE = 30
AND MEMBER_NAME LIKE '%신%';

-- '서울' 지역에  거주하고 '일반회원' 등급 회원의 이름 조회
SELECT MEMBER_NAME
FROM TB_MEMBER m
JOIN TB_AREA a ON m.AREA_CODE = a.AREA_CODE
JOIN TB_GRADE g ON m.GRADE = g.GRADE_CODE
WHERE g.GRADE_NAME = '일반회원'
AND a.AREA_NAME  = '서울';

-- 특정 지역의 회원수 조회
SELECT AREA_NAME , COUNT(*)
FROM TB_MEMBER
JOIN TB_AREA USING (AREA_CODE)
GROUP BY AREA_NAME;

-- 특정 회원의 지역 정보 조회
SELECT MEMBER_NAME , AREA_NAME
FROM TB_MEMBER
JOIN TB_AREA USING (AREA_CODE)
GROUP BY MEMBER_NAME, AREA_NAME;

-- 일반회원과 우수회원 수 비교
SELECT GRADE_NAME , COUNT(*)  
FROM TB_MEMBER
JOIN TB_GRADE ON (GRADE_CODE=GRADE)
GROUP BY GRADE, GRADE_NAME
HAVING GRADE IN (10, 20);

-- SS50000 회원의 등급과 이름 조회
SELECT GRADE_NAME , MEMBER_NAME 
FROM TB_MEMBER 
JOIN TB_GRADE ON (GRADE_CODE=GRADE)
WHERE MEMBERID = 'SS50000';


-- SELECT 서브쿼리 활용한 예제
-- TB_MEMBER 테이블에서 GRADE가 우수회원 이면서
-- AREA_CODE 가 '031'인 회원의 회원 이름 조회하기
SELECT MEMBER_NAME
FROM TB_MEMBER 
WHERE GRADE = (
	SELECT GRADE_CODE
	FROM TB_GRADE
	WHERE GRADE_NAME = '우수회원'
)
AND AREA_CODE = 031;


-- TB_MEMBER 테이블에서
-- GRADE가 일반 회원이면서
-- AREA_CODE가 02가 아닌 회원의 아이디를 조회 !
SELECT MEMBERID
FROM TB_MEMBER 
WHERE GRADE = (
	SELECT GRADE_CODE
	FROM TB_GRADE
	WHERE GRADE_NAME = '일반회원'
)
AND AREA_CODE != 02;


-- TB_MEMBER 테이블에서 GRADE가 특별회원이면서
-- AREA_CODE가 031이 아닌 회원들의 회원 이름 조회하기
SELECT MEMBER_NAME 
FROM TB_MEMBER 
WHERE GRADE = (
	SELECT GRADE_CODE
	FROM TB_GRADE 
	WHERE GRADE_NAME = '특별회원'
)
AND AREA_CODE != 031;


-- TB_MEMBER 테이블에서 
-- AREA_CODE가 031 이거나 032인 
-- 회원들의 이름 조회하기
SELECT MEMBER_NAME
FROM TB_MEMBER
WHERE AREA_CODE IN(031, 032);


-- SELECT, ROWNUM을 활용한 예제

-- ROWNUM 이란?
--> SELECT 회원 데이터에 번호를 붙이는 것
--> 번호를 붙여 원하는 만큼의 갯수만 가져오고 싶을 때 사용

-- TB_MEMBER 회원들 중에서 ROWNUM이 3 이하인 데이터 조회!
SELECT * 
FROM TB_MEMBER
WHERE ROWNUM <= 3;


-- TB_MEMBER 테이블에서 
-- 지역 코드가 031인 회원 중에서 
-- 처음 3명의 아이디와 이름 조회하기
SELECT MEMBERID , MEMBER_NAME 
FROM TB_MEMBER 
WHERE ROWNUM <=3 AND AREA_CODE = 031;


-- TB_MEMBER 이름순으로 상위 3개 멤버 조회하기
SELECT MEMBERID, MEMBER_NAME
FROM (
	SELECT MEMBERID , MEMBER_NAME, ROWNUM AS RN
	FROM TB_MEMBER 
	ORDER BY MEMBER_NAME
)
WHERE RN <= 3;


/***************************************************************************/
-- SQL 활용 시험 풀이
SELECT AREA_NAME 지역명, MEMBERID 아이디, MEMBER_NAME 이름, GRADE_NAME 등급명
FROM TB_GRADE
JOIN TB_MEMBER ON(GRADE = GRADE_CODE)
JOIN TB_AREA USING (AREA_CODE)
WHERE AREA_CODE = (
	SELECT AREA_CODE FROM TB_MEMBER
	WHERE MEMBER_NAME = '김영희')
ORDER BY 이름;
/***************************************************************************/


-----------------------------------------------------------------------------
-- [연습문제]

--1: TB_AREA 테이블에서 지역 코드가 '02'인 지역의 이름을 조회
SELECT AREA_NAME
FROM TB_AREA 
WHERE AREA_CODE = 02;

--2: TB_AREA 테이블에서 지역 코드가 '02'인 지역의 이름을 조회
SELECT AREA_NAME
FROM TB_AREA 
WHERE AREA_CODE = 02;

--3: TB_MEMBER 테이블에서 모든 회원의 이름과 등급을 조회
SELECT MEMBER_NAME , GRADE
FROM TB_MEMBER;

--4: TB_MEMBER 테이블에서 이름이 '이순신'인 회원의 아이디를 조회
SELECT MEMBERID
FROM TB_MEMBER 
WHERE MEMBER_NAME = '이순신';

--5: TB_MEMBER 테이블에서 등급이 '20'인 회원의 이름과 지역 코드를 조회
SELECT MEMBER_NAME , AREA_CODE
FROM TB_MEMBER
WHERE GRADE = 20;

--6: TB_MEMBER 테이블에서 지역이 '서울'인 회원의 아이디와 이름을 조회
SELECT MEMBERID , MEMBER_NAME
FROM TB_MEMBER
JOIN TB_AREA USING (AREA_CODE)
WHERE AREA_NAME = '서울';

--7: TB_MEMBER 테이블에서 등급이 '특별회원'인 회원의 수를 조회
SELECT COUNT(*)
FROM TB_MEMBER
JOIN TB_GRADE ON (GRADE_CODE = GRADE)
WHERE GRADE_NAME = '특별회원';

--8: TB_MEMBER 테이블에서 이름이 '홍길동'이거나 '박철수'인 회원의 아이디를 조회
SELECT MEMBERID
FROM TB_MEMBER
WHERE MEMBER_NAME IN ('홍길동' , '박철수');

--9: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 지역 코드가 '031'인 회원의 이름을 조회
SELECT MEMBER_NAME
FROM TB_MEMBER 
JOIN TB_GRADE ON (GRADE_CODE = GRADE)
WHERE GRADE_NAME = '우수회원' 
AND AREA_CODE = 031;

--10: TB_MEMBER 테이블에서 아이디가 'kyh9876'인 회원의 등급을 조회
SELECT GRADE_NAME
FROM TB_MEMBER 
JOIN TB_GRADE ON (GRADE_CODE = GRADE)
WHERE MEMBERID = 'kyh9876';

--11: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 지역이 '경기' 또는 '인천'인 회원의 아이디와 이름을 조회
SELECT MEMBERID , MEMBER_NAME
FROM TB_GRADE
JOIN TB_MEMBER ON (GRADE_CODE = GRADE)
JOIN TB_AREA USING (AREA_CODE)
WHERE GRADE_NAME = '일반회원'
AND AREA_NAME IN ('경기' , '인천');

--12: TB_MEMBER 테이블에서 등급이 '특별회원'인 회원 중에서 지역이 '서울'이 아닌 회원의 수를 조회
SELECT COUNT(*)
FROM TB_GRADE
JOIN TB_MEMBER ON (GRADE_CODE = GRADE)
JOIN TB_AREA USING (AREA_CODE)
WHERE GRADE_NAME = '특별회원'
AND AREA_NAME != '서울';

--13: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름이 '김영희'인 회원의 등급과 지역을 조회
SELECT GRADE_NAME , AREA_NAME 
FROM TB_GRADE
JOIN TB_MEMBER ON (GRADE_CODE = GRADE)
JOIN TB_AREA USING (AREA_CODE)
WHERE GRADE_NAME = '우수회원' AND MEMBER_NAME = '김영희';

--14: * TB_MEMBER 테이블에서 등급이 '일반회원'이고 지역이 '경기'인 회원 중에서 가입일이 2024년 3월 1일 이후인 회원의 이름을 조회
SELECT MEMBER_NAME
FROM TB_MEMBER
WHERE AREA_CODE = 031 
AND GRADE = 10
AND JOIN_DATE > TO_DATE('2024-03-01', 'YYY-MM-DD'); -- 오류나는게 정상임

--15: TB_MEMBER 테이블에서 등급이 '특별회원'이면서 아이디가 'SS50000'이거나 '1u93'인 회원의 지역을 조회
SELECT AREA_NAME, MEMBERID
FROM TB_MEMBER 
JOIN TB_AREA USING (AREA_CODE)
WHERE GRADE = 30 
AND MEMBERID IN ('SS50000' , '1u93');

--16: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름에 '유'가 포함된 회원의 아이디를 조회
SELECT MEMBERID
FROM TB_MEMBER 
WHERE GRADE = 20
AND MEMBER_NAME LIKE '%유%';

--17: * TB_MEMBER 테이블에서 등급이 '일반회원'이면서 가입일이 현재 날짜보다 이전인 회원의 수를 조회
SELECT COUNT(*)
FROM TB_MEMBER
WHERE GRADE = 10
AND "내가 나중에 사용자가 가입한 날짜를 표시해줄 이름을 작성" > SYSDATE; -- 오류나는게 정상임

--> JOIN_DATE : 사용자가 가입한 날짜를 나타냄
--> SYSDATE : 내 컴퓨터에서 보이는 현제 날짜, 현재 시간
--> TO_DATE : 'YYYY-MM-DD' 문자열로 저장된 날짜를 DATE 형식으로 변환하는 함수
--> YYY MM DD : 년 월 일 표시
--> hh mm ss : 시 분 초


--18: TB_MEMBER 테이블에서 등급이 '특별회원'이면서 가장 오래된 회원의 아이디를 조회
SELECT MEMBERID
FROM TB_MEMBER 
WHERE GRADE = 30 AND ROWNUM = 1;

--19: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름이 '신사임당'이 아닌 회원의 수를 조회
SELECT COUNT(*) 
FROM TB_MEMBER 
WHERE GRADE = 20 
AND MEMBER_NAME != '신사임당';

--20: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 지역이 '서울'인 회원의 이름과 등급을 조회 단, 결과를 등급에 따라 내림차순으로 정렬
SELECT MEMBER_NAME , GRADE_NAME
FROM TB_MEMBER 
JOIN TB_GRADE ON (GRADE_CODE = GRADE)
WHERE GRADE = 10 AND AREA_CODE = 02
ORDER BY GRADE DESC; -- 오름차순 : ASC , 내림차순 DESC

--21: TB_MEMBER 테이블에서 회원 이름의 길이가 4 이상인 회원의 아이디와 이름을 조회
SELECT MEMBER_NAME, MEMBERID 
FROM TB_MEMBER 
WHERE LENGTH (MEMBER_NAME) >= 4;

--22: TB_MEMBER 테이블에서 등급이 '특별회원'이면서 이름이 '김영희'가 아닌 회원의 아이디를 조회
SELECT MEMBERID
FROM TB_MEMBER
WHERE GRADE = 30 
AND MEMBER_NAME != '김영희';

--23: TB_MEMBER 테이블에서 등급이 '일반회원'인 회원 중에서 이름이 '김영희'이거나 '아이유'인 회원의 수를 조회
SELECT COUNT(*) 
FROM TB_MEMBER 
WHERE GRADE = 10
OR MEMBER_NAME IN ('김영희', '아이유');

--24: TB_MEMBER 테이블에서 등급이 '특별회원'이 아니면서 이름이 '홍길동'이 아닌 회원의 아이디를 조회
SELECT MEMBERID
FROM TB_MEMBER 
WHERE GRADE != 30
AND MEMBER_NAME != '홍길동';

--25: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 지역이 '인천' 또는 '경기'인 회원의 아이디와 이름을 조회
SELECT MEMBERID , MEMBER_NAME
FROM TB_MEMBER 
WHERE GRADE = 10
AND AREA_CODE IN (032, 031);

--26: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 이름이 '홍길동'이 아니면서 가장 최근에 가입한 회원의 아이디를 조회
SELECT MEMBERID 
FROM TB_MEMBER
WHERE GRADE = '20'
AND MEMBER_NAME != '홍길동'
AND MEMBERID = (
	SELECT MAX(MEMBERID) 
	FROM TB_MEMBER 
	WHERE GRADE = '20');

--27: TB_MEMBER 테이블에서 등급이 '우수회원'이면서 가장 최근에 가입한 회원의 이름을 조회
SELECT MEMBERID 
FROM TB_MEMBER
WHERE GRADE = '20' 
AND MEMBERID = (
	SELECT MAX(MEMBERID) 
	FROM TB_MEMBER 
	WHERE GRADE = '20');

--28: TB_MEMBER 테이블에서 등급이 '일반회원'이면서 이름에 '김'이 들어가는 회원의 수를 조회
SELECT COUNT(*) 
FROM TB_MEMBER 
WHERE GRADE = 10
AND MEMBER_NAME LIKE '%김%';

--29: TB_MEMBER 테이블에서 등급이 '특별회원'이 아닌 회원의 수를 조회
SELECT COUNT(*) 
FROM TB_MEMBER 
WHERE GRADE = 30;

--30: TB_MEMBER 테이블에서 등급이 '우수회원'인 회원 중에서 아이디가 가장 큰 회원의 이름을 조회
SELECT MEMBER_NAME 
FROM TB_MEMBER 
WHERE GRADE = 20
AND MEMBERID = (
	SELECT MAX(MEMBERID) 
	FROM TB_MEMBER 
	WHERE GRADE = '20');

--31: 모든 회원의 이름과 등급을 조회
SELECT MEMBER_NAME , GRADE 
FROM TB_MEMBER;

--32: ​서울에 거주하는 모든 회원의 이름과 등급을 조회
SELECT MEMBER_NAME , GRADE 
FROM TB_MEMBER  
WHERE AREA_CODE = 02;

--33: ​우수회원인 회원들의 이름과 등급을 조회
SELECT MEMBER_NAME , GRADE 
FROM TB_MEMBER 
WHERE GRADE = 20;

--34: ​특별회원 중에서 이름에 '이'가 들어가는 회원들의 이름을 조회
SELECT MEMBER_NAME 
FROM TB_MEMBER 
WHERE GRADE = 30
AND MEMBER_NAME LIKE '%이%';

--35: ​각 등급별로 몇 명의 회원이 있는지 조회
SELECT GRADE, COUNT(*) 
FROM TB_MEMBER 
GROUP BY GRADE;

--36: 각 지역별로 몇 명의 회원이 있는지 조회
SELECT AREA_CODE , COUNT(*) 
FROM TB_MEMBER  
GROUP BY AREA_CODE;

--37: ​각 지역별로 등급이 '우수회원'인 회원의 수를 조회
SELECT AREA_NAME, COUNT(*) 
FROM TB_MEMBER 
JOIN TB_AREA  USING (AREA_CODE)
WHERE GRADE = '20'
GROUP BY AREA_NAME;

--38: ​​지역별로 회원 수가 2명 이상인 지역 중에서 등급이 '일반회원'인 회원 수가 1명 이상인 지역을 조회

--39: ​​각 등급별로 평균 회원 수와 최대 회원 수를 조회

--40: ​​등급이 '특별회원'이면서, 서울에 거주하는 회원 중에서 등급별로 가장 많은 회원 수를 가진 지역을 조회

--41: ​​​회원 아이디가 'hong'으로 시작하고 등급이 '일반회원'인 회원의 이름을 조회

--42: ​​​각 등급별로 회원의 수가 가장 많은 지역을 조회

--43: ​​​각 지역별로 등급이 '특별회원'인 회원의 수를 조회 만약 그 지역에 특별회원이 없으면 '0'으로 표시

--44: ​​​등급이 '특별회원'이 아니고 지역이 '서울'이 아닌 회원 중에서 이름이 '김'으로 시작하는 회원의 수를 조회

--45: ​​​우수회원이면서 지역이 '경기'인 회원들의 평균 등급을 조회

--46: ​​​서울과 경기에 거주하는 회원 중에서 이름이 '이'로 끝나는 회원의 등급을 조회

--47: ​​​특별회원이 아닌 회원 중에서 등급이 가장 높은 회원의 이름을 조회

--48: ​​​서울과 인천에 거주하며 등급이 '일반회원'인 회원의 수를 조회





















