-- 제약 조건 : 테이블의 컬럼에 할당되어 데이터의 무결성 확보
    -- Primary Key : 테이블에 한번만 사용가능
        -- 중복된 값 넣을 수 x, null 못 넣음
    -- UNIQUE : 테이블의 여러 컬럼에 할당 가능, 중복된 값 x
        -- Null 넣을 수 있다, 한번만
    -- Foreign Key : 다른 테이블의 특정 컬럼의 값을 참조해서 넣을 수 있다
        -- 자신의 컬럼에 임의의 값 할당 불가
    -- Not Null : null 할당 불가
    -- CHECK : 컬럼에 값을 할당 할 때 체크해서 값을 할당 (조건 만족시)
    -- Default : 값을 넣지 않을 때 기본값 할당
    

-- join 에서 USING을 사용하는 경우 :
    -- NATURAL JOIN : 공통 키 컬럼을 oracle 내부에서 자동 처리
        -- 반드시 두 테이블의 공통 키 커럶이 같아야 한다.
    -- 두 테이블의 공통 키 컬럼이 다르거나 여러개인 경우 USING 사용 
    
-- self join : 자기 자신의 테입르 조인 , 별칭 반드시 사용

select eno, ename, manager
from employee
where manager = '7788';

-- self join을 이용해 사원의 이름과 직속상관 이름 출력
select e.eno as 번호, e.ename 이름, e.manager 직속상관번호, m.ename as 직속상관이름
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

select e.ename||'의 직속상관은' || e.manager ||'입니다.'
from employee e, employee m
where e.manager = m.eno
order by  e.ename asc;

select eno, ename, manager, eno, ename
from employee;

-- ansi 호환 : inner join 으로 처리
select e.eno as 번호, e.ename 이름, e.manager 직속상관번호, m.ename as 직속상관이름
from employee e inner join employee m 
on e.manager = m.eno
order by e.ename asc;

select e.ename||'의 직속상관은' || e.manager ||'입니다.'
from employee e inner join employee m
on e.manager = m.eno
order by  e.ename asc;

-- outer join
    -- 특정 컬럼의 두 테이블에서 공통적이지 않은 내용을 출력 할 때
    -- 공적이지 않는 컬럼은 null 출력
    -- + 기호를 사용해서 출력 : oracle
    -- ansi 호환 : outer join 구문을 사용해서 출력 << 모든 dbms 에서 호환
    
-- oracle
select e.ename, m.ename
from employee e join employee m 
on e.manager = m.eno (+)
order by e.ename asc;

-- ansi 호환
    -- Left outer join : 공통적인 부분이 없더라도 왼쪽은 무조건 모두 출력
    -- Right outer join : 공통적인 부분이 없더라도 오른쪽은 무조건 모두 출력
    -- Full outer join : 공통적인 부분이 없더라도 무조건 모두 출력
    
select e.ename, m.ename
from employee e Right outer join employee m
on e.manager = m.eno
order by e.ename asc;

-- sub Query : select 문 내에 select 문이 있는 쿼리

select salary from employee where ename = 'SCOTT';

-- SCOTT의 월급보다 같거나 많은 사용자 출력
select ename, salary from employee where salary >= 3000;

select ename, salary 
from employee 
where salary >= (select salary from employee where ename = 'SCOTT');

-- SCOTT 과 동일한 부서에 근무하는 사원들 출력
select ename, dname
from employee e, department d
where e.dno = d.dno
and dname = (select dname from employee e, department d where e.dno = d.dno and ename = 'SCOTT');

-- 최소 급여를 받는 사원의 이름, 담당업무, 급여 출력
select ename, job, salary
from employee
where salary = (select min(salary) from employee);

-- 30번 부서에서 최소 월급을 받는 사원보다 많은 사원들 이름과 부서번호, 월급을 출력
select salary, dno from employee where dno = 30;
select min(salary) from employee where dno = 30;

select ename, dno, salary
from employee
where salary>(select min(salary)from employee where dno = 30);

-- Having 절에 sub query 사용

-- 30번 부서의 최소월급보다 큰 최소월급을 가진 부서
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

-- 단일행 서브 쿼리 : sub query 의 결과 값이 단 하나만 출력
    -- 단일행 비교 연산자 : >, =, >=, <=, < 등등
-- 다중형 서브 쿼리 : sub query 의 결과 값이 여러개 출력
    -- 다중행 서브쿼리 연산자 : in, any, some, all, exist
        -- IN : 메인 쿼리의 비교조건('=' 연산자로 비교할 경우) 이 서브쿼리의 결과값중에 하나라도 일치하면 참
        -- ANY, SOME : 메인 쿼리의 비교조건이 서브쿼리의 검색결과와 하나 이상 일치하면 참
        -- ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 검색결과와 모든 값이 일치하면 참
        -- EXIST : 메인 쿼리의 비교 조건이 서브 쿼리의 결과값 중에서 만족하는 값이 하나라도 존재하면 참

-- IN 연산자 사용하기
select ename, eno, dno, salary
from employee
order by dno asc;

-- 부서별로 최소 월급을 받는 사용자들 출력(sub query 사용)
select dno, min(salary), count(*)
from employee
group by dno;

select dno, min(salary), count(*)
from employee
where salary in (950,800,1300)
group by dno;

select ename, dno, salary
from employee
where salary in (select min(salary) from employee group by dno)
order by dno asc;

-- ANY 연산자
    -- 서브 쿼리가 반환하는 각각의 값과 비교
    -- '< any' 는 최대값 보다 작음
    -- '> any' 는 최소값 보다 큼
    -- '= any' 는 in과 동일
    
-- 직급이 salesman이 아니면서 급여가 임의의 salesman보다 작은 사원 출력
select ename, job, salary
from employee
order by job;

select ename, job, salary
from employee
where job <> 'SALESMAN'
and salary < any (select salary from employee where job = 'SALESMAN');

-- ALL 연산자
     -- sub query 의 반환하는 모든 값과 비교
     -- ' > all ' : 최대값보다 큼
     -- ' < all ' : 최소값보다 작음
    
-- 직급이 SALESMAN이 아니면서 직급이 SASESMAN 인 사원보다 급여가 적은 사원 출력
select ename, job, salary
from employee
where job <> 'SALESMAN'
and salary < all (select salary from employee where job = 'SALESMAN');   

-- 담당 업무가 분석가인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원 출력
select ename, job, salary
from employee
where job <> 'ANALYST'
and salary < all (select salary from employee where job = 'ANALYST');   

-- 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과 급여에 더해서 오름차순
select eno, ename, salary
from employee
where salary > (select avg(salary) from employee)
order by salary asc;
