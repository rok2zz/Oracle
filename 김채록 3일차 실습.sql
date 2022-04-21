-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
select substr(hiredate,1,2) as �⵵, substr(hiredate,4,2)as ��
from employee;

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�. 
select *
from employee
where substr(hiredate,4,2) = '04';

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select * 
from employee
where mod(manager, 2) !=0;

-- 3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select * 
from employee
where mod(salary,3)=0;

-- 4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select to_char(hiredate, 'YY-MON DY')as �Ի糯¥
from employee;

-- 5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ� ������ ������ ��ġ ��Ű�ÿ�. 
select trunc(sysdate - to_date('2022-01-01','YYYY-MM-DD'))
from dual;

-- 5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select trunc(sysdate - to_date('1995-01-21','YYYY-MM-DD'))
from dual;
-- 5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select trunc(months_between(sysdate,to_date('1995-01-21','YYYY-MM-DD')))
from dual;

-- 6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select eno , nvl(manager, 0)
from employee;

-- 7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180,
--     'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�.
select ename, job, salary, decode(job, 'ANALYST', salary+200,
                                       'SALESMAN', salary+180,
                                       'MANAGER', salary+150,
                                       'CLERK', salary+100,
                                       salary
                                  ) as �޿��λ�
from employee;     

-- 8.   �����ȣ, [�����ȣ 2�ڸ������ �������� *���� ] as "������ȣ", �̸�, [�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� * ����] as "�����̸�"
select eno, rpad(substr(eno,1,2),4,'*') as ������ȣ, ename, rpad(substr(ename,1,1),4,'*') as �����̸�
from employee;

-- 9.  �ֹι�ȣ:   �� ����ϵ� 801210-1*******   ��� �ϵ��� , ��ȭ ��ȣ : 010-11*******	dual ���̺� ���
select rpad('�ֹι�ȣ : 801210-1', 25, '*') as �ֹι�ȣ, rpad('��ȭ��ȣ : 010-11',24,'*') as ��ȭ��ȣ
from dual;

-- 10. �����ȣ, �����, ���ӻ��, 	[���ӻ���� �����ȣ�� ���� ��� : 0000
              /*                ���ӻ���� �����ȣ��  �� 2�ڸ��� 75�� ��� : 5555
                                ���ӻ���� �����ȣ��  �� 2�ڸ��� 76�� ��� : 6666
                                ���ӻ���� �����ȣ��  �� 2�ڸ��� 77�� ��� : 7777
                                ���ӻ���� �����ȣ��  �� 2�ڸ��� 78�� ��� : 8888
                                �׿ܴ� �״�� ���. */
                                
select eno, ename, manager, case when manager is null then '0000'
                                 when manager like '75%' then '5555'
                                 when manager like '76%' then '6666'
                                 when manager like '77%' then '7777'
                                 when manager like '78%' then '8888'      
                                 else manager
                                 end as manager
from employee;
                        