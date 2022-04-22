-- ���� ���� : ���̺��� �÷��� �Ҵ�Ǿ� �������� ���Ἲ Ȯ��
    -- Primary Key : ���̺� �ѹ��� ��밡��
        -- �ߺ��� �� ���� �� x, null �� ����
    -- UNIQUE : ���̺��� ���� �÷��� �Ҵ� ����, �ߺ��� �� x
        -- Null ���� �� �ִ�, �ѹ���
    -- Foreign Key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ� ���� �� �ִ�
        -- �ڽ��� �÷��� ������ �� �Ҵ� �Ұ�
    -- Not Null : null �Ҵ� �Ұ�
    -- CHECK : �÷��� ���� �Ҵ� �� �� üũ�ؼ� ���� �Ҵ� (���� ������)
    -- Default : ���� ���� ���� �� �⺻�� �Ҵ�
    

-- join ���� USING�� ����ϴ� ��� :
    -- NATURAL JOIN : ���� Ű �÷��� oracle ���ο��� �ڵ� ó��
        -- �ݵ�� �� ���̺��� ���� Ű Ŀ���� ���ƾ� �Ѵ�.
    -- �� ���̺��� ���� Ű �÷��� �ٸ��ų� �������� ��� USING ��� 
    
-- self join : �ڱ� �ڽ��� ���Ը� ���� , ��Ī �ݵ�� ���

select eno, ename, manager
from employee
where manager = '7788';

-- self join�� �̿��� ����� �̸��� ���ӻ�� �̸� ���
select e.eno as ��ȣ, e.ename �̸�, e.manager ���ӻ����ȣ, m.ename as ���ӻ���̸�
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

select e.ename||'�� ���ӻ����' || e.manager ||'�Դϴ�.'
from employee e, employee m
where e.manager = m.eno
order by  e.ename asc;

select eno, ename, manager, eno, ename
from employee;

-- ansi ȣȯ : inner join ���� ó��
select e.eno as ��ȣ, e.ename �̸�, e.manager ���ӻ����ȣ, m.ename as ���ӻ���̸�
from employee e inner join employee m 
on e.manager = m.eno
order by e.ename asc;

select e.ename||'�� ���ӻ����' || e.manager ||'�Դϴ�.'
from employee e inner join employee m
on e.manager = m.eno
order by  e.ename asc;

-- outer join
    -- Ư�� �÷��� �� ���̺��� ���������� ���� ������ ��� �� ��
    -- �������� �ʴ� �÷��� null ���
    -- + ��ȣ�� ����ؼ� ��� : oracle
    -- ansi ȣȯ : outer join ������ ����ؼ� ��� << ��� dbms ���� ȣȯ
    
-- oracle
select e.ename, m.ename
from employee e join employee m 
on e.manager = m.eno (+)
order by e.ename asc;

-- ansi ȣȯ
    -- Left outer join : �������� �κ��� ������ ������ ������ ��� ���
    -- Right outer join : �������� �κ��� ������ �������� ������ ��� ���
    -- Full outer join : �������� �κ��� ������ ������ ��� ���
    
select e.ename, m.ename
from employee e Right outer join employee m
on e.manager = m.eno
order by e.ename asc;

-- sub Query : select �� ���� select ���� �ִ� ����

select salary from employee where ename = 'SCOTT';

-- SCOTT�� ���޺��� ���ų� ���� ����� ���
select ename, salary from employee where salary >= 3000;

select ename, salary 
from employee 
where salary >= (select salary from employee where ename = 'SCOTT');

-- SCOTT �� ������ �μ��� �ٹ��ϴ� ����� ���
select ename, dname
from employee e, department d
where e.dno = d.dno
and dname = (select dname from employee e, department d where e.dno = d.dno and ename = 'SCOTT');

-- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ���
select ename, job, salary
from employee
where salary = (select min(salary) from employee);

-- 30�� �μ����� �ּ� ������ �޴� ������� ���� ����� �̸��� �μ���ȣ, ������ ���
select salary, dno from employee where dno = 30;
select min(salary) from employee where dno = 30;

select ename, dno, salary
from employee
where salary>(select min(salary)from employee where dno = 30);

-- Having ���� sub query ���

-- 30�� �μ��� �ּҿ��޺��� ū �ּҿ����� ���� �μ�
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

-- ������ ���� ���� : sub query �� ��� ���� �� �ϳ��� ���
    -- ������ �� ������ : >, =, >=, <=, < ���
-- ������ ���� ���� : sub query �� ��� ���� ������ ���
    -- ������ �������� ������ : in, any, some, all, exist
        -- IN : ���� ������ ������('=' �����ڷ� ���� ���) �� ���������� ������߿� �ϳ��� ��ġ�ϸ� ��
        -- ANY, SOME : ���� ������ �������� ���������� �˻������ �ϳ� �̻� ��ġ�ϸ� ��
        -- ALL : ���� ������ �� ������ ���� ������ �˻������ ��� ���� ��ġ�ϸ� ��
        -- EXIST : ���� ������ �� ������ ���� ������ ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��

-- IN ������ ����ϱ�
select ename, eno, dno, salary
from employee
order by dno asc;

-- �μ����� �ּ� ������ �޴� ����ڵ� ���(sub query ���)
select dno, min(salary), count(*)
from employee
group by dno;

select dno, min(salary), count(*)
from employee
where salary in (950,800,1300)
group by dno;

select ename, dno, salary
from employee
where salary in (select min(salary) from employee group by dno)
order by dno asc;

-- ANY ������
    -- ���� ������ ��ȯ�ϴ� ������ ���� ��
    -- '< any' �� �ִ밪 ���� ����
    -- '> any' �� �ּҰ� ���� ŭ
    -- '= any' �� in�� ����
    
-- ������ salesman�� �ƴϸ鼭 �޿��� ������ salesman���� ���� ��� ���
select ename, job, salary
from employee
order by job;

select ename, job, salary
from employee
where job <> 'SALESMAN'
and salary < any (select salary from employee where job = 'SALESMAN');

-- ALL ������
     -- sub query �� ��ȯ�ϴ� ��� ���� ��
     -- ' > all ' : �ִ밪���� ŭ
     -- ' < all ' : �ּҰ����� ����
    
-- ������ SALESMAN�� �ƴϸ鼭 ������ SASESMAN �� ������� �޿��� ���� ��� ���
select ename, job, salary
from employee
where job <> 'SALESMAN'
and salary < all (select salary from employee where job = 'SALESMAN');   

-- ��� ������ �м����� ������� �޿��� �����鼭 ������ �м����� �ƴ� ��� ���
select ename, job, salary
from employee
where job <> 'ANALYST'
and salary < all (select salary from employee where job = 'ANALYST');   

-- �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ��� �޿��� ���ؼ� ��������
select eno, ename, salary
from employee
where salary > (select avg(salary) from employee)
order by salary asc;
