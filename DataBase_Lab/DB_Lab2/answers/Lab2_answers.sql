
--1
select *
from Sales.SalesOrderHeader as o
join Sales.SalesTerritory as t on t.TerritoryID = o.TerritoryID
where Status=5 and
TotalDue>100000 and TotalDue < 500000
and (t.CountryRegionCode ='US' OR t.CountryRegionCode ='FR');

--2
select o.SalesOrderID,o.CustomerID,o.TotalDue,o.OrderDate,t.Name
from Sales.SalesOrderHeader as o
join Sales.SalesTerritory as t on t.TerritoryID = o.TerritoryID

--3
--part1
select t.Name,d.ProductID,sum(d.OrderQty) as sum_orders
from Sales.SalesOrderHeader as h
join Sales.SalesOrderDetail as d on h.SalesOrderID = d.SalesOrderID
join Sales.SalesTerritory as t on t.TerritoryID = h.TerritoryID
group by t.Name,d.ProductID
order by d.ProductID

--final
with sum_orders(ProductID,TerritoryName,SumOrders) as(
select d.ProductID,t.Name,sum(d.OrderQty)
from Sales.SalesOrderHeader as h
join Sales.SalesOrderDetail as d on h.SalesOrderID = d.SalesOrderID
join Sales.SalesTerritory as t on t.TerritoryID = h.TerritoryID
group by t.Name,d.ProductID
),max_orders( ProductId,MaxOrders) as (
select ProductId, max(SumOrders) as MaxOrders
from sum_orders
group by ProductID
)
select s.ProductID,s.TerritoryName,s.SumOrders,m.MaxOrders,p.Name,p.ProductNumber,p.Color,p.ProductLine
from  sum_orders as s join max_orders as m on s.ProductID = m.ProductId
join Production.Product as p on p.ProductID = s.ProductID
where s.SumOrders = m.MaxOrders
order by s.ProductId

--4
create table NAmerica_sales (
SalesOrderID int ,
TerritoryID int,
Status tinyint NOT NULL,
TotalDue money NOT NULL,
CountryRegionCode nvarchar(3),
CustomerID int
);

insert into NAmerica_sales
select o.SalesOrderID,t.TerritoryID,Status,TotalDue,CountryRegionCode,CustomerID
from Sales.SalesOrderHeader as o
join Sales.SalesTerritory as t on t.TerritoryID = o.TerritoryID
where Status=5 and
TotalDue>100000 and TotalDue < 500000
and t.CountryRegionCode ='US';

select * from NAmerica_sales;

alter table NAmerica_sales
add  level char(4)
check (level in ('Low','High','Mid'));

update NAmerica_sales
set level = case 
when TotalDue > (select avg(TotalDue) from NAmerica_sales ) then 'High'
when TotalDue = (select avg(TotalDue) from NAmerica_sales ) then 'Mid'
else 'Low'
end;



--5
with get_salary(id,salary,level) as(
select BusinessEntityID,max(Rate) as salary,
case 
when max(Rate) < 29 then 3
when max(Rate) >=29 and max(Rate) <50 then 2
else 1
end as level
from  HumanResources.EmployeePayHistory
group by BusinessEntityID
)

select id,case 
	when salary < (select max(salary)/4 from get_salary) then  salary + 0.2 * salary
	when salary between (select max(salary)/4 from get_salary) and (select max(salary)/2 from get_salary) then salary +  0.15 * salary
	when salary between (select max(salary)/2 from get_salary) and (select max(salary)*3/4 from get_salary) then  salary + 0.1 * salary
	else  salary + 0.05 * salary
end as new_salary ,level
from get_salary
order by id

