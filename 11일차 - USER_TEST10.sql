create table test10Tbl(
    a number not null,
    b varchar(50) null
    );

-- user_test10  ���� hr�� �������� employee ���̺� ������ �� ���ٱ��� �ʿ�
-- grant select on hr.employee to user_test10;  : sys �������� �ؾ���
select * from hr.employee;

select * from test10Tbl;
show user;

select * from user_test10.test10tbl;

-- �ٸ� ������� ��ü�� ���� �Ҷ��� �����ָ�.��ü��
select * from employee; -- ����x
select * from hr.employee;

grant ��ü�� ���� on ��ü�� to ����ڸ�;

-- �ٸ� ����� ���̺� insert
desc hr.emp_copy55;
select * from hr.emp_copy55;

insert into hr.emp_copy55 (eno)
values (3333);

-- with grant option���� ���� ������ �ٸ� ����ڿ��� �ο�
grant select on hr.emp_copy56 to user_test11;

select * from hr.dept_copy56;

select * from user_role_privs;;

select * from hr.dept_copy57;
