#Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
Select * from Worker where FIRST_NAME like '%a%';

#Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
Select * from Worker where FIRST_NAME like '%a';

#. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
Select * from Worker where FIRST_NAME like '_____h';

#Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
Select * from Worker where SALARY between 100000 and 500000;

#Write an SQL query to print details of the Workers who have joined in Feb’2014.
select * from worker where extract(year from joining_date)='2014' and extract(month from joining_date)='2';

#Write an SQL query to fetch the count of employees working in the department ‘Admin’.
select count(worker_id) from worker where department = 'admin';

#Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
Select FIRST_NAME,LAST_NAME,SALARY from worker where SALARY >=50000 and SALARY <=100000;

#Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT DEPARTMENT, count(WORKER_ID)  FROM worker 
GROUP BY DEPARTMENT 
ORDER BY WORKER_ID DESC;

#Write an SQL query to print details of the Workers who are also Managers.
SELECT * from worker, title where worker.worker_id = title.worker_ref_id and title.worker_title = 'Manager';

#Write an SQL query to fetch duplicate records having matching data in some fields of a table.
SELECT WORKER_TITLE, count(WORKER_TITLE) as title_counts from title group by WORKER_TITLE order by title_counts desc;

#26. Write an SQL query to show only odd rows from a table.
select * from Worker where Worker_id %2 =0;

#27. Write an SQL query to show only even rows from a table.
select * from Worker where Worker_id %2 <> 0;

#28. Write an SQL query to clone a new table from another table.
SELECT * INTO WorkerClone FROM Worker;
SELECT * INTO WorkerClone FROM Worker WHERE 1 = 0;
CREATE TABLE WorkerClone LIKE Worker;
select * from WorkerClone ;

#29. Write an SQL query to fetch intersecting records of two tables.
SELECT *
FROM Worker
INTERSECT
SELECT * FROM WorkerClone;

#30. Write an SQL query to show records from one table that another table does not have.
SELECT * FROM Worker
MINUS
SELECT * FROM Title;

#31 Write an SQL query to show the current date and time. 
SELECT NOW();

#32 Write an SQL query to show the top n (say 10) records of a table.
SELECT * from worker LIMIT 5;

#33 Write an SQL query to determine the nth (say n=5) highest salary from a table
SELECT Salary FROM Worker ORDER BY Salary DESC LIMIT 4,1;

#34 Write an SQL query to determine the 5th highest salary without using TOP or limit method.
SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS n, Salary FROM WORKER) as w WHERE n = 5 ;
 
# 35 Write an SQL query to fetch the list of employees with the same salary.
SELECT SALARY, count(SALARY) FROM WORKER group by SALARY having count(SALARY);

#36. Write an SQL query to show the second highest salary from a table.
select max(SALARY) from worker where salary < (select max(salary) from worker);

#37. Write an SQL query to show one row twice in results from a table.
Select * from worker where WORKER_ID =1
union all
Select * from worker where WORKER_ID =1;

#38. Write an SQL query to fetch intersecting records of two tables.
select * from WORKER w inner join Bonus b on w.WORKER_ID = b.WORKER_REF_ID;

#39. Write an SQL query to fetch the first 50% records from a table. 
SELECT * FROM WORKER WHERE WORKER_ID <= (SELECT count(WORKER_ID)/2 from Worker);

#40. Write an SQL query to fetch the departments that have less than five people in it.
SELECT DEPARTMENT, COUNT(WORKER_ID)  FROM Worker GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) < 5;

#41. Write an SQL query to show all departments along with the number of people in there.
SELECT DEPARTMENT, COUNT(*)
FROM WORKER
GROUP BY DEPARTMENT;

 #42. Write an SQL query to show the last record from a table.
Select * from Worker where 
WORKER_ID = (SELECT max(WORKER_ID) from Worker);
 
#43. Write an SQL query to fetch the first row of a table.
Select * from Worker where WORKER_ID = (SELECT min(WORKER_ID) from Worker);

#44. Write an SQL query to fetch the last five records from a table.
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 5;

 #45. Write an SQL query to print the name of employees having the highest salary in each department.
 
 #46. Write an SQL query to fetch three max salaries from a table.
 SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 3;
 
 #47. Write an SQL query to fetch three min salaries from a table.
 select * from worker order by salary limit 3;
 
 #48. Write an SQL query to fetch nth max salaries from a table.
 SELECT distinct Salary from worker a WHERE n >= 
 (SELECT count(distinct Salary) from worker b 
 WHERE a.Salary <= b.Salary) order by a.Salary desc;
 
 #49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
 select DEPARTMENT, sum(Salary) from worker group by DEPARTMENT;
 
#50. Write an SQL query to fetch the names of workers who earn the highest salary.
select FIRST_NAME,LAST_NAME, SALARY from Worker where SALARY=(select max(SALARY) from Worker);






