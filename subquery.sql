select (e.employee_id),
(select extract (year from current_date)- extract(year from e.hire_date))lama_kerja,
(case
 	when jumlah_mutasi is null then 0
 	else jumlah_mutasi
 end
)
from employees e left join 
(
select employee_id, count(employee_id)jumlah_mutasi from job_history
group by (employee_id)
)mutasi on e.employee_id = mutasi.employee_id


(select employee_id, count(employee_id) jumlah_mutasi from job_history
group by employee_id)

11.
select count(jumlah_mutasi)
from (select employee_id, count(employee_id) jumlah_mutasi from job_history
group by employee_id)mutasi 
where jumlah_mutasi = (select max(jumlah_mutasi)
from
(select employee_id, count(employee_id) jumlah_mutasi from job_history
group by employee_id)mutasi)

-- max jumlah mutasi
select max(jumlah_mutasi)
from
(select employee_id, count(employee_id) jumlah_mutasi from job_history
group by employee_id)mutasi