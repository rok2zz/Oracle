show user;

-- �ְ� ������ ����(sys)  : ���� ���� ���� ��

-- ���̵� : usertest01, ��ȣ : 1234
create user usertest01 identified by 1234;
-- ������ ��ȣ�� �����ߴ� �ص� ������ �ο� �޾ƾ� ���� ����

-- System privileges
    -- create session : ����Ŭ�� ���� �� �� �ִ� ����
    -- create table : ���̺� ���� ����
    -- create sequence
    -- create view

/*
    DDL : ��ü ���� (Create, Alter, Drop)
    DML : ���ڵ� ���� (Insert, Update, Delete)
    DQL : ���ڵ� �˻� (Select)
    DTL : Ʈ����� (Begin transaction, rollback, commit)
    DCL : ���� ����(Grant, Revoke, Deny)
*/

-- ������ �������� ����Ŭ�� ���� �� �� �ִ� create session ���� �ο�
-- grant �ο��� ���� to ������
Grant create session to usertest01;

-- ����Ŭ�� �����ߴٰ� �ؼ� ���̺� ���ٱ����� �ִ� ���� �ƴ�
Grant create table to usertest01;

/*
    ���̺� �����̽� : ��ü�� �����ϴ� ����. ������ �������� �� ����ں� �����̽� Ȯ��
    SYSTEM : DBA(������ ���������� ���� ����)
*/
select * from dba_users; -- dba_ : sys (�ְ� ������ �������� Ȯ��)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST01');

-- �������� ���̺� �����̽� ����(SYSTEM >> USERS) 
alter user usertest01
default tablespace users
temporary tablespace temp;

-- �������� Users ���̺� �����̽��� ����� ���� �Ҵ�
alter user usertest01
quota 2m on users;

-- ------------------------------
-- ���� : usertest02 ���� �� users ���̺� �����̽����� ���̺�(tbl2) ������ insert









