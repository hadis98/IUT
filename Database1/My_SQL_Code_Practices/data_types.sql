-- concat(first_name,' ',last_name) as full_name

select first_name || ' ' || last_name as full_name,title
from rental r join inventory using(inventory_id)
join film using(film_id)
join customer using (customer_id)
join payment p using(rental_id)
where p.payment_date - r.rental_date >=interval  '1 year 3months 15days'