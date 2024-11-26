use sqltraining;
show tables;
create table department(depid int, depname varchar(10));
alter table department add constraint pk_did primary key(depid);
desc department;
desc employee;
alter table employee add constraint fk_did foreign key(depid) 
references department(depid);

insert into department values(101, "Sales");
insert into department values(102, "Marketing");
insert into department values(103, "Operation");
insert into department values(104, "IT");
select *from department;

insert into employee values(1, "hari", 23000, 104);
insert into employee values(2, "Jack", 32000, null);
insert into employee values(3, "Mary", 43000, 104);
insert into employee values(4, 'Prem', 40000, 101);
insert into employee values(5, 'Chetan', 65000, 102);

select *from employee;

alter table employee modify salary float check(salary >=10000 or salary<=100000);

alter table employee add constraint chk_salary check(salary>=10000 and salary<=100000);
insert into employee values(6, 'Grace', 2000,103);

delete from employee where salary=2000;


select extract(year from sysdate());
select extract(second from sysdate());

select sysdate();
create table datetbl(birthdate date);

insert into datetbl values('1985-01-09');

select *from datetbl;

select *
from datetbl 
where extract(year from birthdate)>1985;

