-- tinyint : 1바이트 사용  -128 ~ 127까지의 정수표현 가능 (unsigned(무조건 양수) -> 0~255 )
--author 테이블에 age column 추가 
alter table author add column age tinyint unsigned;
insert into author (id, name, email, age) values(6, '홍길동', 'hong105@naver.com', 300); 
--int : 4바이트 사용. 대략 40억 숫자범위 표현 가능

--bigint : 8바이트 사용.
--author, post테이블의 id값을  bigint로 변경 
alter table author modify column id bigint;
alter table post modify column author_id bigint;
alter table pos
--참조 관계가 걸려있어 한쪽의 타입을 바꿔버리면 타입이 맞지 않기 떄문에 오류가 남 
--해결하려면 제약 조건을 끊고 타입 변경 후 다시 제약  업데이트 

--pk 와 fk가 연결되었을 때 삭제하는 법 

--삭제 불가 (restrict)
--같이 삭제 (cascading)
--null로 세팅 (set null)

--decimal (총자리수, 소수부자리수)
alter table author add column height decimal (4,1);

--정상적으로 insert 
insert into author (id, name, email,height) values(9, 'hong9', 'hong9@naver.com', 180.5)
--데이터가 잘리도록 insert 
insert into author(id,name, email,height) values (12,'홍길동', 'hong109@naver.com', 1777.1);

--가변길이,  최대길이 지정, 메모리 저장, 빈번히 조회되는 짧은 길이의 데이터 -> varchar 

--가변길이, 최대 길이지정 불가, storage 저장, 빈번히 조회되지  않는  장문의 데이터 -> text
--text로 설정하게 되면 indexing 처리가 어렵다 

--길이가 딱 정해진 짧은 단어 : char or varchar 
--장문의 데이터 : text or varchar 
--그 외는 전부 varchar 

--문자타입 : 고정길이(char), 가변길이(varchar, text);
alter table author add column id_number char(16);
alter table author add column self_introduction text;

--blob(바이너리 데이터) 실습
--일반적으로 blob으로 저장하기 보다는, 이미지를 별도로 지정하고, 이미지 경로를 varchar로 저장.
alter table author add column profile_image longblob;
insert into author(id,name, email, profile_image) values(12,'홍길동', 'hong14@naver.com',LOAD_FILE(C':\\test.jpg'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입 
alter table author change column  address role;
alter table author add column role enum('admin', 'user') not null default 'user';

--enum에서 지정된 role을 insert 
insert into author (id,name, email, role) values(13,'홍길동', 'hong13@naver.com' ,'user');

--enum에서 지정되지 않은 값을 insert --> 에러발생
insert into author (id,name, email, role) values(14,'홍길동', 'hong14@naver.com' ,'super-user');

--role을 지정하지 않고 insert
insert into author (id,name, email) values(13,'홍길동', 'hong13@naver.com' );

--date(연,월,일)와 datetime(연,월,일,시,분,초)
--날짜타입의 입력, 수정, 조회시에는 문자열 형식을 사용;
alter table author add column birth date;
alter table post add column created_time datetime;
insert into post(id, title, contents, author_id, created_time) values(13, 'hello13','asdasd', 1, "2019-01-12 14:00:30");

--(datetime)과 default 현재시간 입력은 많이 사용되는 패턴
alter table post modify column created_time datetime default current_timestamp();
insert into post(id, title, contents, author_id) values(14, 'hello14','asdasd', 1);

--비교 연산자 
select * from author where id>=2 and id<=4 ;
select * from author where id in (select id from author where id %2 = 0);
select * from author where id between 2 and 4;

--like : 특정 문자를 포함하는 데이터를 조회하기 위한 키워드 
select * from post where title like 'h%';
select * from post where title like '%h';
select * from post where title like '%h%';

--RegExp : 정규표현식을 활용한 조회 
select * from author where name regexp '[a-z]'; -- 이름에 소문자 알파벳이 포함된 경우 
select * from author where name regexp '[A-Z]'; -- 이름에 대문자 알파벳이 포함된 경우 
select * from author where name regexp '[가-힣]'; -- 이름에 한글이 포함된 경우 

--타입 변환 --cast 
--문자 -> 숫자
select cast('12'as unsigned);

--숫자 -> 날짜
select cast(20251121 as date);  -- 2025--11--21
--문자 -> 날짜
select cast('20251121' as date) as date ;  --20205-11-21

--날짜 타입 변환 - date_format (Y, m, d, H, i, s)
select date_format(created_time, '%Y-%m-%d') from post;
select * from post where date_format(created_time, '%Y') = '2025';
select * from post where cast(date_format(created_time, '%m') as unsigned) = 1;

--실습 : 20205년  11월에 등록된 계시글 카운트 ****
select count(*) from post where cast(date_format(created_time, '%Y-%m') as unsigned) = '2025-11';
--실습 : 20205년  11월에 등록된 계시글 조회 ****
select * from post where cast(date_format(created_time, '%Y-%m') as unsigned) ='2025-11';
select * from post where created_time like '2025-11%';

--실습 : 2025년 11월 1일부터 19일까지 데이터 조회 ****
select *from post where created_time >='2025-11-01' and created_time < '2025-11-20';
select * from post where created_time > '2025-11-00' and create_time < '2025-11-19 00:00:00';

--GROUP BY와 having
--having은 group by를 통해 나온 집계값에 대한 조건 
--글을 3번 이상 쓴 사람 ID찾기 
select author_id from post p group by author_id having count(*) >=3;