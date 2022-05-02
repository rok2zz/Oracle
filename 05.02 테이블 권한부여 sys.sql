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

/*
    with grant option : Ư�� �������� ������ �ο��ϸ鼭 �ش� ������ �ٸ� ����ڿ��� �ο��� �� �ִ� ����

*/

grant select on hr.employee to user_test10 with grant option;
    -- user_test10�� �ٸ� ����ڿ��� hr.employee �� select ���� �ο� ����
    
    




