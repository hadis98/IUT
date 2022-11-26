-- the LEAD() function can access data from the next row.
select product_name,group_name,
price,
lead(price,1)over (
partition by group_name 
order by price
)as next_price,
price - lead(price,1) over(
partition by group_name
order by price
)as cur_next_diff
from products
inner join product_groups using(group_id);



create table sales(
year smallint check (year>0),
group_id int not null,
amount decimal(10,2) not null,
primary key(year,group_id)
);


insert into sales (year,group_id,amount)
values 
(2018,1,1474),
(2018,2,1787),
(2018,3,1760),
(2019,1,1915),
(2019,2,1911),
(2019,3,1118),
(2020,1,1646),
(2020,2,1975),
(2020,3,1516);


-- This example uses the LEAD() function 
-- to return the sales amount of the current year and the next year

with  cte as(
select year,sum(amount) amount 
	from sales
	group by year
	order by year
)
select year,amount,
lead(amount,1) over(
order by year
)next_year_sales
from cte;

-- The following example uses two common table expressions
-- to return the sales variance between the current year and the next:

with cte as (
select year,sum(amount) amount
from sales
group by year
order by year
),cte2 as(
select year,amount,lead(amount,1)over(
order by year
)next_year_sales
	from cte
)
select year,amount,
next_year_sales,
(next_year_sales - amount) variance
from cte2;

-- partition by
--  compare the sales of the current year with sales of the next year for each product group
select year,amount,group_id,
lead(amount,1) over(
partition by group_id
order by year
)next_year_sales
from sales;