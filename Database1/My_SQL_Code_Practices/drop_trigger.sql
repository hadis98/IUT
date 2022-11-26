create function check_staff_user()
returns trigger
as $$
begin 
if length(new.username) < 8 or new.username is null
then
raise exception 'The username cannot be less than 8 characters';
end if;
if new.name is null then
	raise exception 'Username cannot be NULL';
end if;
return new;
end;$$
language plpgsql;



create trigger username_check
before insert on update 
on staff
for each row 
execute procedure check_staff_user();


drop trigger username_check
on staff;