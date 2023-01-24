 select  d.department_id, d.department_name, count ( e.employee_id) Jumlah_Employee
 from employees e 
 join  departments d on e.department_id = d.department_id 
	group by d.department_id
	order by d.department_id asc
--  select r.region