show user;

-- 최고 관리자 계정(sys)  : 계정 생성 권한 ㅇ

-- 아이디 : usertest01, 암호 : 1234
create user usertest01 identified by 1234;
-- 계정과 암호를 생성했다 해도 권한을 부여 받아야 접속 가능

-- System privileges
    -- create session : 오라클에 접속 할 수 있는 권한
    -- create table : 테이블 생성 권한
    -- create sequence
    -- create view

/*
    DDL : 객체 생성 (Create, Alter, Drop)
    DML : 레코드 조작 (Insert, Update, Delete)
    DQL : 레코드 검색 (Select)
    DTL : 트랜잭션 (Begin transaction, rollback, commit)
    DCL : 권한 관리(Grant, Revoke, Deny)
*/

-- 생성한 계정에게 오라클을 접속 할 수 있는 create session 권한 부여
-- grant 부여할 권한 to 계정명
Grant create session to usertest01;

-- 오라클에 접속했다고 해서 테이블 접근권한이 있는 것은 아님
Grant create table to usertest01;

/*
    테이블 스페이스 : 객체를 저장하는 공간. 관리자 계정에서 각 사용자별 스페이스 확인
    SYSTEM : DBA(관리자 계정에서만 접근 가능)
*/
select * from dba_users; -- dba_ : sys (최고 관리자 계정에서 확인)

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in ('HR', 'USERTEST01');

-- 계정에게 테이블 스페이스 변경(SYSTEM >> USERS) 
alter user usertest01
default tablespace users
temporary tablespace temp;

-- 계정에게 Users 테이블 스페이스를 사용할 공간 할당
alter user usertest01
quota 2m on users;

-- ------------------------------
-- 문제 : usertest02 생성 후 users 테이블 스페이스에서 테이블(tbl2) 생성후 insert









