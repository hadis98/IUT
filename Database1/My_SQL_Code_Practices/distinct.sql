-- SELECT
--    DISTINCT column1
-- FROM
--    table_name;

create table distinct_demo(
id serial not null primary key,
bcolor varchar,
fcolor varchar
);

insert into distinct_demo (bcolor,fcolor)
values
('red', 'red'),
	('red', 'red'),
	('red', NULL),
	(NULL, 'red'),
	('red', 'green'),
	('red', 'blue'),
	('green', 'red'),
	('green', 'blue'),
	('green', 'green'),
	('blue', 'red'),
	('blue', 'green'),
	('blue', 'blue');

select id,bcolor,fcolor
from distinct_demo;

select distinct bcolor
from distinct_demo
order by bcolor;


--  unique combination of bcolor and fcolor
select distinct bcolor,fcolor
from distinct_demo
order by bcolor,fcolor;


-- sorts the result set by the  bcolor and  fcolor
-- and then for each group of duplicates, it keeps the first row in the returned result set.
select distinct on (bcolor) bcolor,fcolor
from distinct_demo
order by bcolor,fcolor;