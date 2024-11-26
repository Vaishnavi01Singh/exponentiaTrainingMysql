create database SQLAssessment;
use SQLAssessment;

CREATE TABLE hospital
   ( name varchar(20) ,
    age VARCHAR(30),
    department VARCHAR(30),
	dateofadm date NOT NULL,
    charges integer,
    sex VARCHAR(10)
   ) ;
   
drop table hospital;
   
desc hospital;   
   
INSERT INTO hospital VALUES ( 'Sandeep' , 65, 'Surgery', "23/02/98" ,'300','M');
INSERT INTO hospital VALUES ( 'Ravina' , 24, 'Orthopedic', '20/01/98' ,'200','F');
INSERT INTO hospital VALUES ( 'Karan' , 45, 'Orthopedic', '19/02/98' ,'200','M');
INSERT INTO hospital VALUES ( 'Tarun' , 12, 'Surgery', '01/01/98' ,'300','M');
INSERT INTO hospital VALUES ( 'Zubin' , 36, 'ENT', '12/02/98' ,'250','M');
INSERT INTO hospital VALUES ( 'Ketaki' , 16, 'ENT', '24/02/98' ,'300','F');
INSERT INTO hospital VALUES ( 'Ankita' , 29, 'Cardiology', '20/02/98' ,'800','F');
INSERT INTO hospital VALUES ( 'Zareen' , 45, 'Gynechology', '22/02/98' ,'300','F');
INSERT INTO hospital VALUES ( 'Kush' , 19, 'Cardiology', '13/02/98' ,'800','M');
INSERT INTO hospital VALUES ( 'Shaliya' , 31, 'Nuclear Medicine', '19/02/98' ,'400','M');

Select * from hospital;

#1.To show all information about the patients of cardiology department. 
Select * from Hospital where department='Cardiology';

#2. To list the names of female patients who are in orthopedic dept.
select name from Hospital where Department='Orthopedic' and Sex='F';

#3.To list names of all patients with their date of admission in ascending order.
Select name,dateofadm from Hospital order by dateofadm;

#================HOSPITAL TABLE2====================
CREATE TABLE hospital1
   ( name varchar(20) ,
    age VARCHAR(30),
    department VARCHAR(30),
	dateofadm date NOT NULL,
    charges integer,
    sex VARCHAR(10)
   ) ;
   
INSERT INTO hospital1 VALUES ( 'Arpit' , 62, 'Surgery', "21/10/98" ,'300','M');
INSERT INTO hospital1 VALUES ( 'zarina' , 22, 'ENT', '12/12/97' ,'205','F');
INSERT INTO hospital1 VALUES ( 'Kareem' ,32,'Orthopedic','19/02/98' ,'200','M');
INSERT INTO hospital1 VALUES ( 'Arun' , 12, 'Surgery', '11/01/98' ,'300','M');
INSERT INTO hospital1 VALUES ( 'Zubin' , 36, 'ENT', '12/02/98' ,'250','M');
INSERT INTO hospital1 VALUES ( 'Ketaki' , 16, 'ENT', '24/02/98' ,'300','F');
INSERT INTO hospital1 VALUES ( 'Ankita' , 29, 'Cardiology', '20/02/98' ,'800','F');
INSERT INTO hospital1 VALUES ( 'Zareen' , 45, 'Gynechology', '22/02/98' ,'300','F');
INSERT INTO hospital1 VALUES ( 'Kush' , 19, 'Cardiology', '13/02/98' ,'800','M');
INSERT INTO hospital1 VALUES ( 'Shaliya' , 31, 'Nuclear Medicine', '19/02/98' ,'400','M');

#4 a 
	SELECT COUNT(DISTINCT charges) FROM hospital;

#4 b
SELECT MIN(age) FROM hospital WHERE sex='F';

#4 c
SELECT SUM(charges) FROM hospital WHERE department='ENT';

#4 d
SELECT AVG(charges) FROM hospital WHERE dateofadm  < ('12/02/98');

#=============LEVEL 2==================

#1 1.	Display the alternate rows from the Hospital Table.
SELECT NAME, sex, ROW_NUMBER() OVER(PARTITION BY sex ORDER BY sex) AS R
FROM hospital1 ORDER BY R, sex DESC;
 
#2 update multiple rows in one query. Use Hospital Table
set sql_safe_updates=0;

update  hospital1 set age='70' ,department='ent',charges='10000'
where name='Arpit';
select * from hospital1;

#========FURNITURE=============

CREATE TABLE furniture (
    itemname varchar(255),
    type varchar(255),
    dateofstock DATE,
    Price varchar(255),
    discount varchar(255)
);

insert into furniture values('white lotus', 'double bed', '23/02/02', 30000, 25);
insert into furniture values('pink feater', 'baby cot', '20/01/02',7000, 25);
insert into furniture values('dolphin', ' baby cot', '19/02/02', 9500, 25);
insert into furniture values('decent', 'office table', '01/01/02',25000, 30);
insert into furniture values('comfort zone', 'double bed', '12/01/02',25000, 25);

select * from furniture;

# 3.	Display the 5th highest price product from furniture table.
SELECT price FROM furniture ORDER BY price DESC LIMIT 4,1;

#4 	Create a after trigger to insert record in furniture table to accept only the price amount which is >2000. 
#If not throw error “ the price of any product should be >2000”.
DELIMITER $$ 
	CREATE TRIGGER after_trigger 
	after insert  
	ON hospital1 FOR EACH ROW  
	BEGIN  
	    DECLARE error_msg VARCHAR(255);  
	    SET error_msg = ('the price of any product should be >2000');  
	    IF price > 2000 THEN  
	    SIGNAL SQLSTATE '2000'   
	    SET MESSAGE_TEXT = error_msg;  
	    END IF;  
	END $$  
DELIMITER ;  

#5 Create a trigger to insert a new record in ‘furniture log’ 
#table also whenever there is new record inserted in furniture table. 
#Identify the trigger type (before or after) and explain why.

delimiter ##
create trigger after_insert1
after insert
on furniture
for each row
begin
    if new.discount is null then
        insert into furniture(itemname,type, dateofstock,Price,discount)
values(new.discount,concat('Hello ', new.discount,' none.'));
end if;
end ##
delimiter ;
 
insert into furniture(itemname,type, dateofstock,Price,discount)
values
('comfozone11', 'doublbed11', '12/01/02',25000, null);

 
#6 Create an unique  index on Itemname and explain the below concepts
create unique index uidx_itemname
on furniture(itemname);




