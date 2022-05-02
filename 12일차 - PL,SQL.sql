12일차 PL/SQL : 오라클에서 프로그래밍 요소를 적용한 sql
        MSSQL : T-SQL, 
    sql : 구조화된 질의언어, 단점 : 유연한 프로그래밍 기능을 적용 불가
    
set serveroutput on     -- pl/sql의 출력 활성화

PL/SQL의 기본 작성 구문

begin
    -- 구문
end;
/

show user;
-- PL/SQL 에서 기본 출력
set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- 자료형 선언
    1. oracle의 자료형
    2. 참조자료형 : 테이블의 컬럼에 선언된 자료형을 참조해서 사용
        %type : 테이블의 특정 컬럼의 자료형을참조 (테이블의 컬럼 1개)
        %rowtype : 테이블 전체 컬럼의 자료형을 모두 참조

-- PL/SQL 에서 변수 선언
변수명 := 변수의 값;

set serveroutput on

declare -- 변수 선언
    v_eno number(4); -- 오라클의 자료형
    v_ename employee.ename%type; 
    -- 참조자료형 : 테이블의 컬럼의 자료형을 참조해서 적용 : employee의 ename 의 자료형
begin
    v_eno := 7788;
    v_ename := 'SCOTT';
    
    dbms_output.put_line('사원번호      사원이름');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno || '         ' ||v_ename); 
end;
/

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type; 
begin
    dbms_output.put_line('사원번호      사원이름');
    dbms_output.put_line('--------------------');
    
    select eno, ename into v_eno, v_ename
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line(v_eno || '         ' ||v_ename);
end;
/

-- 제어문 사용
-- if - end if

set serveroutput on
declare
    v_employee employee%rowtype; -- rowtype : employee 의 모든 컬럼의 자료형 참조
                    -- v_employee변수는 employee의 모든 컬럼 참조
    annsal number (7,2);  -- 총 연봉을 저장하는 변수
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    
    if(v_employee.commission is null) then
        v_employee.commission := 0;
    end if;
    
    annsal := v_employee.salary*12 + v_employee.commission;
    
    dbms_output.put_line('사원번호   사원이름   연봉');
    dbms_output.put_line('=======================');
    dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||annsal);
end;
/

/*
    v_employee.컬럼명 : rowtype으로 저장시 컬럼에따라 출력
*/

/* PL/SQL을 사용해서 deparatment 테이블을 변수에 담아서 출력
    조건 dno = 20
*/

set serveroutput on
declare
    v_department_dno department.dno%type;
    v_department_dname department.dname%type;
    v_department_loc department.loc%type;
begin
    select dno, dname, loc into v_department_dno, v_department_dname, v_department_loc
    from department
    where dno = 20;
    
    dbms_output.put_line('dno   dname   loc');
    dbms_output.put_line(v_department_dno||'   '||v_department_dname||'   '||v_department_loc);
    
end;
/
set serveroutput on
declare
    v_department department%rowtype;
begin
    select * into v_department
    from department
    where dno = 20;
    
    dbms_output.put_line('dno   dname   loc');
    dbms_output.put_line(v_department.dno||'   '||v_department.dname||'   '||v_department.loc);
    
end;
/

-- if ~ elsif ~ end if
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;
begin
    select eno, ename, dno into v_eno, v_ename, v_dno
    from employee
    where ename = 'SCOTT';

    if (v_dno = 10) then
        v_dname := 'ACCOUNT';
    elsif (v_dno = 20) then
        v_dname := 'RESEARCH';
    elsif (v_dno = 30) then
        v_dname := 'SALES';
    elsif (v_dno = 40) then
        v_dname := 'OPERATIONS';
    end if;
    
    dbms_output.put_line('사원번호   사원명   부서명');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_dname);
end;
/

employee 테이블의 eno, ename, salary, dno을 pl/sql로 출력
조건 : 보너스 1400

1. %type
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno, ename, salary, dno into v_eno, v_ename, v_salary, v_dno
    from employee
    where commission = 1400;

    dbms_output.put_line('사원번호   사원명   급여   부서번호');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_salary||'   '||v_dno);
end;
/


2. %rowtype
set serveroutput on
declare
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission = 1400;

    dbms_output.put_line('사원번호   사원명   급여   부서번호');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||v_employee.salary||'   '||v_employee.dno);
end;
/


-- 커서 (cursor) : select 한 결과가 단일 레코드가 아니라 레코드 셋인 경우 필요
declare
    cursor 커서명              1.커서 선언
    is
    커서를 부착할 select 구문


begin
    open 커서명;               2. 커서 오픈
    loop
        fetch 구문            3. 커서를 이동하고 출력
    end loop;
    close 커서명;              4. 커서 종료
end;
/

-- 커서를 사용해서 department 모든 내용 출력
set serveroutput on
declare
    v_dept department%rowtype;
    cursor c1
    is
    select * from department;
begin
    dbms_output.put_line('부서번호   부서명   부서위치');
    dbms_output.put_line('-------------------------');
    open c1;            
    loop
        fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno||'   '||v_dept.dname||'   '||v_dept.loc);
    end loop;
    close c1;      
end;
/

/*
    커서의 속성을 나타내는 속성값
        - 커서명%notfound : 커서영역 내의 모든 자료가 fetch 되었다면 true
        - 커서명%found : 커서 영역 내의 fetch 되지 않은 자료가 존재하면 true
        - 커서명%isopen : 커서가 오픈되었다면 true
        - 커서명%rowcount : 커서가 얻어온 레코드 개수
*/

/*
    사원명, 부서명, 부서위치, 월급을 출력하세요. pl/sql 사용
    커서 사용
*/
set serveroutput on
declare
    v_emp employee%rowtype;
    v_dept department%rowtype;
    cursor c1
    is
    select ename, dname, loc, salary from employee inner join department
    on employee.dno = department.dno;
begin
    dbms_output.put_line('사원명   부서명   부서위치   월급');
    dbms_output.put_line('------------------------------');
    open c1;            
    loop
        fetch c1 into v_emp.ename,v_dept.dname, v_dept.loc, v_emp.salary;
        exit when c1%notfound;
        dbms_output.put_line(v_emp.ename||'   '||v_dept.dname||'   '||v_dept.loc||'   '||v_emp.salary);
    end loop;
    close c1;      
end;
/


















