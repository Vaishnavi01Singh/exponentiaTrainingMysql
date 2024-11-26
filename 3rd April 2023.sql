create database SqlTraining;
use sqltraining;

create table employee(empid int not null auto_increment, empname varchar(20),
salary float, depid int, primary key(empid));

select *from employee;

describe employee;
alter table employee modify empid int not null;
alter table employee modify empname varchar(10) not null;
insert into employee values(1, 'Ajay', 35000, 12);
insert into employee(empid,empname,salary)
values(2,'null',23000);
alter table employee modify salary float default(10000);
insert into employee(empid, empname,depid)values(3, "Lalit",23);

alter table employee add constraint pk_eid primary key(empid);
describe employee;

alter table employee auto_increment=100;

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

delete from employee 
where empid=2;

set sql_safe_updates=0;

alter table employee rename column empid to emp_id;

rename table employee to emp_record;

drop table employee;

create table employee(empid int , empname varchar(20),
salary float, depid int);

alter table employee add constraint pk_eid primary key(empid);

desc employee;

alter table employee drop primary key;