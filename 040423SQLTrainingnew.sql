create database SQLTraining1;

CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20),
species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);
desc pet;

insert into pet values("Fluffy", "Harold", "Cat", "f",'1993-02-04',null);
insert into pet values("Claws", "Gwen", "Cat", "m",'1994-03-17',null);
insert into pet values("Buffy", "Harold", "dog", "f",'1989-05-13',null);
insert into pet values("Fang", "Benny", "dog", "m",'1990-08-27',null);
insert into pet values("Bowser", "Diane", "dog", "m",'1979-08-31',"1995-07-29");
insert into pet values("Chirpy", "Gwen", "bird", "f",'1998-09-11',null);
insert into pet values("Whistier", "Gwen", "bird", "",'1997-12-09',null);
insert into pet values("Slim", "Harold", "snake", "m",'1996-04-29',null);
select * from pet;

select * from pet where species='dog';
select * from pet where birth >='1996';
Select * from pet where extract(year from cast(birth as date) )>= 1996;

select extract(week from sysdate());
select extract(year from sysdate());
select extract(second from sysdate());
select sysdate();
create table datetbl(birthdate date);
insert into datetbl values('1985-01-09');
select *from datetbl;
select *from datetbl where extract(year from birthdate)>1985;

select * from pet where species ='snake' or species= 'bird';
select * from pet where (species='cat' and sex='m') or (sex='m' and species='dog');
select distinct owner from pet;

