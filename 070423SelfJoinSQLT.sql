#joins
 use org;
# 1. inner join- query rows from a table that has matching rows
#in another table
 
select worker_id, first_name, salary, worker_title
from worker w1
inner join
title t1
where w1.WORKER_ID= t1.WORKER_REF_ID;

 # 2. Left join- return all rows from left table and matching rows
# from the right table or null if no matching rows found in the
# right table
select w1.worker_id, w1.first_name, w1.salary, t1.worker_title
from worker w1
left join
title t1
on w1.WORKER_ID= t1.WORKER_REF_ID;

# 3. Right join-return all rows from right table and matching rows
# from the left table or null if no matching rows found in the
# left table
select w1.worker_id, w1.first_name, w1.salary, b1.BONUS_AMOUNT
from bonus b1
right join
worker w1
on w1.WORKER_ID= b1.WORKER_REF_ID;
 
 # 4. Cross join- cartesian product
 select *from worker
cross join
bonus
where worker.worker_id=bonus.WORKER_REF_ID;
 
# 5. self join- join a table to itself using table alias and connect
#rows within the same table using left join and inner join
 select *from worker;
select w1.first_name, w1.JOINING_DATE, w1.salary
from worker w1
inner join
worker w2 
on w1. worker_id= w2.WORKER_ID and w1.FIRST_NAME>w2.FIRST_NAME;




