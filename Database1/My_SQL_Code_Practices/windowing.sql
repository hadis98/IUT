-- Given relation sales(date, value)
-- Given sales values for each date, calculate for
-- each date the average of the sales on that day, the previous day, and the
-- next day
select date,
sum(value) over (order by date between rows 1 preceding and 1 following)
from sales;



-- Find total balance of each account after each transaction on the
-- account
select account_number,date_time,
sum(value) over 
(
    partition by account_number
    order by date_time
    rows unbounded preceding
)as balance
from transaction
order by account_number,date_time


create table product_groups (
group_id serial primary key,
group_name varchar (255) not null
);


create table products(
product_id serial primary key,
product_name varchar (255) not null,
price decimal(11,2),
group_id int not null,
foreign key (group_id) references product_groups(group_id)
);

INSERT INTO product_groups (group_name)
VALUES
	('Smartphone'),
	('Laptop'),
	('Tablet');


INSERT INTO product_groups (group_name)
VALUES
	('Smartphone'),
	('Laptop'),
	('Tablet');

INSERT INTO products (product_name, group_id,price)
VALUES
	('Microsoft Lumia', 1, 200),
	('HTC One', 1, 400),
	('Nexus', 1, 500),
	('iPhone', 1, 900),
	('HP Elite', 2, 1200),
	('Lenovo Thinkpad', 2, 700),
	('Sony VAIO', 2, 700),
	('Dell Vostro', 2, 800),
	('iPad', 3, 700),
	('Kindle Fire', 3, 150),
	('Samsung Galaxy Tab', 3, 200);

-- average price for every product group.
select group_name, avg(price)
from products
inner join product_groups using (group_id)
group by 
group_name;


-- the following query returns the product name, the price, product group name
-- along with the average prices of each product group.
select product_name,price,group_name,
avg(price) over(
partition by group_name
)
from products
inner join product_groups using (group_id)


-- ROW_NUMBER()
-- ROW_NUMBER() function assigns a sequential number to each row in each partition
select product_name,group_name,price,
row_number() over(
partition by group_name
order by price
)
from products
inner join product_groups using (group_id)


-- RANK() 
-- RANK() function assigns ranking within an ordered partition

select product_name,group_name,price,
rank() over(
partition by group_name
order by price
)
from products
inner join product_groups using (group_id)

-- DENSE_RANK()
-- the ranks have no gap
select product_name,group_name,price,
dense_rank() over(
partition by group_name
order by price
)
from products
inner join product_groups using (group_id)
