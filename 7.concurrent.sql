--read uncommitted :커밋되지 않은 데이터 read 가능 -> dirty read 문제 발생
--실습 절차
--1. 워크벤치에서 오토커밋 해제 -> 업데이트 실행 커밋하지 않음 (transaction 1)
--터미널을 열어 select 했을 때 update 변경사랑이 읽히는지 확인 (transaction2)
--결론 : workbench는 기본이 repeatable read 이므로 read불가능 

--read committed : 커밋한 데이터만 read만 가능 ->  phantom read 또는 Non-repeatable read 발생
--실습 절차
--1. 워크벤치에서 아래 코드 실행 
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
--2. 터미널에서 아래 코드 실행 
 insert into author(email) values('ggg@naver.com');

--Repeatable Read : 읽기의 일관성 보장 -> lost update문제 발생 -> 배타락(베타적 잠금)으로 해결 
--lost update 문제가 발생한 상태 
DELIMITER //
create procedure concurrent_test1()
begin
    declare count int;
    start transaction;
    insert into post(title, author_id) values('hello world', 1);
    select post_count into count from author where id=1;
    do sleep(15);
    update author set post_count=count+1 where id=1;
    commit;
end //
DELIMITER ;
call concurrent_test1();
--터미널에서는 아래 코드 실행 
select post_count from author where id=1;

--배타락을 통헤 문제를 해결한 상태
--select for update를 하게 되면 트랜잭션이 실행되는 동안 lock이 걸리고 트랜잭선이 종료된 후에 lock 풀림

DELIMITER //
create procedure concurrent_test2()
begin
    declare count int;
    start transaction;
    insert into post(title, author_id) values('hello world', 1);
    select post_count into count from author where id=1 for update;
    do sleep(15);
    update author set post_count=count+1 where id=1;
    commit;
end //
DELIMITER ;
call concurrent_test2();

--터미널에서는 아래 코드 실행 
select post_count from author where id=1 for update;

--serializable : 모든 트랜잭션 순차적 실행 -> 동시성 문제 없음(성능 저하)

--rdb는 멀티 스레드 프로그램 -> 동시에 여러 트랜잭션 실행 가능 -> 
--lost update 문제 발생할 수 있음(동시성문제)
--해결책 1 : 배타락(select for update) => 조회시에 특정 행에 대해 락을 검
--해결책 2 : redis 기반에 db로 재고관리하고 rdb에 저장 

--낙관적 락이 있다. 
