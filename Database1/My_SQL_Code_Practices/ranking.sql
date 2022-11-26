select id,rank() over (order by gpa desc ) as s_rank,gpa
from student
order by s_rank


-- without gap
select id,dense_rank() over (order by gpa desc ) as s_rank,gpa
from student
order by s_rank

select id,(
	1+(select count(*) from student A
		where A.gpa >B.gpa
	  ))as s_rank
	  from student B
	  order by s_rank;