-- ���̺� ���� ����

-- 1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
select ename, d.dno, dname
from employee e, department d
where d.dno = e.dno
and ename = 'SCOTT';

-- 2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 
select ename, dname, loc
from employee inner join department
on employee.dno = department.dno;

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 
select dno, job, loc
from employee inner join department
using (dno)
where dno = '10';

-- join ���� USING�� ����ϴ� ��� :
    -- NATURAL JOIN : ���� Ű �÷��� oracle ���ο��� �ڵ� ó��
        -- �ݵ�� �� ���̺��� ���� Ű Ŀ���� ���ƾ� �Ѵ�.
    -- �� ���̺��� ���� Ű �÷��� �ٸ��ų� �������� ��� USING ���

-- 4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
select ename, dname, loc
from employee natural join department
where commission is not null;

-- 5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename, d.dno, dname
from employee e, department d
where d.dno = e.dno
and ename like '%A%';

-- 6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
select ename, job, dno, dname, loc
from employee natural join department 
where loc = 'NEW YORK';


