--6���� - CRUD (Create, Read, Update, Delete)

-- Object (��ü) : DataBase�� ���� (XE, <=Express Edition(���� ����), Standard Edtion(����), Enterprise Edition(����))
    -- Databese�� �ִ� ��ü�� ==> 
    --1. ���̺�, 2. ��, 3, ������������, 4, Ʈ����, 5, �ε���, 6.�Լ�, 7.������ 
    -- DDL(Create, Alter, Drop) <== ��ü�� �����,����,����

-- ���̺� ���� (Create)  --DDL ��ü ����

/*
    Create Table ���̺��(
        �÷��� �ڷ��� NULL��뿩�� [��������],
        �÷��� �ڷ��� NULL��뿩�� [��������],
        �÷��� �ڷ��� NULL��뿩�� [��������],
    );
*/
Create Table dept (
    dno NUMBER(2) NOT NULL, 
    dname VARCHAR(14) NOT NULL,
    loc VARCHAR(13) NULL
);

SELECT * FROM dept;

--DCL : DB�� �����͸� �����ϱ� ���� ��ɾ�. COMMIT, ROLLBACK, GRANT, REVOKE ���� �ش�ȴ�.

 -- begin transaction;    --Ʈ����� ���� (Insert, update, delete ������ ���۵Ǹ� �ڵ����� ����)
 --   rollback;           --Ʈ������� �ѹ�(RAM�� ����� Ʈ������� ����)
 --   commit;             --Ʈ������� ����( ���� Database�� ������ ����)

--DML : ���̺� ��(���ڵ�,�ο�)�� �ְ�(INSERT), ����(UPDATE), ����(DELETE)
    --Ʈ������� �߻� ��Ŵ: log�� ����� �����ϰ� Database�� �����Ѵ�.

/*
    INSERT INTO ���̺��(�÷���,�÷���,�÷���)
    VALUES (��1, ��2, ��3)
*/

INSERT INTO dept (dno, dname,loc)
VALUES (10, 'MANAGER', 'SEOUL');

    --insert,update,delete ������ �ڵ����� Ʈ������� ����( begin transaction) - RAM���� ����Ǿ� �ִ� ����
    
rollback;
commit;

/*  insert �� �÷����� ����
    insert into dept
    values (��1, ��2, ��3)
    
*/

SELECT * FROM dept;

INSERT INTO dept
values (20,'ACCOUTING', 'PUSAN');

commit;

desc dept;

/* NULL ��� �÷��� ���� ���� �ʱ� */
INSERT INTO dept(dno,dname)
VALUES (30,'RESEARCH');

--������ ������ ���� �ʴ� ���� ������ ���� �߻�

INSERT INTO dept (dno, dname, loc)
VALUES (300,'SALES', 'DAEGU'); --���� �߻�, NUMBER(2) ���� ���ڸ������� ������ �ִ�.

INSERT INTO dept (loc,dname,dno)
VALUES ('DAEGEON','SALESSSSSSSSSSSSSSSS',60); --���� �߻�, dname VARCHAR2(14) 14�ڸ� ������ �ִ�.

--�ڷ��� (���� �ڷ���)
    --CHAR(10)          :����ũ�� 10����Ʈ, 3����Ʈ�� ���� ��� ����� 7����Ʈ ����, ���� : ������ ����, ���� : �ϵ��������
        --�ڸ����� �˼� �ִ� ���� ũ�� �÷� (ex..�ֹι�ȣ, ��ȭ��ȣ)
    --VARCHAR(10) :     :����ũ�� 10����Ʈ, 3����Ʈ ���� ��� 3����Ʈ�� �����Ҵ�,    ���� : �ϵ�������� ����, ���� : ������ ����
        --�ڸ����� ����ũ���� ��� (ex..�ּ�, �����ּ�)
    --NCHAR(10)     : �����ڵ� 10�� ( �ѱ�, �߱���, �Ϻ���..)
    --NVARCHAR2(10) : �����ڵ� 10�� ( �ѱ�, �߱���, �Ϻ���..)
    
--�ڷ��� (���� �ڷ���)
    --NUMBER(2)     : ���� 2�ڸ��� �Է� ���
    --NUMBER(7,3)   : ��ü 7�ڸ�, �Ҽ��� 3�ڸ����� �����.
    --NUMBER(8,5)   : ��ü 8�ڸ�, �Ҽ��� 5�ڸ����� �����.
    
CREATE TABLE test1_tbl(
    a NUMBER(3,2) not null,
    b NUMBER(7,5) not null,
    c CHAR(6) null,      --<==�ѱ��� 3byte�� ����ؼ� �ֱ� ����( 6����Ʈ�� �ѱ� 2���� ����)
    d VARCHAR2(10) null, --<==�ѱ��� 3byte�� ����ؼ� �ֱ� ����( 10����Ʈ�� �ѱ� 3���� ����)
    e NCHAR(6) null,
    f NVARCHAR2(10) null
);



DESC test1_tbl;
SELECT * FROM test1_tbl;

INSERT INTO test1_tbl (a,b,c,d,e,f)
VALUES ( 3.22, 77.55555, 'aaaaaa', 'bbbbbbbbbb', '�ѱ��̿�����', '�ѱۿ��ڱ�������ؿ�');

INSERT INTO test1_tbl (a,b,c,d,e,f)
VALUES ( 3.22, 77.55555, '�ѱ�', '�ѱ۱�', '�ѱ��̿�����', '�ѱۿ��ڱ�������ؿ�'); --�ѱ� 1���ڴ� 3byte�� �����Ѵ�

CREATE TABLE member1 (
    no NUMBER(10) NOT NULL,
    id VARCHAR2(50) NOT NULL,
    passwd VARCHAR2(50) NOT NULL,
    name NVARCHAR2(6) NOT NULL,
    phone VARCHAR2(50) NULL,
    address VARCHAR2(100) NULL,
    mdate DATE NOT NULL,
    email VARCHAR2(50) NULL
    );
    
SELECT * FROM member1;
DESC member1;

INSERT INTO member1 (no, id, passwd, name, phone, address, mdate, email)
VALUES (1,'aaa','password', 'ȫ�浿', '010-1111-1111', '���� �߱� ���굿',sysdate, 'aaa@aaa.com');

INSERT INTO member1 
VALUES (2,'bbb','password', 'ȫ�浿', '010-2222-2222', '���� �߱� ���굿',sysdate, 'bbb@bbb.com');

commit;

--NULL ��� �÷��� NULL�� ���� �Ҵ�
INSERT INTO member1 (no, id, passwd, name, phone, address, mdate, email)
VALUES (3,'ccc','password', '������', 'NULL', 'NULL',sysdate, 'NULL');

--NULL ��� �÷��� ���� ���� ���� ��� NULL ���� ��
INSERT INTO member1 (no, id, passwd, name, mdate)
VALUES (4,'ddd','password', '�������',sysdate);

--������ ���� (update : ������ ���� �� commit;)
    -- �ݵ�� where ������ ����ؾ� �Ѥ�. �׷��� ������ ��� ���ڵ尡 ������
    
/*
    update ���̺��
    set �÷��� = �����Ұ�
    where �÷��� = ��

*/

UPDATE member1
SET name ='�Ż��Ӵ�'
WHERE no =2;
commit;

SELECT * FROM member1;

UPDATE member1
SET name ='��������'
WHERE no=3;
commit;

UPDATE member1
SET id ='abcd'
WHERE no=3;

UPDATE member1
SET name ='������'
WHERE no=1;

UPDATE member1
SET mdate ='2022/01/01'
WHERE no=4;

UPDATE member1
SET email ='abcd@abcd.com'
WHERE no=1;

commit;

--�ϳ��� ���ڵ忡�� �����÷� ���ÿ� �����ϱ�

UPDATE member1
set name ='������', email= 'kkk@kkk.com', phone ='010-7777-7777'
WHERE no=1;

SELECT * FROM member1;

UPDATE member1
set mdate=to_date('2022-01-01','YYYY-MM-DD')
WHERE no=3;
commit;

delete member1 -- ��� ���ڵ� ����
rollback;

    
    




