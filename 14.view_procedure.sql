--view : 실제 데이터를 참조만 하는 가상의 테이블. select만 가능 
--사용 목적
--1.권한 분리 2. 복잡한 쿼리를 사전생성 

--view 생성
create view author_view as select name,email from author;
create view author_view2 as select name,email from post p join author a  on a.id =p.id;

--view 조회 
select * from author_view;

--view에 대한 권한 부여
grant select on board.author_view to 'marketing'@'%';

--view 삭제
drop view author_view;

--프로시져 생성 
delimiter //
create procedure hello_procedure()
begin
    select 'hello world';
end
// delimiter ;

--프로시져 삭제
drop procedure hello_procedure

--회원 목록조회 프로시져 생성 (한글명 프로시져 가능) 
delimiter // 
create procedure 회원목록조회()
begin 
    select *from author;
end
// delimiter ;

--회원 상세조회 -> input(매개변수)값 여러개 사용 가능 -> 프로시져 호출 시 순서에 맞게 매개변수 입력 
delimiter // 
create procedure 회원상세조회(in idinput bigint)
begin 
    select *from author where id = idinput;
end
// delimiter ;

--전체 회원수 조회 -> 변수 사용
delimiter // 
create procedure 전체회원수조회()
begin
    --변수선언
    declare authorcount bigint; 
    --into를 통해 변수에 값 할당 
    select count(*) into authorcount from author;
    select authorcount;
end
// delimiter ;

--글쓰기
--사용자가 title, contents, 본인의 이메일 값을 입력 
delimiter // 
create procedure 글쓰기(in intitle varchar(255), incontents varchar(3000), inemail varchar(255))
begin 
    declare into_id bigint;
    declare into_aid bigint;

    --email로 회원 ID찾기 
    select id into into_aid from author where email = inemail; 
    --post테이블에 insert
    insert into post(title, contents) values(intitle, incontents);
    --post테이블에 insert된 id값 구하기 
    select id into into_id from post order by id desc limit 1;
    --author_post_list 테이블에 insert하기(author_id,post_id 필요)
   insert into author_post_list(author_id, post_id) values(into_aid, into_id);
end
// delimiter ;

--트랜잭션
delimiter // 
create procedure 글쓰기(in intitle varchar(255), incontents varchar(3000), inemail varchar(255))
begin 
    declare into_id bigint;
    declare into_aid bigint;
    --아래 declare는 변수선언과는 상관없는 예외관련 특수문법
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
     start transaction;
    select id into into_aid from author where email = inemail; 
    insert into post(title, contents) values(intitle, incontents);
    select id into into_id from post order by id desc limit 1;
   insert into author_post_list(author_id, post_id) values(into_aid, into_id);
end
// delimiter ;

--if else문 글삭제  
delimiter //
create procedure 글삭제(in postIdInput bigint, in authorIdInput bigint)
begin
    declare authorCount bigint;
    select count(*) into authorCount from author_post_list where post_id = postIdInput;
    if authorCount=1 then
        delete from author_post_list where post_id=postIdInput and author_id=authorIdInput;
        delete from post where id=postIdInput;
    else
        delete from author_post_list where post_id=postIdInput and author_id=authorIdInput;
    end if;
end
// delimiter ;

--while문을 통한 반복문 
delimiter // 
create procedure 글도배(in incount bigint, inemail varchar(255))
begin 
    declare into_id bigint;
    declare into_aid bigint;
    declare countvalue bigint default 0;
    while countvalue<incount do 
        select id into into_aid from author where email = inemail; 
        insert into post(title) values("안녕하세요");
        select id into into_id from post order by id desc limit 1;
        insert into author_post_list(author_id, post_id) values(into_aid, into_id);
        set countvalue = countvalue + 1;
    end while;
end
// delimiter ;

--database :핵심엔진 _

--inno DB는 트랜잭션 지원 
--myisam은 트랜잭션 지원X, 조회성능빠름

--클러스터링 : 여러서버를 하나로 묶는다
--레플리카 : 복제서버를 둔다 
--샤딩 : 데이터를 여러 서버에 나눈다 

--HA(high ability) : 고가용성을 뜻하는 것으로 장애없는 지속 가능한 서비스
--고가용성 == HA == 서버의 다중화 구성 