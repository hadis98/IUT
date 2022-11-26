---- DATABASE DESIGN 1 @ IUT
---- YOUR NAME: hadis ghafouri
---- YOUR STUDENT NUMBER: 9825413


---- Q4-A
select title,length from film,category,film_category
where film.title like 'C%' and film.film_id = film_category.film_id and
(film_category.category_id,category.name)=(category.category_id,'Action')
order by length desc


---- Q4-B

select title,name
from film,language
where film.language_id = language.language_id and
film.rental_rate > (select avg(rental_rate) from film)
order by rental_rate desc
limit 5

---- Q4-C



---- Q4-D
select
	address,sum(payment.amount) as least_size
from 
	address , payment , store , staff
where address.address_id= store.address_id and
payment.staff_id = staff.staff_id  and
 staff.store_id  = store.store_id
group by address.address_id
order by least_size
limit 1



---- Q4-E
select rating,title,count(distinct rating) as distinct_rating
from film
group by rating,title;


---- Q4-F
select category.name,
(select film.title from film_category, film
where film_category.film_id  = film.film_id
and film_category.category_id=category.category_id
order by film.length desc
limit 1) as length_film_order
,
(select film.title from film_category , film
where film.film_id = film_category.film_id
and category.category_id = film_category.category_id
order by film.rental_rate desc
 limit 1 ) as rate_film_order
from category



---- Q5-A

select id,name 
from student 
where name like 'M%' and name like '%a';


---- Q5-B

select title
from course,section
where   dept_name like '%Eng.' and
course.course_id =section.course_id and
year=2009 and semester='Fall';


---- Q5-C

select name,title
from takes,student,course
where takes.id=student.id and course.course_id=takes.course_id
group by student.id , takes.course_id,course.title
having count(takes.course_id)>2;


---- Q5-D
select course1.course_id,sum(course2.credits) as sum
from course as course1,prereq,course as course2
where course1.course_id=prereq.course_id
and prereq.prereq_id=course2.course_id
group by course1.course_id
having sum(course2.credits)>4
order by sum desc



---- Q5-E

select distinct room_number
from section,time_slot
where section.time_slot_id=time_slot.time_slot_id 
and section.semester='Spring' and section.year=2008 
group by room_number
having sum(end_hr - start_hr) >= 2


---- Q5-F

	
	
---- Q5-G

select distinct course_id
from section,time_slot
where section.year=2007 and section.building='Taylor'
and start_hr between 8 and 12


---- Q5-H

select name , sum(credits) as new_calculation
from  course,takes,student
where (takes.grade like 'A%' OR takes.grade like 'B%') and 
student.id  = takes.id and
takes.course_id = course.course_id
group by student.name


