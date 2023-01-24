create or replace procedure HumanResource.UpdateNewEmployee(
	parb int,
	name_a varchar(50), --Person
	name_b varchar (50), --Person
	name_c varchar (50), --Person
	suffix_a varchar(10), -- Person
	national_a varchar(15), --Employee
    job_a varchar(50), -- Employee
	birth_a date, -- Employee
	marital_a char(1), -- Employee
	gender_a char(1), --Employee
	hire_a date, --Employee
	vacation_a smallInt, -- Employee
	sick_a smallInt, -- Employee
	depid_a Int, -- Department
	shift_a Int, -- shift
	rate_a numeric, --EmployeePayHistory
	frequency_a smallInt -- EmployeePayHistory
)
language plpgsql
as $$
begin

	update pe.p 
	set  	firstname = name_a, 
			middlename = name_b, 
			lastname = name_c, 
			suffix = suffix_a
	where businessentityid = parb;
	
	update hr.e
	set		nationalidnumber = national_a,
            jobtitle = job_a, 
			birthdate = birth_a,
			maritalstatus = marital_a, 
			gender = gender_a, 
			hiredate = hire_a, 
			vacationhours = vacation_a,
			sickleavehours = sick_a
	where businessentityid= parb;
	
	update hr.edh
	set		departmentid=depid_a,
			shiftid=shift_a
	where businessentityid= parb;
	
	update hr.eph
	set		rate = rate_a,
			payfrequency = frequency_a
	where businessentityid = parb;
	
commit;
end;$$

call HumanResource.UpdateNewEmployee (
    1, 
    'Zul', 
    'Aryasa', 
    'Hilmi', 
    'Jr.', 
    '295847281',
    'Chief Executive Officer - Dr.', 
    '1969-01-28', 
    'M', 
    'F', 
    '2009-01-13', 
    '88', 
    '70', 
    15, 
    2, 
    120.1, 
    '1'
)

select * from hr.e e
inner join pe.p p on e.businessentityid=p.businessentityid
inner join hr.edh edh on e.businessentityid=edh.businessentityid
inner join hr.eph eph on e.businessentityid=eph.businessentityid
inner join hr.d d on edh.departmentid=d.departmentid
inner join hr.s s on edh.shiftid=s.shiftid
where e.businessentityid = 346