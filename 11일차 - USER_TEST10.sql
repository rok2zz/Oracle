create table test10Tbl(
    a number not null,
    b varchar(50) null
    );

-- user_test10  에서 hr이 소유주인 employee 테이블에 접근할 때 접근권한 필요
-- grant select on hr.employee to user_test10;  : sys 계정에서 해야함
select * from hr.employee;

select * from test10Tbl;
show user;

select * from user_test10.test10tbl;

-- 다른 사용자의 객체를 접근 할때는 소유주명.객체명
select * from employee; -- 존재x
select * from hr.employee;

grant 객체의 권한 on 객체명 to 사용자명;

-- 다른 사용자 테이블에 insert
desc hr.emp_copy55;
select * from hr.emp_copy55;

insert into hr.emp_copy55 (eno)
values (3333);

-- with grant option으로 받은 권한을 다른 사용자에게 부여
grant select on hr.emp_copy56 to user_test11;

select * from hr.dept_copy56;

select * from user_role_privs;;

select * from hr.dept_copy57;
