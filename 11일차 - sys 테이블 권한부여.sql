-- Ư�� ���̺� Select ���� �ο��ϱ�
    -- sys���� ���� �ʿ�
-- Autication (����) : credential ( ID + Pass )
create user user_test10 identified by 1234;

-- Authorization (�㰡)
grant create session, create table, create view to user_test10;

-- ������ �����ϸ� system ���̺� �����̽��� ��� << �����ڸ� ��밡���� ���̺� �����̽�
-- ���̺� �����̽� �ٲٱ�
Alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- ���̺� �����̽� �뷮 �Ҵ�(���� �ο�)

-- Ư�� �������� ��ü ���� �� �� ������ ��ü ����
select * from dba_tables
where owner in ('HR', 'USER_TEST10');

-- �ٸ� ������� ���̺� ���� �Ϸ��� ������ ������ �Ѵ�.
grant select on hr.employee to user_test10;

grant select on hr.emp_copy55 to user_test10;

grant insert, update, delete on hr.emp_copy55 to user_test10;

-- ���� ����
revoke insert, update, delete on hr.emp_copy55 from user_test10;

-- with grant option : Ư�� �������� ������ �ο��ϸ鼭 �ش� ������ �ٸ� ����ڿ��� �ο��� �� �ִ� ����


grant select on hr.emp_copy55 to user_test10 with grant option;
    -- user_test10�� �ٸ� ����ڿ��� hr.employee �� select ���� �ο� ����

grant select on hr.dept_copy55 to user_test10 with grant option;

-- Public : ��� ����ڿ��� ���� �ο�
grant select, insert, update, delete on hr.dept_copy56 to public;


/*
    ��(role) : ���� ����ϴ� �������� ������ ���� ���� �� : dba, connect, resuorce 
        1. dba : �ý����� ��� ������ ����� role, sys����
        2. connect : 
        3.
        
*/

-- ����� ���� role ���� : ���� ����ϴ� ���ѵ��� ��� role ����
1. �� ���� : 
create role roletest1;

2. �ѿ� ���� ����ϴ� ���� ����
grant create session, create table, create view, create sequence, create trigger to roletest1;

3. ������ ���� ������ ����
grant roletest1 to USER_TEST10;

-- ���� ����ڿ��� �ο��� �� Ȯ��
select * from user_role_privs;

-- �ѿ� �ο��� ���� ���� Ȯ��
select * from role_sys_privs
where role like 'ROLETEST1';

-- ��ü ������ role�� �ο��ϱ�
create role roletest2;

-- employee�� select �� ������ �ѿ� �ο�
grant select on hr.employee to roletest2;

-- ���� ������ ����
grant roletest2 to user_test10;

-- �ǽ� : dept_copy57
hr.dept_copy57 ����
roletest3 ���� : dept_copy57�� select, insert, update, delete �ϴ� ��ü��
user_test10 �� ����;

create role roletest3;
grant select, insert, update, delete on hr.dept_copy57 to roletest3;

grant roletest3 to user_test10;





















