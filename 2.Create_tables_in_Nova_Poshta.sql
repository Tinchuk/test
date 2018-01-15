use Nova_Poshta
go

-- drop and create schema nps!!!!
drop schema if exists nps
go
create schema nps authorization dbo
go

--111
-- drop and create table Countries
drop table if exists nps.Countries
go
create table nps.Countries(
	country_id					integer not null primary key
   ,country_name				varchar(30) not null
   ,country_brief_record		varchar(5) not null
		constraint country_brief_uk unique (country_brief_record)
   ,country_capital				varchar(30) null
   ,country_population			integer null
   ,country_independence_day	date null
   ,country_area				decimal(8,2) null
   ,country_sea_port			bit not null default (0)
   ,country_river_port			bit not null default (0)
   ,country_description			varchar(250) null
)
go


-- drop and create table Cities
drop table if exists nps.Cities
go
create table nps.Cities(
	 city_id				integer not null primary key
	,city_name				varchar(30) not null
	,city_brief_record		varchar(3) not null
		constraint city_brief_uk unique (city_brief_record)
	,city_regional_center	bit not null
		constraint city_regional_centre_df default (1)
    ,city_description		varchar(250) null
    ,city_country_id		integer not null
)
go


-- drop and create table Departments
drop table if exists nps.Departments
go
create table nps.Departments(
	 department_id			smallint not null primary key
	,department_number		integer not null
		constraint dep_num_uk unique (department_number)
	,department_type		varchar(30) not null
	,department_city_id		integer not null
		constraint city_fk foreign key (department_city_id) references nps.Cities (city_id)
	,department_address		varchar(30) not null
	,department_phone		varchar(30) not null
	,department_schedule	varchar(100) null
)
go


-- drop and create table Paymenttypes
drop table if exists nps.Paymenttypes
go
create table nps.Paymenttypes(
	payment_type_id				integer not null primary key
   ,payment_type_title			varchar(30) not null
	constraint pay_type_title_df default ('Cash')
   ,payment_type_description	varchar(100) null
)
go


-- drop and create table Servicetypes
drop table if exists nps.Servicetypes
go
create table nps.Servicetypes(
	service_type_id				integer not null primary key
   ,service_type_title			varchar(12) not null
   ,service_type_description	varchar(100) null
)
go


-- drop and create table Discounts
drop table if exists nps.Discounts
go
create table nps.Discounts(
	discount_id	    integer not null primary key
   ,discount_title	varchar(50) not null
   ,discount_amount	smallint not null
		constraint discount_amount_df default (1)
)
go


-- drop and create table Cards
drop table if exists nps.Cards
go
create table nps.Cards(
	card_id				integer not null primary key
   ,card_produce_date	date not null default getdate()
   ,card_assign_date	date not null default getdate()
   ,card_discount_id	integer not null
	constraint card_discount_id_fk foreign key (card_discount_id) references nps.Discounts (discount_id)
)
go


-- drop and create table Positions
drop table if exists nps.Positions
go
create table nps.Positions(
	position_id				tinyint not null primary key
   ,position_title			varchar(40) not null
   ,position_description	varchar(100) null
   ,position_rate_per_hour	money null
)
go


-- drop and create table Employees
drop table if exists nps.Employees
go
create table nps.Employees(
	  employee_id					integer not null primary key
     ,employee_surname				varchar(30) not null
     ,employee_name					varchar(30) not null
     ,employee_middle_name			varchar(30) null
     ,employee_birthday				date not null
     ,employee_passport				varchar(8) not null
		constraint emp_passport_uk unique (employee_passport)
     ,employee_agreement_number		integer not null
		constraint emp_agreement_num_uk unique (employee_agreement_number)
		constraint emp_agreement_num_chk check (employee_agreement_number > 0)
     ,еmployment_record				varchar(30) not null
		constraint emp_record_uk unique (еmployment_record)
     ,employee_phone_number			varchar(20) null
     ,employee_position_id			tinyint not null
		constraint emp_position_fk foreign key (employee_position_id) references nps.Positions (position_id)
     ,employee_photo				image null
     ,employee_agreement_date		date not null default getdate()
     ,employee_department_id		smallint not null
		constraint emp_depart_fk foreign key (employee_department_ID) references nps.Departments (department_id)
	 ,employee_inserted_date		datetime not null default getdate()
	 ,employee_updated_date			datetime null
)
go


-- drop and create table Carriers
drop table if exists nps.Carriers
go
create table nps.Carriers(
	  carrier_id						integer not null primary key
     ,carrier_name						varchar(40) not null
     ,carrier_email						varchar(40) null
     ,carrier_phone 					varchar(20) null
     ,carrier_count 					integer not null
		constraint car_count_chk check (carrier_count > 0)
     ,carrier_site						varchar(40) null
     ,carrier_agreement_number			integer not null
		constraint car_agreement_num_uk unique (carrier_agreement_number)
     ,carrier_agreement_date_start		date not null default getdate()
     ,carrier_agreement_date_end		date null
     ,carrier_address					varchar(40) null
)
go


-- drop and create table Packagetypes
drop table if exists nps.Packagetypes
go
create table nps.Packagetypes(
	 packagetype_id				integer not null primary key
    ,packagetype_name			varchar(30) not null
    ,packagetype_weight			decimal(6,2) not null
    ,packagetype_fragile		bit not null
		constraint pack_fragile_df default (0)
    ,packagetype_valuability	integer not null
    ,packagetype_length			integer null
    ,packagetype_width			integer null
    ,packagetype_high			integer null
    ,packagetype_pack			varchar(30) null
    ,packagetype_delivery		varchar(30) null
)
go


-- drop and create table Customertypes
drop table if exists nps.Customertypes
go
create table nps.Customertypes(
	type_customer_id	integer not null primary key
   ,type_customer_title	varchar(50) not null
)
go


-- drop and create table Ownerships
drop table if exists nps.Ownerships
go
create table nps.Ownerships(
	ownership_id	integer not null primary key
   ,ownership_title	varchar(50) not null
)
go


-- drop and create table Customers
drop table if exists nps.Customers
go
create table nps.Customers(
	customer_id					integer not null primary key
   ,customer_type_id			integer not null
		constraint cust_type_fk foreign key (customer_type_id) references nps.Customertypes (type_customer_id)
   ,customer_entrepreneur_name	varchar(50) null
   ,customer_ownership_id		integer null
		constraint cust_ownership_fk foreign key (customer_ownership_id) references nps.Ownerships (ownership_id)
   ,customer_legal_entity_code	integer null
   ,customer_lastname			varchar(50) not null 
   ,customer_name				varchar(50) not null
   ,customer_middle_name		varchar(50) null
   ,customer_phone				varchar(20) not null
   ,customer_birthday			date null
   ,customer_email				varchar(50) null
   ,customer_country_id			integer not null
		constraint cust_country_fk foreign key (customer_country_id) references nps.Countries (country_id)
   ,customer_city_id			integer not null 
		constraint cust_city_fk foreign key (customer_city_id) references nps.Cities (city_id)
   ,customer_address			varchar(50) not null
   ,customer_card_id			integer null
		constraint cust_card_fk foreign key (customer_card_id) references nps.Cards (card_id)
   ,customer_password			varchar(50) null
		constraint cust_pass_chk check (len(customer_password) > 5)
   ,created_at					date null
		constraint created_at_df default getdate()
   ,updated_at					date null
)
go


-- drop and create table Shipments
drop table if exists nps.Shipments
go
create table nps.Shipments(
	shipment_id						integer not null primary key
   ,shipment_compensation			money null
   ,shipment_money					money not null
   ,shipment_date					datetime not null
   ,shipment_delivery_date			datetime null
   ,shipment_order_date				datetime not null default getdate()
   ,shipment_issuance_date			datetime not null default getdate()
   ,shipment_storage				integer null
		constraint ship_storage_chk check (shipment_storage > 0)
   ,shipment_storage_price			money null
   ,shipment_price					money not null
   ,shipment_sender_id				integer not null
		constraint ship_sender_fk foreign key (shipment_sender_id) references nps.Customers (customer_id)
   ,shipment_receiver_id			integer not null
		constraint ship_receiver_fk foreign key (shipment_receiver_id) references nps.Customers (customer_id)
   ,shipment_city_send_id			integer not null
		constraint ship_city_send_fk foreign key (shipment_city_send_id) references nps.Cities (city_id)
   ,shipment_city_receive_id		integer not null
		constraint ship_city_receive_fk foreign key (shipment_city_receive_id) references nps.Cities (city_id)
   ,shipment_weight					decimal(6,2) null
   ,shipment_volume					decimal(6,2) null
   ,shipment_description			varchar(150) null
   ,shipment_service_type_id		integer not null
		constraint ship_service_type_fk foreign key (shipment_service_type_id) references nps.servicetypes (service_type_id)
   ,shipment_documents				varchar(100) null
   ,shipment_payer					varchar(20) null
   ,shipment_payment_type_id		integer not null
		constraint ship_pay_type_fk foreign key (shipment_payment_type_id) references nps.Paymenttypes (payment_type_id)
   ,shipment_department_send_id		smallint not null
		constraint ship_dep_send_fk foreign key (shipment_department_send_id) references nps.Departments (department_id)
   ,shipment_department_receive_id	smallint not null
		constraint ship_dep_receive_fk foreign key (shipment_department_receive_id) references nps.Departments (department_id)
   ,shipment_money_status			bit not null
	constraint ship_money_status_df default (0)
   ,shipment_package_status			bit not null
	constraint ship_package_status_df default (0)
   ,shipment_current_location		varchar(300) null
)
go