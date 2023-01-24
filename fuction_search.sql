create or replace function humanresources.get_employee( f_name varchar)
returns text as $$ 

declare employee text default '';
rec_emp record;
cur_emps cursor (f_name varchar)
for select 
	e.nationalidnumber , 
		pe.firstname as firstname,
		pe.lastname as LastName,
		ed.emailaddress as Email,
		pp.phonenumber as PhoneCall,
		e.jobtitle as JobTitle,
		e.birthdate as BirthDate,
		e.hiredate as HireDate,
		d.name as Department
from humanresources.employee e
left Join person.person pe 
on pe.businessentityid =e.businessentityid
left Join person.emailaddress ed
on ed.businessentityid=pe.businessentityid
left join person.personphone pp
on pp.businessentityid = pe.businessentityid
left join humanresources.employeedepartmenthistory edh
on edh.businessentityid =pe.businessentityid
left join humanresources.department d
on d.departmentid = edh.departmentid
-- where nationalidnumber=Nid ;
where firstname = f_name or lastname =f_name or d.name= f_name;

begin 
open cur_emps(f_name);
loop fetch cur_emps into rec_emp;

exit when not found;
	employee:=employee ||'hasil: '|| rec_emp.nationalidnumber||' '||
					rec_emp.firstName  ||' '||
					rec_emp.lastName ||' '||
					rec_emp.email ||' '||
					rec_emp.phoneCall ||' '||
					rec_emp.jobTitle ||' '||
					rec_emp.birthDate ||' '||
					rec_emp.hireDate ||' '||
					rec_emp.department;
-- return next;
end loop;
-- fetch 1 from 
close cur_emps;
return employee;
end;$$
language plpgsql;



select humanresources.get_employee('Engineering')

commit;
fetch next from cur_emps
fetch prior from my_cursor