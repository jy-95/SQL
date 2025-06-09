# 1. Database 생성
create database if not exists youDB;
use youDB;
select database(), user();

# 2. Table 생성
drop table emp;
# create table emp(컬럼명 컬럼데이터타입 제약조건, ...)
/*
# ◆제약조건 : Dirty data를 최소화
	- pk : unique, not null
    - nn : not null
*/

create table emp (
					eid int primary key, 
                    ename char(15) not null,
                    age tinyint, 
                    pnumber varchar(20) default '휴대폰 없음, 02-6000-5037');
                    
# 3. DML : Insert into 테이블(컬럼명1, 컬럼명2, ...) values(v1, v2, ...);
desc emp;
insert into emp values(10, '이원서', 18, default);
insert into emp values(20, '신다소', 21, '010-6854-1370');
insert into emp values(30, '김종식', 48, '010-6137-8740');
insert into emp values(40, '김용우', 34, default);
insert into emp values(50, '강혜미', 25, '010-1212-7122');
insert into emp values(60, '박찬호', 54, '010-0151-6015');
insert into emp values(70, '윤세은', 15, default);
insert into emp values(80, '이준우', 43, '010-5574-5993');



select * from emp;
select @@autocommit;  # 0 : DML이 자동커밋이 아님->롤백 가능
rollback; 
commit; # 커밋을 해서 이제 롤백 불가

# 4. Quiz : id, 이름, 연령대 (10대, 20대, ...)만 조회
select
eid,
ename,
concat(substr(age, 1, 1),"0대") as "연령대",
concat(floor(age/10), "0대") as "연령대2"
from emp;

update emp
set age = 69
where eid = 60;
-- 아이디가 60번인 사람의 age를 업데이트한다.

create table box_office (
seq_no INT PRIMARY KEY,
years SMALLINT,
ranks INT,
movie_name VARCHAR(200),
release_date DATETIME,
sale_amt DOUBLE,
share_rate DOUBLE,
audience_num INT,
screen_num SMALLINT,
showing_count INT,
rep_country VARCHAR(50),
countries VARCHAR(100),
distributor VARCHAR(300),
movie_type VARCHAR(100),
genre VARCHAR(100),
director VARCHAR(1000)
);