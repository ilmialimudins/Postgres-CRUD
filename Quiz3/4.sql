select  cr.countryregioncode as "countryRegionCode", cr.name as "CountryName", 
sum (case when (persontype='IN')  then 1 else 0 end )as "Individual Customer",
sum ( case when (persontype='SP') then 1 else 0 end) as "Sales Person",
sum( case when (persontype='SC')then 1 else 0 end) as "Sales COntact",
sum(case when (persontype='VC') then 1 else 0 end) as "Vendor Contact",
sum(case when (persontype='General Contact')then 1 else 0 end) as "General Contact"
from person.countryregion cr
join person.stateprovince sp on sp.countryregioncode =cr.countryregioncode		
join person.address ad on ad.stateprovinceid=sp.stateprovinceid
join person.businessentityaddress bea on bea.addressid=ad.addressid
join person.person pp on pp.businessentityid = bea.businessentityid
group by  cr.countryregioncode,cr.name 
order by cr.name