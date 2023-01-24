CREATE SCHEMA master;
create table master.regions (
	region_code serial,
	region_name varchar(35) unique,
	constraint  region_code_pk primary key (region_code)
);

create table master.country (
	country_id serial,
	country_name varchar(35) unique,
	country_region_id int,
	constraint  country_id_pk primary key (country_id),
	constraint country_region_id_fk foreign key (country_id) references master.regions(region_code)
	on delete cascade on update cascade
);
	
create table master.proviences(
	prov_id serial,
	prov_name varchar(85),
	prov_country_id int,
	constraint  prov_id_pk primary key (prov_id),
	constraint prov_country_id_fk foreign key (prov_country_id) references master.country(country_id)
	on delete cascade on update cascade
);

create table master.address(
	addr_id serial,
	addr_line1 varchar(225),
	addr_line2 varchar(225),
	addr_postal_code varchar(5),
	addr_spatial_location json,
	addr_prov_id int,
	constraint  addr_id_pk primary key (addr_id),
	constraint addr_prov_id_fk foreign key (addr_prov_id) references master.proviences(prov_id)
	on delete cascade on update cascade
);

create table master.category_group(
	cagro_id serial,
	cagro_name varchar(25) unique,
	cagro_description varchar(225),
	cagro_type varchar(25),
	cagro_icon varchar(255),
	cagro_icon_url varchar(255),
	constraint  cagro_id_pk primary key (cagro_id)
);

create table master.policy(
	poli_id serial,
	poli_name varchar(55),
	poli_description varchar(255),
	constraint  poli_id_pk primary key (poli_id)
);

create table master.policy_category_group(
	poca_poli_id serial,
	poca_cagro_id int,
	constraint  poca_poli_dan_cagro_id_pk primary key (poca_poli_id,poca_cagro_id),
	constraint poca_poli_id_fk foreign key (poca_poli_id) references master.policy(poli_id)
	on delete cascade on update cascade,
	constraint poca_cagro_id_fk foreign key (poca_cagro_id) references master.category_group(cargo_id)
	on delete cascade on update cascade
);

create table master.price_items(
	prit_id serial,
	prit_name varchar(55) unique,
	prit_price money,
	prit_description varchar(255),
	prit_type varchar(15),
	prit_modified_date date,
	constraint  prit_id_pk primary key (prit_id)
);

create table master.service_task(
	seta_id serial,
	seta_name varchar(85) unique,
	set_seq smallint,
	constraint  seta_id_pk primary key (seta_id)
);

insert into master.category_group (cargo_name,cargo_type) 
values ('Room','facillity' );
insert into master.category_group (cargo_name,cargo_type) 
values ('Restaurant','facillity' );insert into master.category_group (cargo_name,cargo_type) 
values ('Meeting Room','facillity' );insert into master.category_group (cargo_name,cargo_type) 
values ('Gym','facillity' );insert into master.category_group (cargo_name,cargo_type) 
values ('Aula','facillity' );insert into master.category_group (cargo_name,cargo_type) 
values ('Balroom Pool','facillity' );


create table master.members(
		memb_name varchar(15),
		memb_description varchar(100),
		constraint  memb_name_pk primary key (memb_name)
	);