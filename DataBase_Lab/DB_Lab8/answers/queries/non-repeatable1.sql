use AdventureWorks2012

create table TestTable2
(
ID INT,
amount CHAR(1)
);

INSERT INTO TestTable2 (ID,amount)
VALUES (1,'A'),(2,'B'),(3,'C');

drop table TestTable2;
select * from TestTable2;
----------NON REPEATABLE READS
BEGIN TRANSACTION TRANS1;

---------Query1---------
select * 
from TestTable2
where amount ='C';
go
waitfor delay '00:00:08'
---------Query3---------
select * 
from TestTable2
where amount ='C';
COMMIT;


