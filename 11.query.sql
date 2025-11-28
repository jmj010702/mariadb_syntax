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

--DB 생성 
create database ordering ;
use ordering;
--user 테이블 생성
create table user(id bigint primary key auto_increment, name varchar(255) not null, role enum('user','seller') default 'user', ph_num varchar(255));
--product 테이블 생성
create table product(id bigint primary key auto_increment,p_name varchar(255) not null, stock int not null, user_id bigint not null, foreign key(user_id) references user(id));
--order_before 테이블 생성
create table order_before(id bigint primary key auto_increment, product_id bigint not null, user_id bigint not null, wbuy_count int not null, foreign key(user_id) references user(id),foreign key(product_id) references product(id));
-- orders
create table orders(id bigint primary key auto_increment, order_time datetime default current_timestamp(), user_id bigint not null, foreign key(user_id) references user(id));
--order_detail
create table order_detail(id bigint primary key auto_increment,buy_count int not null,orders_id bigint not null, product_id bigint not null, foreign key(orders_id) references orders(id),foreign key(product_id) references product(id)  )

1.회원가입 
insert into user(name, ph_num) values('hong1', '010-1111-1111');

2. 상품 등록하기 
insert into product(p_name, stock, user_id) values('사과','30', '1');

3. 주문하기
insert : 주문넣기
update : 재고 감소

start transaction;
insert into orders(user_id) values(2);
insert into order_detail(buy_count,orders_id,product_id) values(5,(select id from orders order by id desc limit 1),1);
update product set stock = stock -5 where id = 1;

--동적으로 처리 
start transaction;
insert into orders(user_id) values(2);
insert into order_detail(buy_count,orders_id,product_id)
values(5, (select id from orders order by id desc limit 1), 1);
update product 
set stock = stock - (select buy_count from order_detail order by id desc limit 1)
where id = (select product_id from order_detail order by id desc limit 1);
commit;

--4. 상품정보조회 //상품조회는 특별한 요구사항은 없습니다. 
--주문 넣은 후에  재고현황, 판매자 이런것들 조회하면 될것 같습니다.
select * from product;
--물건의 아이디, 이름 / 판매자의 아이디, 이름 조회  
select p.id, p.p_name, p.stock, u.name  
 from product p inner join users u on p.user_id = u.id;

--5. 주문정보조회 
--구매한 사람의 정보와 구매 물품, 구매 개수, 주문 시간 
SELECT 
    p.p_name AS product_name,
    od.buy_count,
    buyer.id AS buyer_id,
    buyer.name AS buyer_name,
    o.order_time
FROM order_detail od
INNER JOIN product p           ON od.product_id = p.id
INNER JOIN orders o            ON od.orders_id = o.id
INNER JOIN users buyer        ON buyer.id = o.user_id     
;
 
select 
    p.name, ol.order_qauntity,u.id, u,name, oi.order_time
    from order_list ol 
    inner join product p on p.id = ol.