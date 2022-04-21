-- 숫자함수
/*
    ROUND : 특정 자릿수에서 반올림
    TRUNK : 특정 자릿수에서 잘라냄(버림)
    MOD : 입력 받은 수를 나눈 나머지 값만 출력
*/
-- round(대상) : 소숫점 아래자리에서 반올림
-- 소수점자릿수 : 양수 일때 소수점 오른쪽으로 자릿수만큼 이동한 후 그 뒤에서 반올림
-- : 음수 일때 왼쪽으로 자릿수만큼 이동 후 반올림
select 98.7654, ROUND(98.7654), ROUND(98.7654,2), round(98.7654,-2) from dual;

-- 날짜함수
/*
    sysdate : 시스템에 저장된 현재 날짜 출력
    months_between : 두 날짜 사이의 몇 개월인지 반환
    add_months : 특정 날짜에 개월 수 더함
    next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜 변환
    last_day : 달의 마지막 날짜를 변환
    round : 인자로 받은 날짜를 특정 기준으로 반올림
    trunk : 인자로 받은 날짜를 특정 기준으로 버림
*/

select sysdate 
from dual;

select sysdate -1 as 어제날짜, sysdate as 오늘날짜, sysdate+1 내일날짜
from dual;

-- 특정 날짜에서 월을 기준으로 반올림한 날짜 ( 16일이상 반올림)
select hiredate,round(hiredate, 'MONTH') from employee;

-- 입사일부터 현재까지 사원들의 근무 개월 수 구하기
select ename, sysdate, hiredate, months_between(sysdate,hiredate) as "근무 개월 수"
from employee;

-- 입사 후 6개월이 지난 시점
select hiredate, add_months(hiredate, 6)
from employee;

-- 입사 후 100일이 지난 시점의 날짜
select hiredate, hiredate+100 as "입사 후 100일 날짜"
from employee;

-- next_day (date, '요일') : date이후 도래하는 요일의 날짜
select sysdate, next_day(sysdate,'토요일') as "이번 주 토요일의 날짜"
from dual;

-- last_day (date) : 해당 달의 마지막 날짜
select hiredate, last_day(hiredate)
from employee;

-- 형 변환 함수 : 중요함
/*
    TO_CHAR : 숫자, 날짜를 문자형으로 변환
    TO_DATE : 문자형을 날짜형으로 변환
    TO_NUMBER : 문자형을 숫자형으로 변환
*/

-- 날짜 함수 사용하기
-- to_char (date,'YYYYMMDD")
select ename, hiredate, to_char(hiredate,'YYYYMMDD'), to_char(hiredate, 'YYMM'), 
    to_char(hiredate,'YYYYMMDD DAY'), to_char(hiredate,'YYYYMMDD DY')
from employee;

-- 현재 시스템의 오늘 날짜를 출력( 초까지)
select sysdate, to_char(sysdate,'YYYY-MM-DD HH:MI:SS DAY')
from dual;

desc employee;

select hiredate, to_char(hiredate,'YYYY-MM-DD HH:MI:SS DAY')
from employee;

-- to_char에서 숫자와 관련된 형식
/*
    0 : 자리수를 나타내며, 자리수가 맞지 않을 경우 0으로 채움
    9 : 자리수를 나타내며, 자리수가 맞지 않아도 채우지 않음
    L : 각 지역별 통화 기호 출력
    . : 소수점 표현
    , : 천단위의 구분자
*/
desc employee;

select ename, salary, to_char(salary,'L999,999'), to_char(salary, 'L0000,000')
from employee;

-- to_date('char','format') : 날짜형으로 변환

-- 오류 발생 : date- - char
/*select sysdate, syadate - '20000101'
from dual;*/

-- 2000년 1월 1일부터 오늘까지의 일 수
select sysdate, trunc(sysdate - to_date('20000101','YYYYMMDD'))
from dual;

select hiredate, trunc(hiredate - to_date('19600101','YYYYMMDD'))
from employee;

select ename, hiredate
from employee
where hiredate = to_date('1981-02-22', 'YYYY-MM-DD');

-- 2000년 12월 25일부터 오늘까지 총 몇달이 지났는지 출력
select trunc(months_between(sysdate,to_date('2000-12-25','YYYY-MM-DD')))
from dual;

-- nvl 함수 : null값을 다른값으로 치환
    -- nvl(A,B) : A가 null이면 B로 치환
select commission from employee;

select commission, nvl(commission, 0)
from employee;

select manager from employee;

select manager, nvl(manager, 1111)
from employee;

-- nvl2(A,B,C) : A가 null이, 아니면 B 출력, null이면 C 출력

--  nvl 함수로 연봉 계산하기
select salary, salary*12, commission, nvl(commission, 0),
    salary*12 + nvl(commission, 0) as 연봉
from employee;

--  nvl2 함수로 연봉 계산하기
select salary, commission, nvl2(commission,  salary*12 + commission, salary*12) as 연봉
from employee;

-- nullif : 두 표현식을 비교해서 동일한 경우 null 반환, 아니면 첫번째 표현식 반환
select nullif('A','A'), nullif('A','B')
from dual;

-- coalesce 
coalesce (expr1, expr2, expr3, .... expr-n) 
    -- expr1이 null이 아니면 expr1을 반환
    -- expr1이 null이고 expr2가 null이 아니면 expr2 반환
    
select coalesce('abc','bcd','cde','def')
from dual;

select coalesce(null,'bcd','cde','def')
from dual;

select ename, salary, commission, coalesce(commission, salary, 0)
from employee;

-- decode 함수
/*
    decode(표현식, 조건1, 결과1
                  조건2, 결과2
                  조건3, 결과3
                  기본결과
                  )
*/

select ename, dno, decode(dno, 10, 'ACCOUNTING',
                               20, 'RESEARCH',
                               30, 'SALES',
                               40, 'OPERATION',
                               'DEFAULTS'
                          ) as DNAME
from employee;

-- dno컬럼이 10번 부서일 경우 월급에서 +300, 20번 부서일경우 월급에 + 500을 
-- 부서번호가 30일 경우 월급에 +700해서 이름,월급, 부서별 월급 + 결과 출력

select ename, dno, salary, decode(dno, 10, salary+300,
                                  20, salary+500,
                                  30, salary+700,
                                  salary
                                  )
from employee;              

-- case : if~else 
select ename, dno, case when dno=10 then 'ACCOUNTING',
                        when dno=20 then 'RESEARCH',
                        






