use classicmodels;

show tables;

select * from customers;

delimiter $$
create procedure GetCustomers()
begin
select CustomerName,
    city, postalcode, country,state
    from customers
    order by customerName;
end $$
delimiter ;

Delimiter //
create procedure GetTotalOrder()
begin
 #variable to store the count of totalorder
declare totalorder int ;
select count(*) into totalorder
from orders;
select totalOrder;
end //
delimiter ;


delimiter $$
create procedure empdetails()
begin
select firstname, lastname, email, jobtitle
from employees
order by firstname;
end $$
delimiter ;
call empdetails;

#display fn,ln, email, jobtitle from employees table using storedprocedure
delimiter $$
create procedure empdetails()
begin
select firstname, lastname, email, jobtitle
from employees
order by firstname;
end $$
delimiter ;
call empdetails;

#waq to return orderdetail based on customerno by creating storedprocedure using "in parameter"
delimiter //
create procedure GetOrderDetailBycustomerNumber(IN customerNumber int)
begin
select * from orderdetails where customerNumber=customerNumber;
end //
delimiter ;
call GetOrderDetailBycustomerNumber(121);

#-- waq to return orderdetail based on customerno by creating storedprocedure using "in parameter" using orders table
delimiter //
create procedure GetOrderByCustNumber(IN CustNo int)
begin
select * from orders
where customerNumber=CustNo;
end //
delimiter ;
call GetOrderByCustNumber(103);

