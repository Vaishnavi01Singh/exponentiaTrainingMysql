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
