use classicmodels;
 
create view Sales_Rep_Emp
as
select *
from employees
where jobTitle="Sales Rep";
 
select *from sales_rep_emp
where reportsto=1102;
 
insert into sales_rep_emp values(1452, 'Grace','Mona', 'x102', 'GMona@classicmodelcars.com',7,1102,'Sales Rep');
 
select *From sales_rep_emp;

#==================

create view usa_customers
as select * from customers
where country ='USA' ;

select *from usa_customers;

#==================
#FUNCTION CREATION

#Delimiter $$
#create fuction func_name(param1, param2,...)
#returns datatype
#[not] deterministic 
#begin
#--statements
#end $$
#Delimiter ;

#-----------------Create Function------
delimiter $$
    create function CustomerLevel(credit Decimal(10,2))
    returns Varchar(20)
    deterministic
    begin
        declare customerlevel varchar(20);

            IF credit>50000 Then
                set customerlevel='Platinum';
            elseif (credit <=50000 and credit >=10000) Then
                set customerlevel='Gold';
            elseif credit <10000 then
                set customerlevel='Silver';
            end if;
            RETURN (customerlevel);
    end $$
delimiter ;
 

#execute function using select statement
 
select customername, CustomerLevel(creditLimit) as LevelofCustomer
from customers
order by customerName;

#==============
#wa function to return the sum of quantityordered and sum of price group by OrderNumber ?
#use orderdetails table;
select * from orderdetails;

drop function orderreport;
delimiter $$
create function orderreport(orderno int)
returns decimal(10,2)
deterministic
begin
    #declare qa int;
    declare price int;

    select sum(priceeach) into price
    from orderdetails
    where orderNumber=orderno;
    return (price);
end $$
delimiter ;
 
select orderNumber,orderreport(OrderNumber)
from orderdetails;
