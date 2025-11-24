--트랜잭션
-- 1. 하나의 쿼리작업
-- 2. 하나 이상의 쿼리를 논리적 단위로 묶은 작업

--트랜젝선 테스트를 위한 컬럼 추가 
alter table author add column post_count int default 0;

--원래 쿼리를 한 번 날린 후에 커밋 또는 롤백을 해줘야 함 

--트랜잭션 실습
--post에 글쓰기(insert). author의 post_count에 +1을 update하는 작업. 2개를 한 트랜젝션으로 처리
--start transaction은 실질적인 의미는 없고 트랜잭션의 시작이라는 상징적인 의미만 있는 코드다
start transaction;
update author set post_count = post_count+1 where id =2;
insert into post(title,contents,author_id) values('hello', 'hello world...', 2);
commit;

--위 트랜젝션은 실패시 자동으로 rollback이 어렵다 
--stored 프로시져를 활용하여  성공시에는 commit, 실패시에는 rollback등 동적인 프로그래밍이 가능하다;

/*
1. post에 글 생성. insert 
2. 글쓴이의 쓴 글의 개수를 update
->transaction 처리
->둘 중 1작업이 성공 && 둘중 1작업이 싪패
->전체 롤백
-->작업의 순서가 차이가 없다 
*/

DELIMITER //
create procedure transaction_test()
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    update author set post_count=post_count+1 where id = 2;
    insert into post(title, contents, author_id) values("hello", "hello ...", 2);
    commit;
end //
DELIMITER ;

--프로시저 호츌
call transaction_test;

--트랜잭션 고립성 
--db 시스템이 있음 
--멀티쓰레드 때문에 동시성문제가 생김 
--

1.db는 멀티쓰레드 프로그램이다 
2.사용자의 트랜잭션이 동시에 발생할 수 있음
3.동시성 문제 발생할 수 있다. 

