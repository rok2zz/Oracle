5���� - ��������

-- Sub Query : Select �� ���� Select ���� �ִ� ����. 
    -- where ������ :  sub query
    -- having ������ : sub query

 select ename, salary  from employee; 
 select salary from employee where ename='SCOTT'
 
 -- SCOTT�� ���� ���� ���ų� ���� ����ڸ� ��� �϶�. (���� ����)
 
 select ename, salary from employee where salary >= 3000 
 
  select ename, salary 
  from employee 
  where salary >= (select salary from employee where ename='SCOTT')  
  
  -- SCOTT�� ������ �μ�(dno)�� �ٹ��ϴ� ����� ��� �ϱ�. (5��) (sub query)
  select dno from employee where ename = 'SCOTT'
  select ename ,dno from employee where dno = 20
  
    select ename ,dno from employee 
    where dno = (select dno from employee where ename = 'SCOTT')
  
  
  -- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ��� �ϱ�. (sub query)
  select min (salary) from employee;
  
  select ename, job, salary 
  from employee
  where salary = (select min (salary) from employee)
  

  
  -- 30�� �μ�(dno)���� �ּ� ������ �޴� ������� ���� ����� �̸���, �μ���ȣ�� ������ ��� �غ�����. (7��)
  
  select salary, dno from employee where dno = 30 
  select min(salary) from employee where dno= 30
  
  select ename,  dno, salary 
  from employee
  where salary > (select min(salary) from employee where dno= 30)

    --Having ���� Sub query ����ϱ�. 
      
    -- 30�� �μ��� �ּҿ��� ���� ū �� �μ��� �ּ� ����  
    select dno, min(salary), count(dno)
    from employee
    group by dno 
    having min(salary) > ( select min(salary) from employee where dno=30)
    
--������ ���� ���� : sub query �� ��� ���� �� �ϳ��� ���.
           -- ������ �� ������ :  >, = , >=, < , <= , <> , <=   
--������ ���� ���� : sub query �� ��� ���� ������  ���
           -- ������ �������� ������ : IN, ANY, SOME, ALL, EXISTS
            --IN : ���� ������ �� ���� ( '=' �����ڷ� ���� ���) �� ���������� ������߿� �ϳ��� ��ġ�ϸ� ��
            --ANY, SOME : ���� ������ �� ������ ���������� �˻� ����� �ϳ� �̻� ��ġ �ϸ� ��
            --ALL : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ �ϸ� ��
            --EXIST : ���� ������ �� ������ ���� ������ ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��. 
 

-- IN ������ ����ϱ�. 
select ename, eno, dno, salary
from employee
order by dno asc

-- �μ����� �ּ� ������ �޴� ����ڵ� ��� �ϱ�. (sub query�� �ݵ�� ����ؼ� ��� ) 

select dno, min(salary), count(*) 
from employee
group by dno

select ename , dno, salary 
from employee 
where salary in (950, 800, 1300)

select ename , dno, salary 
from employee 
where salary in ( select min (salary) from employee group by dno
)

-- ANY ������ ���. 
    -- ���� ������ ��ȯ�ϴ� �� ���� ���� ����. 
    -- ' < any ' �� �ִ밪 ���� ������ ��Ÿ��. 
    -- ' > any ' �� �ּҰ� ���� ŭ�� ��Ÿ��. 
    -- ' = any ' �� IN �� ���� ��. 
    
 ��) ������ SALESMAN �� �ƴϸ鼭  �޿��� ������ SALESMAN ���� ���� ����� ���. 
            -- 1600 (�ִ밪) ���� ���� ��� ���(SALESMAN)�� �ƴϰ�) 
 select eno, ename, job, salary 
 from employee 
 where salary < any (select salary from employee
                        where job = 'SALESMAN') 
                 and job <> 'SALESMAN'        
                
select ename, job, salary from employee order by job;   

--ALL ������ 
    -- Sub query �� ��ȯ�ϴ� ��� ���� ��. 
    -- ' > all ' : �ִ밪 ���� ŭ�� ��Ÿ��. 
    -- ' < all ' : �ּҰ� ���� ������ ��Ÿ��. 

-- ��) ������ SALESMAN�� �ƴϸ鼭 ������ SALESMAN �� ��� ���� �޿��� ���� ����� ��� ���. 

            -- 1250 (�ּҰ�) ���� ���� ��� ( ������ SALESMAN�� �ƴ�) 
select eno, ename , job, salary 
from employee
where salary < all (select salary 
                    from employee
                    where job = 'SALESMAN') 
                    and job <> 'SALESMAN' 
                    
-- ��� ������ �м���(ANALYST)�� �������  �޿��� �����鼭 ������ �м����� �̴� ����� ���.
select eno, ename, salary, dno 
from employee 
where salary < all ( Select salary 
                     from employee
                     where job = 'ANALYST' ) 
                     and job <> 'ANALYST' 
                     

-- �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ�� �ϵ� ��� �޿��� ���ؼ� �������� �Ͻÿ�. 
select ename, eno, salary 
from employee
where salary  > ( select round (AVG (salary))  from employee)

select min(round (avg(salary),1)) from employee group by job

select job , avg(salary) 
from employee
group by job


subquery ����. 

Join ����.

�Ϸ� �ð� : 6:20�б���.  :  ����� 12 ~ �Ͽ��� ���� 10�� : ����Ŭ : < �����ͺ��̽� ����. >

7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 	������ ��Ī���� �ѱ۷� �����ÿ�. 
    -- Self JOIN : �ݵ�� ���̺��� ��Ī�� ���. Select �÷��� ��� �Ҷ� ��Ī�̸�.�÷��� 
        -- �������� ���, ����� ���ӻ�� ������ ���.
    select ename, eno, manager, eno from employee;
    
    -- EQUI JOIN : ����Ŭ ������ ����ϴ� ����  , �� ���̺��� Ű�� ��ġ�ϴ� �͸� ��� 
    -- ANSI : INNER JOIN���� ��ȯ ���� ( ��� DBMS���� ���� ���� , MSSQL, MYSQL, IBM DB2)
    
    select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 , employee e2
    where e1.manager = e2.eno 
    
    select * from employee; 
    
    select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 Inner JOIN employee e2
    ON e1.manager = e2.eno   
    

8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
   
    select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 , employee e2
    where e1.manager = e2.eno (+)
    order by e1.eno desc
    
`   select e1.ename as ����̸�, e1.eno as �����ȣ, e1.manager �����ڹ�ȣ, e2.ename �������̸� 
    from employee e1 Left Outer JOIN employee e2
    ON e1.manager = e2.eno  
    order by e1.eno desc
    
9. SELF JOIN�� ����Ͽ� ������ ���<<('SCOTT')>>�� �̸�, �μ���ȣ, ������ ���('SCOTT')�� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
   ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
   
   select e1.ename �̸�, e1.dno �μ���ȣ, e2.ename ���� 
   from employee e1, employee e2
   where e1.dno = e2.dno               -- <== �� ���̺��� �μ� �÷��� ����Ű�� ���. 
   and e1.ename = 'SCOTT' and e2.ename != 'SCOTT' 
   
   select * from employee where ename = 'SCOTT' ; 
   select * from employee where dno = 20 
   
   select ename, dno , ename, dno from employee; 


10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
select * from employee;

select * from employee
where hiredate > '81/02/22'

select * from employee
where hiredate > to_date ( 19810222, 'YYYYMMDD')

select * from employee
where hiredate > to_date ( '1981_02_22', 'YYYY_MM_DD')


select ename, hiredate , ename, hiredate from employee; 

select e2.ename �̸�, e2.hiredate �Ի��� 
from employee e1, employee e2
where e2.hiredate > e1.hiredate
and e1.ename = 'WARD'
order by e2.hiredate asc;


11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
    
    select eno, ename, manager, hiredate from employee; 
    
    select e1.ename ����̸�, e1.hiredate ������Ի���, e2.ename �������̸�, e2.hiredate �������Ի���  
    from employee e1, employee e2
    where e1.manager = e2.eno 
    and  e1.hiredate < e2.hiredate 
    
    select eno, ename, manager, hiredate,  eno, ename, manager, hiredate from employee; 
   
<<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  

select job , ename from employee where eno = '7788' ; 
select ename, job from employee where job = 'ANALYST' 

select ename, job from employee where job = (select job from employee where eno = '7788'  )


2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 

select ename ����̸�, job ������, salary ���� 
from employee
where salary > (select salary from employee where eno = 7499)

3. �ּ� �޿��� �޴� <<���޺�>>��, ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)

select job , count(*), min (salary) 
from employee
group by job 

select ename ����̸�, job ������, salary �޿�
from employee
where salary in ( select min (salary) 
                from employee
                group by job )
                
4.  <<���޺��� ��� �޿��� ���ϰ�, ���� ����  ���� ��տ���   ���� ����  �����  ���ް�  �޿��� ǥ���Ͻÿ�.>>

select job, round( AVG(salary)) from employee 
group by job 
select * from employee where job = 'CLERK'

select ename �̸�,  job ����, salary �޿� 
from employee
where salary = ( select min(salary) from employee
                    group by Job 
                    having avg(salary) = (select min (avg(salary))
                    from employee group by job)
                )

select min (salary) �޿�, job ����
from employee 
group by job 
having avg (salary) <= all (select avg(salary) 
                            from employee 
                            group by job); 

5. �� �μ��� �ʼ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.

select ename ����̸�, job ������, salary �޿�
from employee
where salary in ( select min (salary) 
                from employee
                group by job )

6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
    select * from employee where job = 'ANALYST' ; 

    select eno, ename, job, salary 
    from employee 
    where salary < all ( select salary 
                        from employee 
                        where job = 'ANALYST') and job <> 'ANALYST' 
7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select * from employee; 


8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select eno, ename 
from employee
where eno in ( select manager 
                    from employee 
                    where manager is not null )
select * from employee; 

9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select * from employee where ename = 'BLAKE'

select ename  ����, hiredate �Ի���, dno �μ��� 
from employee 
where dno = ( select dno from employee where ename = 'BLAKE' ) and  ename != 'BLAKE'


10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
    select eno, ename, salary 
    from employee 
    where salary > ( select round (avg(salary)) from employee ) 
    order by salary asc; 

11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select dno, ename
from employee
where dno in ( select dno from employee where ename like '%K%' )

select * from employee where ename like '%K%' 

12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
select * from department; 

-- JOIN �� ���
select ename, e.dno, job, loc             -- �� ���̺��� ���� Ű �÷�, EQUI JOIN������ ���̺���� ��� 
from employee e , department d
where e.dno = d.dno
and loc = 'DALLAS'

--Sub Query 
select ename, e.dno , job , loc 
from employee e, department d 
where e.dno =d.dno
and e.dno in (select dno from department where loc = 'DALLAS')  


13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select * from employee; 

select ename, salary, manager
from employee
where manager = ( select eno from employee where ename='KING' ) 


14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�.
select * from department

-- JOIN 
select eno �μ���ȣ, ename ����̸�, job ������, dname �μ��� 
from employee e, department d
where e.dno  = d.dno 
and d.dname = 'RESEARCH' 

-- Sub Query 
select eno �μ���ȣ, ename ����̸�, job ������, dname �μ��� 
from employee e, department d
where e.dno  = d.dno 
and e.dno in ( Select dno from department where dname = 'RESEARCH')  


15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
select round(avg (salary )) from employee 

select eno �����ȣ, ename �̸�, salary �޿�
from employee 
where salary > (select round(avg (salary )) from employee)  
        and dno IN ( select dno from employee where ename like '%M%') 

select * from employee where ename like '%M%' 

16. ��� �޿��� ���� ���� ������ ã���ÿ�. 
select job ���� , round ( avg (salary)) ��ձ޿�
from employee
group by job
having avg(salary) = ( select min ( avg(salary) ) from employee group by job )


17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
select ename ����� 
from employee
where dno in ( select dno from employee where job = 'MANAGER' )

select * from employee where job ='MANAGER' 









            
    
  
  
  
  
  
  
  
  
  
  
  