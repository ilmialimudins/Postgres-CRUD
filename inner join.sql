-- select * from regions;

-- select * from regions r left join countries c on r.region_id = c.region_id;
-- select * from regions r right join countries c on r.region_id = c.region_id;
-- select * from regions r inner join countries c on r.region_id = c.region_id;
-- select * from regions r full outer join countries c on r.region_id = c.region_id;
-- select * from locations l left join departments d on l.location_id = d.location_id;
-- select * from locations l right join departments d on l.location_id = d.location_id;



-- select *from regon r join countries c


-- select manager_id, count(employee_id)from employees group by manager_id

-- select department_id, sum(salary)as salary from employees group by department_id
-- having sum(salary)<=6500

-- select employee_id, first_name, last_name from employees
-- where first_name like 'Mu%'

-- select * from departments where location_id in (select location_id from locations l, countries c where l.country_id= c.country_id)

-- select concat(first_name,' ',last_name) from employees

-- select * from countries;
-- select sum(salary) from employees;

