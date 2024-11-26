use SqlTraining;
show tables;

create table department(depid int, depname varchar(10));
create table employee(empid varchar(10), empname varchar(20),
salary float, depid int, primary key(empid));

alter table department add constraint pk_did primary key(depid);
desc department;
desc employee;
drop table employee;

alter table employee add constraint fk_did foreign key(depid)
references department(depid);

insert into department values(101,"Sales");
insert into department values(102,"Marketing");
insert into department values(103,"Operation");
insert into department values(104,"IT");
select *from department;

insert into employee values(1, "hari", 23000, 104);
insert into employee values(2, "Jack", 32000, null);
insert into employee values(3, "Mary", 43000, 104);
insert into employee values(4, 'Prem', 40000, 101);
insert into employee values(5, 'Chetan', 65000, 102);
select *from employee;

drop table employee;

alter table employee add constraint chk_salary check(salary>=10000 and salary<=100000);
insert into employee values(6, 'Grace', 2000,103);
select *from employee;






