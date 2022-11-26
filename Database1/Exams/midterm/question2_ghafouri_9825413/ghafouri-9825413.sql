
2A
select film_id,title
from film inner join inventory using(film_id)
full outer join rental using(inventory_id)
where return_date is null
order by film_id;

2B
select avg(return_date - rental_date) as avg_rental_time
from rental inner join inventory using(inventory_id)
inner join film_category using(film_id)
group by category_id;



2C

with most_seen(film_id) as
(
 select film_id
 from film inner join inventory using(film_id)
 inner join rental using(inventory_id)
 group by film_id
 order by count(rental_id) desc
 limit 7
)
select actor_id,first_name
from actor a inner join film_actor using(actor_id)
inner join most_seen using(film_id)
order by a.first_name;



2D
create view v(name,num_rental,avg_time,num_actor) as 
select 
title,
(
select count(rental_id)
from film inner join inventory using(film_id)
inner join rental using(inventory_id)
group by film_id
),
(
select avg(return_date - rental_date) as avg_rental_time
from rental inner join inventory using(inventory_id)
group by film_id
),

(
select count(actor_id)
from actor a inner join film_actor using(actor_id)
inner join film using(film_id)
group by film_id
)

from film;


select *
from v 
order by name;

/*select count(rental_id)
from film inner join inventory using(film_id)
inner join rental using(inventory_id)
group by film_id;

select avg(return_date - rental_date) as avg_rental_time
from rental inner join inventory using(inventory_id)
group by film_id;

select count(actor_id)
from actor a inner join film_actor using(actor_id)
inner join film using(film_id)
group by film_id;*/