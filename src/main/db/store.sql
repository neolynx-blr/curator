drop table if exists vendor_detail;
create table vendor_detail (
	id serial primary key,
	vendor_id integer not null unique,
	name varchar(512) not null,
	abbr char(3) not null,
	tin varchar(32) not null,
	tagline varchar(512));
	
drop table if exists vendor_location_detail;
create table vendor_location_detail (
	id serial primary key,
	vendor_id integer not null unique,
	address varchar(2048) not null,
	google_map_url varchar(512),
	latitude real,
	longitude real);
	
drop table if exists vendor_contact_detail;
create table vendor_contact_detail (
	id serial primary key,
	vendor_id integer not null unique,
	phone varchar(128),
	mobile varchar(64));
	
drop table if exists vendor_information_cache;
create table vendor_information_cache (
	id serial primary key,
	vendor_id integer not null unique,
	-- vendor_details table
	basic_details varchar(2048),
	-- location and contact details
	contact_details varchar(2048),
	-- product count, last update etc.
	inventory_details varchar(2048)
);