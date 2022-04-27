-- 10 : ������ ���Ἲ�� ���� ����, 11 ��

-- 1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
    -- ��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
create table emp_sample
as
select * from employee;

alter table emp_sample
add constraint my_emp_pk primary key(eno);

-- 2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
    -- �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
create table dept_sample
as
select * from department;

alter table dept_sample
add constraint my_dept_pk primary key(dno);

-- 3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� 
    -- ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
modify dno constraint my_emp_dept_fk references dep_sample (dno);

-- 4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
add constraint check_com check(commission > 0);

-- 5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
add constraint sal_def default 1000 for commission;

-- 6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
modify ename constraint emp_unq unique;

-- 7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
modify commission not null;

-- 8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 
alter table emp_sample
drop constraint my_emp_pk;

alter table emp_sample
drop constraint sal_def;

alter table emp_sample
drop constraint emp_unq;

alter table dept_sample
drop constraint my_dept_pk;

-- �� ���� 

-- 1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	-- ���� �̸� : v_em_dno  

create view v_em_dno
as
select eno, ename, dno
from employee
where dno = 20;

select * from v_em_dno;

-- 2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
create or replace view v_em_dno
as
select eno, ename, dno, salary
from employee
where dno = 20;

select * from v_em_dno;

-- 3. ������  �並 ���� �Ͻÿ�. 
drop view v_em_dno;

select * from v_em_dno;

-- 4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
	-- ���̸� : v_sal_emp
create view v_sal_emp
as
select min(salary) as �ּҰ�, max(salary) as �ִ밪, avg(salary) as ���, sum(salary) as ����
from employee
group by dno;

select * from v_sal_emp;

-- 5. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
 -- �б� ����
create or replace view v_em_dno
as
select eno, ename, dno, salary
from employee
where dno = 20 with read only; 

select * from v_em_dno;