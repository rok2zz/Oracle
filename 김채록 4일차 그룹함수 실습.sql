-- �׷��Լ� ����. 

-- 1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary),0) as ���
from employee;

-- 2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select job, max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary),0) as ���
from employee
group by job;

-- 3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job, count(*)
from employee
group by job;

-- 4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select count(distinct manager) as �����ڼ�
from employee;

-- 5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select (max(salary) - min(salary)) as DIFFERENCE
from employee;

-- 6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڰ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
select job, min(salary)
from employee
where manager is not null
group by job
having min(salary)>2000
order by min(salary) desc;

-- 7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno as �μ���ȣ, count(*) as �����, round(avg(salary),2) as ��ձ޿� 
from employee
group by dno;

-- 8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.  �ᷳ�� ��Ī�� [�μ���ȣ�̸�, ������, �����,��ձ޿�] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  
select decode(dno, '10', 'ACCOUNTING',
                   '20', 'RESEARCH',
                   '30', 'SALES'
                ) as �μ���ȣ�̸�,
       decode(dno, '10', 'NEWYORK',
                   '20', 'DALLAS',
                   '30', 'CHICAGO'
                ) as ������,    
                count(*) as �����, round(avg(salary),0) as ��ձ޿� 
from employee
group by dno;




