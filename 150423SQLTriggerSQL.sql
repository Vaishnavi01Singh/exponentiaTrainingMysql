use classicmodels;

create table sales
(
    id int auto_increment,
    product varchar(100) not null,
    quantity int not null default 0,
    fiscalyear smallint not null,
    fiscalmonth tinyint not null,
    check(fiscalmonth>=1 and fiscalmonth<=12),
    check(fiscalyear between 2000 and 2050),
    check(quantity>=0),
    unique(product ,fiscalyear, fiscalmonth),
    primary key(id)
);

desc sales;

insert into sales(product, quantity,fiscalyear,fiscalmonth)
values('Eagle Drag Bike', 120, 2020, 1);
insert into sales(product, quantity,fiscalyear,fiscalmonth)
values('2023 HD Eagle Drag Bike', 150, 2023, 1);
insert into sales(product, quantity,fiscalyear,fiscalmonth)
values('1970 Plymouth Hemi Cuda', 200, 2025, 3);

select * from sales;

#==========BEFORE UPDATE  TRIGGER========================

drop trigger before_sales_update;
Delimiter $$
Create trigger before_sales_update
before update
on sales 
for each row
begin
        declare errorMsg varchar(255);
        set errorMsg=concat('The new quantity ', 
        NEW.quantity, ' cannot be 3 times greater than current quantity ', old.quantity);

        if new.quantity>old.quantity*3 then
            signal sqlstate '45000'
            set message_text=errormsg;
        end if;
end $$
delimiter ;
 
 
update sales set quantity=2000 where id=1;
rollback;
show errors;

#-------After update Trigger------#

create table salesChanges(
id int auto_increment primary key,
salesid int,
beforequantity int,
afterquantity int,
changedAt timestamp not null default current_timestamp);
 

delimiter $$
create trigger after_sales_update
after update
on sales 
for each row
begin
    if old.quantity<>new.quantity then
        insert into salesChanges(salesid, beforequantity,
        afterquantity)values(old.id,old.quantity, new.quantity);
    end if;
end $$
delimiter ;
 
update sales 
set quantity=350
where id=1;


