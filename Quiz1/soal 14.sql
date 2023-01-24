select d.department_id, d.department_name, max(hire_date) from employees e
join departments d on d.department_id = e.department_id
group by d.department_id
order by d.department_name asc







