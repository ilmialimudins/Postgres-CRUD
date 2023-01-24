select v.accountnumber as "AccountNumber",
v.name as "VendorName",
sum(case when (status='1')then 1 else 0 end) as "Pending",
sum (case when (status='2') then 1 else 0 end)as Approved,
sum (case when (status='3')then 1 else 0 end)as "Reject",
	 sum (case when (status='4')then 1 else 0 end)as "Completed"
from purchasing.vendor v
join purchasing.purchaseorderheader poh on poh.vendorid=v.businessentityid
group by v.accountnumber, v.name
order by "Completed" desc
