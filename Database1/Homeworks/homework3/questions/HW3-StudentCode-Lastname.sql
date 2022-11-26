---- DATABASE DESIGN 1 @ IUT
---- YOUR NAME:hadis ghafouri
---- YOUR STUDENT NUMBER: 9825413


---- Q1
---A
select dept_name
from instructor
group by dept_name
having sum(salary) > (
	select avg(dept2.sum_salary)
	from (
		select sum(salary) as sum_salary
		from instructor
		group by dept_name
	) as dept2
)

---B
with inst_table(inst_name,lessons_num) as 
(
 select instructor.name,count(*)
 from teaches , instructor
 where teaches.id = instructor.id and year=2003
 group by instructor.id
),
lessons_num_avg (num_avg) as
(
	select avg(lessons_num) 
	from inst_table
)
select inst_table.inst_name,inst_table.lessons_num
from inst_table,lessons_num_avg
where lessons_num>num_avg 


---- Q2
---A
create table uni_data(stu_id varchar(5), stu_name varchar(20) not null,stu_dept_name varchar(20), year numeric(4,0),semester varchar(6),course_name varchar(35), score numeric(3), is_rank numeric(1,0))

---B
insert into uni_data(stu_id, stu_name,stu_dept_name, year,semester,course_name, score, is_rank)
select s.id,name,s.dept_name,t.year,t.semester,c.title,
CASE when grade='A+' then 100
when grade='A' then 95
when grade='A-' then 90
when grade='B+' then 85
when grade='B' then 80
when grade='B-' then 75
when grade='C+' then 70
when grade='C' then 65
when grade='C-' then 60
else 0
end as score,
case when grade='A+' or grade='A' or grade='A-' or grade='B+' or grade='B' or grade='B-'  then 1
else 0
end as is_rank
from student as s,takes as t,course as c 
where s.id = t.id
and t.course_id = c.course_id;

---C
update uni_data
set score = case when score < 75 then 10 + score
else 15 + score
end 
where stu_dept_name = 'Physics'

---D
select *
from uni_data as uni_1
where stu_name like 'T%' 
and score < (
select avg(score)
from uni_data as uni_2
where uni_1.stu_dept_name = uni_2.stu_dept_name  	
)




---- Q4
---A
 select *
 from course as c
 inner join section as s on c.course_id=s.course_id
 union all
select  c.course_id,c.title,c.dept_name,c.credits ,null,null,null,null,null,null,null
from course as c
where c.course_id not in(
	select course_id from section as s
)

---B
 select *
 from course as c
 inner join section as s   on c.course_id=s.course_id
 union all
select  null,null,null,null,s.course_id,s.sec_id,s.semester,s.year,s.building,s.room_number,s.time_slot_id
from section as s
where s.course_id not in(
	select course_id from course as c 
)
---C
 select *
 from course as c
 inner join section as s on c.course_id=s.course_id
 union all
select  c.course_id,c.title,c.dept_name,c.credits ,null,null,null,null,null,null,null
from course as c
where c.course_id not in(
	select course_id from section as s
)

union all

select  null,null,null,null,s.course_id,s.sec_id,s.semester,s.year,s.building,s.room_number,s.time_slot_id
from section as s
where s.course_id not in(
	select course_id from course as c 
)




---- Q5
---A
select  p.name, s.salesorderid
from  sales.SalesOrderDetail as s 
left outer join production.product as p using(productid);



---B
select  p.name
from  sales.SalesOrderDetail as s 
right outer join production.product as p using(productid)
where s.salesorderid is null;


---C
select customerid , p.name
from sales.customer as c
inner join sales.salesorderheader as h using(customerid)
inner join sales.SalesOrderDetail as s using(salesorderid)
inner join production.product as p using(productid);


---D
select  h.salesorderid,h.salesorderid,t.name
from  sales.customer as c
right outer join sales.salesorderheader as h using(customerid),sales.salesterritory as t
where c.territoryid = t.territoryid;

---- Q6
create view workorder as (select sub.productsubcategoryid,sub.name,sum(orderqty)
from(
	select * from production.workorder as worker
	order by enddate desc
 	limit 1000
)as w
inner join production.workorderrouting as routing 
on w.workorderid = routing.workorderid
inner join production.product as p 
on p.productid=w.productid
inner join production.productsubcategory as sub 
on sub.productsubcategoryid = p.productsubcategoryid
where routing.operationsequence < 7
group by sub.productsubcategoryid,sub.name
order by count(w.workorderid) desc)




---- Q7
create view stu_ins as ((select instructor.id,instructor.name,instructor.dept_name
 ,case when instructor.dept_name like '%Eng.' then 'Engineer'
 else 'Scientist'
 end as dept_type
 , 'INS' as person_type
from instructor
)
union 
(
	select student.id,student.name,student.dept_name,
	case when student.dept_name like '%Eng.' then 'Engineer'
 else 'Scientist'
 end as dept_type,
 'STU' as person_type
	from student
))
	
	
---- Q8
select * 
from (
select  stu_ins.name,person_type,
(salary/budget)*100	as calc_number
from instructor natural join department,stu_ins
	where stu_ins.id = instructor.id
) as ins	
where person_type='INS'
union 
select * 
from (
	select  stu_ins.name, person_type,
	(budget/(
		select count(*)
		from student 
		where student.dept_name = dep1.dept_name
	)) as calc_number
	from student natural join department as dep1,stu_ins
	where stu_ins.id = student.id
)as stu
 where person_type='STU'



