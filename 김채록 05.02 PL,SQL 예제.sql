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

    dbms_output.put_line('�����ȣ   �����   �޿�   �μ���ȣ');
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

    dbms_output.put_line('�����ȣ   �����   �޿�   �μ���ȣ');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||v_employee.salary||'   '||v_employee.dno);
end;
/

/*
    �����, �μ���, �μ���ġ, ������ ����ϼ���. pl/sql ���
    Ŀ�� ���
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
    dbms_output.put_line('�����   �μ���   �μ���ġ   ����');
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








































