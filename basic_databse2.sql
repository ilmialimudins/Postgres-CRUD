-- create table countries(
-- country_id CHAR(2),
-- coutry_name VARCHAR (40) Default NULL,
-- region_id INT NOT NULL,
-- CONSTRAINT pk_country_id PRIMARY KEY(country_id),
-- CONSTRAINT fk_regions_id FOREIGN KEY(region_id) REFERENCES regions(region_id) ON DELETE CASCADE ON UPDATE CASCADE);

-- create table locations
-- (
-- location_id serial,
-- 	street_address varchar(40),
-- 	postal_code varchar(12),
-- 	city varchar(30),
-- 	state_provience varchar(25),
-- 	country_id char(2) not null,
-- 	constraint pk_location_id primary key (location_id),
-- 	constraint fk_country_id foreign key(country_id) references countries(country_id) ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- create table departments(
-- department_id serial,
-- 	department_name varchar(30),
-- 	manager_id int not null,
-- 	location_id int not null,
-- 	constraint pk_department_id primary key (department_id),
-- 	constraint fk_manager_id foreign key (manager_id) references employees(employee_id) on delete cascade on update cascade,
-- 	constraint fk_location_id foreign key (location_id) references locations (location_id) on delete cascade on update cascade
-- );

-- create table jobs(
-- job_id varchar (10),
-- 	job_titte varchar(35) unique,
-- 	min_salary numeric,
-- 	max_salary numeric,
-- 	constraint pk_job_id primary key (job_id)
-- );

-- create table employees(
-- employee_id serial,
-- 	first_name varchar(20),
-- 	last_name varchar(20),
-- 	email varchar(25),
-- 	phone_number varchar (20),
-- 	hire_date date,
-- 	salary numeric,
-- 	comission_pct numeric,
-- 	job_id varchar (10),
-- 	department_id int not null,
-- 	manager_id int not null,
-- 	constraint pk_employee_id primary key ( employee_id),
-- 	constraint fk_job_id foreign key (manager_id) references employees(employee_id) on delete cascade on update cascade
-- );

-- create table job_history(
-- employee_id int,
-- 	start_date date,
-- 	end_date date,
-- 	job_id varchar(10),
-- 	department_id int,
-- 	constraint pk_job_history primary key (employee_id, start_date),
-- 	constraint fk_job_history foreign key (job_id) references jobs(job_id) on delete cascade on update cascade,
-- 	constraint fk_department foreign key (department_id) references departments (department_id) on delete cascade on update cascade
-- );

-- select * from employees
-- alter table employees add constraint fk_manager_id foreign key (manager_id)references employees(employee_id) on delete cascade on update cascade;
alter table employees add constraint fk_department_id foreign key (department_id) references departments(department_id) on delete cascade on update cascade;