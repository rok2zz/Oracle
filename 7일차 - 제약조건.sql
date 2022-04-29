-- 7���� - ��������

-- ���̺� ���� : �÷��� ���ڵ常 ����

create table dept_copy
as
select * from department;

create table dept20
as
select * from department;
desc dept20;

-- ������ ���̺� �÷� �߰� : �ݵ�� null ���
alter table dept20
add (birth date);

alter table dept20
add (email varchar2 (100) not null); -- ����

alter table dept20
add (email varchar2 (100)); 

alter table dept20
add (address varchar2 (100)); 

-- �÷��� �ڷ��� ����
alter table dept20
modify dname varchar (100);

alter table dept20
modify dno number(4);

alter table dept20
modify address Nvarchar2 (200);

-- �÷� ���� : ���ϰ� ���� �ɸ��Ƿ� �����ð� �ܿ� �۾�
alter table dept20
drop column birth;

alter table dept20
drop column email;

alter table dept20
set unused (address); -- ����ϱ����� ����

alter table dept20
drop unused column;

-- �÷� �̸� ����





-- DML : Insert, Update, Delete

/*
    ���̺��� ��ü �����̳� ���̺� ���� ��
    1. delete : ���̺��� ���ڵ� ����, where ��� ���ҽ� ��� ���ڵ� ����
    2. truncate : ���̺��� ���ڵ� ����, �ӵ� ����
    3. drop : ���̺� ����
*/
create table emp10
as
select * from employee;

create table emp20
as
select * from employee;

create table emp30
as
select * from employee;

select * from emp30;

-- delete
delete emp10;

select * from emp10;
commit;

-- truncate
truncate table emp20;

select * from emp20;
commit;

-- drop
drop table emp30;

select * from emp30;
commit;

drop table emp;
drop table emp_copy;

/*
    ������ ���� : �ý����� ���� ������ ������ִ� ���̺�
        user_ : �ڽ��� ������ ���� ��ü���� ���
        all_ : �ڽŤ��� ������ ������ ��ü�� ������ �ο��� ��ü
        dba_ : ����Ÿ���̽� �����ڸ� ���� ������ ��ü
*/

show user;
select * from user_tables; -- ����ڰ� ������ ���̺� ����
select * from user_views;
select * from user_constraints;
select * from user_indexs;
select * from user_sequences;

select * from all_tables;
select * from all_views;

select * from dba_tables;

/*
    �������� : ���̺��� ���Ἲ�� Ȯ���ϱ� ���� �÷��� �ο��Ǵ� ��Ģ
        1. Primary Key
        2. Unique
        3. Not Null
        4. Check
        5. Foreign Key
        6. Default
*/

-- 1. Primary Key : �ߺ��� �� x
    -- ���̺� ������ �÷��� �ο�
    -- ���������̸� : �������� ������� , oracle���� �ڵ����� ����
    -- ���������� ������ �� ���� ���� �̸��� ����ؼ� ����
create table customer01(
    id varchar2 (20) not null  constraint PK_costomer01_id Primary Key,
    pwd varchar2 (20) constraint NN_customer01_pwd not null ,
    name varchar2 (20) constraint NN_customer01_name not null ,
    phone varchar2 (30) null,
    address varchar2 (100) null
); 
    
select * from user_constraints
where table_name = 'CUSTOMER01';
    
-- ���������� ����

-- 1. �������Ǹ����� �����ϱ�
alter table (���̺��) drop constraint (���������̸�) 
-- �̸� ������ �� ���������� �̸��� �Է�, �̷��� ���� ������ �������Ǹ��� �� �ľ��ؾ���.

-- 2. Ű �̸����� �����ϱ�
alter table (���̺��) drop PRIMARY KEY;

-- 3. cascade constraints ����ؼ� ���̺�� �Բ� �����
drop table (���̺��) cascade constraints; -- �� ����� ��� ���ʹ� �� �ٸ�. ���̺� ���� �ɷ��ִ����� �׳� �Ѳ����� ������ �ڵ���.
                                          --  ��ǻ� ���� ���� ����ϴ� ����̶�� �Ͻ�

-- 4.���� ���� ��Ȱ��ȭ �ϱ�
alter table (���̺��) disable constraint (�������Ǹ�); -- ���� �̷��� ġ�� ��ǥ ���̺��� �ٸ� ���̺��� �������̶�� ������ ���
                                                    -- �̶� �ٸ� ���̺��� �ɸ����Ÿ��� ���̺��̶�� Ī�ϰ���.
                                                    -- �ϴ� ���� �ɸ����Ÿ����� �Ʒ� �ڵ带 �Է��ؼ� ��Ȳ�� �ľ�����
                                                    
select constraint_name, table_name, status from user_constraints where table_name IN (('��ǥ ���̺��'),('�ɸ����Ÿ��� ���̺��'));
-- �̴� ��ȣ�ȿ� �� �̸��� �ݵ�� ��ҹ��ڸ� �����ؼ� ���̺��� ��Ī�� ��ġ������� �Ѵ�.
-- �̷��� ã���� ��ǥ ���̺�� �ɸ����Ÿ��� ���̺� ���� Ű���� � ������� �����ִ��� �ľ��� �����ϴ�
                                                    
alter table (���̺��) disable constraint (�������Ǹ�) cascade;  -- �̷��� �о������ ��ǥ���̺�� �ɸ����Ÿ��� ���̺� �ɷ��ִ�
                                                              -- ���� Ű���� �ѹ��� �� Ǯ����� �� ����. ��� Ǯ��� �Ұ�����.
                                                              
select constraint_name, table_name, status from user_constraints where table_name IN (('��ǥ ���̺��'),('�ɸ����Ÿ��� ���̺��'));
-- �ٽ� Ű ������ Ȯ���� �� �ִ� �ڵ带 �Է��غ��� ��� Ű���� DIASABLED �� ���� �� �� ����. 
    
 
    
    
    
    
    
    
    




