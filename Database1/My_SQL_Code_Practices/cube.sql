select item_name,color,size,sum(number)
from sales
group by cube(item_name,color,size);


select item_name,color,size,sum(number),
grouping(item_name) as item_name_flag,
grouping(color) as color_flag,
grouping(size) as size_flag,
from sales
group by cube(item_name,color,size);


CUBE(c1,c2,c3) 

-- GROUPING SETS (
--     (c1,c2,c3), 
--     (c1,c2),
--     (c1,c3),
--     (c2,c3),
--     (c1),
--     (c2),
--     (c3), 
--     ()
--  ) 

select brand,segment,sum(quantity)
from sales
group by 
cube(brand,segment)
order by brand,segment;


select brand,segment,sum(quantity)
from sales
group by 
brand,
cube(segment)
order by brand,segment;