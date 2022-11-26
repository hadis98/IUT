-- The LAG() function has the ability to access data from the previous row
-- comparing the values of the current and the previous row.
select product_name,group_name,
price,
lag(price,1)over (
partition by group_name 
order by price
)as prev_price,
price - lag(price,1) over(
partition by group_name
order by price
)as cur_prev_diff
from products
inner join product_groups using(group_id);

-- sales amount of the current year and the previous year:
select year,amount,
lag(amount,1) over (
order by year
)previous_year_sales
from (
select year,sum(amount) amount
from sales
group by year
order by year
)as table2

-- ======

WITH cte AS (
	SELECT 
		year, 
		SUM(amount) amount
	FROM sales
	GROUP BY year
	ORDER BY year
) 
SELECT
	year, 
	amount,
	LAG(amount,1) OVER (
		ORDER BY year
	) previous_year_sales
FROM
	cte;



-- eturn the sales variance between the current and previous years
select year,amount,
lag(amount,1) over (
order by year
)previous_year_sales,
lag(amount,1) over (
order by year
)-amount as variance
from (
select year,sum(amount) amount
from sales
group by year
order by year
)as table2


-- partition by

select year,amount,group_id,
lag(amount,1) over(
partition by group_id
order by year 
)previous_year_sales
from sales;