#List the stored procedure
show procedure status
where db='classicmodels'; #sp conditional statements
# syntax:
# IF condition THEN
    #statements;
#END IF
use classicmodels;
select *from customers;
drop procedure GetCustomerLevel;
Delimiter ##
create procedure GetCustomerLevel(
IN PcustomerNo int,
Out PCustomerLevel Varchar(20))
Begin
    declare credit decimal(10,2);

    select creditLimit into credit
    from customers
    where customerNumber=PcustomerNo;

IF credit >50000 THEN
	SET PCustomerLevel='Platinum';
    END IF;
End ##
Delimiter ; Call GetCustomerLevel(141, @level); select @level; select customerNumber, creditLimit 
from customers
where creditLimit>50000;


drop procedure GetCustomerLevel;
Delimiter ##
create procedure GetCustomerLevel(
IN PcustomerNo int,
Out PCustomerLevel Varchar(20))
Begin
    declare credit decimal(10,2);

    select creditLimit into credit
    from customers
    where customerNumber=PcustomerNo;

    IF credit >50000 THEN
        SET PCustomerLevel='Platinum';
    ELSEIF credit<50000 and credit>10000 THEN
        SET PCustomerLevel='Gold';
    ELSE
        SET PCustomerLevel='Silver';
    END IF;
End ##
Delimiter ; Call GetCustomerLevel(103,@level); select @level as TypeofMember;

#============================

drop procedure GetCustomerLevel;
Delimiter ##
create procedure GetCustomerLevel(
IN PcustomerNo int,
Out PCustomerLevel Varchar(20))
Begin
    declare credit decimal(10,2);

    select creditLimit into credit
    from customers
    where customerNumber=PcustomerNo;

    IF credit >50000 THEN
        SET PCustomerLevel='Platinum';
    ELSEIF credit<50000 and credit>10000 THEN
        SET PCustomerLevel='Gold';
    ELSE
        SET PCustomerLevel='Silver';
    END IF;
End ##
Delimiter ; 

Call GetCustomerLevel(103,@level); 
select @level as TypeofMember;

#==========================
#[label]:Loop
#....
#--terminate the loop
# if condition then
#    LEAVE [label];
#END IF;
#.... #END Loop; drop procedure LoopDemo;
Delimiter $$
create procedure LoopDemo()
begin
    declare n1 int;
    declare str1 varchar(255);

    set n1=1;
    set str1='';

    label1:LOOP
    IF n1>10 THEN
        LEAVE label1;
    END IF;

    set n1= n1+1;
    if (n1 mod 2) then
        ITERATE label1;
    else
        set str1=concat(str1,n1, ',');
    END IF;
END Loop;
select str1;
end $$
delimiter ; 

call LoopDemo();

#==============================

#[label]:Loop
#....
#--terminate the loop
# if condition then
#    LEAVE [label];
#END IF;
#.... #END Loop; drop procedure LoopDemo;
Delimiter $$
create procedure LoopDemo()
begin
    declare n1 int;
    declare str1 varchar(255);

    set n1=1;
    set str1='';

    label1:LOOP
    IF n1>10 THEN
        LEAVE label1;
    END IF;

    set n1= n1+1;
    if (n1 mod 2) then
        ITERATE label1;
    else
        set str1=concat(str1,n1, ',');
    END IF;
END Loop;
select str1;
end $$
delimiter ; 
call LoopDemo();









