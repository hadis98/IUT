-- In this case, the GROUP BY works like the DISTINCT clause that removes duplicate rows from the result set.
select customer_id
from payment
group by customer_id


-- get total amount that each customer has been paid:
select customer_id,sum(amount)
from payment
group by customer_id
order by sum(amount) desc;

-- group customers by their names.
select first_name ||' ' || last_name full_name,
sum(amount) amount
from payment
inner join customer using(customer_id)
group by full_name
order by amount desc;

-- number of payment transactions that each staff has been processed
select staff_id,count(payment_id)
from payment
group by staff_id


-- each group of (customer_id, staff_id) 
-- the SUM() calculates the total amount.

select customer_id,staff_id,sum(amount)
from payment
group by staff_id,customer_id
 order by customer_id;


-- group payments by dates
 select DATE(payment_date) paid_date,
sum(amount) sum
from payment
group by DATE(payment_date)