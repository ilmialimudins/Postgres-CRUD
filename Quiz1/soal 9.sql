select j.employee_id, d.department_name, count(j.employee_id)
from job_history j
join departments d on d.department_id= j.department_id
group by d.department_id, j.employee_id

