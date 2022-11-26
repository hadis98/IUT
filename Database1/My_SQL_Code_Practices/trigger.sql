create table employees(
id int generated always as identity,
first_name varchar(40) not null,
last_name varchar(40) not null,
primary key(id)
);

create table employee_audits(
id int generated always as identity,
employee_id int not null,
last_name varchar(40) not null,
changed_on timestamp(6) not null
);

create or replace function log_last_name_changes()
returns trigger
language plpgsql
as $$
begin 
if new.last_name <> old.last_name
then
	insert into employee_audits(employee_id,last_name,changed_on)
	values(old.id,old.last_name,now());
end if;
return new;
end;
$$

create trigger last_name_changes
before update
on employees
for each row
execute procedure log_last_name_changes();

insert into employees(first_name,last_name)
values('hadis','ghafouri');

insert into employees(first_name,last_name) 
values('hadi','hoseini');

update employees
set last_name = 'askari'
where id=2;


select * from employee_audits;