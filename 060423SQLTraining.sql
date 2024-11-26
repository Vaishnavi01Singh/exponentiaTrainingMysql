# filtering data
# where clause
#15 waq to display the employee who are in admin department
select WORKER_ID,FIRST_NAME,SALARY,DEPARTMENT
from worker
where DEPARTMENT='admin';

#waq to display the exist department of worker
select distinct department
from worker;
 
#waq to display worker salary above 80k from the admin department
select WORKER_ID, FIRST_NAME, salary, DEPARTMENT
from worker
where salary >80000 and DEPARTMENT='Admin';


select WORKER_ID, FIRST_NAME, salary, DEPARTMENT
from worker
where salary >80000 or DEPARTMENT='Admin';
 
#waq to display the worker who hold manager and asst.manager
select WORKER_REF_ID, WORKER_TITLE
from title
where worker_title='manager' or WORKER_TITLE='asst. Manager';
 
#waq to display worker_ref_id whose bonus amount between(or in the range) 3k to 5k
select WORKER_REF_ID,BONUS_AMOUNT
from bonus
where BONUS_AMOUNT between 4000 and 5000;
 
#waq to display worker_ref_id whose bonus amount is 3k, 4k, 5k
select WORKER_REF_ID,BONUS_AMOUNT
from bonus
where BONUS_AMOUNT in(3000, 4000, 5000);
#waq to display worker_ref_id whose bonus amount is not 3k, 4k, 5k
 
select WORKER_REF_ID,BONUS_AMOUNT
from bonus
where BONUS_AMOUNT not in(3000, 4000, 5000);
 

#waq to display worker whose first_name starts with A and V.
select WORKER_ID, FIRST_NAME 
from worker
where FIRST_NAME like 'A%' or FIRST_NAME like 'V%';
 
#waq to display worker info whose first_name starts with 'V' and end with 'l'
select WORKER_ID, FIRST_NAME 
from worker
where FIRST_NAME like 'V%l';
 
#waq to display worker lastname whose lastname 2nd char is 'i';
select WORKER_ID, last_name 
from worker
where LAST_NAME like '_i%';
 
select WORKER_ID, last_name 
from worker
where LAST_NAME like '%i%';
 
#waq to display the 5 worker details order by first_name
select *
from  worker
order by salary desc, FIRST_NAME desc
limit 2,7;

select max(salary),department
from worker
where salary<(select max(Salary) from worker)
group by department;
 
 # waq to display department of worker which is not assigned
 select department, first_name, worker_id
from worker
where department is not null;

SELECT * FROM worker ORDER BY FIRST_NAME ASC;
SELECT * FROM worker ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;
Select * from Worker where FIRST_NAME in ('Vipul','Satish');
Select * from Worker where FIRST_NAME not in ('Vipul','Satish');
SELECT * FROM worker WHERE department = "Admin";

