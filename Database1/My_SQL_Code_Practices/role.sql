create role role1;
grant select on instructor to role1 with grant opetion

create role role13;
grant role12 to role13
grant update,delete,insert on course,student to role13
grant update(dept_name) on student to  role12 
revoke all on student from role12


-- grant to view
create view  view_stu as
select * from (
(student s join takes using(id)) join 
(select course_id,title from course)as course1 using(course_id)
)
where s.dept_name in ('Elec. Eng.','Comp. Sci.')
grant select on view_stu to role12;