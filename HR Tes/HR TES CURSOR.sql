CREATE OR REPLACE FUNCTION humanresources.searchEmployee (nama text)
RETURNS TABLE (
	nationalidnumber 	varchar,
	firstname			varchar,
	lastname			varchar,
	emailaddress		text,
	phonenumber			varchar,
	jobtitle			varchar,
	birthdate			date,
	hiredate			date,
	name				varchar
		
)
AS $$

DECLARE
	cur_id	int;
	offset int;
	limit int;
	my_cursor CURSOR FOR
		 select 
--
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
WHERE pe.firstname ilike concat(nama, '%');
		
BEGIN
	OPEN my_cursor;
	LOOP
		FETCH NEXT FROM my_cursor INTO 
	nationalidnumber 	,
	firstname			,
	lastname			,
	emailaddress		,
	phonenumber			,
	jobtitle			,
	birthdate			,
	hiredate			,
	name				;
		EXIT WHEN NOT FOUND;
		RETURN NEXT;
	END LOOP;
	CLOSE my_cursor;
END; $$
LANGUAGE plpgsql;
select * from humanresources.searchEmployee('KEN')

-- Pagination
CREATE OR REPLACE FUNCTION humanresources.pageEmployee (offsets int, limits int)
RETURNS TABLE (
	nationalidnumber 	varchar,
	firstname			varchar,
	lastname			varchar,
	emailaddress		text,
	phonenumber			varchar,
	jobtitle			varchar,
	birthdate			date,
	hiredate			date,
	name				varchar
)
AS $$

DECLARE
	cur_id	int;
	offset int;
	limit int;
	my_cursor CURSOR FOR
		SELECT
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
WHERE pe.businessentityid >= offsets AND pe.businessentityid <= limits;

BEGIN
	OPEN my_cursor;
	LOOP
		FETCH  FROM my_cursor INTO 
-- 		FETCH PRIOR FROM my_cursor INTO 
-- 		FETCH NEXT FROM my_cursor INTO 
		
			nationalidnumber 	,
	firstname			,
	lastname			,
	emailaddress		,
	phonenumber			,
	jobtitle			,
	birthdate			,
	hiredate			,
	name				;
	
		EXIT WHEN NOT FOUND;
		RETURN NEXT;
	END LOOP;
	CLOSE my_cursor;
END; $$
LANGUAGE plpgsql;
select * from humanresources.pageEmployee(1,12)