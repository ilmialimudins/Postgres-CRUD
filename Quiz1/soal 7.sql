select d.department_id, d.department_name,min(salary)
from employees e
join departments d on e.department_id = d.department_id
group by d.department_id
