#An index is a data structure such as B-Tree that improves
#the speed of data retrieval on a table.
# The query optimizer may use indexes to quickly locate data 
#without having to scan every row in a table for a given query
use org;

create table demotbl(
c1 int primary key,
c2 int not null,
c3 int not null,
c4 varchar(20),
index(c2,c3)
);

create index idx_c4 on demotbl(c4);
#storage engine	allowed index type
#innodb          B-Tree
#MyISAM          B-Tree
#Memory/Heap     Hash, B-Tree

use classicmodels;

select *from employees;

select employeeNumber, lastname, firstname
from employees
where jobTitle='Sales Rep';

create index idx_Jtitle on employees(jobTitle);

Explain select employeeNumber, lastname, firstname
from employees
where jobTitle='Sales Rep';

 explain select firstname, officecode
from employees
where employeenumber=1002;

show indexes from employees;
drop index idx_jtitle on employees;


select *from products;

explain select 
productName,buyprice, msrp
from products
where  productName Like '1970%';

#prefix index
create index idx_prdname
on products(productName(20));

desc products;

#unique index
create unique index uidx_lastname
on employees(lastname);

#types of indexes
#clustered indexes(Primary key column)
#unique indexes(index on unique value column)
#prefix indexes(index on string or binary dtype column specified with length)
#composite index(index on more than one column)