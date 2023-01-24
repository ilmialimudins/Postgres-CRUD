select d.name as "Name",
 sum(case when (s.shiftid='1')then 1 else 0 end)
	 as "Day",
sum(case when(s.shiftid='2')then 1 else 0 end)
 as "Evening",
 sum(case when (s.shiftid='3')then 1 else 0 end)
 as "Night"
 from humanresources.department d
 join humanresources.employeedepartmenthistory edh on edh.departmentid=d.departmentid
 join humanresources.shift s on s.shiftid=edh.shiftid
 group by d.name
 order by d.name