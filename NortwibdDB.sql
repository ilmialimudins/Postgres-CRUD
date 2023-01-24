-- Database: SalesHRDB

-- DROP DATABASE IF EXISTS "SalesHRDB";

CREATE DATABASE "SalesHRDB"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	create table suppliers
	(
	supr_id serial,
		supr_name varchar(40),
		supr_contact_name varchar(30),
		supr_city varchar(15),
		constraint pk_supr_id primary key(supr_id)
	)
	
	create table customers(
	cust_id serial,
		cust_name varchar(40),
		cust_city varchar (15),
		constraint pk_cust_id primary key (cust_id)
	)
	
	create table shipper(
	ship_id serial,
		shipe_name varchar(40),
		ship_phone varchar(24),
		constraint pk_ship_id primary key (ship_id)
	)
	
	create table orders_detail(
	ordet_order_id int,
	ordet_prod_id int,
	ordet_price money,
	ordet_quantity smallint,
	ordet_discount real,
	constraint pk_ordet_order_id primary key (ordet_order_id),
	constraint fk_prod_id foreign key (ordet_prod_id) references products (prod_id)on delete cascade on update cascade
	)
	
	create table products (
	prod_id serial,
		prod_name varchar(40),
		prod_quantity varchar(20),
		prod_price money,
		prod_in_stock smallint,
		prod_on_order smallint,
		prod_reorder_level smallint,
		prod_discontinued bit,
		prod_cate_id int,
		prod_supr_id int,
		constraint pk_prod_id primary key (prod_id),
		constraint fk_prod_cate_id foreign key (prod_cate_id) references categories (cate_id)on delete cascade on update cascade,
		constraint fk_prod_supr_id foreign key (prod_supr_id) references suppliers (supr_id) on delete cascade on update cascade
	)
	
	create table categories(
	cate_id serial,
	cate_name varchar(15),
	cate_description text,
	constraint pk_cate_id primary key (cate_id));
	
	create table orders(
	order_id serial,
	order_date date,
	order_required_date date,
	order_shipped_date date,
	order_freight money,
	order_sub_total money,
	order_total_qty smallint,
	order_ship_city varchar(15),
	order_ship_address varchar(60),
	order_status varchar(15),
	order_employee_id int,
		order_cust_id int,
		order_ship_id int,
		constraint pk_order_id primary key (order_id),
		constraint fk_order_cust_id foreign key (order_cust_id) references customers(cust_id),
		constraint fk_order_ship_id foreign key (order_ship_id) references shipper(ship_id))