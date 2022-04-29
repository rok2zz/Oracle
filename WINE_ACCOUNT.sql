-- 예제  계정명 : wine_account / 1234
-- 테이블 스페이스 : wine_datafile 100m, 100mb, 무제한
-- 임시 테이블 스페이스 : wine_log 100mb, 100mb, 1gb

-- 테이블 10개 생성 후 레코드 3개씩
create table sale(
    sale_date date  default sysdate not null constraint PK_sale_date_sale primary key,
    wine_code varchar2 (6) not null, constraint FK_wine_code_sale foreign key (wine_code) references wine(wine_code),
    mem_id varchar2 (30) not null, constraint FK_mem_id_sale foreign key (mem_id) references member(mem_id),
    sale_amount varchar2 (5)  default 0 not null,
    sale_price varchar2 (6) default 0 not null,
    sale_tot_price varchar2 (15) default 0 not null
);

comment on table sale is '구매 관련 정보를 관리 합니다.';
comment on column sale.sale_date is '판매날짜';
comment on column sale.wine_code is '와인코드';
comment on column sale.mem_id is '아이디';
comment on column sale.sale_amount is '판매수량';
comment on column sale.sale_price is '판매단가';
comment on column sale.sale_tot_price is '판매가격';

alter table sale
modify wine_code varchar2 (26);

insert into sale(sale_date, wine_code, mem_id, sale_amount, sale_price, sale_tot_price)
values (sysdate, 'winecode01', 'id01', '4개', '100000', '4개' );

insert into sale(sale_date, wine_code, mem_id, sale_amount, sale_price, sale_tot_price)
values (sysdate-1, 'winecode02', 'id02', '3개', '200000', '3개' );

insert into sale(sale_date, wine_code, mem_id, sale_amount, sale_price, sale_tot_price)
values (sysdate-2, 'winecode03', 'id03', '2개', '150000', '2개' );

select * from sale;


create table member(
    mem_id varchar2 (6) not null constraint PK_mem_id_member primary key,
    mem_grade varchar2 (20), constraint FK_mem_grade_member foreign key (mem_grade) references grade_pt_rade(mem_grade),
    mem_pw varchar2 (20) not null,
    mem_birth date default sysdate not null,
    mem_tel varchar2 (20),
    mem_pt varchar2 (10) default 0 not null
);

comment on table member is '회원 정보를 관리 합니다.';
comment on column member.mem_id is '아이디';
comment on column member.mem_grade is '회원등급';
comment on column member.mem_pw is '비밀번호';
comment on column member.mem_birth is '생년월일';
comment on column member.mem_tel is '전화번호';
comment on column member.mem_pt is '마일리지';

insert into member(mem_id, mem_grade, mem_pw, mem_birth, mem_tel, mem_pt)
values ('id01', 'S등급', '1111', to_date('1995-01-21','YYYY-MM-DD'), '010-1111-1111', 3);

insert into member(mem_id, mem_grade, mem_pw, mem_birth, mem_tel, mem_pt)
values ('id02', 'A등급', '2222', to_date('1994-07-28','YYYY-MM-DD'), '010-2222-2222', 1);

insert into member(mem_id, mem_grade, mem_pw, mem_birth, mem_tel, mem_pt)
values ('id03', 'B등급', '3333', to_date('1999-01-25','YYYY-MM-DD'), '010-3333-3333', 0);

select * from member;


create table grade_pt_rade(
    mem_grade varchar2 (20) not null constraint PK_mem_grade_rade primary key,
    grade_pt_rate number(3,2)
);

comment on table grade_pt_rade is '회원 등급별 마일리지율 정보를 관리 합니다.';
comment on column grade_pt_rade.mem_grade is '회원등급';
comment on column grade_pt_rade.grade_pt_rate is '등급별 마일리지율';

insert into grade_pt_rade(mem_grade, grade_pt_rate)
values ('S등급', 3);

insert into grade_pt_rade(mem_grade, grade_pt_rate)
values ('A등급', 2);

insert into grade_pt_rade(mem_grade, grade_pt_rate)
values ('B등급', 1);

select * from grade_pt_rade;


create table today(
    today_code varchar2 (6) not null constraint PK_today_code_today primary key,
    today_sens_value number (3),
    today_intell_value number (3),
    today_phy_value number (3)
);

comment on table today is '오늘의 와인 관련 정보를 관리 합니다.';
comment on column today.today_code is '오늘의 와인 코드';
comment on column today.today_sens_value is '감성 지수';
comment on column today.today_intell_value is '지성 지수';
comment on column today.today_phy_value is '신체 지수';

insert into today(today_code, today_sens_value, today_intell_value, today_phy_value)
values ('today1', 1, 1, 1);

insert into today(today_code, today_sens_value, today_intell_value, today_phy_value)
values ('today2', 2, 2, 4);

insert into today(today_code, today_sens_value, today_intell_value, today_phy_value)
values ('today3', 3, 5, 1);

select * from today;


create table nation(
    nation_code varchar2 (26) not null constraint PK_nation_code_nation primary key,
    nation_name varchar2 (50) not null
);

comment on table nation is '국가 관련 정보를 관리 합니다.';
comment on column nation.nation_code is '국가 코드';
comment on column nation.nation_name is '국가 이름';

insert into nation(nation_code, nation_name)
values ('nation01', 'Korea');

insert into nation(nation_code, nation_name)
values ('nation02', 'America');

insert into nation(nation_code, nation_name)
values ('nation03', 'Japan');

select * from nation;


create table wine(
    wine_code varchar2 (26) not null constraint PK_wine_code_wine primary key,
    wine_name varchar2 (100) not null,
    wine_url blob,
    nation_code varchar2 (26), constraint FK_nation_code_wine foreign key (nation_code) references nation(nation_code),
    wine_type_code varchar2 (6), constraint FK_wine_type_code_wine foreign key (wine_type_code) references wine_type(wine_type_code),
    wine_sugar_code number (2),
    wine_price number (15) default 0 not null,
    wine_vintage date,
    theme_code varchar2 (6), constraint FK_theme_code_wine foreign key (theme_code) references theme(theme_code),
    today_code varchar2 (6), constraint FK_today_code_wine foreign key (today_code) references today(today_code)
);

comment on table wine is '와인 관련 정보를 관리 합니다.';
comment on column wine.wine_code is '와인 코드';
comment on column wine.wine_name is '와인 이름';
comment on column wine.wine_url is '와인 사진저장';
comment on column wine.nation_code is '국가 코드';
comment on column wine.wine_type_code is '종류 코드';
comment on column wine.wine_sugar_code is '당도별';
comment on column wine.wine_price is '가격';
comment on column wine.wine_vintage is '생산년도';
comment on column wine.theme_code is '테마 코드';
comment on column wine.today_code is '오늘의 와인 코드';

insert into wine(wine_code, wine_name, wine_url, nation_code, wine_type_code, wine_sugar_code, wine_price, wine_vintage, theme_code, today_code)
values ('winecode01', 'Syrah', null, 'nation01', 'wine01', 1, 100000, to_date('1980-01-01','YYYY-MM-DD'), 'theme1', 'today1');

insert into wine(wine_code, wine_name, wine_url, nation_code, wine_type_code, wine_sugar_code, wine_price, wine_vintage, theme_code, today_code)
values ('winecode02', 'Chardonnay', null, 'nation02', 'wine02', 2, 200000, to_date('1985-07-21','YYYY-MM-DD'), 'theme2', 'today2');

insert into wine(wine_code, wine_name, wine_url, nation_code, wine_type_code, wine_sugar_code, wine_price, wine_vintage, theme_code, today_code)
values ('winecode03', 'Mateus Rose', null, 'nation03', 'wine03', 3, 150000, to_date('1990-10-31','YYYY-MM-DD'), 'theme3', 'today3');

select * from wine;


create table theme(
    theme_code varchar2 (6) not null constraint PK_theme_code_theme primary key,
    theme_name varchar2 (5) not null
);

comment on table theme is '와인 테마 관련 정보를 관리합니다.';
comment on column theme.theme_code is '테마 코드';
comment on column theme.theme_name is '테마 이름';

insert into theme(theme_code, theme_name)
values ('theme1', '01');

insert into theme(theme_code, theme_name)
values ('theme2', '02');

insert into theme(theme_code, theme_name)
values ('theme3', '03');

select * from theme;

create table stock_management(
    stock_code varchar2 (6) not null constraint PK_stock_code_stock_management primary key,
    wine_code varchar2 (6), constraint FK_wine_code_stock_management foreign key (wine_code) references wine(wine_code),
    manager_id varchar2 (30), constraint FK_manager_id_stock_management foreign key (manager_id) references manager(manager_id),
    ware_date date default sysdate not null,
    stock_amount number(5) default 0 not null
);

comment on table stock_management is '재고 관련 정보를 관리 합니다.';
comment on column stock_management.stock_code is '재고 코드';
comment on column stock_management.wine_code is '와인 코드';
comment on column stock_management.manager_id is '아이디';
comment on column stock_management.ware_date is '입고일';
comment on column stock_management.stock_amount is '재고량';



create table manager(
    manager_id varchar2 (30) not null constraint PK_manager_id_manager primary key,
    manager_pwd varchar2 (20) not null,
    manager_tel varchar2 (20)
);

comment on table manager is '관리자 관련 정보를 관리 합니다.';
comment on column manager.manager_id is '아이디';
comment on column manager.manager_pwd is '비밀번호';
comment on column manager.manager_tel is '전화번호';

insert into manager(manager_id, manager_pwd, manager_tel)
values ('cofhr111', '1111' , '010-1111-1111');

insert into manager(manager_id, manager_pwd, manager_tel)
values ('cofhr222', '2222' , '010-2222-2222');

insert into manager(manager_id, manager_pwd, manager_tel)
values ('cofhr333', '3333' , '010-3333-3333');

select * from manager;


create table wine_type(
    wine_type_code varchar2 (6) not null constraint PK_wine_type_code primary key,
    wine_type_name varchar2 (50)
);

comment on table wine_type is '와인 종류 관련 정보를 관리합니다.';
comment on column wine_type.wine_type_code is '종류 코드';
comment on column wine_type.wine_type_name is '와인 종류 이름';

insert into wine_type(wine_type_code, wine_type_name)
values ('wine01', '레드 와인');

insert into wine_type(wine_type_code, wine_type_name)
values ('wine02', '화이트 와인');

insert into wine_type(wine_type_code, wine_type_name)
values ('wine03', '로제 와인');

select * from wine_type;


