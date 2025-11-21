--DML 구조 : 데이터를 넣고 조회/ 삭제/ 수정/ 삭제 
select : 조회 insert into values :삽입 ,update set : 수정,delete : 삭제 

--회원가입 -> insert 발생
--회원정보 수정 -> update 발생
--회원탈퇴 -> delete -> 현실에서는  update(탈퇴 O,X여부로) 처리 

--insert : 테이블에 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
--문자열은 일반적으로 작음따옴표 사용
EX) insert into author(id,name,email) values(4, 'hong4', 'hong4@naver.com');

--update : 테이블의 데이터를 변경 
update 테이블명 set name='@@'(바꾼 후 이름) , email='@@'(바꾼 후 이름) where id='@';

--delete : 데이터 삭제
delete from 테이블명 where 조건;
EX) delete from author where id='4';
-- delete where 세트 

--select : 조회
select 컬럼1, 컬럼2 from 테이블명;
EX) select name, email from author;
--*은 모든 컬럼을 의미
select * from @@; 

--select 조건절 (where)활용
ex) select * from author where id='1';
ex) select * from author where name='홍길동';
ex) select * from author where id > 2 and name='홍길동';
ex) select * from author where id in(1,3,5);

--이름 '홍길동'인 글쓴이가 쓴 글 목록을 조회하시오 
select * from post where author_id in(select id from author where name='홍길동');

--중복제거 조회 : distinct
select distinct name from @@;

--정렬 : order by + 컬럼명
select  * from @@ order by @@; 

--asc : 오름차순 desc : 내림차순 , 안붙이면 자동으로 asc 
--아무런 정렬조건 없이 조회할 경우에는 pk기준 오름차순
ex) select * from author order by name desc;

--멀티컬럼 order by : 여러컬럼으로 정렬시에, 먼저 쓴 컬럼 우선 정렬하고, 중복 시 그다음 컬럼으로 정렬적용 
ex) select * from author order by name desc , email asc;

--결과값 개수 제한 
--가장 최근에 가입한 회원 1명만 조회 
select * from author order by id desc  limit 1;

--별칭(alias)를 이용한 select 
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as.a; 

--null을 조회조건으로 활용 
select * from author where password is  null;
select * from author where password is not null;

--프로그래머스 sql 문제풀이 
--여러 기준으로 정렬하기 

-- like @@ % : %기준 포함하거나 전후로 포함이 된 
--count(*) *에 해당되는 행 집계할 때 사용됨     
