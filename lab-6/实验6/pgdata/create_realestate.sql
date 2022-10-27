drop table customer_lot;
drop table customer;
drop table lot;

create table customer(
 customer_id integer,
 customer_first_name varchar(100),
 customer_last_name varchar(100));

 create table lot(
 lot_id integer,
 lot_description varchar(100),
 lot_size float,
 lot_district integer,
 lot_value float,
 lot_street_address varchar(100));

 create table customer_lot(
 customer_id integer,
 lot_id integer) ;
