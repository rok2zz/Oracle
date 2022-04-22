-- 테이블 조인 문제

-- 1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오. 
select ename, d.dno, dname
from employee e, department d
where d.dno = e.dno
and ename = 'SCOTT';

-- 2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오. 
select ename, dname, loc
from employee inner join department
on employee.dno = department.dno;

-- 3. INNER JOIN과 USING 연산자를 사용하여 10번 부서에 속하는 모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 
select dno, job, loc
from employee inner join department
using (dno)
where dno = '10';

-- join 에서 USING을 사용하는 경우 :
    -- NATURAL JOIN : 공통 키 컬럼을 oracle 내부에서 자동 처리
        -- 반드시 두 테이블의 공통 키 커럶이 같아야 한다.
    -- 두 테이블의 공통 키 컬럼이 다르거나 여러개인 경우 USING 사용

-- 4. NATUAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
select ename, dname, loc
from employee natural join department
where commission is not null;

-- 5. EQUI 조인과 WildCard를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select ename, d.dno, dname
from employee e, department d
where d.dno = e.dno
and ename like '%A%';

-- 6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
select ename, job, dno, dname, loc
from employee natural join department 
where loc = 'NEW YORK';


