-- 04.26 �����ͺ��̽� ���輭

create table member(
    id varchar2 (20) not null constraint PK_member_id Primary Key,
    pwd varchar2 (20),
    name varchar2 (50),
    zipcode varchar2 (7) constraint FK_member_id_tb_zipcode references tb_zipcode (zipcode),
    address varchar2 (20),
    tel varchar2 (13),
    indate date default sysdate
);

comment on table member is '������ ȸ�������� �����մϴ�.';
comment on column member.id is '�� ���̵�';
comment on column member.pwd is '�� ��ȣ';
comment on column member.name is '�� �̸�';
comment on column member.zipcode is '�����ȣ';
comment on column member.address is '�ּ�';
comment on column member.tel is '����ó';
comment on column member.indate is '������';

insert into member (id, pwd, name, zipcode, address, tel)
values ('cofhr23','1234', '��ä��', '14246', '��⵵ �����', '010-1111-1111');

insert into member (id, pwd, name, zipcode, address, tel)
values ('cofhr123','2341', 'ä�ϱ�', '12345', '��⵵ �Ȼ��', '010-2222-2222');

insert into member (id, pwd, name, zipcode, address, tel)
values ('cofhr234','3412', '�ϱ�ä', '15237', '��⵵ ������', '010-3333-3333');

select * from all_tab_comments
where table_name = 'MEMBER';

select * from all_col_comments
where table_name = 'MEMBER';

select * from member;

create table tb_zipcode(
    zipcode varchar2 (7) not null constraint PK_tb_zipcode_zipcode Primary Key,
    sido varchar2 (30),
    gugun varchar2 (30),
    dong varchar2 (30),
    bungi varchar2 (30)
);
comment on table tb_zipcode is '�����ȣ ������ �����մϴ�.';
comment on column tb_zipcode.zipcode is '�����ȣ';
comment on column tb_zipcode.sido is '�õ�';
comment on column tb_zipcode.gugun is '����';
comment on column tb_zipcode.dong is '��';
comment on column tb_zipcode.bungi is '����';

insert into tb_zipcode (zipcode, sido, gugun, dong, bungi)
values ('14246', '��⵵ �����', null, '�Ͼȵ�', null );

insert into tb_zipcode (zipcode, sido, gugun, dong, bungi)
values ('12345', '��⵵ �Ȼ��', null, '���õ�', null );

insert into tb_zipcode (zipcode, sido, gugun, dong, bungi)
values ('15237', '��⵵ ������', null, '��ȵ�', null );

alter table tb_zipcode
modify (dong varchar2(100));

alter table tb_zipcode
drop primary key;

alter table tb_zipcode
add (zip_seq varchar(10));

alter table tb_zipcode
rename column bungi to bunji;

select * from all_tab_comments
where table_name = 'TB_ZIPCODE';

select * from all_col_comments
where table_name = 'TB_ZIPCODE';

select * from tb_zipcode;

create table products(
    product_code varchar2 (20) not null constraint PK_products_product_code Primary Key,
    product_name varchar2 (20),
    product_kind char (1),
    product_price1 varchar2 (10),
    product_price2 varchar2 (10),
    product_content varchar2 (1000),
    product_image varchar2 (50),
    sizeSt varchar2 (5),
    sizeEt varchar2 (5),
    product_quantity varchar2 (5),
    useyn char (1),
    indate date
);

comment on table products is '��ǰ ������ �����մϴ�.';
comment on column products.product_code is '��ǰ �ڵ�';
comment on column products.product_name is '��ǰ��';
comment on column products.product_kind is '��� ��ǰ ����';
comment on column products.product_price1 is '��ǰ ����';
comment on column products.product_price2 is '��ǰ �ǸŰ�';
comment on column products.product_content is '��ǰ ����';
comment on column products.product_image is '��ǰ �̹�����';
comment on column products.sizeSt is '������ ����';
comment on column products.sizeEt is '������ ��';
comment on column products.product_quantity is '����';
comment on column products.useyn is '��ǰ ��� ����(���� ���)';
comment on column products.indate is '�����';

insert into products(product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image,
                    sizeSt, sizeEt, product_quantity, useyn)
values ('1-1', '����Ƽ', 'A', '5000', '10000', '��������Ƽ', 'black01', 'S', 'XL', '2', 'N'); 

insert into products(product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image,
                    sizeSt, sizeEt, product_quantity, useyn)
values ('1-2', '����', 'B', '7000', '13000', '���̼���', 'shirt01', 'S', 'XL', '3', 'N'); 

insert into products(product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image,
                    sizeSt, sizeEt, product_quantity, useyn)
values ('2-1', '�ĵ�Ƽ', 'C', '10000', '20000', '�ĵ�����', 'hood01', 'S', 'XL', '42', 'N'); 

select * from all_tab_comments
where table_name = 'PRODUCTS';

select * from all_col_comments
where table_name = 'PRODUCTS';

select * from products;

create table orders(
    o_seq number (10) not null constraint PK_orders_o_seq Primary Key,
    product_code varchar2 (20) constraint FK_orders_product_code references products (product_code),
    id varchar2 (16) constraint FK_orders_id_member references member (id),
    product_size varchar2 (5),
    quantity varchar2 (5),
    result char (1),
    indate date
);

comment on table orders is '�ֹ� ������ �����մϴ�.';
comment on column orders.o_seq is '�ֹ� �Ϸ� ��ȣ';
comment on column orders.product_code is '�ֹ� ��ǰ �ڵ�';
comment on column orders.id is '�ֹ��� ���̵�';
comment on column orders.product_size is '�ֹ� ��ǰ ������';
comment on column orders.quantity is '�ֹ� ����';
comment on column orders.result is '�ֹ� ó�� ����';
comment on column orders.indate is '�ֹ���';

insert into orders(o_seq, product_code, id, product_size, quantity, result)
values (1111, '1-1', 'cofhr23', 'large', '3', 'Y');

insert into orders(o_seq, product_code, id, product_size, quantity, result)
values (2222, '1-2', 'cofhr123', 'small', '1', 'N');

insert into orders(o_seq, product_code, id, product_size, quantity, result)
values (3333, '2-1', 'cofhr234', 'large', '2', 'Y');

select * from all_tab_comments
where table_name = 'ORDERS';

select * from all_col_comments
where table_name = 'ORDERS';

select * from orders;


----------------------------------------------------------------------------------------
/*
    Foreign Key�� �����Ǵ� ���̺� ������
        1. �ڽ� ���̺��� ���� ���� �� �θ� ���̺� ����
        2. Foreign Key ���� ������ ��� ������ ���̺� ����
        3. cascade constraints �ɼ����� ���̺��� ���� ����

*/


-- ���̺� ������ ���� ���� : �ٸ� ���̺��� Foreign key�� �ڽ��� ���̺��� �����ϰ� ������ ������ �ȵȴ�.
    -- �ٸ� ���̺��� ���� �ϰ� �ִ��� ������ �����ϴ� �ɼ� : cascade
drop table orders;
drop table member;       -- ���� �߻� : orders ���̺��� id �÷��� member ���̺��� id �÷��� �����ϰ� �ִ�.
drop table tb_zipcode;   -- ���� �߻� : member ���̺��� zipcode �÷��� tb_zipcode ���̺��� zipcode �÷��� �����ϰ� �ִ�.
drop table products;

-- ���� ���� �����Ŀ� ���̺� ����. (Foreign Key)
alter table member
drop constraint FK_MEMBER_ID_TB_ZIPCODE;

alter table orders
drop constraint FK_ORDERS_ID_MEMBER;

alter table orders
drop constraint FK_ORDERS_PRODUCT_CODE;

-- ���� ���� Ȯ��
select * from user_constraints
where table_name = 'ORDERS';


drop table member ;

-- cascade constraints �ɼ��� ����ؼ� ����, <== Foreign Key ���� ������ ���� ������ ����.

drop table member cascade constraints ;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table Orders cascade constraints;



-- ���̺� ������(Foreign Key) : �θ����̺� (FK ���� ���̺�) �� ���� �����ؾ� �Ѵ�. �ڽ����̺� ����.
    -- �ڽ� ���̺��� ������ �� FK�� ���� �ʰ� ���� ��, �θ����̺� ������, Alter table �� ����ؼ� ���߿� FK�� �־��ش�.
    

----------���̺� ���� ------------
CREATE TABLE tb_zipcode(
    zipcode VARCHAR2(7) NOT NULL CONSTRAINT PK_tb_zipcode_zipcode PRIMARY KEY,
    sido VARCHAR2(30),
    gugum VARCHAR2(30),
    dong VARCHAR2(30),
    bungi VARCHAR2(30)
    );
    
    
CREATE TABLE member(
    id VARCHAR(20) NOT NULL CONSTRAINT PK_member_id PRIMARY KEY,
    pwd VARCHAR(20),
    name VARCHAR(20),
    zipcode VARCHAR(7), CONSTRAINT FK_member_zipcode_tb_zipcode FOREIGN KEY (zipcode) REFERENCES tb_zipcode(zipcode)
    );

CREATE TABLE products (
    product_code VARCHAR2(20) NOT NULL CONSTRAINT PK_products_product_code PRIMARY KEY,
    product_name VARCHAR2(100),
    product_kind CHAR(1),
    product_price1 VARCHAR2(10),
    product_price2 VARCHAR2(10),
    product_content VARCHAR2(1000),
    product_image VARCHAR2(50),
    sizeSt VARCHAR2(5),
    sizeEt VARCHAR2(5),
    product_quantity VARCHAR2(5),
    useyn CHAR(1),
    indate DATE
    );
    
    CREATE TABLE orders(
    o_seq NUMBER(10) NOT NULL CONSTRAINT PK_orders_o_seq PRIMARY KEY,
    product_code VARCHAR2(20), CONSTRAINT FK_orders_product_code FOREIGN KEY (product_code) REFERENCES products(product_code),
    id VARCHAR2(16), CONSTRAINT FK_orders_id_member FOREIGN KEY (id) REFERENCES member(id),
    product_size VARCHAR2(5),
    quantity VARCHAR2(5),
    result CHAR(1),
    indate DATE
    );
    
    
    
    
-- zip.sql ����� ���� ���̺�� �ٸ� ���� �����ؼ� insert �Ͻÿ�.

-- Ʈ����� �߻� : DML : insert, update, delete  <== commit

select * from tb_zipcode;

-- 1. ���� �÷� �߰�
alter table tb_zipcode
add zip_seq varchar2(30);

-- 2. �÷� �̸� ����.
alter table tb_zipcode
rename column bungi to bunji;

alter table tb_zipcode
rename column gugum to gugun;

--3. ������ �ڸ��� �÷��ֱ�
alter table tb_zipcode
modify ZIPCODE varchar2(100);

alter table tb_zipcode
modify DONG varchar2(100);

-- ���� ���� ��� ��Ȱ��ȭ �ϱ�. (��� ��Ȱ��ȭ)  
    --      ==> Bulk Insert (�뷮���� Insert) : ���� �������� ���ؼ� insert �Ǵ� �ӵ��� ������ ����.
    
    
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode    -- ���� �߻� : member ���̺��� zipcode �÷��� �����ϰ� �ִ�.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;    -- Member ���̺��� FK �� ����� �������ǵ� �Բ� disable

select constraint_name, table_name, status  from user_constraints
where table_name in ('MEMBER' , 'TB_ZIPCODE');

select * from tb_zipcode;

truncate table tb_zipcode;  -- ������ ���ڵ常 ��� ���� (������ ��� ���ڵ� ����)

delete tb_zipcode;      -- ������ ���ڵ常 ��� ���� (������ ������ - �뷮�� ���)
commit;





