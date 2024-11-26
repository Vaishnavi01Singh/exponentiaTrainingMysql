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


#==================================

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

SET SQL_SAFE_UPDATES = 0;
 
delete from salaryrecord
where empno=1002;
 
delete from salaryrecord;

delete from salaries 
where empno=1045;

select * from salaries;

#==================================

use classicModels;
 
create table Pricelogs
(id int auto_increment primary key,
productcode varchar(15) not null,
price  dec(10,2),
updated_at timestamp not null default current_timestamp
on update current_timestamp,
foreign key(productcode) references
products(productcode)
on delete cascade
on update cascade);
 
delimiter $$
create trigger before_products_update
before update on products
for each row
begin
    if OLD.msrp<>NEW.msrp then
        insert into pricelogs(productcode, price)
        values(old.productcode,old.msrp);
    end if;
end $$
delimiter ;
 

select *from pricelogs;
update products
set msrp=200
where productcode='s10_2016';
 
#-for Multitrigger to check userchangelog--#
create table userchangelogs
(id int auto_increment primary key,
productcode varchar(15) default null,
updated_at timestamp not null default current_timestamp
on update current_timestamp,
updated_by varchar(30) not null,
foreign key(productcode) references
products(productcode)
on delete cascade
on update cascade);
 
#--- Multi Trigger---#
 
delimiter $$
create trigger before_productupdate_loguser
before update on products
for each row
follows before_products_update
begin
    if old.msrp<>new.msrp then
        insert into userchangelogs(productcode,updated_by)
        values
        (old.productcode,user());
    end if;
end $$
delimiter ;
 

update products
set msrp=220
where productcode='s10_2016';
 
SELECT * FROM classicmodels.products;
select *From pricelogs;
select *From userchangelogs;

#==================================

show triggers 
from classicmodels;
 
select trigger_name,
action_order
from 
information_schema.triggers
where trigger_schema='classicmodels'
order by event_object_table,
action_timing,
event_manipulation;





