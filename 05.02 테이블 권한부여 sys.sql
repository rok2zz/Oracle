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

/*
    with grant option : 특정 계정에게 권한을 부여하면서 해당 권한을 다른 사용자에게 부여할 수 있는 권한

*/

grant select on hr.employee to user_test10 with grant option;
    -- user_test10은 다른 사용자에게 hr.employee 의 select 권한 부여 가능
    
    




