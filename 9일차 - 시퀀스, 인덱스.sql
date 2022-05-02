-- 9일차 시퀀스, 인덱스

/*
    시퀀스 : 자동 번호 발생기

*/

-- 초기값 : 10, 증가값 : 10
create sequence sample_seq
    increment by 10 -- 증가값
    start with 10; -- 초기값
    
-- 시퀀스 정보 출력 (데이터 사전)
select * from user_sequences;

select sample_seq.nextval from dual; -- 시퀀스의 다음 값 출력
select sample_seq.currval from dual; -- 현재 시퀀스의 값

-- 초기값 : 2, 증가값 : 2
create sequence sample_seq2
    increment by 2 -- 증가값
    start with 2
    nocache;  --  캐시 사용x : 메모리 사용x : 서버 부하 줄여줌

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- 시퀀스를 Primary key 에 적용하기

create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

-- 시퀀스 생성 초기값 : 10, 증가값 : 10
create sequence dept_seq
    start with 10
    increment by 10
    nocache;

insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval, 'HR', 'SEOUL');

select * from dept_copy80;

-- cache : 서버의 성능 향상을 위해 사용 ( 기본값 : 20)
    -- 서버 다운되면 캐쉬된 넘버링 날아감
    
create sequence emp_seq_no
    increment by 1
    start with 1
    nocache;
    
create table emp_copy80
as
select * from employee
where 0=1;

select * from emp_copy80;

-- 시퀀스를 테이블의 특정 컬럼에 적용

insert into emp_copy80
values (emp_seq_no.nextval, 'SMITH', 'SALSEMAN', 2222, sysdate, 3000, 300, 20);

-- 기존의 시퀀스 수정

select * from user_sequences;

alter sequence emp_seq_no
    maxvalue 1000;

alter sequence emp_seq_no
    cycle;  -- 최대값 적용 시 

alter sequence emp_seq_no
    nocycle;
    
select * from user_sequences;
 
drop sequence sample_seq;

/* 
    INDEX : 테이블의 컬럼에 생성, 특정 컬럼의 검색을 빠르게 사용 할 수 있도록 한다.
        - INDEX PAGE : 컬럼의 중요 키워드를 걸러서 위치 정보를 잡아 놓음
        - 색인 : 책의 색인과 같음
        - 테이블 스캔 : 레코드의 처음 ~ 마지막까지 검색
        - Primary Key, Unique 키가 적용된 컬럼은 INDEX PAGE가 만들어져 있음
        - where 절에서 자주 검색을 하는 컬럼에 index 생성
        - 테이블의 검색을 자주하는 컬럼에 index를 생성, 테이블 스캔을 하지 않고
            index page를 검색해서 위치를 빠르게 찾는다.
        - index를 생성 할 때 부하가 많이 걸린다. 주로 야간에 생성
        - 너무 많이 생성하면 속도가 느려짐
*/

-- index 정보가 저장되어 있는 데이터 사전
    -- user_columns, user_ind_columns
    
select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in('EMPLOYEE', 'DEPARTMENT');


select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select * from employee; -- eno 컬럼에 primary key <== 자동으로 index 생성

/*
    index 자동생성 (Primary key, unique) 컬럼에는 자동 생성
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
where ename = 'KING'; -- ename 컬럼에 index가 없으므로 테이블 스캔 실행

select * from emp_copy90
where job = 'SALESMAN';


-- ename 컬럼에 index 생성(부하가 많으므로 야간에 작업)
-- 컬럼에 index가 생성 되어 있지 않으면 테이블 스캔 : 하나하나 검색
-- index가 생성 되어 있으면 index page를 검색, 빠름

create index id_emp_ename
on emp_copy90 (ename);

drop index id_emp_ename;

/*
    index는 주기적으로 rebuild 해야한다, index는 조각난다(insert, update, delete)가 빈번히 일어나면
        -- rebuild : 인덱스페이지가 조각나면 새로 리빌드
*/

-- index rebuild를 해야 하는 정보 얻기, index의 tree 깊이가 4 이상인 경우가 조회가 되면 rebuild 할 필요가 있다.

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild
alter index id_emp_ename rebuild; -- index 새로 조각모음

select * from emp_copy90;

/*
    index 를 사용해야 하는 경우
        1. 테이블의 행(row, 레코드) 의 개수가 많은 경우
        2. where에서 자주 사용 할 경우
        3. join 시 사용되는 키 컬럼
        4. 검색 결과가 원본 테이블 데이터의 2%, 4% 정도 되는 경우
        5. 해당 컬럼이 null이 포함하는 경우
    
    index를 사용하면 안 좋은 경우
        1. 테이블의 행의 개수가 적은 경우
        2. 검색 결과가 원본 테이블의 많은 비중을 차지하는 경우
        3. insert, update, delete가 빈번하게 일어나는 컬럼
*/

/*
    index 종류
        1. 고유 인덱스 (Unique index) : 컬럼의 중복되지 않는 고유한 값을 갖는 인덱스
        2. 단일 인덱스 (Single Index) : 한 컬럼에 부여되는 Index
        3. 결합 인덱스 (Composite Index) : 여러 컬럼을 묶어서 생성한 Index
        4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 Index
*/

select * from emp_copy90;

-- 단일 인덱스 생성
create index inx_emp_copy90_salary
on emp_copy90 (salary);

-- 결합 인덱스 생성 : 두 컬럼 이상을 결합
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
    권한관리
    
    사용권한 : dbms는 여러 명이 사용
    -- 각 사용자별로 계정을 생성, DBMS에 접속할 수 있는 사용자 생성
        (인증 (Authentication : Credential (Identity + password)) 확인
        (허가 (Authorization : 인증된 사용자에게 Oracle의 시스템 권한, 객체( 테이블, 뷰, 트리거, 함수) 권한
            - System privileges : 오라클의 전반적인 권한, 테이블 스페이스 내에서의 권한
            - Object privileges : 테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스 접근 권한
*/

-- Oracle 에서 계정 생성 (일반 계정에서는 계정 생성 권한이 없다.) 
show user;
create user usertest01 identified by 1234;

-- Object privileges : 테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스에 부여되는 권한 할당
    -- 객체에 권한 할당
====================================================================
   권한      Table       view        SEQUENCE        PROCEDEUR
--------------------------------------------------------------------
  Alter       O                         O
  Delete      O           O
  EXECUTE                                               O
  INDEX       O
  INSERT      O           O
  REFERENCES  O
  SELECT      O           O             O
  UPDATE      O           O

-- 특정 테이블에 Select 권한 부여하기
create user user_test10 indentified by 1234;






































