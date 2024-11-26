use classicmodels;

create table WorkCenter(
id int auto_increment primary key,
name varchar(90) not null,
capacity int not null
);
 
drop table workcenter;

create table workcenterstats
(
    totalcapacity int not null
);


delimiter $$
create trigger before_workcenter_insert
before insert
on workcenter for each row
begin
    declare rowcount int;

    select count(*)
    into rowcount
    from workcenterstats;

    if rowcount>0 then
        update workcenterstats
        set totalcapacity=totalcapacity+new.capacity;
    else
        insert into workcenterstats values(new.capacity);
    end if;
end $$
 
delimiter ;
 
insert into workcenter(name,capacity)
values('Mold Machine',100);
 
insert into workcenter(name,capacity)
values('packing',200);

SET SQL_SAFE_UPDATES = 0;

select *From workcenter;
select *from workcenterstats;
select * from classicmodels.workcenterstats;

#--- After insert Trigger---#
create table members
(
    id int auto_increment primary key,
    name varchar(80) not null,
    email varchar(255),
    birthdate date
);
 
create table reminders
(
    id int auto_increment,
    member_id int,
    message varchar(255) not null,
    primary key(id, member_id)
);
 

delimiter ##
create trigger after_member_insert
after insert
on members
for each row
begin
    if new.birthdate is null then
        insert into reminders(member_id, message)
values(new.id,concat('Hello ', new.name,' , please update your date of birth.'));
end if;
end ##
delimiter ;
 
insert into members(name, email, birthdate)
values
('mary', 'mary.k@gmail.com', null),
('Harry', 'harry.k@gmail.com','2000-02-01');
 
select *From members;
 
select *From reminders;

#========================Excersice===========================
#Use orders table in classicmodels db
#create a before update trigger to update the comment column in orders table which contains null to 'no comments'?
#update comment column to 'no comment' if comments column contains null;

use classicmodels;
select * from orders;

delimiter //
CREATE TRIGGER upd_check BEFORE UPDATE ON orders
       FOR EACH ROW
       BEGIN
 ALTER TABLE orders CHANGE comments `id` INT( 11 ) COMMENT 'id of user' 
end if;
end ##
delimiter ;

select * from orders;





