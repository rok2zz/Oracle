-- 1. ���� �����ڸ� ����Ͽ� ��� ����� ���ؼ� $300�� �޿� �λ��� ������� ����̸�, �޿�, �λ�� �޿��� ����ϼ���. 
select ename, salary, salary+300 from employee;

-- 2. ����� �̸�, �޿�, ���� �� ������ ������ ���� ���������� ��� �Ͻÿ�. ���� �� ������ ���޿� 12�� ������ $100�� �󿩱��� ���ؼ� ��� �Ͻÿ�. 
select ename, salary, salary*12+100 from employee order by salary desc;

-- 3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ������ ���� ���������� ����ϼ���. 
select ename, salary from employee  where salary>2000 order by salary desc;

-- 4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ����ϼ���. 
select ename, dno from employee where eno = 7788;

-- 5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ��� �ϼ���. 
select ename, salary from employee where salary<2000 or salary>3000;

-- 6. 1981�� 2�� 20�Ϻ��� 81�� 5�� 1�� ������ �Ի��� ����� �̸� ������, �Ի����� ����Ͻÿ�


-- 7. �μ���ȣ�� 20�� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� ����(��������)���� ����Ͻÿ�. 
select ename, dno from employee where dno=20 or dno=30 order by ename desc;

-- 8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� �̸�, �޿��� �μ���ȣ�� ����ϵ� �̸��� ������������ ����ϼ���. 
select ename, salary, dno from employee where salary between 2000 and 3000 and (dno=20 or dno=30) order by ename asc;

-- 9. 1981�⵵ �Ի��� ����� �̸��� �Ի����� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ���)
select ename, hiredate from employee where hiredate like '81%';

-- 10. �����ڰ� ���� ����� �̸��� �������� ����ϼ���.
select ename, job from employee where manager is null;

-- 11. Ŀ�Լ��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� ����ϵ� �޿��� Ŀ�Լ��� �������� �������� �����Ͽ� ǥ���Ͻÿ�. 
select ename, salary, commission from employee where commission is not null order by salary desc, commission desc;

-- 12. �̸��� ����° ������ R�� ����� �̸��� ǥ���Ͻÿ�. 
select ename from employee where ename like '__R%';

-- 13. �̸��� A �� E �� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�. 
select ename from employee where ename like '%A%E%';

-- 14. ��� ������ �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸缭 �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 
select ename, job, salary from employee where (job ='SALESMAN' or job = 'CLERK') and salary not in (1600, 950, 1300);

-- 15. Ŀ�̼��� $500�̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�.  
select ename, salary, commission from employee where commission>=500;