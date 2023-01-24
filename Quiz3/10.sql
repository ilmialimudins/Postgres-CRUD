select pr.productid, pr.name, so.discountpct,
	extract(year from startdate)as "Year Discount",
	sum(case when(extract(month from so.startdate)='01')then 1 else 0 end)as "January",
	sum(case when(extract(month from so.startdate)='02')then 1 else 0 end)as "February",
	sum(case when(extract(month from so.startdate)='03')then 1 else 0 end)as "March",
	sum(case when(extract(month from so.startdate)='04')then 1 else 0 end)as "Apr",
	sum(case when(extract(month from so.startdate)='05')then 1 else 0 end)as "May",
	sum(case when(extract(month from so.startdate)='06')then 1 else 0 end)as "Juny",
	sum(case when(extract(month from so.startdate)='07')then 1 else 0 end)as "July",
	sum(case when(extract(month from so.startdate)='08')then 1 else 0 end)as "August",
	sum(case when(extract(month from so.startdate)='09')then 1 else 0 end)as "September",
	sum(case when(extract(month from so.startdate)='10')then 1 else 0 end)as "October",
	sum(case when(extract(month from so.startdate)='11')then 1 else 0 end)as "November",
	sum(case when(extract(month from so.startdate)='12')then 1 else 0 end)as "December"
from production.product pr
join sales.specialofferproduct sop on pr.productid=sop.productid
join sales.specialoffer so on sop.specialofferid= so.specialofferid
group by pr.productid, so.discountpct,"Year Discount"
order by  "Year Discount" desc


