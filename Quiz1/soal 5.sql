 select  c.country_id, c.country_name, count ( e.employee_id) Jumlah_Employee
 from employees e 
 join  departments d on e.department_id = d.department_id 
 join locations l on d.location_id= l.location_id
 join countries c on l.country_id = c.country_id
	group by c.country_id
	order by c.country_name asc
--  select r.region	