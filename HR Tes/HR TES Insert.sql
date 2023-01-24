create or replace procedure HumanResources.CreateNewEmployee(
	parb int,
	name_a varchar(50), --Person
	name_b varchar (50), --Person
	name_c varchar (50), --Person
	suffix_a varchar(10), -- Person
	person_a varchar(2), --PersonI
	namesty_a boolean, --PersonI
	emailp_a int, --PersonI
	national_a varchar(15), --Employee
	job_a varchar(50), --Employee
    login_a varchar(250), --EmployeeI
    birth_a date, -- Employee
	marital_a char(1), -- Employee
	gender_a char(1), --Employee
	hire_a date, --Employee
    salflag_a boolean, --EmployeeI
	vacation_a smallInt, -- Employee
	sick_a smallInt, -- Employee
    currflag_a boolean, --EmployeeI
	depid_a Int, -- Department
	start_a date, -- Department
	shift_a Int, -- shift
	rcd_a timestamp, --EmployeePayHistory
	rate_a numeric, --EmployeePayHistory
	frequency_a smallInt -- EmployeePayHistory
)
language plpgsql
as $$
begin

	insert into pe.p (businessentityid, firstname, middlename, lastname, suffix, persontype, namestyle, emailpromotion)
	values (parb, name_a, name_b, name_c, suffix_a, person_a, namesty_a, emailp_a);
	
	insert into hr.e (businessentityid, nationalidnumber, loginid, jobtitle, birthdate, maritalstatus, gender, hiredate, salariedflag, vacationhours, sickleavehours, currentflag)
	values (parb, national_a, login_a, job_a, birth_a, marital_a, gender_a, hire_a, salflag_a, vacation_a, sick_a, currflag_a);
	
	insert into hr.edh (businessentityid, departmentid, shiftid, startdate)
	values (parb, depid_a, shift_a, start_a);
	
	insert into hr.eph(businessentityid, ratechangedate, rate, payfrequency)
	values (parb, rcd_a, rate_a, frequency_a);
	
commit;
end;$$

call HumanResources.CreateNewEmployee (
    348, 
    'Zul', 
    'Aryasa', 
    'Hilmi', 
    'Jr.',
	'EM',
	false,
	1,
    '295847281',
    'Chief Executive Officer - Dr.',
	'adventure-works\zul0',
    '1969-01-28', 
    'M', 
    'F', 
    '2009-01-13', 
	false,
    '88', 
    '70', 
	false,
    15,
	'2009-01-13',
    2, 
	'2009-01-11 00:00:00',
    120.1, 
    '1'
)

select * from hr.e e
inner join pe.p p on e.businessentityid=p.businessentityid
inner join hr.edh edh on e.businessentityid=edh.businessentityid
inner join hr.eph eph on e.businessentityid=eph.businessentityid
inner join hr.d d on edh.departmentid=d.departmentid
inner join hr.s s on edh.shiftid=s.shiftid
where e.businessentityid = 348