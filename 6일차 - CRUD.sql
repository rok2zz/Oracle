--6일차 - CRUD (Create, Read, Update, Delete)

-- Object (객체) : DataBase에 존재 (XE, <=Express Edition(무료 버전), Standard Edtion(유료), Enterprise Edition(유료))
    -- Databese에 있는 객체들 ==> 
    --1. 테이블, 2. 뷰, 3, 저장프리시져, 4, 트리거, 5, 인덱스, 6.함수, 7.시퀀스 
    -- DDL(Create, Alter, Drop) <== 객체를 만들고,수정,삭제

-- 테이블 생성 (Create)  --DDL 객체 생성

/*
    Create Table 테이블명(
        컬럼명 자료형 NULL허용여부 [제약조건],
        컬럼명 자료형 NULL허용여부 [제약조건],
        컬럼명 자료형 NULL허용여부 [제약조건],
    );
*/
Create Table dept (
    dno NUMBER(2) NOT NULL, 
    dname VARCHAR(14) NOT NULL,
    loc VARCHAR(13) NULL
);

SELECT * FROM dept;

--DCL : DB에 데이터를 제어하기 위한 명령어. COMMIT, ROLLBACK, GRANT, REVOKE 등이 해당된다.

 -- begin transaction;    --트랜잭션 시작 (Insert, update, delete 구문이 시작되면 자동으로 시작)
 --   rollback;           --트랜잭션을 롤백(RAM에 적용된 트랜잭션을 삭제)
 --   commit;             --트랜잭션을 적용( 실제 Database에 영원히 적용)

--DML : 테이블에 값(레코드,로우)을 넣고(INSERT), 수정(UPDATE), 삭제(DELETE)
    --트랜잭션을 발생 시킴: log에 기록을 먼저하고 Database에 적용한다.

/*
    INSERT INTO 테이블명(컬럼명,컬럼명,컬러명)
    VALUES (값1, 값2, 값3)
*/

INSERT INTO dept (dno, dname,loc)
VALUES (10, 'MANAGER', 'SEOUL');

    --insert,update,delete 구문은 자동으로 트랜잭션이 시작( begin transaction) - RAM에만 적용되어 있는 상태
    
rollback;
commit;

/*  insert 시 컬럼명을 생략
    insert into dept
    values (값1, 값2, 값3)
    
*/

SELECT * FROM dept;

INSERT INTO dept
values (20,'ACCOUTING', 'PUSAN');

commit;

desc dept;

/* NULL 허용 컬럼에 값을 넣지 않기 */
INSERT INTO dept(dno,dname)
VALUES (30,'RESEARCH');

--데이터 유형에 맞지 않는 값을 넣으면 오류 발생

INSERT INTO dept (dno, dname, loc)
VALUES (300,'SALES', 'DAEGU'); --오류 발생, NUMBER(2) 정수 두자리까지만 넣을수 있다.

INSERT INTO dept (loc,dname,dno)
VALUES ('DAEGEON','SALESSSSSSSSSSSSSSSS',60); --오류 발생, dname VARCHAR2(14) 14자만 넣을수 있다.

--자료형 (문자 자료형)
    --CHAR(10)          :고정크기 10바이트, 3바이트만 넣을 경우 빈공간 7바이트 생김, 장점 : 성능이 빠름, 단점 : 하드공간낭비
        --자릿수를 알수 있는 고정 크기 컬럼 (ex..주민번호, 전화번호)
    --VARCHAR(10) :     :가변크기 10바이트, 3바이트 넣을 경우 3바이트만 공간할당,    장점 : 하드공간낭비 없음, 단점 : 성능이 느림
        --자릿수가 가변크기인 경우 (ex..주소, 메일주소)
    --NCHAR(10)     : 유니코드 10자 ( 한글, 중국어, 일본어..)
    --NVARCHAR2(10) : 유니코드 10자 ( 한글, 중국어, 일본어..)
    
--자료형 (숫자 자료형)
    --NUMBER(2)     : 정수 2자리만 입력 기능
    --NUMBER(7,3)   : 전체 7자리, 소수점 3자리까지 저장됨.
    --NUMBER(8,5)   : 전체 8자리, 소수점 5자리까지 저장됨.
    
CREATE TABLE test1_tbl(
    a NUMBER(3,2) not null,
    b NUMBER(7,5) not null,
    c CHAR(6) null,      --<==한글을 3byte로 계산해서 넣기 가능( 6바이트라 한굴 2글자 가능)
    d VARCHAR2(10) null, --<==한글을 3byte로 계산해서 넣기 가능( 10바이트라 한굴 3글자 가능)
    e NCHAR(6) null,
    f NVARCHAR2(10) null
);



DESC test1_tbl;
SELECT * FROM test1_tbl;

INSERT INTO test1_tbl (a,b,c,d,e,f)
VALUES ( 3.22, 77.55555, 'aaaaaa', 'bbbbbbbbbb', '한글이여섯자', '한글열자까지출력해요');

INSERT INTO test1_tbl (a,b,c,d,e,f)
VALUES ( 3.22, 77.55555, '한글', '한글굿', '한글이여섯자', '한글열자까지출력해요'); --한글 1글자는 3byte를 차지한다

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
VALUES (1,'aaa','password', '홍길동', '010-1111-1111', '서울 중구 남산동',sysdate, 'aaa@aaa.com');

INSERT INTO member1 
VALUES (2,'bbb','password', '홍길동', '010-2222-2222', '서울 중구 남산동',sysdate, 'bbb@bbb.com');

commit;

--NULL 허용 컬럼에 NULL로 값을 할당
INSERT INTO member1 (no, id, passwd, name, phone, address, mdate, email)
VALUES (3,'ccc','password', '강감찬', 'NULL', 'NULL',sysdate, 'NULL');

--NULL 허용 컬럼에 값을 넣지 않을 경우 NULL 값이 들어감
INSERT INTO member1 (no, id, passwd, name, mdate)
VALUES (4,'ddd','password', '세종대왕',sysdate);

--데이터 수정 (update : 데이터 수정 후 commit;)
    -- 반드시 where 조건을 사용해야 한ㄷ. 그렇지 않으면 모든 레코드가 수정됨
    
/*
    update 테이블명
    set 컬럼명 = 수정할값
    where 컬럼명 = 값

*/

UPDATE member1
SET name ='신사임당'
WHERE no =2;
commit;

SELECT * FROM member1;

UPDATE member1
SET name ='을지문덕'
WHERE no=3;
commit;

UPDATE member1
SET id ='abcd'
WHERE no=3;

UPDATE member1
SET name ='김유신'
WHERE no=1;

UPDATE member1
SET mdate ='2022/01/01'
WHERE no=4;

UPDATE member1
SET email ='abcd@abcd.com'
WHERE no=1;

commit;

--하나의 레코드에서 여러컬럼 동시에 수정하기

UPDATE member1
set name ='김유신', email= 'kkk@kkk.com', phone ='010-7777-7777'
WHERE no=1;

SELECT * FROM member1;

UPDATE member1
set mdate=to_date('2022-01-01','YYYY-MM-DD')
WHERE no=3;
commit;

delete member1 -- 모든 레코드 삭제
rollback;

    
    




