--DDL 구조 : (DB 테이블) 생성/변경/삭제 작업
CREATE, ALTER, DROP 

--mariadb 서버에 터미널창에서 접속 /DB gui툴로 접속사에는 커넥션 객체 생성하여 접속 
mariadb -u root -p --엔터 후 비밀번호 별도 접속

--스키마(database) 생성
create database @@;

--스키마 삭제
DROP DATABASE @@;

--스키마 목록 조회
SHOW DATABASES;

--스키마 선택
USE @@;

--테이블 목록 조회
SHOW TABLES;

--문자 인코팅 세팅 조회 
SHOW VARIABLES LIKE 'character_set_server';

--문자 인코딩 변경
ALTER DATABASE board default character set = utf8mb4;

--SQL문은 대문자가 관례이고  시스템에서 대소문자를 구문하지 않음
--테이블명. 컬럼명 등은 소문자가 관례이고, 대소문자가 차이가 있음 
--테이블 생성 
CREATE TABLE @@(id int primary key, name varchar(255), email varchar(255), password varchar(255)); 

--테이블 컬럼정보 조회 
describe author;

--테이블 데이터 전체 조회
select * from author;

--테이블 생성명령문 조회
show create TABLE author;

-- posts  테이블 신규 생성 ( id, title, contents, author_id)
create table posts(id int, title varchar(255), contents varchar(255), author_id int,primary key(id), foreign key(author_id) references author(id));

--테이블 삭제
drop table @@;

--테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name='@@';

--테이블 index 조회 (제약 조건 확인 가능)
show index from @@;

--alter : 테이블의 구조를 변경 
--테이블의 이름 변경 
alter table @@ rename @@;

--테이블의 컬럼 추가
alter table @@ add column @@(컬럼명) @@(type); 


--테이블의 컬럼 삭제
alter table @@ drop column @@;

--테이블의 컬럼명 변경 
alter table @@ change column @@ @@@ varchar(255);

--테이블 컬럼의 타입과 제약조건변경 
alter table @@ modify column @@(column name) varchar(3000);
alter table @@ modify column @@(column name) varchar(255) not null unique;

--실습 1 . author 테이블에 address 컬럼을 추가(varchar255), name은 not null로 변경
alter table author add column address varchar(255); 
alter table author modify column name varchar(255) not null;

--실습 2 .post 테이블에 title을 not null로 변경. content는 contents로 이름 변경  
alter table post modify column title varchar(255) not null;
alter table post change column content contents varchar(255);

--테이블 삭제
drop table @@

--일련의 쿼리를 실행시킬때 특정 쿼리에서 에러가 나지 않도록 if exist를 많이 사용 
drop table if exists @@; 

