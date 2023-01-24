create or replace function get_profile(p_year integer)
returns text as $$

declare 
	profile text default '';
	rec_emp record;
	cur_emps cursor (p_year integer)
		for select concat(first_name, ' ', last_name) as full_name, salary, hire_date
		from employees 
		where extract (year from age(now(), hire_date)) = p_year;
		
begin  
	open cur_emps(p_year);
	loop
		fetch cur_emps into rec_emp;
		exit when not found;
		profile:=profile || ',' || rec_emp.fullname || ',' || rec_emp.salary;
		end loop;
		
		close cur_emps;
		return profile;
		
		end; $$
		language plpgsql
		
		select get_profile(15)
		
create or replace procedure bonus(
			sander int,
			amount dec
)
language plpgsql
as $$
begin 	
	update employees
		set salary = salary + amount
		where employee_id = sander;
		commit;
	end;$$	
	call bonus (166,7000)
	
	select*from employees where employee_id =166