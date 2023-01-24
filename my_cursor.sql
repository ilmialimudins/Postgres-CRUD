begin;
declare 
my_cursor cursor for select * from employees;

fetch next from my_cursor
fetch prior from my_cursor
fetch last from my_cursor
fetch first from my_cursor
fetch 10 from my_cursor

--untuk menutup
commit

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
		
		--https://www.postgresqltutorial.com/