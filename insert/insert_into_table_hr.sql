select c.region_id,c.region_name, b.country_name
from regions c, countries b
where c.region_id=b.region_id
and c.region_id=1
order by c.region_id

select * from employees e left join departments d on e.employee_id = d.manager_id
select * from regions r right join countries c on r.region_id = c.region_id 
join locations l on c.country_id = l.country_id

select manager_id,count(employee_id)
from employees
group by manager_id

select sum(salary) from employees

select min(salary) from employees

select max(salary) from employees

select department_id, sum(salary) as salary from employees group by department_id
having sum(salary) <= 6500

select employee_id, first_name, last_name from employees
where first_name like 'Da%'

select * from departments where 
location_id in (select location_id
			from locations l, countries c where l.country_id = c.country_id)
			
	select concat(e.first_name,' ',e.last_name)fullname, 
	d.department_name from employees e, departments d
	where e.department_id = d.department_id
	
	select e.last_name, d.department_name from employees e, departments d
	where e.department_id = d.department_id
	group by d.department
	
	select concat(e.first_name,' ',e.last_name)fullname, 
	d.department_name from employees e inner join departments d on e.department_id = d.department_id
	where department_name ='IT'