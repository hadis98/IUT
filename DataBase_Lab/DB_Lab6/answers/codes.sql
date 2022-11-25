create procedure myprocedure2
as
begin
select *
from HumanResources.vEmployeeDepartmentHistory
end

execute myprocedure2
exec myprocedure2
------------------------------------------------
alter procedure myprocedure2
@firstName varchar(50),
@lastName varchar(50)
as
begin
select *
from HumanResources.vEmployeeDepartmentHistory
where FirstName=@firstName and LastName=@lastName
end

execute myprocedure2 'John','Wood'
execute myprocedure2 @lastName='Wood',@firstName='John'
----------------------------------------------------
alter procedure myprocedure2
@firstName varchar(50),
@lastName varchar(50),
@department varchar(20) output
as
begin
set @department=(select Department
from HumanResources.vEmployeeDepartmentHistory
where FirstName=@firstName and LastName=@lastName)
end

declare @dep varchar(20)
execute myprocedure2 'John','Wood',@dep output
select @dep
---------------------------------------------------
create table temp(
ID char(3),
[name] varchar(20)
);
create table mylog(
insertTime datetime
);

create trigger t1
on temp
after insert
as
begin
insert into mylog values(GETDATE())
end

insert into temp values('1','Hadi')
insert into temp values('2','Ali')
-------------------------------------------------
alter trigger t1
on temp
after insert
as
begin
select * from inserted
end

insert into temp values('3','Farhad')
-------------------------------------------------
alter trigger t1
on temp
after delete
as
begin
select *  from deleted
end

delete from temp where ID='3'
-------------------------------------------------
alter trigger t1
on temp
after update
as
begin
select *  from deleted
select * from inserted
end

select * from temp

update temp
set name='ahmad'
where ID='2'

select * from temp
---------------------------------------------
alter trigger t1
on temp
instead of insert
as
begin
print 'Ok'
end

select * from temp
insert into temp values('5','Farshid')
select * from temp
