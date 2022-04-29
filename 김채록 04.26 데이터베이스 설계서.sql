-- 04.26 데이터베이스 설계서

create table member(
    id varchar2 (20) not null constraint PK_member_id Primary Key,
    pwd varchar2 (20),
    name varchar2 (50),
    zipcode varchar2 (7) constraint FK_member_id_tb_zipcode references tb_zipcode (zipcode),
    address varchar2 (20),
    tel varchar2 (13),
    indate date default sysdate
);

comment on table member is '가입한 회원정보를 관리합니다.';
comment on column member.id is '고객 아이디';
comment on column member.pwd is '고객 암호';
comment on column member.name is '고객 이름';
comment on column member.zipcode is '우편번호';
comment on column member.address is '주소';
comment on column member.tel is '연락처';
comment on column member.indate is '가입일';

insert into member (id, pwd, name, zipcode, address, tel)
values ('cofhr23','1234', '김채록', '14246', '경기도 광명시', '010-1111-1111');

insert into member (id, pwd, name, zipcode, address, tel)
values ('cofhr123','2341', '채록김', '12345', '경기도 안산시', '010-2222-2222');

insert into member (id, pwd, name, zipcode, address, tel)
values ('cofhr234','3412', '록김채', '15237', '경기도 수원시', '010-3333-3333');

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
comment on table tb_zipcode is '우편번호 정보를 관리합니다.';
comment on column tb_zipcode.zipcode is '우편번호';
comment on column tb_zipcode.sido is '시도';
comment on column tb_zipcode.gugun is '구군';
comment on column tb_zipcode.dong is '동';
comment on column tb_zipcode.bungi is '번지';

insert into tb_zipcode (zipcode, sido, gugun, dong, bungi)
values ('14246', '경기도 광명시', null, '하안동', null );

insert into tb_zipcode (zipcode, sido, gugun, dong, bungi)
values ('12345', '경기도 안산시', null, '원시동', null );

insert into tb_zipcode (zipcode, sido, gugun, dong, bungi)
values ('15237', '경기도 수원시', null, '장안동', null );

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

comment on table products is '상품 정보를 관리합니다.';
comment on column products.product_code is '상품 코드';
comment on column products.product_name is '상품명';
comment on column products.product_kind is '등록 상품 구분';
comment on column products.product_price1 is '상품 원가';
comment on column products.product_price2 is '상품 판매가';
comment on column products.product_content is '상품 내용';
comment on column products.product_image is '상품 이미지명';
comment on column products.sizeSt is '사이즈 시작';
comment on column products.sizeEt is '사이즈 끝';
comment on column products.product_quantity is '수량';
comment on column products.useyn is '상품 사용 유무(삭제 대신)';
comment on column products.indate is '등록일';

insert into products(product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image,
                    sizeSt, sizeEt, product_quantity, useyn)
values ('1-1', '반팔티', 'A', '5000', '10000', '검정반팔티', 'black01', 'S', 'XL', '2', 'N'); 

insert into products(product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image,
                    sizeSt, sizeEt, product_quantity, useyn)
values ('1-2', '셔츠', 'B', '7000', '13000', '와이셔츠', 'shirt01', 'S', 'XL', '3', 'N'); 

insert into products(product_code, product_name, product_kind, product_price1, product_price2, product_content, product_image,
                    sizeSt, sizeEt, product_quantity, useyn)
values ('2-1', '후드티', 'C', '10000', '20000', '후드집업', 'hood01', 'S', 'XL', '42', 'N'); 

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

comment on table orders is '주문 정보를 관리합니다.';
comment on column orders.o_seq is '주문 일련 번호';
comment on column orders.product_code is '주문 상품 코드';
comment on column orders.id is '주문자 아이디';
comment on column orders.product_size is '주문 상품 사이즈';
comment on column orders.quantity is '주문 수량';
comment on column orders.result is '주문 처리 여부';
comment on column orders.indate is '주문일';

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
    Foreign Key로 참조되는 테이블 삭제시
        1. 자식 테이블을 먼저 삭제 후 부모 테이블 삭제
        2. Foreign Key 제약 조건을 모두 제거후 테이블 삭제
        3. cascade constraints 옵션으로 테이블을 강제 삭제

*/


-- 테이블 삭제시 주의 사항 : 다른 테이블에서 Foreign key로 자신의 테이블을 참조하고 있으면 삭제가 안된다.
    -- 다른 테이블이 참조 하고 있더라도 강제로 삭제하는 옵션 : cascade
drop table orders;
drop table member;       -- 오류 발생 : orders 테이블의 id 컬럼이 member 테이블의 id 컬럼을 참조하고 있다.
drop table tb_zipcode;   -- 오류 발생 : member 테이블의 zipcode 컬럼이 tb_zipcode 테이블의 zipcode 컬럼을 참조하고 있다.
drop table products;

-- 제약 조건 제거후에 테이블 삭제. (Foreign Key)
alter table member
drop constraint FK_MEMBER_ID_TB_ZIPCODE;

alter table orders
drop constraint FK_ORDERS_ID_MEMBER;

alter table orders
drop constraint FK_ORDERS_PRODUCT_CODE;

-- 제약 조건 확인
select * from user_constraints
where table_name = 'ORDERS';


drop table member ;

-- cascade constraints 옵션을 사용해서 삭제, <== Foreign Key 제약 조건을 먼저 제거후 삭제.

drop table member cascade constraints ;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table Orders cascade constraints;



-- 테이블 생성시(Foreign Key) : 부모테이블 (FK 참조 테이블) 을 먼저 생성해야 한다. 자식테이블 생성.
    -- 자식 테이블을 생성할 때 FK를 넣지 않고 생성 후, 부모테이블 생성후, Alter table 을 사용해서 나중에 FK를 넣어준다.
    

----------테이블 설계 ------------
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
    
    
    
    
-- zip.sql 적용시 실제 테이블과 다른 점을 수정해서 insert 하시오.

-- 트랜잭션 발생 : DML : insert, update, delete  <== commit

select * from tb_zipcode;

-- 1. 누락 컬럼 추가
alter table tb_zipcode
add zip_seq varchar2(30);

-- 2. 컬럼 이름 변경.
alter table tb_zipcode
rename column bungi to bunji;

alter table tb_zipcode
rename column gugum to gugun;

--3. 부족한 자리수 늘려주기
alter table tb_zipcode
modify ZIPCODE varchar2(100);

alter table tb_zipcode
modify DONG varchar2(100);

-- 제약 조건 잠시 비활성화 하기. (잠시 비활성화)  
    --      ==> Bulk Insert (대량으로 Insert) : 제약 조건으로 인해서 insert 되는 속도가 굉장히 느림.
    
    
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode    -- 오류 발생 : member 테이블의 zipcode 컬럼이 참조하고 있다.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;    -- Member 테이블의 FK 가 적용된 제약조건도 함께 disable

select constraint_name, table_name, status  from user_constraints
where table_name in ('MEMBER' , 'TB_ZIPCODE');

select * from tb_zipcode;

truncate table tb_zipcode;  -- 기존의 레코드만 모두 제거 (빠르게 모든 레코드 삭제)

delete tb_zipcode;      -- 기존의 레코드만 모두 제거 (삭제가 느리다 - 대량일 경우)
commit;





