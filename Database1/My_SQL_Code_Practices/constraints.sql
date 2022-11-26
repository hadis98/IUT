create table trader (
    traider_id serial primary key,
    trader_name varchar(40),
    birth_date date check(birth_date>'1900-01-01'),
    joined_date date check(joined_date>birth_date),
    salary numeric check(salary>1000)
);

insert into trader values(10,'hadis','2001-02-03','2018-01-01',10000);
-- using serial id
insert into trader(trader_name, birth_date,joined_date,salary) values('hadi','2001-02-03','2018-01-01',10000); 

alter table section 
add check (time_slot_id) in
(select time_slot_id from time_slot where start_hr>=9)


create function avoid_before_9(time_slot_id1 varchar(4))
returns boolean
as $$
select(
case when (9<= all(
	select time_slot.start_hr from time_slot
	where time_slot.time_slot_id = time_slot_id1
)) then true
	else false
	end
)
$$ language sql;

alter table section 
add check(
case when sec_id in ('1','2','3') then true
else avoid_before_9(time_slot_id)
end
)


INSERT INTO public.section(
course_id, sec_id, semester, year, building, room_number,time_slot_id)
VALUES ('313', '44', 'Fall', 2010, 'Chandler', 804, 'A');