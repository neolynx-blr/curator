drop table if exists user_detail;
create table user_detail (
	id serial primary key,
	first_name varchar(128),
	last_name varchar(256),
	screen_name varchar(64),
	email varchar(256) unique,
	registered_phone varchar(16) unique,
	other_phone varchar(128),
	device_id varchar(2048));
	
drop table if exists user_location_detail;
create table user_location_detail (
	id serial primary key,
	user_id integer not null,
	address_tag varchar(64),
	address varchar(2048) not null,
	google_map_url varchar(512),
	latitude real,
	longitude real);
