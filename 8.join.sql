--case 1 : author inner join post
--글쓴적이 있는 글쓴이와 그 글쓴이가 쓴 글의 목록 출력 
select * from author a inner join post p on a.id = p.author_id;
select a.*,p.* from author a inner join post p on a.id = p.author_id;

--case 2 : post inner join author
--글쓴이가 있는 글과 해당 글의 글쓴이를 조회
select * from post p inner join author a on p.author_id = a.id;

--글쓴이가 있는 글 전체 정보와 글쓴이의 이메일만 출력 
select p.*, a.email from post p inner join author a on p.author_id = a.id;

--case 3 : author left join post
--글쓴이는 모두 조회하되, 만약 쓴 글이 있다면 글도 함께 조회 
select * from author a left join post p on a.id = p.author_id; 

--case 4 : post left join author
--글을 모두 조회하되, 글쓴이가 있다면 글쓴이도 함께 조회
select * from post p left join author a on p.author_id = a.id;

--문법 작성 출력 
--select from join on where 조건 group by having order by ; 
--셀(select) 프(from) 조인(join on) 왜(where 조건) 글(그룹바이) 해(해빙) 오(오더바이) 

--실습
--글쓴이가 있는 글 중에서 글의 제목과 저자의 email, 저자의 나이를  출력하되 저자의 나이가 30세 이상인 글만 출력 
select a.email,a.age, p.title from post p  inner join author a on a.id = p.author_id where a.age >30;
--글의 저자의 이름이 빈값이 아닌 글 목록만을 출력해라 
select p.*  from post p inner join author a on a.id=p.author_id where a.name is not null; 

--조건에 맞는 도서와 저자 리스트 출력 
SELECT  B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d')AS PUBLISHED_DATE from BOOK B inner join Author A on B.AUTHOR_ID = A.AUTHOR_ID WHERE B.CATEGORY = '경제' ORDER BY B.PUBLISHED_DATE ASC;

--없어진 기록 찾기 
select AOUT.ANIMAL_ID, AOUT.NAME from ANIMAL_OUTS AOUT left join ANIMAL_INS AIN  ON AOUT.ANIMAL_ID = AIN.ANIMAL_ID WHERE AIN.ANIMAL_ID IS NULL;

--union : 두 테이블의 select 결과를 횡으로 결합 
--union을 시킬 때 컬럼의 개수와 컬럼의 타입이 같아야 함
select name,email from author select title, contents from post;
--union은 기본적으로 distrint 적용 중복허려면 nuion all 사용

--서브쿼리 : select 문 안에 또다른 서브쿼리함
--where 절 안에 서브쿼리 
--한번이라도 글을 쓴 author의 목록 조회 중복 제외 
select distinct a.* from author a inner join post p on a.id = p.author_id;
--null값은 in조건절에서 자동으로 제외
select * from author where id in(select author_id from post);

--컬럼 위치에 서브쿼리
--회원별로 본인의 쓴 글의 개수를 출력 ex) email, post_count 
select email, (select count(*)from post p where p.author_id = a.id) as post_count from author a;

--from 절 안에 서브쿼리 
select a.* from(select *from author) as a ;

---group by 컬럼명 : 특정 컬럼으로 데이터를 그룹화하여, 하나의 행처럼 취급
select author_id from post group by author_id;
--회원별로 본인의 쓴 글의 개수를 출력 (left join)  ex) email, post_count 
select a.email ,count(p.id) as post_count from author a left join post p  on a.id = p.author_id group by a.email order by post_count asc;

--집계함수
select count(*) from author;
select sum(age) from author;
select avg(age) from author;
--소수점 3번째 자리에서 반올림 

--group by와 집계함수
--회원의 이름별 숫자를 출력하고 이름별 평균값을 출력하라 
select name, count(name)as count, avg(age) as age from author group by name order by name asc; 

--where와 group by
--날짜값이 null인 데이터는 제외하고 날짜별 post 글의 개수 
select date_format(created_time, '%Y-%m-%d'), count(*) from post p where created_time is not null group by date_format(created_time, '%Y-%m-%d') order by created_time asc;

--자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기 
SELECT CAR_TYPE,COUNT(OPTIONS) AS CARS FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS LIKE ('%시트%')

GROUP BY CAR_TYPE 
ORDER BY CAR_TYPE;

--입양 시각 구하기  
SELECT  
CAST(DATE_FORMAT(DATETIME, '%H')AS UNSIGNED)AS HOUR, COUNT(*) AS COUNT
FROM ANIMAL_OUTS
WHERE CAST(DATE_FORMAT(DATETIME, '%H')AS UNSIGNED) > '8' AND CAST(DATE_FORMAT(DATETIME, '%H')AS UNSIGNED) < '20'
group by CAST(DATE_FORMAT(DATETIME, '%H')AS UNSIGNED) 
ORDER BY CAST(DATE_FORMAT(DATETIME, '%H')AS UNSIGNED);

--동명 동물 수 찾기 
-- 코드를 입력하세요
SELECT NAME, COUNT(NAME) AS COUNT FROM ANIMAL_INS COUNT GROUP BY NAME HAVING COUNT(NAME) >=2 ORDER BY NAME ASC;

--카테고리 별 도서 판매량 집계하기 
-- 코드를 입력하세요
SELECT BK.CATEGORY , SUM(SALES) AS TOTAL_SALES
FROM BOOK BK INNER JOIN BOOK_SALES BS ON BK.BOOK_ID = BS.BOOK_ID 
WHERE DATE_FORMAT(SALES_DATE, '%Y-%m') LIKE '2022-01' 
GROUP BY BK.CATEGORY HAVING SUM(SALES)
ORDER BY CATEGORY ASC;

--조건에 맞는 사용자의 총 거래금액 조회하기
-- USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 결과는 총거래금액을 기준으로 오름차순 정렬해주세요.
SELECT USER.USER_ID, USER.NICKNAME, SUM(BOARD.PRICE) AS TOTAL_SALES
FROM USED_GOODS_USER USER 
INNER JOIN  USED_GOODS_BOARD BOARD ON USER.USER_ID = BOARD.WRITER_ID 
WHERE STATUS LIKE 'DONE'
GROUP BY USER.USER_ID HAVING SUM(PRICE) >=700000
ORDER BY TOTAL_SALES ASC;

