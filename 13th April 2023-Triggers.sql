#trigger is a stored program invoked automatically alter
#in response to an event such as insert,update or delete that 
# occurs in the associated table
# 2 types of triggers
#-------------------
# A row level trigger-is activated for each row that is inserted, updated or deleted
# A statement level trigger- is executed once for each transactions regardless
#of how many of rows are inserted ,updated or deleted
####in mysql it supports only A row level trigger

create table employees_audit
(id int auto_increment primary key,
employeeNo int not null,
Name varchar(50) not null,
changedate datetime default null,
action varchar(50) default null
);
drop trigger before_employee_update;
#before trigger
create trigger before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
insert into employees_audit 
set action='update',
employeeno =old.employeeNumber,
Name=old.lastName,
changedate=now();


select *from employees
where employeeNumber=1056;

update employees set lastName='Phan'
where employeenumber=1056;

select *From employees_audit;
