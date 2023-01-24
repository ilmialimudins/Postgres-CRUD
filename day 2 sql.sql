create table supplier(
	supplier_id int,
	company_name varchar(40),
	contact_name varchar(30),
	contact_title varchar(30),
	address varchar(60),
	city varchar(15),
	region varchar(15),
	postal_code varchar(10),
	country varchar(15),
	phone varchar(24),
	fax varchar(24),
	homepage text,
	constraint supplier_id_pk primary key (supplier_id)
);


create table products(
	product_id smallint,
	product_name varchar(40),
	quantity_per_unit varchar(20),
	unit_price real,
	units_in_stock smallint,
	unit_in_order smallint,
	reorder_level smallint,
	discontinued int,
	supplier_id smallint,
	category_id smallint,
	constraint product_id_pk primary key (product_id),
	constraint supplier_id_fk foreign key (supplier_id) references supplier(supplier_id) on update cascade on delete cascade
);

create table categories(
	category_id smallint,
	category_name varchar(15),
	description text,
	picture int,
	constraint category_id_pk primary key (category_id)
)

alter table products add constraint category_id_fk foreign key (category_id) references categories(category_id) on update cascade on delete cascade

create table shippers(
	shipper_id int,
	company_name varchar(40),
	phone varchar(24),
	constraint shipper_id_pk primary key (shipper_id)
);

create table employees(
	employee_id int,
	last_name varchar(20),
	first_name varchar(10),
	title varchar(30),
	title_of_courtesy varchar(25),
	birth_date date,
	hire_date date,
	address varchar(60),
	city varchar(15),
	region varchar(15),
	postal_code varchar(10),
	country varchar(15),
	home_phone varchar(24),
	extension varchar(4),
	photo integer,
	notes text,
	reports_to int,
	photo_path varchar(255),
	constraint employee_id_pk primary key (employee_id)
)

create table customers(
	customer_id char(5),
	company_name varchar(40),
	contact_name varchar(30),
	contact_title varchar (30),
	address varchar(60),
	city varchar (15),
	region varchar (15),
	postal_code varchar (10),
	country varchar(15),
	phone varchar (24),
	fax varchar(24),
	constraint customer_id_pk primary key (customer_id)
);

create table orders(
	order_id int,
	order_date date,
	required_date date,
	shipped_date date,
	freight real,
	ship_name varchar(40),
	ship_address varchar(60),
	ship_city varchar(15),
	ship_region varchar(15),
	ship_postal_code varchar(15),
	ship_country varchar(15),
	employee_id int,
	customer_id char(5),
	ship_via int,
	constraint order_id_pk primary key (order_id),
	constraint employee_id_fk foreign key (employee_id) references employees(employee_id) on delete cascade on update cascade,
	constraint customer_id_fk foreign key (customer_id) references customers(customer_id) on delete cascade on update cascade,
	constraint ship_via_fk foreign key (ship_via) references shippers(shipper_id) on delete cascade on update cascade
)

create table order_detail(
	order_id int,
	product_id int,
	unit_price real,
	quantity int,
	discount real,
	constraint product_id1_pk primary key (order_id,product_id),
	constraint order_id1_fk foreign key (order_id) references orders(order_id) on delete cascade on update cascade,
	constraint product_id1_fk foreign key (product_id) references products(product_id) on delete cascade on update cascade
)