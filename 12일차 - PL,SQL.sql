12���� PL/SQL : ����Ŭ���� ���α׷��� ��Ҹ� ������ sql
        MSSQL : T-SQL, 
    sql : ����ȭ�� ���Ǿ��, ���� : ������ ���α׷��� ����� ���� �Ұ�
    
set serveroutput on     -- pl/sql�� ��� Ȱ��ȭ

PL/SQL�� �⺻ �ۼ� ����

begin
    -- ����
end;
/

show user;
-- PL/SQL ���� �⺻ ���
set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- �ڷ��� ����
    1. oracle�� �ڷ���
    2. �����ڷ��� : ���̺��� �÷��� ����� �ڷ����� �����ؼ� ���
        %type : ���̺��� Ư�� �÷��� �ڷ��������� (���̺��� �÷� 1��)
        %rowtype : ���̺� ��ü �÷��� �ڷ����� ��� ����

-- PL/SQL ���� ���� ����
������ := ������ ��;

set serveroutput on

declare -- ���� ����
    v_eno number(4); -- ����Ŭ�� �ڷ���
    v_ename employee.ename%type; 
    -- �����ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� ���� : employee�� ename �� �ڷ���
begin
    v_eno := 7788;
    v_ename := 'SCOTT';
    
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno || '         ' ||v_ename); 
end;
/

set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type; 
begin
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('--------------------');
    
    select eno, ename into v_eno, v_ename
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line(v_eno || '         ' ||v_ename);
end;
/

-- ��� ���
-- if - end if

set serveroutput on
declare
    v_employee employee%rowtype; -- rowtype : employee �� ��� �÷��� �ڷ��� ����
                    -- v_employee������ employee�� ��� �÷� ����
    annsal number (7,2);  -- �� ������ �����ϴ� ����
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    
    if(v_employee.commission is null) then
        v_employee.commission := 0;
    end if;
    
    annsal := v_employee.salary*12 + v_employee.commission;
    
    dbms_output.put_line('�����ȣ   ����̸�   ����');
    dbms_output.put_line('=======================');
    dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||annsal);
end;
/

/*
    v_employee.�÷��� : rowtype���� ����� �÷������� ���
*/

/* PL/SQL�� ����ؼ� deparatment ���̺��� ������ ��Ƽ� ���
    ���� dno = 20
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
    
    dbms_output.put_line('�����ȣ   �����   �μ���');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_dname);
end;
/

employee ���̺��� eno, ename, salary, dno�� pl/sql�� ���
���� : ���ʽ� 1400

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


-- Ŀ�� (cursor) : select �� ����� ���� ���ڵ尡 �ƴ϶� ���ڵ� ���� ��� �ʿ�
declare
    cursor Ŀ����              1.Ŀ�� ����
    is
    Ŀ���� ������ select ����


begin
    open Ŀ����;               2. Ŀ�� ����
    loop
        fetch ����            3. Ŀ���� �̵��ϰ� ���
    end loop;
    close Ŀ����;              4. Ŀ�� ����
end;
/

-- Ŀ���� ����ؼ� department ��� ���� ���
set serveroutput on
declare
    v_dept department%rowtype;
    cursor c1
    is
    select * from department;
begin
    dbms_output.put_line('�μ���ȣ   �μ���   �μ���ġ');
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
    Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ���
        - Ŀ����%notfound : Ŀ������ ���� ��� �ڷᰡ fetch �Ǿ��ٸ� true
        - Ŀ����%found : Ŀ�� ���� ���� fetch ���� ���� �ڷᰡ �����ϸ� true
        - Ŀ����%isopen : Ŀ���� ���µǾ��ٸ� true
        - Ŀ����%rowcount : Ŀ���� ���� ���ڵ� ����
*/

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


















