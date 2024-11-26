#Delete Trigger

use classicmodels;

create table salaries
(
	Empno int primary key,
    validfrom date not null,
    amount dec(12,2) not null default 0
);

insert into salaries values
(1001, '2002-01-02', 50000),
(1002, '2000-01-09', 65000),
(1045, '2000-01-05', 70000);

select *From salaries;

create table salaryArchives
(id int primary key auto_increment,
empno int  ,
validfrom date not null,
amount dec(12,2) not null default 0,
deletedat timestamp default now());

#--- Before Delete Trigger----#
Delimiter ##
create trigger before_salaries_delete
before delete
on salaries 
for each row
begin
		insert into salaryArchives
        (empno ,validfrom, amount)
        values(old.empno, old.validfrom,old.amount);
end ##
delimiter ;


delete from salaries 
where empno=1045;
#----------------#
create table salaryRecord
(empno int primary key,
salary dec(10,2) not null default 0
);

insert into salaryRecord
values(1002, 6000),
(1001,8000),
(1003, 9000);

select *from salaryRecord;


create table salaryBudgets
(
	total decimal(15,2) not null
);

insert into salaryBudgets(total)
select sum(salary)
from salaryRecord;

#---After Delete Triggers----#

delimiter ##
create trigger after_salary_delete
after delete
on salaryrecord
for each row
begin
		update salarybudgets
        set total=total-old.salary;
end ##
delimiter ;

delete from salaryrecord
where empno=1002;

delete from salaryrecord;