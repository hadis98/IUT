  select * from rental
  order by rental_date desc;


CREATE TRIGGER recommendation
after insert ON rental
FOR EACH ROW 
WHEN (pg_trigger_depth() < 1)
EXECUTE PROCEDURE give_suggest();


create or replace function give_suggest()
returns trigger
language plpgsql
as $$
DECLARE
rent_num int;
rand_num int;
count_id int;
new_inventory_id integer;
new_staff_id smallint;
begin 

update customer
set rent_count = rent_count+1
where customer.customer_id = new.customer_id;

select rent_count into rent_num
from customer
where customer.customer_id = new.customer_id
;


if rent_num >=5
then

select count(inventory_id) into count_id
 from inventory inner join film_category using(film_id)
 where (category_id) in (
 select category_id
from rental r
inner join inventory i using(inventory_id)
inner join film_category using(film_id)
where r.customer_id =new.customer_id
order by rental_date desc
 limit 5
 ) and 
 film_id not in (
 select film_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = new.customer_id
 )and (store_id) in (
 select i.store_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = new.customer_id
order by rental_date desc
limit 1
 );

select  floor(random()* (count_id+ 1)) into rand_num;



select staff_id into new_staff_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = new.customer_id
order by rental_date desc
limit 1;



select inventory_id into new_inventory_id
from inventory inner join film_category using(film_id)
where (category_id) in (
select category_id
from rental r
inner join inventory i using(inventory_id)
inner join film_category using(film_id)
where r.customer_id = new.customer_id
order by rental_date desc
 limit 5
 ) and 
 film_id not in (
select film_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = new.customer_id
 )and (store_id) in (
 select i.store_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = new.customer_id
order by rental_date desc
limit 1
 )
limit rand_num offset rand_num+1;


insert into rental(rental_date,inventory_id,customer_id,staff_id)
values(now(),new_inventory_id ,new.customer_id,new_staff_id);

update customer
set rent_count = 0
where customer.customer_id = new.customer_id;

end if;

return new;
end;
$$
 



 select inventory_id,film_id
 from inventory inner join film_category using(film_id)
 where (store_id,category_id) in (
 select i.store_id,category_id
from rental r
inner join inventory i using(inventory_id)
inner join film_category using(film_id)
where r.customer_id = 373
order by rental_date desc
 limit 5
 ) and 
 film_id not in (
 select film_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = 373
 )
 limit floor(random()* (500+ 1))+1 offset floor(random()* (500+ 1))+1 ;
 







-- last store , last staff:
select i.store_id,staff_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = 373
order by rental_date desc
limit 1




 select count(inventory_id)
 from inventory inner join film_category using(film_id)
 where (category_id) in (
 select category_id
from rental r
inner join inventory i using(inventory_id)
inner join film_category using(film_id)
where r.customer_id =373
order by rental_date desc
 limit 5
 ) and 
 film_id not in (
 select film_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = 373
 )and (store_id) in (
 select i.store_id
from rental r
inner join inventory i using(inventory_id)
where r.customer_id = 373
order by rental_date desc
limit 1
 )


select  customer_id,count(rental_id)
from customer inner join rental using(customer_id)
inner join inventory using(inventory_id)
inner join film_category using(film_id)
group by customer_id
order by customer_id


select * from rental r
where r.customer_id = 373
order by rental_date desc
 limit 5;


 	
	 	select sum(customer_rate)/count(rental_id)
 	from rental inner join inventory using(inventory_id)
 	inner join film f2 using(film_id)
	where film_id = 1;


score = select sum(customer_rate)/count(rental_id)
 	from rental inner join inventory using(inventory_id)
 	inner join film f2 using(film_id)
	where film_id = 1;


create or replace function update_satisfaction()
  returns trigger
  language plpgsql
  as $$
  begin 
  if old.customer_rate <> new.customer_rate and
  new.return_date is not null and new.return_date > new.rental_date
 then
 	update film f1
 	set score = (
 	select sum(customer_rate)/count(rental_id)
 from rental inner join inventory using(inventory_id)
 inner join film f2 using(film_id)
 where f1.film_id = f2.film_id
 group by film_id
 );
	
end if;
 return new;
  end;
 $$

select film_id,rental_id,customer_rate
from rental inner join inventory using(inventory_id)
inner join film f2 using(film_id)
where film_id =1;

972 = 60

 update rental
    set customer_rate = 8
    where rental_id = 972;


     select * from film
 where film_id=1;

 create or replace function update_satisfaction()
returns trigger
language plpgsql
as $$
begin 
if new.customer_rate <> old.customer_rate and old.return_date is not null and old.return_date > old.rental_date
then
	update film f1
	set score = (
	select avg(customer_rate) 
	from old inner join inventory using(inventory_id)
	inner join film f2 using(film_id)
	where f1.film_id = f2.film_id
	);	
end if;
return new;
end;
$$


 select sum(customer_rate),count(rental_id)
 from rental inner join inventory using(inventory_id)
 inner join film f2 using(film_id)
 where film_id =2;

 select film_id,rental_id,customer_rate
from rental inner join inventory using(inventory_id)
inner join film f2 using(film_id)
where film_id =2;


 update rental
    set customer_rate = 20
    where rental_id = 7733;



	select extract (month from  rental_date),
	 rating,
	sum(amount)
	  from film
  inner join inventory using(film_id)
  inner join rental r2 using(inventory_id)
  inner join payment using(rental_id)
  where rating is not null
	 group by rating,extract (month from  rental_date)
	
	order by extract (month from  rental_date)


	  WITH cte AS (
	SELECT 
		extract (month from  rental_date) month_d, 
	  	rating,
		SUM(amount)  over
		(partition by rating
 		order by extract (month from  rental_date)
		)amount
  from film
  inner join inventory using(film_id)
  inner join rental r2 using(inventory_id)
  inner join payment using(rental_id)
--   group by extract (month from  rental_date)
  order by extract (month from  rental_date)
) 
SELECT
	month_d, 
	rating,
	amount,
	LAG(amount,1) OVER (
		ORDER BY month_d
	) previous_month_sales,
	lead(amount+1) over(
		order by month_d
	)next_months_sales
FROM
	cte; 