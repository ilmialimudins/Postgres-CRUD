select cu.customerid,
concat(pe.firstname,' ',pe.lastname) as "CustomerName",
sum(case when (soh.status='1')then 1 else 0 end)as "InProcess",
sum(case when (soh.status='2')then 1 else 0 end)as "Approved",
sum(case when (soh.status='3')then 1 else 0 end)as "BackOrdered",
sum(case when (soh.status='4')then 1 else 0 end)as "Rejected",
sum(case when (soh.status='5')then 1 else 0 end)as "Shipped",
sum(case when (soh.status='6')then 1 else 0 end)as "Cancelled"
from sales.customer cu
join person.person pe on cu.personid= pe.businessentityid
join sales.salesorderheader soh on cu.customerid=soh.customerid
group by cu.customerid, "CustomerName"
order by cu.customerid

select * from sales.salesorderheader
group by  businessentityid
order by  businessentityid desc

select *from sales.salesorderheader