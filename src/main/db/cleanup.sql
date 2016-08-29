-- Core tables supporting the order management
----------------------------------------------
	
drop table if exists vendor_user_order_mapper;
drop table if exists order_detail;

		 
-- Bunch of meta data tables
----------------------------

drop table if exists order_status;
drop table if exists delivery_mode;

-- Account information for various authorization modes to the service invocations
---------------------------------------------------------------------------------

drop table if exists account;


-- Table supporting the uber 'NeoLynks' level data from across stores
---------------------------------------------------------------------

-- Master table for all known products across stores/vendors
drop table if exists product_master;

-- Tables supporting the latest vendor inventory details 
--------------------------------------------------------

drop table if exists inventory_master;
drop table if exists vendor_item_master;
drop table if exists vendor_item_history;

-- Vendor registration should include this
------------------------------------------

drop table if exists vendor_version_detail;
drop table if exists vendor_version_differential;

-- Bunch of meta data tables
----------------------------

drop table if exists tax_type;
drop table if exists discount_type;


drop table if exists user_detail;
drop table if exists user_location_detail;


drop table if exists vendor_detail;
drop table if exists vendor_location_detail;
drop table if exists vendor_contact_detail;
drop table if exists vendor_information_cache;