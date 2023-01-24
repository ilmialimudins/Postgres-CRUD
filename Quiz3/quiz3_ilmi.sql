-- Module Person
-- 1. 
select persontype,
	   case
	   		when (persontype = 'IN') then 'Individual Customer'
			when (persontype = 'EM') then 'Employee'
			when (persontype = 'SP') then 'Sales Person'
			when (persontype = 'SC') then 'Sales Contact'
			when (persontype = 'VC') then 'Vendor Contact'
			when (persontype = 'GC') then 'General Contact'
		end as persontype,
		count(persontype) as total_person
from person.person
group by persontype


-- 2. 
select person.person.businessentityid,
	   lastname as fullname,
	   emailaddress,
	   phonenumber,
	   concat (person.address.addressline1, ', ',
			   person.address.city, ', ',
			   person.stateprovince.name, ', ',
			   person.countryregion.name) as address,
	   person.addresstype.name
from person.person
	-- addresstype = home
	join person.businessentity on person.person.businessentityid = person.businessentity.businessentityid
	join person.businessentityaddress on person.person.businessentityid = person.businessentityaddress.businessentityid
	join person.addresstype on person.businessentityaddress.addresstypeid = person.addresstype.addresstypeid
	-- end join
	-- address = US
	join person.address on person.businessentityaddress.addressid = person.address.addressid
	join person.stateprovince on person.address.stateprovinceid = person.stateprovince.stateprovinceid
	join person.countryregion on person.stateprovince.countryregioncode = person.countryregion.countryregioncode
	-- end join
	-- 	join email
	join person.emailaddress on person.person.businessentityid = person.emailaddress.businessentityid
	-- 	join phonenumber
	join person.personphone on person.person.businessentityid = person.personphone.businessentityid
where person.countryregion.countryregioncode = 'US'


-- 3.
select person.countryregion.countryregioncode,
	   person.countryregion.name as countryname,
	   case
	   		when (persontype = 'IN') then 'Individual Customer'
			when (persontype = 'EM') then 'Employee'
			when (persontype = 'SP') then 'Sales Person'
			when (persontype = 'SC') then 'Sales Contact'
			when (persontype = 'VC') then 'Vendor Contact'
			when (persontype = 'GC') then 'General Contact'
		end as persontypedesc,
	   count(person.person.businessentityid) as total_person
from person.countryregion
	join person.stateprovince on person.countryregion.countryregioncode = person.stateprovince.countryregioncode
	join person.address on person.stateprovince.stateprovinceid = person.address.stateprovinceid
	join person.businessentityaddress on person.address.addressid = person.businessentityaddress.addressid
	join person.businessentity on person.businessentityaddress.businessentityid = person.businessentity.businessentityid
	join person.person on person.businessentity.businessentityid = person.person.businessentityid
group by person.countryregion.countryregioncode, persontypedesc
order by countryname asc


-- 4.
select person.countryregion.countryregioncode,
	   person.countryregion.name as countryname,
	   sum(case
		  	when (persontype = 'IN') then 1 else 0
		  end) as "Individual Customer",
	   sum(case
		  	when (persontype = 'EM') then 1 else 0
		  end) as "Employee",
	   sum(case
		  	when (persontype = 'SP') then 1 else 0
		  end) as "Sales Person",
	   sum(case
		  	when (persontype = 'SC') then 1 else 0
		  end) as "Sales Contact",
	   sum(case
		  	when (persontype = 'VC') then 1 else 0
		  end) as "Vendor Contact",
	   sum(case
		  	when (persontype = 'GC') then 1 else 0
		  end) as "General Contact"
from person.countryregion
	join person.stateprovince on person.countryregion.countryregioncode = person.stateprovince.countryregioncode
	join person.address on person.stateprovince.stateprovinceid = person.address.stateprovinceid
	join person.businessentityaddress on person.address.addressid = person.businessentityaddress.addressid
	join person.businessentity on person.businessentityaddress.businessentityid = person.businessentity.businessentityid
	join person.person on person.businessentity.businessentityid = person.person.businessentityid
group by person.countryregion.countryregioncode, countryname
order by countryname


-- Module HumanResources
-- 5.
select humanresources.department.departmentid,
	   name,
	   count(humanresources.employee.businessentityid) as total_employee
from humanresources.department
	join humanresources.employeedepartmenthistory on humanresources.department.departmentid = humanresources.employeedepartmenthistory.departmentid
	join humanresources.employee on humanresources.employeedepartmenthistory.businessentityid = humanresources.employee.businessentityid
group by humanresources.department.departmentid
order by humanresources.department.departmentid asc


-- 6.
select humanresources.department.name,
	   sum(case
		  	when (humanresources.shift.name = 'Day') then 1 else 0
		  end) as "Day",
	   sum(case
		  	when (humanresources.shift.name = 'Evening') then 1 else 0
		  end) as "Evening",
	   sum(case
		  	when (humanresources.shift.name = 'Night') then 1 else 0
		  end) as "Night"
from humanresources.department
	join humanresources.employeedepartmenthistory on humanresources.department.departmentid = humanresources.employeedepartmenthistory.departmentid
	join humanresources.shift on humanresources.employeedepartmenthistory.shiftid = humanresources.shift.shiftid
group by humanresources.department.name
order by humanresources.department.name asc


-- Module Purchasing
-- 7.
select accountnumber,
	   name as vendorname,
	   sum(case
		  	when(purchaseorderheader.status = '1') then 1 else 0
		  end) as "Pending",
	   sum(case
		  	when(purchaseorderheader.status = '2') then 1 else 0
		  end) as "Approved",
	   sum(case
		  	when(purchaseorderheader.status = '3') then 1 else 0
		  end) as "Rejected",
	   sum(case
		  	when(purchaseorderheader.status = '4') then 1 else 0
		  end) as "Completed"
from purchasing.vendor
	join purchasing.purchaseorderheader on purchasing.vendor.businessentityid = purchasing.purchaseorderheader.vendorid
group by accountnumber, vendorname
order by "Completed" desc
	   

-- Module Sales
-- 8.
select sales.customer.customerid,
	   concat(person.person.firstname, ' ', person.person.lastname) as customername,
	   sum(case
		  	when (sales.salesorderheader.status = '1') then 1 else 0
		  end) as "InProcess",
	   sum(case
		  	when (sales.salesorderheader.status = '2') then 1 else 0
		  end) as "Approved",
	   sum(case
		  	when (sales.salesorderheader.status = '3') then 1 else 0
		  end) as "BackOrdered",
	   sum(case
		  	when (sales.salesorderheader.status = '4') then 1 else 0
		  end) as "Rejected",
	   sum(case
		  	when (sales.salesorderheader.status = '5') then 1 else 0
		  end) as "Shipped",
	   sum(case
		  	when (sales.salesorderheader.status = '6') then 1 else 0
		  end) as "Cancelled"
from sales.customer
	join person.person on sales.customer.customerid = person.person.businessentityid
	join sales.salesorderheader on sales.customer.customerid = sales.salesorderheader.customerid
group by sales.customer.customerid, customername
order by sales.customer.customerid asc


-- 9.
select sales.customer.customerid,
	   concat(person.person.firstname, ' ', person.person.lastname) as customername,
	   sum(case
		  	when (production.productcategory.name = 'Accessories') then 1 else 0
		  end) as "Accessories",
	   sum(case
		  	when (production.productcategory.name = 'Bikes') then 1 else 0
		  end) as "Bikes",
	   sum(case
		  	when (production.productcategory.name = 'Components') then 1 else 0
		  end) as "Components",
	   sum(case
		  	when (production.productcategory.name = 'Clothing') then 1 else 0
		  end) as "Clothing"
from sales.customer
-- 	join customer
	join person.person on sales.customer.customerid = person.person.businessentityid
	join sales.salesorderheader on sales.customer.customerid = sales.salesorderheader.customerid
-- 	end join
--  join product category
	join sales.salesorderdetail on sales.salesorderheader.salesorderid = sales.salesorderdetail.salesorderid
	join production.product on sales.salesorderdetail.productid = production.product.productid
	join production.productsubcategory on production.product.productsubcategoryid = production.productsubcategory.productsubcategoryid
	join production.productcategory on production.productsubcategory.productcategoryid = production.productcategory.productcategoryid
--  end join
group by sales.customer.customerid, customername
order by customername asc

productid(product), name(product), name(production.productcategory(1,2,3,4))


-- 10.
select production.product.productid,
	   production.product.name,
	   sales.specialoffer.discountpct,
	   extract(year from sales.specialoffer.startdate) as "Year Discount",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '1') then 1 else 0
		  end) as "January",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '2') then 1 else 0
		  end) as "February",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '3') then 1 else 0
		  end) as "March",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '4') then 1 else 0
		  end) as "April",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '5') then 1 else 0
		  end) as "May",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '6') then 1 else 0
		  end) as "June",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '7') then 1 else 0
		  end) as "July",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '8') then 1 else 0
		  end) as "August",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '9') then 1 else 0
		  end) as "September",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '10') then 1 else 0
		  end) as "October",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '11') then 1 else 0
		  end) as "November",
	   sum(case
		  	when (extract(month from sales.specialoffer.startdate) = '12') then 1 else 0
		  end) as "December"
from production.product 
	join sales.specialofferproduct on production.product.productid = sales.specialofferproduct.productid
	join sales.specialoffer on sales.specialofferproduct.specialofferid = sales.specialoffer.specialofferid
where sales.specialoffer.description <> 'No Discount'
group by production.product.productid, sales.specialoffer.discountpct, "Year Discount"
order by "Year Discount" desc
	   
	   

productid(product), productname(production.product(name)), 

select * from person.person

select * from production.product

select * from sales.specialoffer