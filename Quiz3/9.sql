select cu.customerid,
concat(pe.firstname,' ',pe.lastname) as "CustomerName"
,
sum(case when (pc.name='Accessories')then 1 else 0 end)as "Accessories",
sum(case when (pc.name='Bikes')then 1 else 0 end)as "Bikes",
sum(case when (pc.name='Component')then 1 else 0 end)as "Component",
sum(case when (pc.name='Clothing')then 1 else 0 end)as "Clothing"
from sales.customer cu
-- join customer
join person.person pe on cu.customerid= pe.businessentityid
join sales.salesorderheader soh on cu.customerid=soh.customerid
join sales.salesorderdetail sod on soh.salesorderid=sod.salesorderid

-- end join
-- join product category
join production.product pr on sod.productid = pr.productid
join production.productsubcategory psc on pr.productsubcategoryid = psc.productsubcategoryid
join production.productcategory pc on psc.productcategoryid=pc.productcategoryid
group by cu.customerid, "CustomerName"
order by "CustomerName" asc



select * from sales.customer
order by  businessentityid desc

select *from sales.salesorderheader