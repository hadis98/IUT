create table sales(
brand varchar not null,
segment varchar not null,
quantity int not null,
primary key (brand,segment)
);
insert into sales(brand,segment,quantity)
values
('ABC','Premium',100),
('ABC','Basic',200),
('XYZ','Premium',100),
('XYZ','Basic',300);

select brand , segment ,sum(quantity)
from sales
group by brand,segment;

select brand ,sum(quantity)
from sales
group by brand;

select segment ,sum(quantity)
from sales
group by segment;


select sum(quantity)
from sales;


SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand,
    segment

UNION ALL

SELECT
    brand,
    NULL,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand

UNION ALL

SELECT
    NULL,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment

UNION ALL

SELECT
    NULL,
    NULL,
    SUM (quantity)
FROM
    sales;
-- =====

select brand,segment,sum(quantity)
from sales
group by 
grouping sets(
(brand,segment),
(brand),
(segment),
()
);


select 
grouping(brand) grouping_brand,
grouping (segment) grouping_segment,
brand,segment,sum(quantity)
from sales
group by 
grouping sets(
(brand),
(segment),
()
)
order by brand,segment

-- having
select 
grouping(brand) grouping_brand,
grouping (segment) grouping_segment,
brand,segment,sum(quantity)
from sales
group by 
grouping sets(
(brand),
(segment),
()
)
having grouping(brand) =0
order by brand,segment
