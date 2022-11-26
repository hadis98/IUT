---- DATABASE DESIGN 1 @ IUT
---- YOUR NAME:hadis ghafouri
---- YOUR STUDENT NUMBER: 9825413


---- Q1
---A
alter table rental
add column customer_rate integer
check (customer_rate > 0 and customer_rate<100)
default 50

alter table film
add column Score float(2);


---B
create trigger avg_satisfaction
after update
on rental
for each row
execute procedure update_satisfaction();




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




---C
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
    
    
select * from film
 where film_id=2;


---- Q2
---A


---B



---- Q3

alter table customer
add column  Rent_Count integer default 0;

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
 
 insert into rental(rental_date,inventory_id,customer_id,staff_id)
 values(now(),3 ,6,1);
 
 select * from rental
  where customer_id=6
 order by rental_date desc;

select * from customer
  where customer_id=6;

 
---- Q4
WITH group_box AS (
	SELECT 
		title,
		rating,
		SUM(amount) sum_amount
from film f2 inner join inventory using(film_id)
inner join rental using(inventory_id)
inner join payment using(rental_id)
group by film_id
) 
SELECT
	title, 
	rating,
	sum_amount,
	rank() OVER (
		ORDER BY sum_amount desc
	) rank_in_all
	,
	rank() OVER (
		partition by rating
		ORDER BY sum_amount desc
	) rank_in_rating,
	(
	 case 
 	when ntile(4) over (order by sum_amount desc) = '1' then 'yes'
 	else 'no'
 	end
 )as is_in_first_quarter
	
FROM
	group_box
	order by title





---- Q5
---A
 with group_box as (
	 	select extract (month from  rental_date) month_d,
	 rating,
	sum(amount) sum_amount
	  from film
  inner join inventory using(film_id)
  inner join rental r2 using(inventory_id)
  inner join payment using(rental_id)
  where rating is not null
 group by rating,extract (month from  rental_date)
order by extract (month from  rental_date)
 )

 SELECT
 	distinct month_d, 
 	rating,
 	sum_amount,
 	LAG(sum_amount,1) OVER (
 		partition by rating
 		ORDER BY month_d
 	) previous_month_sales,
 	lead(sum_amount+1) over(
 		partition by rating
	order by month_d
	)next_months_sales
FROM
	group_box
	order by month_d;
	



---- Q6
-----A:
select film.film_id,city_id , s.store_id,f.staff_id,count(rental_id) 
from film,rental r,staff f,store s,address a,inventory i
where f.store_id = s.store_id and
a.address_id = s.address_id and
 r.staff_id = f.staff_id and
i.film_id = film.film_id and
i.inventory_id= r.inventory_id
group by 
film.film_id,
cube(city_id , s.store_id,f.staff_id)
order by 
count(rental_id) desc

-----B


select film.film_id,city_id , s.store_id,f.staff_id,count(rental_id) 
from film,rental r,staff f,store s,address a,inventory i
where f.store_id = s.store_id and
a.address_id = s.address_id and
 r.staff_id = f.staff_id and
i.film_id = film.film_id and
i.inventory_id= r.inventory_id
group by 
film.film_id,
grouping sets(
(city_id , s.store_id,f.staff_id),
(city_id , s.store_id),
(city_id ,f.staff_id),
( s.store_id,f.staff_id),
(city_id ),
(s.store_id),
(f.staff_id),
()
)
 order by 
count(rental_id) desc;





