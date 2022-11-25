use AdventureWorks2012
go

select * from Sales.Customer;
----------exclusive & shared locks ---------
BEGIN TRANSACTION;
---------Query1---------
update Sales.Customer
set TerritoryID =2
where CustomerID =1;
go
waitfor delay '00:00:08'
ROLLBACK;
select * from Sales.Customer;

