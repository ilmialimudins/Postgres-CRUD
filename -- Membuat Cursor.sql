-- Membuat Cursor
begin ;
declare
my_cursor cursor for select*from employees;

fetch next from my_cursor
fetch prior from my_cursor
fetch last from my_cursor

fetch 10 from my_cursor

-- end the cursor
commit


-- CONTOH KASUS
-- menampilkan data employees berdasarkan masa kerja ,nama dan salary menggunakan cursor
-- 1. Membuat function get_profile
create or replace function get_profile(p_year integer)
returns text as $$

-- 2.declarasikan function
declare 
	profile text default'';
	rec_emp record;
	cur_emps cursor (p_year integer )
		for select concat(first_name,'',last_name) as fullname,salary
		from employees
		where extract(year from age(now(),hire_date)) <= p_year;

begin
	open cur_emps(p_year);
	loop
		fetch cur_emps into rec_emp;
		exit when not found;

		profile:=profile || ',' || rec_emp.fullname ||':'||rec_emp.salary;
	end loop;

	close cur_emps;
	return profile;

end;$$
language plpgsql

    -- berdasarkan masa kerja, jika 15 = 15 tahun
	select get_profile(15)


-- create prosedure dengan contoh kasus update bonus dari anggota
-- 1. Membuat prosedure
create or replace procedure bonus(
	sender int,
	amount dec
	)
language plpgsql 
as $$
-- 2. memulai function
begin
	update employees
		set salary = salary + amount
		where employee_id = sender;
		commit;
end;$$
-- 3. Print Output
call bonus (166,2000)
-- 4. Check data employee_id 166 telah terupdate pada kolom paling bawah
select * from employees



-- quiz 2
-- 1
	select name_type.name
	from pe.p person_type
	join pe.bec busines on busines.businessentityid = person_type.businessentityid
	join pe.ct name_type on busines.contacttypeid = name_type.contacttypeid
	group by name_type.name

	-- ver II
	select c.name,a.persontype,count(a.id)
	from pe.p a
	join pe.bec b on b.businessentityid = a.businessentityid
	join pe.ct c on b.contacttypeid = c.contacttypeid
	group by c.name,a.persontype

	-- ver III
	select persontype,count(persontype) as total_person
	from pe.p
	group by persontype

-- 2
    select  b.businessentityid,b.lastname as Fullname,e.emailaddress,o.phonenumber,concat(addressline1,addressline2,' - ',city)
from pe.p b 
join pe.e e on b.businessentityid = e.businessentityid
join pe.pp o on e.businessentityid = o.businessentityid
where 

select concat(addressline1,addressline2,' - ',city)
from pe.a 
where addressline1 = like"1234 Seaside Way"
-- ver II
select persontype,
	case 
		WHEN persontype= 'IN' THEN 'Individual Customer'
		WHEN persontype= 'EM' THEN 'Employee'
		WHEN persontype='SP' THEN 'Sales Person'
		WHEN persontype= 'SC' THEN 'Sales Contact'
		WHEN persontype ='VC' THEN 'Vendor Contcat'
		WHEN persontype='GC' THEN 'General Contact'
	end as nama,
	count(persontype) as total_person
from pe.p
group by persontype