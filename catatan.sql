-- pilih kolom 
select ... (kolom) from ( Tabel)

-- ambil database dari Shcema->views
from ... ( Database)    

-- Gabungkan kolom dari schema->views on(pada) kolom a= kolom b yang kode_id/nama nya sama
join ...(Database inisial) inisial.kolom1 on inisial.kolom2 = inisial.kolom1

-- Dikelopmpokan 
Group by kolom1

-- Sortir/ di pilih berdasarkan...
Order by kolom1

-- Membuat substrint dengan menggunakan select dalam select

-- Membuat table (isi, primary key, dan foreign key)
create table ( isi spasi tipe data1, isi spasi tipe data2, 
                constraint nama(pk) primary key (kolom_id)
                
);

-- Menambahkan kolom pada tabel
alter table (nama_tabel) add column (kolom_baru tipedata)

-- Merubah nama kolom 
alter table (nama_tabel1) rename column ( kolom1 to kolom 2)

-- Menambah Primary key
alter table (nama_tabel1) add constraint ( nama_primary_key) primary key (kolom_id)

-- Menghapus Primary key
alter table (nama_tabel1) drop constraint (nama_primary_key)

-- menghapus tabel
drop table (nama_tabel)

-- menghapus tabel constraint pada tabel
drop table (nama_table) cascade

-- Mengubah isi dari tabel
update (nama_tabel) set ='nama_isi/field' where kolom_id=1

-- menghapus isi dari tabel
delete from (nama_table) where (kolom_id)=1

-- menggabungkan 2 table
concat (kolom1, kolom 2) as (nama_kolom_baru)

-- nilai tertinggi
max(nama_kolom)

-- nilai terendah
min(nama_kolom)

-- rata-rata
avg(nama_kolom)

-- menjumlahkan
sum(nama_kolom)

-- kondisi dengan argumen
having sum (nama_kolom) ('argumen'atau <=) (nilai)

-- menggabungkan nama yang sama
distinct(nama_kolom)

-- mengecek umur
age((now), tanggal_lahir) as (umur)

-- Menambahkan isi pada tabel
insert into (nama tabel) (kolom1,kolom2) values (isi_kolom1, isi_kolom2)

-- Mengambil tahun pada date
extract(year from (kolom_date))

-- Substring / Menggabung kan banyak select 
select kolom1, isi_kolom2
from ( select kolom 1, kolom2,
from (nama_tabel)
) as (a1 atau inisial )
join (nama_tabel) as (a atau insial)
group by (nama_tabel)
order by (nama_tabel)

-- memindahkan tabel dari database 1 ke database 2
-- 1. buat koneksi antar database
create extension dblink
-- 2. buat wrapper untuk koneksi antar foreign key
create foreign data wrapper (nama_wraper_bebas)
-- 3.buat koneksi server lokal
create  server localhost foreign data wrapper (nama_wraper_bebas) options (hostaddr,'127.0.0.1', dbname '(nama_database)');
-- 4.buat user mapping
create user mapping for postgres server localhost option(user, 'postgres', password 'admin')
-- 5.pilih koneksi ke database
select dblink_connect ('localhost')
-- 6. Manipulasi data contohnya Insert/update/delete
insert into (nama_tabel)(kolom1,kolom2,kolom3)
select * from dblink ('localhost', 'select(kolom1, kolom2, kolom3')
as data (kolom 1 type data, kolom 2 type data, kolom3  type data)
select *from (nama_tabel1)


-- Membuat cursor
begin;
-- deklarasikan 
declare (nama_cursor) cursor for select * from (nama_tabel)
-- menampilkan tabel 1 ke 2 atau selanjutnya
fetch next from (nama_cursor)
-- menampilkan tabel 2 ke 1 atau ke sebelumnya
fetch prior from(nama_cursor)
-- menampilkan isi tabel terakhir 
fetch last from(nama_cursor)
-- menampilkan 10 data 
fetch 10 from (nama_cursor)
-- akhiri
commit;

-- 
-- Membuat function
-- 1.buat nama function 
        create or replace function nama_tabel_function(nama_data type data)
return as text $$
-- 2.declarasikan fucntion
declare Var_1 text default "",
-- membuat data record
nama_recod record;
nama_cursor cursor (nama_data type data)
for select concat(first_name,'', last_name) as fullname(isi2), salary(isi3)
from nama_tabel
where extract( year from age(now(), data_date)) <= nama_data
-- mulai perulangan atau looping
begin
open nama_cursor(nama_data);
-- memasukan ke dalam record
loop fetch nama_cursor into nama_record 
exit when not found
Var_1:=Var1 || 'isi_data' || nama_recod.fullname(isi1), salary(isi3)
-- akhiri looping
end loop
-- tutup nama cursor
end nama_cursor;
-- kembali ke profile
return Var1;

-- tutup function
end;$$
-- gunakan bahasa
plpgsql language;

-- memilih funtion
select nama_tabel_funtion(nilai)


-- 
-- Membuat atau memperbarui Prosedure 
-- 1. Membuat prosedure
create or replace procedure nama_prosedur(set1, set2 )
language plpgsql
as $$
-- 2.memulai function
begin
update nama_tabel
set tabel2=(tabel2 + set2)
where kolom_id=set1,
commit;
-- 3.Print Output
call(166,2000)
-- 4. pilih
select *from nama_tabel






