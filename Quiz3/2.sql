select pe.businessentityid as"BusinessEntityId", pe.lastname as "FullName", 
		ei.EmailAddress as "EmailAddress", pp.PhoneNumber as "PhoneNumber",
		concat (ad.addressline1 ,addressline2,',',
		ad.city,',',sp.name,',',cr.name )as "Address",
			adt.name as AdreesType
from person.person pe
left join person.emailaddress ei on ei.businessentityid = pe.businessentityid
left join person.personphone pp on pp.businessentityid = pe.businessentityid
left join person.businessentityaddress be on be.businessentityid = pe.businessentityid
left join person.address ad on ad.addressid=be.addressid	
left join person.addresstype adt on adt.addresstypeid = be.addresstypeid
left join person.stateprovince sp on sp.stateprovinceid = ad.stateprovinceid
left join person.countryregion cr on cr.countryregioncode=sp.countryregioncode


