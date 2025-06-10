use youdb;
drop table p_test;
create table p_test(
	p_id int primary key auto_increment, 	-- pk, 자동값이 insert, auto_increment는 값이 안들어가면 자동으로 값이 커짐
    p_name varchar(20) not null unique,
    age tinyint not null,
    check (age >= 18 and age <35));
desc p_test;

-- 자식 테이블 생성
create table c_test(
	c_id int primary key,
    c_add varchar(20),
    constraint my_fk foreign key (c_id) references p_test(p_id)
    );
    
    desc p_test;
    desc c_test;
    
    select * from p_test;
    insert into p_test(p_name, age) values ('새은', 34);
    insert into p_test(p_name, age) values ('종민', 22);
    insert into p_test values (10, '세현', 27);
    insert into p_test(p_name, age) values ('예지', 31);
    insert into p_test(p_name, age) values ('Sorry', 22);
    commit;
    
    select * from p_test;
    select * from c_test;
    desc c_test;
    insert into c_test values (1, '가락동');
    insert into c_test values (10, '봉천동');
    insert into c_test values (12, '주거지 없음');
    commit;
    
    select
    * 
    from p_test p
    join c_test c on p.p_id = c.c_id;
    
    -- 세현 삭제(자식 먼저 삭제 -> 부모 삭제)
    delete from c_test
    where c_id = 10;

	delete from p_test
    where p_id = 10; -- 이를 참조하고 있는 자식이 있기 때문에 지우려면 자식 먼저 지운다. 
    
    -- 부모에 없는 데이터를 자식에 insert 시도. 부모 먼저 입력 -> 자식 입력
    insert into c_test values(20, '코엑스');         -- 부모에 없는 데이터이기에 추가 불가
    insert into c_test values(2, '코엑스');         -- 2는 부모에 있는 데이터이기에 추가 가능
    
    
    
    
    
    drop table wspace;
    drop table myemp;
    
    -- 부모 테이블 생성
    
    create table wspace(
   wid int primary key,
   wname varchar(20) not null,
   wloc varchar(10),
   waddr varchar(30));
   
   -- data 입력
   insert into wspace(wid, wname, wloc, waddr) values (10, 'scit', '서울', '코엑스 4층');
   insert into wspace(wid, wname, wloc, waddr) values (20, 'abcd', '부산', '부산 무역회관 2~3층');
   insert into wspace(wid, wname, wloc, waddr) values (30, 'swdo', '광주', '광주 무역회관 7층');

   -- 자식 테이블 생성
    
    create table myemp(
		id int primary key auto_increment,
        name varchar(20) not null,
        age tinyint not null,
        wid int,
        constraint my_check check (age >= 20 and age < 50)); -- constraint 뜻? constraint 제약 조건 이름(내가 정하는 것) 제약 조건 (필드이름)
        
   -- 제약 조건 추가
   alter table myemp -- alter의 뜻? 테이블을 수정한다.
   add constraint my_fk2 foreign key (wid) references wspace(wid);
   
   -- 제약 조건 확인
   select * from information_schema.KEY_COLUMN_USAGE
   where constraint_schema = 'youDB'
   and table_name in ('myemp', 'wspace');
   
 -- 데이터 입력
 insert into myemp(name, age, wid) values ('승혁', 25, 10);
 insert into myemp(name, age, wid) values ('지연', 25, 30);
 insert into myemp(name, age, wid) values ('찬호', 30, 20);
 insert into myemp(name, age, wid) values ('동현', 31, 30);
 
 -- 요구사항 sql
 select m.id as 직원id, m.name as 직원명,
 w.wname as 부서명, w.waddr as 부서주소
 from myemp m, wspace w
 where m.wid = w.wid;
 
 -- view 생성 = 가상 테이블
 create or replace view my_view
 as
 select m.id as 직원id, m.name as 직원명,
 w.wname as 부서명, w.waddr as 부서주소
 from myemp m, wspace w
 where m.wid = w.wid;
 
 desc my_view;
 select 직원id, 부서명, 부서주소 from my_view;