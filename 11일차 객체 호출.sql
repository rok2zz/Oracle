-- hr
-- ��ü ��½� �����ָ� �־����
select * from hr.employee;

-- �ڽ��� ��ü�� �����ָ� ���� ����
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