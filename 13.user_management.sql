--사용자 목록 조회 
select *from  mysql.user;

--사용자 생성
create user 'marketing'@'%'identified by 'test4321';

--사용자에게 권한 부여(root 계정으로 )
grant select on board.author to 'marketing'@'%';
grant select, insert board.* to 'marketing'@'%';
grant all privileges on board.* to 'marketing'@'%';

--사용자 권한회수 
revoke select on board.author from 'marketing'@'%';

--사용자 권한 조회
show grant for 'marketing'@'%';

--사용자 계정삭제
drop user 'marketing'@'%';

--