---- DATABASE DESIGN 1 @ IUT
---- YOUR NAME:hadis ghafouri
---- YOUR STUDENT NUMBER: 9825413


---- Q7
---A
alter table student
add column GPA float(4)
---B
	 
		 
update student as s1
 set  GPA =
 (
select sum(
	(
		case 
		WHEN T.grade = 'A+' or 
		T.grade = 'A ' or
		T.grade = 'A-'
		THEN 4
		WHEN T.grade = 'B+' or
	    T.grade = 'B ' or
		 T.grade = 'B-' 
		THEN 3
		WHEN T.grade = 'C+' THEN 2
		WHEN T.grade = 'C ' THEN 1
		WHEN T.grade = 'C-' THEN 0
		ELSE 0
		END
	) *c.credits) / sum(c.credits)
from takes T
inner join student s using(id)
inner join course c using(course_id)
where s1.id = s.id
group by s.id
)

