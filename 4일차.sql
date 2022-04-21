/*
    �׷��Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ�
        group by ���� Ư�� �÷��� ���� �� ���, �ش� �÷��� ������ ������ �׷����ؼ� ���� ����

    �����Լ� 
        - SUM : �׷��� �հ�
        - AVG : �׷��� ���
        - MAX : �׷��� �ִ밪
        - MIN : �׷��� �ּҰ�
        - COUNT : �׷��� �� ����(���ڵ� �� record, �ο� �� row)
*/  

select sum(salary), avg(salary), round(avg(salary),2), max(salary), min(salary)
from employee;

-- ���ǻ��� : �����Լ��� ó���� �� ��� �÷� ����
select sum(salary), ename
from employee;

-- �����Լ��� null���� ó���ؼ� ����
select sum(commission), avg(commission), max(commission), min(commission)
from employee;

-- count() : ���ڵ�, �ο� ��
    -- null�� ī��Ʈ���� ����
    -- ���̺� ��ü ���ڵ� ���� ������ ��� : count(*) or nou null �÷��� count()
    
select eno from employee;
select count(eno) from employee;
select count(commission) from employee;

-- �ߺ����� ��������
select count(distinct dno) from employee;

-- group by : Ư�� �÷��� ���, �յ� ��� ����
select dno as �μ���ȣ, avg(salary) as ��ձ޿�
from employee
group by dno;

-- ������ ��å�� �׷����ؼ� ������ ���, ��, �ִ�, �ּ�
select job, count(job), avg(salary), sum(salary), max(salary), min(salary)
from employee
group by job;

-- ������ ��å�� �׷����ؼ� ����

-- �����÷� �׷���
select dno, job, count(*), sum(salary)
from employee
group by dno,job; -- �� �÷��� ��� ��ġ�ϴ� �� �׷���

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- having : group by ���� ���� ����� �������� ó��
select dno, count(*), sum(salary) as �μ����հ�, round(avg(salary), 2) as �μ������
from employee
group by dno;

-- ������ ���� 9000 �̻��ΰ�
select dno, count(*), sum(salary) as �μ����հ�, round(avg(salary), 2) as �μ������
from employee
group by dno
having sum(salary)>9000;

-- ������ ����� 2000 �̻��ΰ�
select dno, count(*), sum(salary) as �μ����հ�, round(avg(salary), 2) as �μ������
from employee
group by dno
having avg(salary)>2000;

-- rollup, cube ���x
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by dno
order by dno;

-- rollup : group by �� �ȿ��� ��� , �÷� �� ���� ��� �� ��ü�� ��, ��� �� ���
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;

-- cube : ������ ���ο� ��ü �հ�, ���
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by cube(dno)
order by dno;

-- rollup : 2�÷��̻�, �ΰ��� �����͸� ���
select dno, job, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno, job)
order by dno;

-- cube : 2�÷��̻�
select dno, job, count(*), sum(salary), round(avg(salary))
from employee
group by cube(dno, job)
order by dno;

-- join : �� ���̺��� ��� �ϳ��� ���̺�, �𵨸�(�ߺ�����, �������)�� ���� �и�
    --  ���� Ű�÷� dno�� ������ dno �÷� ����
    -- �ΰ� �̻��� ���̺��� �÷��� join ������ ����ؼ� ���

select * from department; -- �μ�����
select * from employee; -- �������
-- �� ���̺��� ���� Ű �÷� : dno

-- equi join : ����Ŭ���� ���� ���� ����ϴ� join,  oracle ������ ���Ǵ�
    -- from : ������ ���̺��� "," �� ó��
    -- where : �� ���̺��� ������ Ű �÷��� " = " �� ó��
    -- and : ������ ó��
    -- on �� ��� : �� ���̺��� ������ Ű �÷� " = " �� ó��
    
-- where ���� ���� �÷� ó��  
select * 
from employee, department
where department.dno = employee.dno
and job = 'MANAGER';

-- ansi ȣȯ : inner join : ��� sql���� ��� ����
-- on �� : ���� Ű�÷��� ó���� ���
select * 
from employee e inner join department d --inner ���� ����
on e.dno = d.dno
where job = 'MANAGER';

-- join �� ���̺� �˸��
select * 
from employee e, department d
where d.dno = e.dno
and salary>1500;

-- select ������ ���� Ű�÷� ��� �� �� ��� �÷��� �÷����� ���
select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno;

-- �� ���̺��� join�ؼ� ������ �ִ밪�� �μ������� ���

select dname, max(salary)
from employee e, department d
where e.dno = d.dno
group by(dname);

-- natural join : oracle 9���� ����
    -- equi join��  where ���� ���� : �� ���̺��� ���� Ű �÷��� ���� " = "
    -- ���� Ű �÷��� oracle ���������� �ڵ����� �����ؼ� ó��
    -- ���� Ű�÷��� ��Ī �̸��� ����ϸ� ���� �߻�.
    -- from ���� natural join Ű���� ���
    
select eno, ename, dname, dno
from employee e natural join department d;

-- ���� : select ���� ����Ű �÷��� ��� �� ���̺� ���� ����ϸ� ���� �߻�

-- EQUI JOIN vs NATURAL JOIN�� ���� Ű �÷� ó��
    -- EQUI JOIN : select ���� �ݵ�� ���� Ű �÷��� ��� �� �� ���̺� ���� ���
    -- NATURAL JOIN : select���� �ݵ�� ���� Ű �÷��� ��� �� �� ���̺� �� ����ϸ� �ȵ�


select ename, salary, dname, e.dno
from employee e, department d
where e.dno = d.dno;

select ename, salary, dname, dno
from employee natural join department;

-- NON EQUI JOIN : EQUI JOIN���� Where ���� " = " �� ������� �ʴ� join
select * from salgrade; -- �������� ����� ǥ���ϴ� ���̺�

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;





