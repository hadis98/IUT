drop table if exists employees;

create table employees(
employee_id int generated always as identity,
first_name varchar(50) not null,
last_name varchar(50) not null,
salary decimal(11,2) not null default 0,
primary key(employee_id)
);

create or replace function check_salary()
returns trigger
language plpgsql
as $$
begin
if (new.salary - old.salary)/ old.salary >=1
then  
	raise 'The salary increment cannot that high.';
end if;

return new;
end;
$$

create trigger before_update_salary
before update
on employees
for each row
execute procedure check_salary();


insert into employees(first_name,last_name,salary)
values('hadi','hoseini',100000);


update employees 
set salary = 200000
where employee_id =1;

alter trigger before_update_salary
on employees
rename to salary_before_update;