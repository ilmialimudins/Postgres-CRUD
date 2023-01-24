select j.job_id ,count(e.employee_id) Jumlah_employee
from employees e
join jobs j on j.job_id = e.job_id
group by  j.job_id
order by  j.job_id asc 
-- select count  (employee_id) from employees

--  select *from employees
--  select *from job_history
--  select *from jobs
 
 
 
