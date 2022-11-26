
-- ROLLUP(c1,c2,c3) hierarchy c1 > c2 > c3

-- (c1, c2, c3)
-- (c1, c2)
-- (c1)
-- ()

-- (brand,segment)
-- (brand)
-- ()

-- brand > segment
select brand,segment,sum(quantity)
from sales
group by 
rollup(brand,segment)
order by brand,segment


--  segment > brand 
select segment, brand,sum(quantity)
from sales
group by 
rollup(segment,brand)
order by segment,brand

-- dvdrental

select 
extract (year from rental_date) y,
extract (month from rental_date) m,
extract (day from rental_date) d,
count(rental_id)
from rental
group by 
rollup(
extract (year from rental_date),
extract (month from rental_date),
extract (day from rental_date) 
)