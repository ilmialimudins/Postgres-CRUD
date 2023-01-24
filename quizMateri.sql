1.
select r.region_name, count(department_id)
from regions r inner join countries c on r.region_id = c.region_id
join locations l on c.country_id=l.country_id 
join departments d on l.location_id = d.location_id group by region_name
2.
select c.country_name, count(department_id)
from regions r inner join countries c on r.region_id = c.region_id
join locations l on c.country_id=l.country_id 
join departments d on l.location_id = d.location_id group by country_name
3.
select d.department_name, count(employee_id) 
from departments d 
inner join employees e 
on d.department_id= e.department_id 
group by department_name
4.
select r.region_name, count(employee_id)
from regions r inner join countries c on r.region_id = c.region_id
join locations l on c.country_id=l.country_id 
join departments d on l.location_id = d.location_id 
join employees e on d.department_id= e.department_id 
group by region_name
5.
select c.country_name, count(employee_id)
from regions r inner join countries c on r.region_id = c.region_id
join locations l on c.country_id=l.country_id 
join departments d on l.location_id = d.location_id 
join employees e on d.department_id= e.department_id 
group by country_name
6.
select j.max_salary, d.department_name
from departments d inner join employees e 
on d.department_id=e.department_id 
join jobs j on e.job_id=j.job_id
7.
select j.min_salary, d.department_name
from departments d inner join employees e 
on d.department_id=e.department_id 
join jobs j on e.job_id=j.job_id
8.
select d.department_name, avg(salary)
from departments d inner join employees e 
on d.department_id=e.department_id group by department_name
9.informasi jumlah mutasi pegawai tiap deparment.
select d.department_name, count(employee_id)jml_mutasi 
from departments d 
inner join job_history j
on d.department_id= j.department_id 
group by department_name
10.informasi jumlah mutasi pegawai berdasarkan role-jobs.
select j.job_title, count(employee_id)
from jobs j inner join job_history h on j.job_id=h.job_id
group by job_title
11.Informasi jumlah employee yang sering dimutasi.///
select count(jumlah_mutasi)jumlhmutasi
from (select employee_id, count(employee_id) jumlah_mutasi from job_history
group by employee_id)mutasi 
where jumlah_mutasi = 
	(select max(jumlah_mutasi)
	from
	 (select employee_id, count(employee_id) jumlah_mutasi from job_history
	group by employee_id)mutasi)
12.formasi jumlah employee berdasarkan role jobs-nya.
select j.job_title, count(employee_id)
from jobs j inner join employees e 
on j.job_id=e.job_id
group by job_title
13.Informasi employee paling lama bekerja di tiap deparment.
select concat(e1.first_name, ' ', e1.last_name), e1.department_id, e1.hire_date
from
(select department_id, min(hire_date)pertama
from employees group by (department_id))e2
join employees e1 on e1.department_id = e2.department_id
where e1.hire_date = e2.pertama

14.Informasi employee baru masuk kerja di tiap department.
select concat(e1.first_name, ' ', e1.last_name), e1.department_id, e1.hire_date
from
(select department_id, max(hire_date)pertama
from employees group by (department_id))e2
join employees e1 on e1.department_id = e2.department_id
where e1.hire_date = e2.pertama
15.Informasi lama bekerja tiap employee dalam tahun dan jumlah mutasi history-nya
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