use AdventureWorks2012
go
create user loginTemp for login loginTemp;

create role Role2;

ALTER ROLE db_accessadmin ADD MEMBER Role2;

ALTER ROLE db_denydatareader ADD MEMBER Role2;

ALTER ROLE Role2 ADD MEMBER loginTemp;

grant select 
on database::AdventureWorks2012
to Role2;