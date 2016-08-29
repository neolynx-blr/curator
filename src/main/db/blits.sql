/*
	Blits: Service to support the user/worker applications
	Bring-Life-To-Shipping
*/

-- Core tables supporting the order management
----------------------------------------------
	
drop table if exists vendor_user_order_mapper;
create table vendor_user_order_mapper (
	id bigserial primary key,
	vendor_id integer not null,
	user_id integer not null,
	order_id integer not null unique,
	status smallint not null,
	last_modified_on timestamp not null);
		
drop table if exists order_detail;
create table order_detail (
	id bigserial primary key,
	order_id integer not null unique,
	status integer,
	
	item_list varchar(2048),
	item_list_delivery varchar(2048),
	delivery_address_id integer,
	delivery_mode integer,
	
	vendor_id integer not null,
	server_data_version_id bigint not null,
	device_data_version_id bigint not null,
	
	net_amount real not null,
	tax_amount real,
	taxable_amount real,
	discount_amount real,
	
	created_on timestamp not null,  
	last_modified_on timestamp not null
);
	

		 
-- Bunch of meta data tables
----------------------------

drop table if exists order_status;
create table order_status (
	id smallint primary key,
	name varchar(32) not null,
	description varchar(256));
	
insert into order_status (id, name, description) values (1, 'Created', 'Order details have been submitted on server side and is ready for payment.');
insert into order_status (id, name, description) values (2, 'Updated', 'Order details have been updated since initial submission and is ready for payment.');
insert into order_status (id, name, description) values (3, 'Pending Pickup', 'Order has been paid for and awaiting in-store pickup.');
insert into order_status (id, name, description) values (4, 'Pending Delivery', 'Order has been paid for and awaiting delivery.');
insert into order_status (id, name, description) values (5, 'Picked, Pending Delivery', 'Order has been paid for, partially picked up and awaiting delivery.');	
insert into order_status (id, name, description) values (6, 'Completed', 'Order is complete.');

drop table if exists delivery_mode;
create table delivery_mode (
	id smallint primary key,
	name varchar(16) not null,
	description varchar(128));
	
insert into delivery_mode (id, name, description) values (1, 'In-Store Pickup', 'Order will be picked up in store.');
insert into delivery_mode (id, name, description) values (2, 'Partial Delivery', 'Order will be partially picked up and partially delivered.');
insert into delivery_mode (id, name, description) values (3, 'Delivery', 'Order will be delivered.');

-- Account information for various authorization modes to the service invocations
---------------------------------------------------------------------------------

drop table if exists account;
create table account (
	id serial primary key,
	user_name varchar(128) not null,
	password_hash varchar(1024) not null,
	role varchar(64) not null);
	
insert into account (user_name, password_hash, role) values ('nitesh', '1000:d6b9d42984c26f228dae1699fbed0290ffe525239799b1de:2cdd7136d9c7fc61df699d4e8bea34c3e523fa46c89f6f2e', 'Administrator');
insert into account (user_name, password_hash, role) values ('analyst', '1000:c7354b5296f99dac0a7288b1aac6ba08bf0a486920f7c157:4069108b52212a169b7fd432b3e75fe89fcbb06dc0b34a99', 'Analyst');
insert into account (user_name, password_hash, role) values ('vendor', '1000:18ee47af9a316a27155876219f73078e1797e9f7632277b9:6d67b8018cf99d8d51142161fe4b430194437c510ff56a4e', 'Vendor');

		 