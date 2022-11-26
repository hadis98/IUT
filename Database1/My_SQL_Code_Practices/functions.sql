create [or replace] function function_name(param_list)
   returns return_type 
   language plpgsql
  as
$$
declare 
-- variable declaration
begin
 -- logic
end;
$$

create function dept_count(dept_name varchar(20))
returns integer 
begin
declare d_count integer;
select count(*) into d_count
from instructor
where instructor.dept_name = dept_count.dept_name
return d_count;
end
-- usage:
select dept_name,budget
from department
where dept_count(dept_name) >12



-- table function
create function instructor_of(dept_name char(20))
returns table(
    id varchar(5),
    name varchar(20),
    dept_name varchar(20),
    salary numeric(8,2)
)
return table(
    select id,name,dept_name,salary
    from instructor 
    where instructor.dept_name = instructor_of.dept_name
)
-- usage:
select * 
from table(instructor_of('Music'));

create or replace function showCustomers(region varchar(20))
returns table(first_name varchar(20), last_name varchar(20), title varchar(100))
language plpgsql
as
$$
begin
return query
select c1.first_name,c1.last_name,f1.title
from customer c1 inner join rental using(customer_id)
inner join inventory using(inventory_id)
inner join film f1 using(film_id)
inner join address using(address_id)
where rental_date = (
select max(rental_date)
from customer c2 inner join rental using(customer_id)
where c1.customer_id = c2.customer_id
group by customer_id
)
 and address.district = showCustomers.region;   
end;
$$



-- name ofcustomers from 'Texas' with their last rental movie
select first_name,last_name,title
from customer c join address using(address_id)
join rental using(customer_id)
join inventory using(inventory_id)
join film using(film_id)

where district = 'Texas' and title 
in(
select title 
	from film join inventory using(film_id)
	join rental r using(inventory_id)
	where r.customer_id = c.customer_id
	order by rental_date desc
	limit 1
)

-- function of it:


create or replace function showCustomers(
district_name varchar(20)
)
returns table(
first_name varchar(20),last_name varchar(20),title varchar(255)
)
language plpgsql as $$
begin
return query 
select c.first_name,c.last_name,f1.title
from customer c join address using(address_id)
join rental using(customer_id)
join inventory using(inventory_id)
join film f1 using(film_id)

where district = district_name and f1.title 
in(
select f2.title 
	from film f2 join inventory using(film_id)
	join rental r using(inventory_id)
	where r.customer_id = c.customer_id
	order by rental_date desc
	limit 1
);

end; $$

select * from showCustomers('Texas')