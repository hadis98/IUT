use AdventureWorks2012
go

-----------------”Ê«· 1--------------------
exec xp_cmdshell 
'bcp AdventureWorks2012.Sales.SalesTerritory out
"C:\Users\Win 10\Desktop\term6\az DB\homeworks\az7_9825413\salesTerritory.txt"
-T -c -t"|" ';


bulk insert Sales.SalesTerritoryNew
from 'C:\Users\Win 10\Desktop\term6\az DB\homeworks\az7_9825413\salesTerritory.txt'
with 
(
	fieldterminator = '|'
)

select * from Sales.SalesTerritoryNew;

-----------------”Ê«· 2--------------------
exec xp_cmdshell 'bcp "select Name , TerritoryID  from AdventureWorks2012.Sales.SalesTerritory" queryout "C:\Users\Win 10\Desktop\term6\az DB\homeworks\az7_9825413\soal2_output.txt" -T -c -t;'

----------------”Ê«· 3---------------------
select * from Production.Location;
exec xp_cmdshell 'bcp "AdventureWorks2012.Production.Location" out "C:\Users\Win 10\Desktop\term6\az DB\homeworks\az7_9825413\location.dat" -T -c';


-----------------”Ê«· 4--------------------
select * from sales.Store;

select Name,Demographics.query('
declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
for $x in /StoreSurvey
return 
<result>
{$x/AnnualSales}
</result>
') as AnnualSales,
Demographics.query('
declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
for $x in /StoreSurvey
return 
<result>
{$x/YearOpened}
</result>
') as YearOpened,
Demographics.query('
declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
for $x in /StoreSurvey
return 
<result>
{$x/NumberEmployees}
</result>
') as NumberEmployees
from Sales.store;


select Name,Demographics.query('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; for $x in /StoreSurvey return <result> {$x/AnnualSales} </result>') as AnnualSales, Demographics.query('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; for $x in /StoreSurvey return <result> {$x/YearOpened} </result>') as YearOpened, Demographics.query('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; for $x in /StoreSurvey return <result> {$x/NumberEmployees} </result>') as NumberEmployees from Sales.store;

exec xp_cmdshell 'bcp "select Name,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\"; for $x in /StoreSurvey return <result> {$x/AnnualSales} </result>'') as AnnualSales, Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\"; for $x in /StoreSurvey return <result> {$x/YearOpened} </result>'') as YearOpened, Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\"; for $x in /StoreSurvey return <result> {$x/NumberEmployees} </result>'') as NumberEmployees from AdventureWorks2012.Sales.Store" queryout "C:\Users\Win 10\Desktop\term6\az DB\homeworks\az7_9825413\xml_output.txt" -T -c -q -t;';