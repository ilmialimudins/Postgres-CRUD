select j.job_id ,count(j.employee_id) Jumlah_Mutasi
from job_history j
join employees e on e.employee_id= j.employee_id
group by  j.job_id
order by  j.job_id asc

