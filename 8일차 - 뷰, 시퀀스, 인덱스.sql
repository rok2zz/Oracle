-- 8일차 - 뷰, 시퀀스, 인덱스

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- 뷰 생성
create view v_emp_job
as
select eno, ename, dno, job
from emp_copy60
where job like 'SALESMAN';

-- 뷰 생성 확인
select * from user_views;

select * from user_views
where view_name = 'V_EMP_JOB';

-- 뷰 실행
select * from v_emp_job;

-- 뷰에 조인 사용
create view v_join
as
select e.dno, ename, job, dname, loc
from employee e, department d
where e.dno = d.dno;

-- view : insert, delete, update 가능
create view v_dept10
as 
select dno, dname, loc
from dept_copy60;

insert into v_dept10
values (90, 'HR4', 'PUSAN4');

select * from v_dept10;

update v_dept10
set dname = 'HR5', loc = 'PUSAN5'
where dno= 90;

delete v_dept10
where dno = 90;

commit;

-- 읽기만 가능한 뷰 생성 : insert, update, delete 불가
create view v_readonly
as
select dno, dname, loc
from dept_copy60 with read only;

select * from v_readonly;

insert into v_readonly
values (88, 'HR7', 'PUSAN7'); -- 오류 발생

update v_readonly
set dname = 'HR77', loc = 'POUSAN77'
where dno = 88; -- 오류







