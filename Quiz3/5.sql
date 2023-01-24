select d.departmentid as "DepartmentID",
		d.name as "Name",
		count(e.businessentityid) as "TotalEmployee"
from humanresources.department d
join humanresources.employeedepartmenthistory edh on edh.departmentid=d.departmentid
join humanresources.employee e on e.businessentityid=edh.businessentityid
group by d.departmentid
order by d.departmentid asc
