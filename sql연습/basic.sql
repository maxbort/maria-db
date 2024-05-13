select version(), current_data, now() from dual;

-- 수학함수, 사칙연산도 가능

select sin(pi() / 4), 1+2*3-4/5 from dual;

-- 대소문자 구분이 없다.
sElECT verSion(), current_DATE, NOw() from DuaL;

-- table 생성: DDL
create table pet(
	name varchar(255),
	owner varchar(50),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- schema 확인
describe pet;
desc pet;

-- table 삭제
drop table pet;
show tables;

-- insert: DML(C)
insert into pet values('성탄이', '안대혁', 'dog', 'm', '2007-12-25',null);

-- select:DML(R)
select * from pet;

-- update:DML(U)
update pet set name='성타니' where name='성탄이';