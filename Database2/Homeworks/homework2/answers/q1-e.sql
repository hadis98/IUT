create or alter procedure fill_customer
as
begin
	truncate table temp_new_jobs;
	if (exists (select * from dimention_customer))
	begin

		insert into temp_new_jobs 
		select customer_id,customer_name,branch_id,customer_type,customer_type_explanation,national_code,src.job,phone
		from customer join customer_type 
		on (src.customer.customer_type=src.customer_type.customer_type)
		join dimention_customer 
		on(src.customer_id=dimention_customer.customer_id
		and dimention_customer.curr_flag=1)
		where src.job <> dimention_customer.job;
		
		update dimention_customer
		set curr_flag=0 , end_date=GETDATE()
		from dimention_customer join temp_new_jobs 
		on (dimention_customer.customer_id = temp_new_jobs.customer_id
		and dimention_customer.curr_flag=1)

		insert into  dimention_customer(customer_id,customer_name,branch_id,customer_type,customer_type_explanation,national_code,src.job,phone,start_date,curr_flag)
		select customer_id,customer_name,branch_id,customer_type,customer_type_explanation,national_code,src.job,phone,GETDATE(),1
		from temp_new_jobs

	end
	else
	begin
		insert into  dimention_customer(customer_id,customer_name,branch_id,customer_type,customer_type_explanation,national_code,src.job,phone,start_date,curr_flag)
		select customer_id,customer_name,branch_id,customer_type,customer_type_explanation,national_code,src.job,phone,'14000101',1
		from src.customer join src.customer_type on
		src.customer.customer_type=src.customer_type.customer_type
	end

end 
