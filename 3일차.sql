-- �����Լ�
/*
    ROUND : Ư�� �ڸ������� �ݿø�
    TRUNK : Ư�� �ڸ������� �߶�(����)
    MOD : �Է� ���� ���� ���� ������ ���� ���
*/
-- round(���) : �Ҽ��� �Ʒ��ڸ����� �ݿø�
-- �Ҽ����ڸ��� : ��� �϶� �Ҽ��� ���������� �ڸ�����ŭ �̵��� �� �� �ڿ��� �ݿø�
-- : ���� �϶� �������� �ڸ�����ŭ �̵� �� �ݿø�
select 98.7654, ROUND(98.7654), ROUND(98.7654,2), round(98.7654,-2) from dual;

-- ��¥�Լ�
/*
    sysdate : �ý��ۿ� ����� ���� ��¥ ���
    months_between : �� ��¥ ������ �� �������� ��ȯ
    add_months : Ư�� ��¥�� ���� �� ����
    next_day : Ư�� ��¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥ ��ȯ
    last_day : ���� ������ ��¥�� ��ȯ
    round : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø�
    trunk : ���ڷ� ���� ��¥�� Ư�� �������� ����
*/

select sysdate 
from dual;

select sysdate -1 as ������¥, sysdate as ���ó�¥, sysdate+1 ���ϳ�¥
from dual;

-- Ư�� ��¥���� ���� �������� �ݿø��� ��¥ ( 16���̻� �ݿø�)
select hiredate,round(hiredate, 'MONTH') from employee;

-- �Ի��Ϻ��� ������� ������� �ٹ� ���� �� ���ϱ�
select ename, sysdate, hiredate, months_between(sysdate,hiredate) as "�ٹ� ���� ��"
from employee;

-- �Ի� �� 6������ ���� ����
select hiredate, add_months(hiredate, 6)
from employee;

-- �Ի� �� 100���� ���� ������ ��¥
select hiredate, hiredate+100 as "�Ի� �� 100�� ��¥"
from employee;

-- next_day (date, '����') : date���� �����ϴ� ������ ��¥
select sysdate, next_day(sysdate,'�����') as "�̹� �� ������� ��¥"
from dual;

-- last_day (date) : �ش� ���� ������ ��¥
select hiredate, last_day(hiredate)
from employee;

-- �� ��ȯ �Լ� : �߿���
/*
    TO_CHAR : ����, ��¥�� ���������� ��ȯ
    TO_DATE : �������� ��¥������ ��ȯ
    TO_NUMBER : �������� ���������� ��ȯ
*/

-- ��¥ �Լ� ����ϱ�
-- to_char (date,'YYYYMMDD")
select ename, hiredate, to_char(hiredate,'YYYYMMDD'), to_char(hiredate, 'YYMM'), 
    to_char(hiredate,'YYYYMMDD DAY'), to_char(hiredate,'YYYYMMDD DY')
from employee;

-- ���� �ý����� ���� ��¥�� ���( �ʱ���)
select sysdate, to_char(sysdate,'YYYY-MM-DD HH:MI:SS DAY')
from dual;

desc employee;

select hiredate, to_char(hiredate,'YYYY-MM-DD HH:MI:SS DAY')
from employee;

-- to_char���� ���ڿ� ���õ� ����
/*
    0 : �ڸ����� ��Ÿ����, �ڸ����� ���� ���� ��� 0���� ä��
    9 : �ڸ����� ��Ÿ����, �ڸ����� ���� �ʾƵ� ä���� ����
    L : �� ������ ��ȭ ��ȣ ���
    . : �Ҽ��� ǥ��
    , : õ������ ������
*/
desc employee;

select ename, salary, to_char(salary,'L999,999'), to_char(salary, 'L0000,000')
from employee;

-- to_date('char','format') : ��¥������ ��ȯ

-- ���� �߻� : date- - char
/*select sysdate, syadate - '20000101'
from dual;*/

-- 2000�� 1�� 1�Ϻ��� ���ñ����� �� ��
select sysdate, trunc(sysdate - to_date('20000101','YYYYMMDD'))
from dual;

select hiredate, trunc(hiredate - to_date('19600101','YYYYMMDD'))
from employee;

select ename, hiredate
from employee
where hiredate = to_date('1981-02-22', 'YYYY-MM-DD');

-- 2000�� 12�� 25�Ϻ��� ���ñ��� �� ����� �������� ���
select trunc(months_between(sysdate,to_date('2000-12-25','YYYY-MM-DD')))
from dual;

-- nvl �Լ� : null���� �ٸ������� ġȯ
    -- nvl(A,B) : A�� null�̸� B�� ġȯ
select commission from employee;

select commission, nvl(commission, 0)
from employee;

select manager from employee;

select manager, nvl(manager, 1111)
from employee;

-- nvl2(A,B,C) : A�� null��, �ƴϸ� B ���, null�̸� C ���

--  nvl �Լ��� ���� ����ϱ�
select salary, salary*12, commission, nvl(commission, 0),
    salary*12 + nvl(commission, 0) as ����
from employee;

--  nvl2 �Լ��� ���� ����ϱ�
select salary, commission, nvl2(commission,  salary*12 + commission, salary*12) as ����
from employee;

-- nullif : �� ǥ������ ���ؼ� ������ ��� null ��ȯ, �ƴϸ� ù��° ǥ���� ��ȯ
select nullif('A','A'), nullif('A','B')
from dual;

-- coalesce 
coalesce (expr1, expr2, expr3, .... expr-n) 
    -- expr1�� null�� �ƴϸ� expr1�� ��ȯ
    -- expr1�� null�̰� expr2�� null�� �ƴϸ� expr2 ��ȯ
    
select coalesce('abc','bcd','cde','def')
from dual;

select coalesce(null,'bcd','cde','def')
from dual;

select ename, salary, commission, coalesce(commission, salary, 0)
from employee;

-- decode �Լ�
/*
    decode(ǥ����, ����1, ���1
                  ����2, ���2
                  ����3, ���3
                  �⺻���
                  )
*/

select ename, dno, decode(dno, 10, 'ACCOUNTING',
                               20, 'RESEARCH',
                               30, 'SALES',
                               40, 'OPERATION',
                               'DEFAULTS'
                          ) as DNAME
from employee;

-- dno�÷��� 10�� �μ��� ��� ���޿��� +300, 20�� �μ��ϰ�� ���޿� + 500�� 
-- �μ���ȣ�� 30�� ��� ���޿� +700�ؼ� �̸�,����, �μ��� ���� + ��� ���

select ename, dno, salary, decode(dno, 10, salary+300,
                                  20, salary+500,
                                  30, salary+700,
                                  salary
                                  )
from employee;              

-- case : if~else 
select ename, dno, case when dno=10 then 'ACCOUNTING',
                        when dno=20 then 'RESEARCH',
                        






