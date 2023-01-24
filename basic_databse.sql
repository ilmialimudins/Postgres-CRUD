-- create table regions(
-- 	region_id serial,
-- 	region_name varchar(25),
-- 	constraint region_id_pk primary key(region_id)
-- );
select * from regions;
alter table regions add column region_x varchar(30);
alter table regions rename column region_x to region_y
alter table regions add constraint region_x_pk primary key (region_x)
alter table regions drop constraint region_id_pk
drop table regions
drop table regions cascade
insert into regions(region_id, region_name) values(1, 'artic')
insert into regions(region_name) values('artic')
update regions set regions_name ='Antartic' where region-id=1
update region       
delete from regions where region_id=2