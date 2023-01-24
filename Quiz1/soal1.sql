select r.region_id, r.region_name, count(d.department_id)
from departments d
join locations l on l.location_id = d.location_id
join countries c on c.country_id = l.country_id
join regions r on r.region_id = c.region_id
group by r.region_id
order by r.region_id asc