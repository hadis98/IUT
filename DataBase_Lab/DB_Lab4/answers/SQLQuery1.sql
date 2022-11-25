USE AdventureWorks2012
GO

----------------soal1------------------
SELECT Sales.SalesOrderHeader.CustomerID, Sales.SalesOrderHeader.OrderDate,Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderDetail.LineTotal,
AVG(Sales.SalesOrderDetail.LineTotal)OVER (PARTITION BY Sales.SalesOrderHeader.CustomerID
ORDER BY Sales.SalesOrderHeader.OrderDate, Sales.SalesOrderHeader.SalesOrderID
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as avg3
FROM Sales.SalesOrderHeader JOIN Sales.SalesOrderDetail ON
(SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID)
order by Sales.SalesOrderHeader.CustomerID

----------------soal2------------------
select
CASE GROUPING(t.Name)
WHEN 0 THEN t.Name
WHEN 1 THEN'All Territories'
END AS TerritoryName,
CASE GROUPING([Group])
WHEN 0 THEN [Group]
WHEN 1 THEN'All Regions'
END AS Region,
sum(SubTotal) as SalesTotal
,count(h.SalesOrderID)as SalesCount
from Sales.SalesTerritory as t inner join Sales.SalesOrderHeader as h
on (t.TerritoryID = h.TerritoryID)
group by rollup([Group],t.Name);


----------------soal3------------------
select
case GROUPING(sub.Name)
when 0 then sub.Name
when 1 then 'All subcategories'
end as subcategory
,cat.Name as category,sum(OrderQty) as num_orders,sum(OrderQty * UnitPrice) sum_orders_values
from Production.Product as p inner join Production.ProductSubcategory as sub
on (p.ProductSubcategoryID = sub.ProductSubcategoryID )
inner join Production.ProductCategory as cat on (sub.ProductCategoryID = cat.ProductCategoryID)
inner join Sales.SalesOrderDetail as d
on (d.ProductID = p.ProductID)
group by grouping sets((sub.Name,cat.Name),(cat.Name))

----------------soal4------------------
select * from (
select 
CONCAT(FirstName,' ',MiddleName,' ',LastName)as full_name,
NationalIDNumber,Gender,
case 
when MaritalStatus ='S' then 'Single'
when MaritalStatus ='M' then 'Married'
end as maritalStatus,JobTitle,(
select count(*)
from HumanResources.Employee as e1
where e1.JobTitle = e2.JobTitle
group by JobTitle
)as employee_per_job
from HumanResources.Employee e2 inner join 
Person.Person p on (e2.BusinessEntityID= p.BusinessEntityID)
)as temp
where temp.employee_per_job>3;

