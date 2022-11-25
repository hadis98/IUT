use AdventureWorks2012
go
--drop table TestTable2;
create table TestTable2
(
ID INT,
amount CHAR(1)
);

INSERT INTO TestTable2 (ID,amount)
VALUES (1,'A'),(2,'B'),(3,'C');

select * from TestTable2;

----------DIRTY  READS ---------
BEGIN TRANSACTION TRANS2;

---------Query1---------
update TestTable2
set amount ='C'
where amount ='A';
go
waitfor delay '00:00:08'
ROLLBACK TRAN TRANS2;
select * from TestTable2;

