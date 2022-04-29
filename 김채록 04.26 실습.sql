-- 08 ���̺� ���� ���� ����   <<�Ϸ� �ð� : 12: 20>>

-- 1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 
/*
�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
DNO	    number	    2	NOT NULL
DNAME	varchar2	14	NULL
LOC	    varchar2	13	NULL
*/
create table dept(
    dno number (2) not null,
    dname varchar2 (14) null,
    loc varchar2 (13) null
);
    
select * from dept;

-- 2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 
/*
�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	    number      4	NOT NULL
ENAME	varchar2	10	NULL
DNO	    number	    2	NULL
*/
create table emp(
    eno number (4) not null,
    ename varchar2 (10) null,
    dno number (2) null
);

select * from emp;

-- 3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 
/*
�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		25	NULL		<<==���� �÷�  : 10 => 25  �� �ø�
DNO	number		2	NULL
*/
alter table emp
modify ename varchar2 (25);

select * from emp;

-- 4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ� �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ� ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 
create table employee2
as
select eno as EMP_ID, ename as NAME, salary as SAL, dno as DEPT_ID from employee;

select * from employee2;

-- 5. EMP ���̺��� ���� �Ͻÿ�. 
drop table emp;

-- 6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�. 
alter table employee2 rename to emp;

select * from emp;

-- 7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�
alter table dept
drop column dname;

select * from dept;

-- 8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�. 
alter table dept
set unused (loc);

select * from dept;

-- 9. UNUSED Ŀ���� ��� ���� �Ͻÿ�. 
alter table dept
drop unused column;

select * from dept;

-- 09 - ������ ���۰� Ʈ����� ����. 

-- 1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�. 
create table emp_insert
as 
select * from emp
where 0=1;

alter table emp_insert
add (hiredate date);

select * from emp_insert;

-- 2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�. 
insert into emp_insert (emp_id, name, sal, dept_id, hiredate)
values (1, '��ä��', 33333, 2, sysdate);

select * from emp_insert;

-- 3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�. 
insert into emp_insert (emp_id, name, sal, dept_id, hiredate)
values (2, 'ȫ�浿', 44444, 2, to_date('2022-04-25','YYYY-MM-DD'));

select * from emp_insert;

-- 4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 
create table emp_copy
as
select * from employee;

select * from emp_copy;

-- 5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���] 
update emp_copy
set dno = 10
where eno = 7788;
commit;

select * from emp_copy;

-- 6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���] 
update emp_copy
set job = (select job from emp_copy where eno = 7499) , salary = (select salary from emp_copy where eno = 7499)
where eno = 7788;

select * from emp_copy;

-- 7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���] 
update emp_copy
set dno = (select dno from emp_copy where eno = 7369)
where job = (select job dno from emp_copy where eno = 7369);

select * from emp_copy;

-- 8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 
create table dept_copy
as
select * from department;

select * from dept_copy;

-- 9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 
delete from dept_copy
where dname = 'RESEARCH';

select * from dept_copy;

-- 10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�. 
delete from dept_copy
where dno = 10 or dno = 40;

select * from dept_copy;





