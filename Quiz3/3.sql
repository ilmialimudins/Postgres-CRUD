select  cr.countryregioncode as "countryRegionCode", cr.name as "CountryName", 
(case 
 when persontype='SP' then 'Sales Person'
 when persontype='IN' then 'Individual 	Customer'
 when persontype='EM' then 'Employee' 
end) as "PersonTypeDesc"  , count(pp.persontype)as "TotalPerson"
from person.countryregion cr
join person.stateprovince sp on sp.countryregioncode =cr.countryregioncode		
join person.address ad on ad.stateprovinceid=sp.stateprovinceid
join person.businessentityaddress bea on bea.addressid=ad.addressid
join person.person pp on pp.businessentityid = bea.businessentityid
group by  cr.countryregioncode, pp.persontype
order by cr.countryregioncode asc


select *from person.person
order by person.persontype asc