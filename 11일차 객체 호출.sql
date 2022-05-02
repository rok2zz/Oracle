-- hr
-- 객체 출력시 소유주명 넣어야함
select * from hr.employee;

-- 자신의 객체는 소유주명 생략 가능
select * from employee;

create table emp_copy55
as
select * from employee;

select * from emp_copy55;

create table dept_copy55
as
select * from department;

create table dept_copy56
as
select * from department;