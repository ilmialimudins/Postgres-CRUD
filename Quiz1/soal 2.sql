 select  c.country_id, c.country_name, count ( d.department_id) total
 from departments d 
 join  locations l on l.location_id = d.location_id 
 join countries c on c.country_id = l.country_id 
	group by c.country_id
	order by c.country_id asc