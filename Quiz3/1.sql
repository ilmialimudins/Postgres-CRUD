-- 1. Menampilkan data dari kolom person dan hitung jumlah quantity nya
-- a. tanpilan kolom1
select pp.persontype as "PersonType",
-- 	b. tampilan kolom 2 pakai case(kasus), when(ketika), end(akhiri), as(alias)
case 
		WHEN persontype= 'IN' THEN 'Individual Customer'
		WHEN persontype= 'EM' THEN 'Employee'
		WHEN persontype='SP' THEN 'Sales Person'
		WHEN persontype= 'SC' THEN 'Sales Contact'
		WHEN persontype ='VC' THEN 'Vendor Contcat'
		WHEN persontype='GC' THEN 'General Contact'
	end as nama,
-- 	c.menjumlah total kolom
	count(pp.persontype) as "TotalPerson"
-- ambil database dari tabel(person) dan kolom(person), as(alias p)
from person.person pp
-- join person.emailaddress e on e.businessentityid=p.businessentityid
group by pp.persontype
-- order by persontype asc




