create table suppliers(
supr_id int,
	supr_name varchar(40),
	supr_contact_name varchar(30),
	supr_city varchar(15),
CONSTRAINT supr_id_pk primary key(supr_id)
)

create table products(
	prod_id int,
	prod_name varchar(40),
	prod_quantity varchar(20),
	prod_price money,
	prod_in_stock smallint,
	prod_on_order smallint,
	prod_reorder_level smallint,
	prod_discontinued bit,
	prod_cat_id int,
	prod_supr_id int,
	constraint prod_id_pk primary key (prod_id)
)
alter table products
add constraint fk_prod_supr_id 
foreign key (prod_supr_id)
references suppliers(supr_id)

alter table products
add constraint fk_prod_cate_id 
foreign key (prod_cate_id)
references categories(cate_id)

create table categories(
cate_id int,
	cate_name varchar(15),
	cate_description text,
	constraint cate_id primary key (cate_id)
)

create table customers(
cust_id int,
	cust_name varchar(40),
	cust_city varchar(15),
	constraint cust_id_pk primary key(cust_id)
)

create table employees(
employee_id int,
	constraint employee_id_pk primary key(employee_id)
)

create table shippers(
ship_id int,
	ship_name varchar(40),
	ship_phone varchar(24),
	constraint ship_id_pk primary key(ship_id)
)

create table orders(
order_id int,
	order_date timestamp,
	order_required_date timestamp,
	order_shipped_date timestamp,
	order_freight money,
	order_subtotal money,
	order_total_qty smallint,
	order_ship_city varchar(15),
	order_ship_address varchar(60),
	order_status varchar(15),
	order_employee_id int,
	order_cust_id int,
	order_ship_id int,
	constraint order_id_pk primary key (order_id)
)
alter table orders
add constraint fk_order_employee_id 
foreign key (order_employee_id)
references employees(employee_id)

alter table orders
add constraint fk_order_cust_id 
foreign key (order_cust_id)
references customers(cust_id)

alter table orders
add constraint fk_order_ship_id 
foreign key (order_ship_id)
references shippers(ship_id)

create table order_detail(
ordet_order_id int,
	ordet_prod_id int,
	ordet_price money,
	ordet_quantity smallint,
	ordet_discount real,
	constraint ordet_id_pk primary key(ordet_order_id, ordet_prod_id)
)
alter table orders_detail
add constraint fk_ordet_order_id 
foreign key (ordet_order_id)
references orders(order_id)

alter table orders_detail
add constraint fk_ordet_prod_id 
foreign key (ordet_prod_id)
references products(prod_id)