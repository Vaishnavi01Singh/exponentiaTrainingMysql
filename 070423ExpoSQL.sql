use org;
select count(worker_ref_id), bonus_amount
from bonus
group by BONUS_AMOUNT
having BONUS_AMOUNT>3000;

select sum(SALARY), DEPARTMENT
from worker
group by department;

select count(worker_id), department
from worker
group by department;

select worker_title, count(WORKER_REF_ID)
from org.title
group by worker_title;

select sum(salary), department, WORKER_ID
from worker
group by department, WORKER_ID
with rollup;

select worker_id, first_name, last_name, department
from worker
where department in('HR', 'Account', 'Admin');

#acheive the above scenario using subquery if not sure about departments
select worker_id, first_name, last_name, department
from worker
where department in(select department from worker 
where department is not null) 
order by department;

create table demo1(id int primary key);
create table demo2(id int primary key);

insert into demo1 values(1),(2),(3);
insert into demo2 values(2),(3),(4);

select * from demo2;

select id from demo1
union all 
select id from demo2;

#Emulate intersect using distinct and inner join
select distinct id from demo1 inner join demo2 using (id);

#Emulate minus operator using left join
select id from demo1 left join demo1 using(id) where demo1.id is null;



