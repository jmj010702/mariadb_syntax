--회원 테이블 생성
create table author(id bigint primary key auto_increment, email varchar(255)not null unique, name varchar(255)not null, password varchar(255) not null);

--주소 테이블
create table address(id bigint primary key auto_increment, country varchar(255)not null, city varchar(255)not null, street varchar(255)not null,author_id bigint not null unique, foreign key(author_id) references author(id));

--post 테이블 
create table post(id bigint primary key auto_increment, title varchar(255) not null , contents varchar(3000));

--연결(junction) 테이블 
create table author_post_list(id bigint primary key auto_increment,author_id bigint not null, post_id bigint not null,foreign key(author_id) references author(id),foreign key(psot_id) references post(id));

--복합키를 이용한 연결 테이블 
create table author_post_list(  author_id bigint not null,post_id bigint not null,primary key(author_id, post_id) ,foreign key(author_id) references author(id),foreign key(post_id) references post(id));

--회원가입 및 주소 생성
insert into author(email,name,password) values('hong1@naver.com','hong1', '1234');
insert into address(country, city, street,author_id) values('korea','seoul','borame',3);

--글쓰기
insert into post(title, contents) values('hello','hello worlds...');
insert into author_post_list(post_id,  author_id) values(1,2);

--글 전체 목록 조회하기 : 제목 내용 글쓴이 이름이 조회가 되도록 select 쿼리 생성  
select * from post p  inner join author_post_list apl on p.id=apl.post_id inner join author a on a.id=apl.author_id;