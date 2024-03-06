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



































