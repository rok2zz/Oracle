/*
    그룹함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수
        group by 절에 특정 컬럼을 정의 할 경우, 해당 컬럼의 동일한 값들을 그룹핑해서 연산 적용

    집계함수 
        - SUM : 그룹의 합계
        - AVG : 그룹의 평균
        - MAX : 그룹의 최대값
        - MIN : 그룹의 최소값
        - COUNT : 그룹의 총 개수(레코드 수 record, 로우 수 row)
*/  

select sum(salary), avg(salary), round(avg(salary),2), max(salary), min(salary)
from employee;

-- 주의사항 : 집계함수를 처리할 때 출력 컬럼 오류
select sum(salary), ename
from employee;

-- 집계함수는 null값을 처리해서 연산
select sum(commission), avg(commission), max(commission), min(commission)
from employee;

-- count() : 레코드, 로우 수
    -- null은 카운트하지 않음
    -- 테이블 전체 레코드 수를 가져올 경우 : count(*) or nou null 컬럼을 count()
    
select eno from employee;
select count(eno) from employee;
select count(commission) from employee;

-- 중복없이 가져오기
select count(distinct dno) from employee;

-- group by : 특정 컬럼별 평균, 합등 계산 가능
select dno as 부서번호, avg(salary) as 평균급여
from employee
group by dno;

-- 동일한 직책을 그룹핑해서 월급의 평균, 합, 최대, 최소
select job, count(job), avg(salary), sum(salary), max(salary), min(salary)
from employee
group by job;

-- 동일한 직책을 그룹핑해서 집계

-- 여러컬럼 그룹핑
select dno, job, count(*), sum(salary)
from employee
group by dno,job; -- 두 컬럼이 모두 일치하는 것 그룹핑

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- having : group by 에서 나온 결과를 조건으로 처리
select dno, count(*), sum(salary) as 부서별합계, round(avg(salary), 2) as 부서별평균
from employee
group by dno;

-- 월급의 합이 9000 이상인것
select dno, count(*), sum(salary) as 부서별합계, round(avg(salary), 2) as 부서별평균
from employee
group by dno
having sum(salary)>9000;

-- 월급의 평균이 2000 이상인것
select dno, count(*), sum(salary) as 부서별합계, round(avg(salary), 2) as 부서별평균
from employee
group by dno
having avg(salary)>2000;

-- rollup, cube 사용x
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by dno
order by dno;

-- rollup : group by 절 안에서 사용 , 컬럼 별 내용 출력 후 전체의 합, 평균 등 출력
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;

-- cube : 마지막 라인에 전체 합계, 평균
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by cube(dno)
order by dno;

-- rollup : 2컬럼이상, 두개가 같은것만 출력
select dno, job, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno, job)
order by dno;

-- cube : 2컬럼이상
select dno, job, count(*), sum(salary), round(avg(salary))
from employee
group by cube(dno, job)
order by dno;

-- join : 두 테이블은 사실 하나의 테이블, 모델링(중복제거, 성능향상)을 통해 분리
    --  공통 키컬럼 dno는 서로의 dno 컬럼 참조
    -- 두개 이상의 테이블의 컬럼을 join 구문을 사용해서 출력

select * from department; -- 부서정보
select * from employee; -- 사원정보
-- 두 테이블의 공통 키 컬럼 : dno

-- equi join : 오라클에서 제일 많이 사용하는 join,  oracle 에서만 사요악능
    -- from : 조인할 테이블을 "," 로 처리
    -- where : 두 테이블의 공통의 키 컬럼을 " = " 로 처리
    -- and : 조건을 처리
    -- on 절 사용 : 두 테이블의 공통의 키 컬럼 " = " 로 처리
    
-- where 에서 공통 컬럼 처리  
select * 
from employee, department
where department.dno = employee.dno
and job = 'MANAGER';

-- ansi 호환 : inner join : 모든 sql에서 사용 가능
-- on 절 : 공통 키컬럼을 처리한 경우
select * 
from employee e inner join department d --inner 생략 가능
on e.dno = d.dno
where job = 'MANAGER';

-- join 시 테이블 알리어스
select * 
from employee e, department d
where d.dno = e.dno
and salary>1500;

-- select 절에서 공통 키컬럼 출력 할 떄 어느 컬럼의 컬럼인지 명시
select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno;

-- 두 테이블을 join해서 월급의 최대값을 부서명으로 출력

select dname, max(salary)
from employee e, department d
where e.dno = d.dno
group by(dname);

-- natural join : oracle 9부터 지원
    -- equi join의  where 절을 없앰 : 두 테이블의 공통 키 컬럼을 정의 " = "
    -- 공통 키 컬럼을 oracle 내부적으로 자동으로 감지해서 처리
    -- 공통 키컬럼을 별칭 이름을 사용하면 오류 발생.
    -- from 절에 natural join 키워드 사용
    
select eno, ename, dname, dno
from employee e natural join department d;

-- 주의 : select 절의 공통키 컬럼을 출력 시 테이블 명을 명시하면 오류 발생

-- EQUI JOIN vs NATURAL JOIN의 공통 키 컬럼 처리
    -- EQUI JOIN : select 에서 반드시 공통 키 컬럼을 출력 할 때 테이블 명을 명시
    -- NATURAL JOIN : select에서 반드시 공통 키 컬럼을 출력 할 때 테이블 명 명시하면 안됨


select ename, salary, dname, e.dno
from employee e, department d
where e.dno = d.dno;

select ename, salary, dname, dno
from employee natural join department;

-- NON EQUI JOIN : EQUI JOIN에서 Where 절의 " = " 를 사용하지 않는 join
select * from salgrade; -- 영업비의 등급을 표시하는 테이블

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;





