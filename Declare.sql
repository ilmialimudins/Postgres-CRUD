-- Contoh Kasus 
-- Menampilkan data employee berdasarkan masa kerja, nama, dan gaji menggunakan cursor
create or replace function get_profile(p_year integer)
returns text as $$
declare 
profile text default'';
rec_emp record;
cur_emps cursor (p_year integer)
for select concat (first_name,' ', last_name) as fullname, salary
from employees
where extract(year from age(now(), hire_date))<= p_year;
begin
open cur_emps(p_year);
loop
fetch cur_emps into rec_emp;
exit when not found;
profile:=profile || ','|| rec_emp.fullname || ':'|| rec_emp.salary;
end loop;
close cur_emps;
return profile;
end;$$
language plpgsql
-- run

-- menampilkan data cursor
select get_profile(15)
-- run

-- Membuat Cursor
begin;
declare
my_cursor cursor for select*from employee;
fetch next from my_cursor
fetch prior from my_cursor
fetch last from my_cursor
fetch 10 from my_cursor
-- run

-- End Cursor
commit
-- run

-- Contoh kasus Bonus
create or replace procedure bonus(sender int, amount dec)
language plpgsql
as $$
begin
update employees
set salary = salary + amount
where employee_id =sender;
end;$$
-- run

-- panggil function bonus
call bonus (166,2000)
-- run

select* from employees
