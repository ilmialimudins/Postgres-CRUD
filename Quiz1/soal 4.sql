 select  r.region_id, r.region_name, count ( e.employee_id) Jumlah_Employee
 from employees e 
 join  departments d on e.department_id = d.department_id 
 join locations l on d.location_id= l.location_id
 join countries c on l.country_id = c.country_id
 join regions r on c.region_id = r.region_id
	group by r.region_id
	order by r.region_id asc
--  select r.region	