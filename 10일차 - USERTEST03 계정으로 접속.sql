create table testTbl(
    a number not null,
    b number null,
    c varchar (10) null
);

insert into testTbl
values (1, 1, '°¡³ª´Ù');

select * from testTbl;