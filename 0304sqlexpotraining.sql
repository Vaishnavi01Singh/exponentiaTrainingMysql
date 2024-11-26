create database SqlTraining;
use SqlTraining;

create table employee(empid int not null auto_increment, empname varchar(20),
salary float, depid int, primary key(empid));

select * from employee;
desc employee;

alter table employee modify empid int not null;
alter table employee modify empname varchar(10) not null;

insert into employee values(1, 'Ajay', 35000, 12);
describe employee;
select * from employee;

insert into employee(empid,empname,salary)
values(2,'null',23000);
describe employee;
select * from employee;

alter table employee modify salary float default(1000);
insert into employee(empid, empname,depid)values(3, "Lalit",23);
select * from employee;

alter table employee add constraint pk_eid primary key(empid);
describe employee;

alter table employee auto_increment=100;
describe employee;

truncate table employee;
insert into employee(empname, salary, depid) values('Hari', 32000, 24);
insert into employee(empname, salary, depid) values('Kiran', 12000, 25);
select *from employee;
drop table employee;

alter table employee change empid empid int auto_increment primary key;
alter table employee add emailid varchar(20) unique;

describe employee;

update  employee set emailid='jay@xyz.com' 
where empid=2;

select * from employee;

delete from employee 
where empid=2;

set sql_safe_updates=0;







