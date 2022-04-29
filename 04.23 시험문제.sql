-- ����� ���蹮��

-- 1. �Ʒ� ���� ���̺��� ����ؼ� ������ 1000�̻� 1500���ϰ� �ƴ� ����̸��� ������ ��� �Ͻÿ�. 
-- ��Ī �̸��� ���� "����̸�" , "����" ���� ��� �ϵ�  �ݵ�� between �� ����ؼ� ��� �Ͻÿ�
select ename as ����̸�, salary as ����
from employee
where salary between 1000 and 1500;

-- 2. 1981�⵵�� �Ի��� ����̸��� �Ի����� ��� �Ͻÿ�.
-- ��, LIKE  �����ڿ� ���ϵ� ī�� ( _ , %) �� ����ؼ� ��� �Ͻÿ�.
-- ��Ī�̸��� ���� "����̸�", "�Ի���" �� ����Ͻÿ�
select ename as ����̸�, hiredate as �Ի���
from employee
where hiredate like '81%';

-- 3. substr �Լ��� ����ؼ� 87�⵵��  �Ի��� ����� ��� �÷��� ��� �Ͻÿ�.
select *
from employee
where substr(hiredate,1,2) = '87';

-- 4. �� ������� ���� ���� �ٹ��� �������� ��� �Ͻÿ�
select ename,trunc(months_between(sysdate,hiredate)) as ������
from employee; 

-- 5. �μ��� ������ �Ѿ���  3000 �̻��� �μ��� �μ� ��ȣ�� �μ��� �޿� �Ѿ��� ��� �Ͻÿ�.
select dno, sum(salary)
from employee
group by dno
having sum(salary)>=3000;

-- 6. �μ��� ������� ��� �޿��� ����ϵ�, ��ձ޿��� �Ҽ��� 2�ڸ� ������ ��� �Ͻÿ�.
-- ��� �÷��� �μ���ȣ, �μ��������, ��ձ޿� �� ��� �ϵ� ��Ī�̸��� "�μ���ȣ" , "�μ��������", "��ձ޿�"�� ��� �Ͻÿ�
select dno as �μ���ȣ, count(*) as �μ��������, round(avg(salary),2) as ��ձ޿�
from employee
group by dno;

-- 7. 2�� ������ EMPLOYEE, �Ʒ� DEPARTMENT ���̺��� Ȱ���Ͽ� �Ʒ� ���� ���Ͻÿ�.
-- EQUI ������ ����Ͽ� "SCOTT" ����� ����̸�, �μ���ȣ�� �μ��̸��� ��� �Ͻÿ�.
select ename as ����̸�, e.dno as �μ���ȣ, dname as �μ��̸�
from employee e, department d
where e.dno = d.dno
and ename = 'SCOTT';

-- 8. Natural Join�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�.
-- ��Ī�̸��� "����̸�", "�μ��̸�", "������" ���� ����Ͻÿ�
select ename as ����̸�, dname as �μ��̸�, loc as ������
from employee natural join department
where commission is not null;

-- 9. ������ ���� ������ ����Ͽ� ��� �Ͻÿ�.
-- �� �μ��� �ּҿ����� �޴� ����� �̸�, �޿� , �μ���ȣ�� ǥ���Ͻÿ�.
-- ��Ī�̸��� "�̸�", "�޿�","�μ���ȣ" �� ��� �Ͻÿ�
select ename as �̸�, salary as �޿�, dno as �μ���ȣ
from employee
where salary in (select min(salary) from employee group by dno);













