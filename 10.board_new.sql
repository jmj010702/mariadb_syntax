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
--위에것과 같이 일일이 author_id를 넣을 필요 없이 서브쿼리로 방금 넣은걸 꺼내서  author_id로 삽입
insert into address(country, city, street,author_id) values('korea','seoul','borame',(select id from author order by id desc limit 1));

--글쓰기
--최초 생성자
insert into post(title, contents) values('hello','hello worlds...');
insert into author_post_list(author_id,  post_id) values(1,2);
insert into author_post_list(author_id,  post_id) values((select id from author where email= '@@'),(select id from post order by post_id desc limit 1));

--추후 참여자 
--update 
insert into author_post_list(post_id,  author_id) values(1,2);

--글 전체 목록 조회하기 : 제목 내용 글쓴이 이름이 조회가 되도록 select 쿼리 생성  
select * from post p  inner join author_post_list apl on p.id=apl.post_id inner join author a on a.id=apl.author_id;


--정규화의 직관적인 룰 
--1. 데이터의 원자성 보장(도메인 분해)
--2. 성격의 차이 
--3. 데이터 중복
--4. 확장성 

--반정규화 : count 값을 추가로 두는 것 
--역정규화 : 쪼개진 두 테이블을 다시 합치는 것 

--실습 주문 시스템(쇼핑몰)
--요구사항 
--1. 회원가입 / 판매자,일반 사용자 구분 
--2. 상품 등록 / 재고 컬럼, 판매자가 누군지 기록 필요(판매자도 회원 테이블)
--3. 주문하기 / 장바구니 기능(한번에 여러개 주문할 수 있는 일반적인 서비스)
--          /한 주문을 조회했을 때 어떤 상품을 주문했는지 조회 가능해야함

1.회원가입 
insert into..
2. 상품 등록하기 
insert .. 
3. 주문하기
insert : 주문넣기
update : 재고 감소
4. 상품정보조회 
select .. 
5. 주문정보조회 


--1. 엑셀로 더미데이터 넣은 캡쳐본 제출
--2. erd설계 -> 캡처 제출
--3. erd 기반에 DB구축 및 테스트 데이터 삽입 

