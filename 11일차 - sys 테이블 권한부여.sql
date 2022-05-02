-- 특정 테이블에 Select 권한 부여하기
    -- sys계정 접속 필요
-- Autication (인증) : credential ( ID + Pass )
create user user_test10 identified by 1234;

-- Authorization (허가)
grant create session, create table, create view to user_test10;

-- 계정을 생성하면 system 테이블 스페이스를 사용 << 관리자만 사용가능한 테이블 스페이스
-- 테이블 스페이스 바꾸기
Alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- 테이블 스페이스 용량 할당(권한 부여)

-- 특정 계정에서 객체 생성 시 그 계정이 객체 소유
select * from dba_tables
where owner in ('HR', 'USER_TEST10');

-- 다른 사용자의 테이블에 접근 하려면 권한을 가져야 한다.
grant select on hr.employee to user_test10;

grant select on hr.emp_copy55 to user_test10;

grant insert, update, delete on hr.emp_copy55 to user_test10;

-- 권한 해제
revoke insert, update, delete on hr.emp_copy55 from user_test10;

-- with grant option : 특정 계정에게 권한을 부여하면서 해당 권한을 다른 사용자에게 부여할 수 있는 권한


grant select on hr.emp_copy55 to user_test10 with grant option;
    -- user_test10은 다른 사용자에게 hr.employee 의 select 권한 부여 가능

grant select on hr.dept_copy55 to user_test10 with grant option;

-- Public : 모든 사용자에게 권한 부여
grant select, insert, update, delete on hr.dept_copy56 to public;


/*
    롤(role) : 자주 사용하는 여러개의 권한을 묶어 놓은 것 : dba, connect, resuorce 
        1. dba : 시스템의 모든 권한이 적용된 role, sys계정
        2. connect : 
        3.
        
*/

-- 사용자 정의 role 생성 : 자주 사용하는 권한들을 묶어서 role 생성
1. 롤 생성 : 
create role roletest1;

2. 롤에 자주 사용하는 권한 적용
grant create session, create table, create view, create sequence, create trigger to roletest1;

3. 생성된 롤을 계정에 적용
grant roletest1 to USER_TEST10;

-- 현재 사용자에게 부여된 롤 확인
select * from user_role_privs;

-- 롤에 부여된 권한 정보 확인
select * from role_sys_privs
where role like 'ROLETEST1';

-- 객체 권한을 role에 부여하기
create role roletest2;

-- employee에 select 할 권한을 롤에 부여
grant select on hr.employee to roletest2;

-- 롤을 계정에 적용
grant roletest2 to user_test10;

-- 실습 : dept_copy57
hr.dept_copy57 생성
roletest3 생성 : dept_copy57을 select, insert, update, delete 하는 객체롤
user_test10 에 적용;

create role roletest3;
grant select, insert, update, delete on hr.dept_copy57 to roletest3;

grant roletest3 to user_test10;





















