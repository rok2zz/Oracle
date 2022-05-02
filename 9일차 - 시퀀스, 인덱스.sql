-- 9���� ������, �ε���

/*
    ������ : �ڵ� ��ȣ �߻���

*/

-- �ʱⰪ : 10, ������ : 10
create sequence sample_seq
    increment by 10 -- ������
    start with 10; -- �ʱⰪ
    
-- ������ ���� ��� (������ ����)
select * from user_sequences;

select sample_seq.nextval from dual; -- �������� ���� �� ���
select sample_seq.currval from dual; -- ���� �������� ��

-- �ʱⰪ : 2, ������ : 2
create sequence sample_seq2
    increment by 2 -- ������
    start with 2
    nocache;  --  ĳ�� ���x : �޸� ���x : ���� ���� �ٿ���

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- �������� Primary key �� �����ϱ�

create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

-- ������ ���� �ʱⰪ : 10, ������ : 10
create sequence dept_seq
    start with 10
    increment by 10
    nocache;

insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval, 'HR', 'SEOUL');

select * from dept_copy80;

-- cache : ������ ���� ����� ���� ��� ( �⺻�� : 20)
    -- ���� �ٿ�Ǹ� ĳ���� �ѹ��� ���ư�
    
create sequence emp_seq_no
    increment by 1
    start with 1
    nocache;
    
create table emp_copy80
as
select * from employee
where 0=1;

select * from emp_copy80;

-- �������� ���̺��� Ư�� �÷��� ����

insert into emp_copy80
values (emp_seq_no.nextval, 'SMITH', 'SALSEMAN', 2222, sysdate, 3000, 300, 20);

-- ������ ������ ����

select * from user_sequences;

alter sequence emp_seq_no
    maxvalue 1000;

alter sequence emp_seq_no
    cycle;  -- �ִ밪 ���� �� 

alter sequence emp_seq_no
    nocycle;
    
select * from user_sequences;
 
drop sequence sample_seq;

/* 
    INDEX : ���̺��� �÷��� ����, Ư�� �÷��� �˻��� ������ ��� �� �� �ֵ��� �Ѵ�.
        - INDEX PAGE : �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��� ����
        - ���� : å�� ���ΰ� ����
        - ���̺� ��ĵ : ���ڵ��� ó�� ~ ���������� �˻�
        - Primary Key, Unique Ű�� ����� �÷��� INDEX PAGE�� ������� ����
        - where ������ ���� �˻��� �ϴ� �÷��� index ����
        - ���̺��� �˻��� �����ϴ� �÷��� index�� ����, ���̺� ��ĵ�� ���� �ʰ�
            index page�� �˻��ؼ� ��ġ�� ������ ã�´�.
        - index�� ���� �� �� ���ϰ� ���� �ɸ���. �ַ� �߰��� ����
        - �ʹ� ���� �����ϸ� �ӵ��� ������
*/

-- index ������ ����Ǿ� �ִ� ������ ����
    -- user_columns, user_ind_columns
    
select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in('EMPLOYEE', 'DEPARTMENT');


select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select * from employee; -- eno �÷��� primary key <== �ڵ����� index ����

/*
    index �ڵ����� (Primary key, unique) �÷����� �ڵ� ����
*/

create table tbl1(
    a number (4) constraint PK_tbl1_a Primary Key,
    b number (4),
    c number (4)
);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TBL1', 'EMPLOYEE', 'DEPARTMENT');

select * from tbl1;

create table tbl2(
    a number (4) constraint PK_tbl2_a Primary Key,
    b number (4) constraint UQ_tbl2_b unique,
    c number (4) constraint UQ_tbl2_c unique,
    d number (4) ,
    e number (4)
)

create table emp_copy90
as 
select * from employee;

select * from emp_copy90;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP_COPY90');


select * from emp_copy90
where ename = 'KING'; -- ename �÷��� index�� �����Ƿ� ���̺� ��ĵ ����

select * from emp_copy90
where job = 'SALESMAN';


-- ename �÷��� index ����(���ϰ� �����Ƿ� �߰��� �۾�)
-- �÷��� index�� ���� �Ǿ� ���� ������ ���̺� ��ĵ : �ϳ��ϳ� �˻�
-- index�� ���� �Ǿ� ������ index page�� �˻�, ����

create index id_emp_ename
on emp_copy90 (ename);

drop index id_emp_ename;

/*
    index�� �ֱ������� rebuild �ؾ��Ѵ�, index�� ��������(insert, update, delete)�� ����� �Ͼ��
        -- rebuild : �ε����������� �������� ���� ������
*/

-- index rebuild�� �ؾ� �ϴ� ���� ���, index�� tree ���̰� 4 �̻��� ��찡 ��ȸ�� �Ǹ� rebuild �� �ʿ䰡 �ִ�.

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild
alter index id_emp_ename rebuild; -- index ���� ��������

select * from emp_copy90;

/*
    index �� ����ؾ� �ϴ� ���
        1. ���̺��� ��(row, ���ڵ�) �� ������ ���� ���
        2. where���� ���� ��� �� ���
        3. join �� ���Ǵ� Ű �÷�
        4. �˻� ����� ���� ���̺� �������� 2%, 4% ���� �Ǵ� ���
        5. �ش� �÷��� null�� �����ϴ� ���
    
    index�� ����ϸ� �� ���� ���
        1. ���̺��� ���� ������ ���� ���
        2. �˻� ����� ���� ���̺��� ���� ������ �����ϴ� ���
        3. insert, update, delete�� ����ϰ� �Ͼ�� �÷�
*/

/*
    index ����
        1. ���� �ε��� (Unique index) : �÷��� �ߺ����� �ʴ� ������ ���� ���� �ε���
        2. ���� �ε��� (Single Index) : �� �÷��� �ο��Ǵ� Index
        3. ���� �ε��� (Composite Index) : ���� �÷��� ��� ������ Index
        4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ Index
*/

select * from emp_copy90;

-- ���� �ε��� ����
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- ���� �ε��� ���� : �� �÷� �̻��� ����
create table dept_copy91
as
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname, loc);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91(salary * 12);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP_COPY91');

drop index idx_emp_copy91_allsal;

/*
    ���Ѱ���
    
    ������ : dbms�� ���� ���� ���
    -- �� ����ں��� ������ ����, DBMS�� ������ �� �ִ� ����� ����
        (���� (Authentication : Credential (Identity + password)) Ȯ��
        (�㰡 (Authorization : ������ ����ڿ��� Oracle�� �ý��� ����, ��ü( ���̺�, ��, Ʈ����, �Լ�) ����
            - System privileges : ����Ŭ�� �������� ����, ���̺� �����̽� �������� ����
            - Object privileges : ���̺�, ��, Ʈ����, �Լ�, �������ν���, ������, �ε��� ���� ����
*/

-- Oracle ���� ���� ���� (�Ϲ� ���������� ���� ���� ������ ����.) 
show user;
create user usertest01 identified by 1234;

-- Object privileges : ���̺�, ��, Ʈ����, �Լ�, �������ν���, ������, �ε����� �ο��Ǵ� ���� �Ҵ�
    -- ��ü�� ���� �Ҵ�
====================================================================
   ����      Table       view        SEQUENCE        PROCEDEUR
--------------------------------------------------------------------
  Alter       O                         O
  Delete      O           O
  EXECUTE                                               O
  INDEX       O
  INSERT      O           O
  REFERENCES  O
  SELECT      O           O             O
  UPDATE      O           O

-- Ư�� ���̺� Select ���� �ο��ϱ�
create user user_test10 indentified by 1234;






































