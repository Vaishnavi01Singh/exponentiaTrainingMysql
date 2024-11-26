use classicmodels;

#---Common Table Expression--#
#syntax
#---with cte_name (column_list) as
#-----(query)
#------select *from cte_name;
 
with cust_in_usa As
(select customerName, state from
customers where country='USA')
select customerName,state 
from cust_in_usa
where state='CA'
order by customername;

select *from orders;
select *From orderdetails;
select *From customers;
select *From employees;
with top5sales2003 as
(select salesRepEmployeeNumber employeenumber,
sum(quantityOrdered*priceEach) as sales
from orders
Inner join 
orderdetails using(orderNumber)
inner join 
customers using(customerNumber)
where 
year(shippedDate)=2003
and status='Shipped'
group by employeenumber
order by sales desc
limit 5)
select employeenumber,firstName,lastname, sales
from 
employees
join 
top5sales2003 using(employeenumber);


#======================

create view salesrepdetails as
with salesrep as
(select employeenumber, concat(firstName, '-',lastName) as SalesRepName
from employees
where jobTitle='Sales Rep'),
customer_salesrep as
(select customerName, salesrepname
from customers
inner join 
salesrep on employeenumber=salesrepEmployeenumber)
select *
from customer_salesrep
order by customerName;
 
#execute the view
select *From salesrepdetails;


