create extension dblink ``

create foreign data wrapper isibebas;

create server localhost foreign data wrapper isibebas options (hostaddr '127.0.0.1', dbname 'NorthwindDB');

create user mapping for postgres server localhost options(user 'postgres', password 'admin')

select dblink_connect('localhost');

alter table shipper rename shipe_name to ship_name

insert into shipper(ship_id, ship_name,ship_phone)
select*from dblink
('localhost', 'select shipper_id, company_name, phone from shippers')
as data (ship_id integer, ship_name varchar(40), ship_phone varchar(24))

select*from shipper