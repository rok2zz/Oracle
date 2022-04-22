-- 7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 	-- ������ ��Ī���� �ѱ۷� �����ÿ�. 
select e.eno as �����ȣ, m.ename �̸�, e.manager �����ڹ�ȣ, m.ename as �������̸�
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
select e.eno, m.ename, e.manager
from employee e join employee m 
on e.manager = m.eno (+)
order by e.eno desc;

-- 9. SELF JOIN�� ����Ͽ� ������ ���(SCOTT)�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
    -- ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
select e.ename as �̸�, e.dno as �μ���ȣ, m.ename as ����
from employee e, employee m
where e.ename = 'SCOTT'
and m.dno = (select dno from employee where ename = 'SCOTT');

-- 10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
select e.ename as �̸�, e.hiredate as �Ի���
from employee e, employee m
where e.ename = m.ename
and e.hiredate > (select hiredate from employee where ename = 'WARD')
order by e.hiredate;

-- 11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    -- ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
select e.ename as �̸�, e.hiredate as �Ի���, m.ename as �������̸�, m.hiredate as �������Ի���
from employee e, employee m
where e.manager = m.eno;

-- <<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

-- 1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  
select ename as ����̸�, job as ������
from employee
where job = (select job from employee where eno = 7788);

-- 2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename as ����̸�, job as ������
from employee
where salary > (select salary from employee where eno = 7499);

-- 3.  <<���޺�>>�� �ּ� �޿��� �޴�, ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select ename, job , salary
from employee
where (job,salary) in (select job, min(salary) from employee group by job)
order by job;

-- 4. <<���޿��� ��� �޿��� ���� ����  �����  ���ް� ��� �޿��� ǥ���Ͻÿ�.>>
select job, avg(salary)
from employee
where (job,salary) in (select job, avg(salary) from employee group by job);
select job, avg(salary) from employee group by job;

-- 5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
select ename, salary, dno
from employee
where (dno, salary) in (select dno, min(salary) from employee group by dno);

-- 6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
select eno as �����ȣ, ename as �̸�, job as ������, salary as �޿�
from employee
where job != 'ANALYST'
and salary < all(select salary from employee where job = 'ANALYST');

-- 7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename
from employee
where eno != all(select eno from employee where eno = manager);

-- 8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename
from employee
where eno in (select manager from employee);

-- 9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select ename, hiredate
from employee
where ename != 'BLAKE'
and dno = (select dno from employee where ename = 'BLAKE');

-- 10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
select eno, ename
from employee
where salary >(select avg(salary) from employee)
order by salary asc;

-- 11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select eno, ename
from employee
where dno in (select dno from employee where ename like '%K%');

-- 12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
select ename, dno, job
from employee
where dno = (select dno from department where loc = 'DALLAS') ;

-- 13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select ename, salary
from employee
where manager in (select manager from employee where manager = (select eno from employee where ename = 'KING'));

-- 14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 
select dno, ename, job
from employee
where dno = (select dno from department where dname = 'RESEARCH');

-- 15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
select eno, ename, salary
from employee
where salary > (select avg(salary) from employee)
and dno in (select dno from employee where ename like '%M%'); 

-- 16. ��� �޿��� ���� ���� ������ ã���ÿ�. 
select job
from employee
where avg(salary) < any(select avg(salary) from employee group by job);

-- 17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
select *
from employee
where dno in (select dno from employee where job = 'MANAGER')
order by dno;





