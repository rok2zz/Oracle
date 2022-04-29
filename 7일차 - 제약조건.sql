-- 7일차 - 제약조건

-- 테이블 복사 : 컬럼과 레코드만 복사

create table dept_copy
as
select * from department;

create table dept20
as
select * from department;
desc dept20;

-- 기존의 테이블에 컬럼 추가 : 반드시 null 허용
alter table dept20
add (birth date);

alter table dept20
add (email varchar2 (100) not null); -- 오류

alter table dept20
add (email varchar2 (100)); 

alter table dept20
add (address varchar2 (100)); 

-- 컬럼의 자료형 수정
alter table dept20
modify dname varchar (100);

alter table dept20
modify dno number(4);

alter table dept20
modify address Nvarchar2 (200);

-- 컬럼 삭제 : 부하가 많이 걸리므로 업무시간 외에 작업
alter table dept20
drop column birth;

alter table dept20
drop column email;

alter table dept20
set unused (address); -- 드랍하기위해 설정

alter table dept20
drop unused column;

-- 컬럼 이름 변경





-- DML : Insert, Update, Delete

/*
    테이블의 전체 내용이나 테이블 삭제 시
    1. delete : 테이블의 레코드 삭제, where 사용 안할시 모든 레코드 삭제
    2. truncate : 테이블의 레코드 삭제, 속도 빠름
    3. drop : 테이블 삭제
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
    데이터 사전 : 시스템의 각종 정보를 출력해주는 테이블
        user_ : 자신의 계정에 속한 객체정보 출력
        all_ : 자신ㄴ의 계정이 소유한 객체나 권한을 부여한 객체
        dba_ : 데이타베이스 관리자만 접근 가능한 객체
*/

show user;
select * from user_tables; -- 사용자가 생성한 테이블 정보
select * from user_views;
select * from user_constraints;
select * from user_indexs;
select * from user_sequences;

select * from all_tables;
select * from all_views;

select * from dba_tables;

/*
    제약조건 : 테이블의 무결성을 확보하기 위해 컬럼에 부여되는 규칙
        1. Primary Key
        2. Unique
        3. Not Null
        4. Check
        5. Foreign Key
        6. Default
*/

-- 1. Primary Key : 중복된 값 x
    -- 테이블 생성시 컬럼에 부여
    -- 제약조건이름 : 지정하지 않을경우 , oracle에서 자동으로 설정
    -- 제약조건을 수정할 때 제약 조건 이름을 사용해서 수정
create table customer01(
    id varchar2 (20) not null  constraint PK_costomer01_id Primary Key,
    pwd varchar2 (20) constraint NN_customer01_pwd not null ,
    name varchar2 (20) constraint NN_customer01_name not null ,
    phone varchar2 (30) null,
    address varchar2 (100) null
); 
    
select * from user_constraints
where table_name = 'CUSTOMER01';
    
-- 제약조건의 해제

-- 1. 제약조건명으로 삭제하기
alter table (테이블명) drop constraint (제약조건이름) 
-- 미리 지정해 둔 제약조건의 이름을 입력, 이러한 이유 때문에 제약조건명을 잘 파악해야함.

-- 2. 키 이름으로 삭제하기
alter table (테이블명) drop PRIMARY KEY;

-- 3. cascade constraints 사용해서 테이블과 함께 지우기
drop table (테이블명) cascade constraints; -- 이 방법은 사실 위와는 좀 다름. 테이블에 뭐가 걸려있던간에 그냥 한꺼번에 날리는 코드임.
                                          --  사실상 가장 많이 사용하는 방식이라고 하심

-- 4.제약 조건 비활성화 하기
alter table (테이블명) disable constraint (제약조건명); -- 보통 이렇게 치면 목표 테이블을 다른 테이블에서 참고중이라며 에러가 뜬다
                                                    -- 이때 다른 테이블을 걸리적거리는 테이블이라고 칭하겠음.
                                                    -- 일단 뭐가 걸리적거리는지 아래 코드를 입력해서 상황을 파악하자
                                                    
select constraint_name, table_name, status from user_constraints where table_name IN (('목표 테이블명'),('걸리적거리는 테이블명'));
-- 이대 괄호안에 들어간 이름은 반드시 대소문자를 구분해서 테이블의 명칭과 일치시켜줘야 한다.
-- 이렇게 찾으면 목표 테이블과 걸리적거리는 테이블 간에 키들이 어떤 방식으로 얽혀있는지 파악이 가능하다
                                                    
alter table (테이블명) disable constraint (제약조건명) cascade;  -- 이렇게 밀어버리면 목표테이블과 걸리적거리는 테이블에 걸려있던
                                                              -- 여러 키들을 한번에 다 풀어버릴 수 있음. 골라 풀기는 불가능함.
                                                              
select constraint_name, table_name, status from user_constraints where table_name IN (('목표 테이블명'),('걸리적거리는 테이블명'));
-- 다시 키 정보를 확인할 수 있는 코드를 입력해보면 모든 키들이 DIASABLED 된 것을 폴 수 있음. 
    
 
    
    
    
    
    
    
    




