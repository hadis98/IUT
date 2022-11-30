with tab as
(SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY 
                branchid,invoicnum
            ORDER BY 
                 year asc,
				 month asc,
				 day asc
        ) row_num
     FROM 
        sales_db2
 where  branchid is not null and
 productid  is not null and
 invoicnum is not null and
 unitsolid is not null and
 day is not null and
 month is not null and
 year is not null

)

select min(branchid) as branchid,min(productid) as productid,min(invoicnum) as invoicnum,sum(unitsolid) as unitsolid,min(day) as day,min(month)as month,min(year)as year
into sales_detailes2
from tab
where row_num = 1
group by branchid,invoicnum,productid

