

select SalesOrderID,ProductID,UnitPrice,
avg(UnitPrice) OVER (PARTITION by SalesOrderID ORDER BY ProductID) as AverageUnitPrice,
sum(UnitPrice) OVER (PARTITION by SalesOrderID ORDER BY ProductID) as TotalUnitPrice
from Sales.SalesOrderDetail
order by SalesOrderID


select SalesOrderID, AVG(UnitPrice)
from Sales.SalesOrderDetail
group by SalesOrderID
order by SalesOrderID

---------------------------------------------------------------------


select SalesOrderID, ProductID, UnitPrice,
sum(UnitPrice) OVER (PARTITION by SalesOrderID ORDER BY ProductID
ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) as Prev3
From Sales.SalesOrderDetail
order by SalesOrderID, ProductID;

----------------------------------------------------------------------
select SalesOrderID,ProductID, UnitPrice,
sum(UnitPrice) OVER (PARTITION by SalesOrderID ORDER BY ProductID
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as Prev_aggr_sum
From Sales.SalesOrderDetail
order by SalesOrderID, ProductID;


------------------------------------------------------------------

USE AdventureWorks2012
GO
SELECT NULL AS Color, Class,sum(ProductID),avg(ListPrice)FROM Production.Product
GROUP BY Class

UNION

SELECT Color,NULL,sum(ProductID),avg(ListPrice)FROM Production.Product
GROUP BY COLOR





USE AdventureWorks2012
GO

SELECT Color, Class , sum(ProductID) as SUM ,avg(ListPrice) as AVERAGE 
FROM Production.Product
GROUP BY GROUPING SETS(
	Color, Class
)
ORDER BY Color

SELECT Class , sum(ProductID) as SUM ,avg(ListPrice) as AVERAGE 
FROM Production.Product
GROUP BY Class

SELECT Color , sum(ProductID) as SUM ,avg(ListPrice) as AVERAGE 
FROM Production.Product
GROUP BY Color


SELECT Color, Class , sum(ProductID) as SUM ,avg(ListPrice) as AVERAGE 
FROM Production.Product
GROUP BY Color, Class
ORDER BY Color


SELECT Color, Class , sum(ProductID) as SUM ,avg(ListPrice) as AVERAGE 
FROM Production.Product
GROUP BY GROUPING SETS(
	(Color), 
	(Class)
)
ORDER BY Color


SELECT Color, Class , sum(ProductID) as SUM ,avg(ListPrice) as AVERAGE 
FROM Production.Product
GROUP BY GROUPING SETS(
	(),
	(Color), 
	(Class),
	(Color , Class)

)
ORDER BY Color



SELECT Color, Class , sum(ProductID) as SUM ,avg(ListPrice) as AVERAGE 
FROM Production.Product
GROUP BY CUBE(Color , Class)