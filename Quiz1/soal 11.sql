select e.employee_id, concat(e.first_name,' ', e.last_name), max(tmp.Jumlah_Mutasi)
from (select e.employee_id employe_id ,e.first_name,j.employee_id , count(j.employee_id) Jumlah_Mutasi
from job_history 
join employees e on e.employee_id= j.employee_id
group by  e.employee_id) tmp
join employees e on e.employee_id = tmp.employe_id
group by e.employee_id
having max (tmp.Jumlah_Mutasi) > count (tmp.Jumlah_Mutasi)
order by e.employee_id


