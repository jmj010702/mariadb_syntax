--not null 제약조건 추가 
alter table author add column name varchar(255) not null;
alter table author modify column name varchar(255) not null; -- 이미 있는 경우에는 modify로 수정 
--not null 제약조건 제거 
alter table author modify column name varchar(255);
--not null, unique 추가 
alter table author modify column email varchar(255) not null unique;

--pk/fk 추가/제거 
--pk 제약조건 삭제 순서 
describe post;
select * from information_schema.key_column_usage where table_name='@@';
alter table post drop primary key;

--fk제약 조건 삭제
alter table post drop foreign key fk명;

--pk 제약 조건 추가 
alter table post add constraint post_pk primary key(id);

--fk제약 조건 추가 
alter table post add constraint post_fk foreign key(author_id) refrences author(id);

--unique 추가는 modify column으로 가능 삭제하려면 index에서 삭제해야됨 

--on delete/ on update 제약조건 변경 테스트 
alter table post add constraint post_fk foreign key(author_id) references author(id) on delete set null on update cascade;

--기존 fk 삭제
--새로운 fk 추가  (on update/ on delete 변경)
--새로운 fk에 맞는 테스트 
-- 3-1 ) 삭제 테스트  참조를 부모에게서 했기 때문에 테스트는 부모한테 해봐야 된다 
delete from author where id = 6;

-- 3-2 ) 수정 테스트 
update author set id=20  where id=6;

--default 옵션
--어떤 컬럼이든 deauilt 지정이 가능하지만 일반적으로 enum타입 및 현재시간에서 많이 사용 
alter table author modify column name varchar(255) default 'ananymous';

--auto_increment : 숫자값을 입력 안했을 때 마지막에 입력된 가장 큰 값에 +1만큼 자동으로 증가된 숫자값 자동으로 적용 
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

--uuid : DB분산, 보안에 이점이 있음, 
alter table post Add column user_id char(36) default (UUID());

























