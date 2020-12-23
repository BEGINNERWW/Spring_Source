create table smember(
id varchar2(15),
password varchar2(10),
name varchar2(15),
age number,
gender varchar2(5),
email varchar2(30),
primary key(id)
);

select * from smember;
delete from smember where id= 'admin';
commit;
