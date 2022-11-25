--CREATE SCHEMA hotel_database;
use hotel;
--------------------------------------------------------
----------  hotel_database.addresses
--------------------------------------------------------


--SELECT * FROM hotel_database.addresses;
--DELETE FROM  hotel_database.addresses;
DROP TABLE IF EXISTS hotel_database.addresses;

CREATE TABLE hotel_database.addresses(
address_id INT NOT NULL,
building_number VARCHAR(20) NULL,
address_line VARCHAR(150) NULL,
city VARCHAR(50) NULL,
[state] VARCHAR(50) NULL,
country VARCHAR(50) NULL,
zipcode VARCHAR(8) NULL,
PRIMARY KEY (address_id)
);

--ALTER TABLE hotel_database.addresses ADD  building_number VARCHAR(20) NULL;

--------------------------------------------------------
----------  hotel_database.hotel_chain
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.hotel_chain;

CREATE TABLE hotel_database.hotel_chain(
hotel_chain_id INT NOT NULL,
hotel_chain_name VARCHAR(50) NULL,
hotel_chain_contact_number VARCHAR(12) NULL,
hotel_chain_website VARCHAR(50) NULL,
hotel_chain_email VARCHAR(50),
hotel_chain_head_office_address_id INT NOT NULL,
	PRIMARY KEY (hotel_chain_id),
	CONSTRAINT fk_hotel_chains_addresses1
	FOREIGN KEY (hotel_chain_head_office_address_id)
	REFERENCES hotel_database.addresses(address_id)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


--------------------------------------------------------
----------  hotel_database.star_ratings
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.star_ratings;

CREATE TABLE hotel_database.star_ratings(
star_rating INT NOT NULL,
star_rating_image VARCHAR(100) NULL,
PRIMARY KEY(star_rating)
);

--------------------------------------------------------
----------  hotel_database.hotel
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.hotel;

CREATE TABLE hotel_database.hotel(
hotel_id INT NOT NULL,
hotel_name VARCHAR(50) NULL,
hotel_contact_number VARCHAR(12) NULL,
hotel_email VARCHAR(50) NULL,
hotel_website_address VARCHAR(50) NULL,
hotel_description VARCHAR(100) NULL,
hotel_room_capacity INT NULL,
hotel_floor_count INT NULL,
hotel_chain_id INT NULL,
addresses_address_id INT NOT NULL,
star_ratings_star_rating INT NOT NULL,
check_in_time datetime NULL,
check_out_time datetime NULL,
	PRIMARY KEY (hotel_id),
	CONSTRAINT fk_hotels_addresses1
	FOREIGN KEY (addresses_address_id)
	REFERENCES hotel_database.addresses(address_id) 
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_hotel_star_ratings1
    FOREIGN KEY (star_ratings_star_rating)
    REFERENCES hotel_database.star_ratings (star_rating)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

--------------------------------------------------------
----------  hotel_database.room_type
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.room_type;

CREATE TABLE hotel_database.room_type (
  room_type_id INT NOT NULL,
  [name] VARCHAR(45) NULL,
  cost  DECIMAL(10,2) NULL,
  [description] VARCHAR(260) NULL,
  smoke_friendly TINYINT NULL,
  pet_friendly TINYINT NULL,
  PRIMARY KEY (room_type_id)
);

--------------------------------------------------------
----------  hotel_database.rooms
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.rooms;

CREATE TABLE hotel_database.rooms (
  room_id INT NOT NULL,
  room_number VARCHAR(4) NULL,
  rooms_type_rooms_type_id INT NOT NULL,
  hotel_hotel_id INT NOT NULL,
  PRIMARY KEY (room_id),
  CONSTRAINT fk_rooms_rooms_type1
    FOREIGN KEY (rooms_type_rooms_type_id)
    REFERENCES hotel_database.room_type(room_type_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	CONSTRAINT fk_rooms_hotel1
    FOREIGN KEY (hotel_hotel_id)
    REFERENCES hotel_database.hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

--------------------------------------------------------
----------  hotel_database.guests
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.guests;

CREATE TABLE hotel_database.guests (
  guest_id INT NOT NULL,
  guest_first_name VARCHAR(45) NOT NULL,
  guest_last_name VARCHAR(45) NOT NULL,
  guest_gender CHAR(1) NULL,
  guest_contact_number VARCHAR(12) NOT NULL,
  guest_email VARCHAR(45) NULL,
  guest_credit_card VARCHAR(45) NULL,
  guest_id_proof VARCHAR(45) NOT NULL,
  addresses_address_id INT NOT NULL,
  PRIMARY KEY (guest_id),
  CONSTRAINT fk_guests_addresses1
    FOREIGN KEY (addresses_address_id)
    REFERENCES hotel_database.addresses (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

--------------------------------------------------------
----------  hotel_database.department
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.department;

CREATE TABLE  hotel_database.department (
  department_id INT NOT NULL,
  department_name VARCHAR(45) NOT NULL,
  department_description VARCHAR(260) NULL,
  PRIMARY KEY (department_id)
);

--------------------------------------------------------
----------  hotel_database.employees
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.employees;

CREATE TABLE hotel_database.employees (
  employee_id INT NOT NULL,
  employee_first_name VARCHAR(45) NOT NULL,
  employee_last_name VARCHAR(45) NOT NULL,
  employee_gender CHAR(1) NULL,
  employee_designation VARCHAR(45) NOT NULL,
  employee_contact_number VARCHAR(12) NULL,
  employee_email VARCHAR(45) NULL,
  department_department_id INT NOT NULL,
  addresses_address_id INT NOT NULL,
  hotel_hotel_id INT NOT NULL,
  PRIMARY KEY (employee_id),
  CONSTRAINT fk_employees_services1
    FOREIGN KEY (department_department_id)
    REFERENCES hotel_database.department (department_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_employees_addresses1
    FOREIGN KEY (addresses_address_id)
    REFERENCES hotel_database.addresses (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_employees_hotel1
    FOREIGN KEY (hotel_hotel_id)
    REFERENCES hotel_database.hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


--------------------------------------------------------
----------  hotel_database.bookings
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.bookings;

CREATE TABLE  hotel_database.bookings (
  booking_id INT NOT NULL,
  booking_date DATETIME NULL,
  duration_of_stay VARCHAR(10) NULL,
  check_in_date DATETIME NULL,
  check_out_date DATETIME NULL,
  booking_payment_type VARCHAR(45) NULL,
  total_rooms_booked INT NULL,
  hotel_hotel_id INT NOT NULL,
  guests_guest_id INT NOT NULL,
  employees_emp_id INT NOT NULL,
  total_amount DECIMAL(10,2) NULL,
  CHECK (booking_payment_type IN ('cash','card')),
  PRIMARY KEY (booking_id),
  CONSTRAINT fk_bookings_hotel1
    FOREIGN KEY (hotel_hotel_id)
    REFERENCES hotel_database.hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_bookings_guests1
    FOREIGN KEY (guests_guest_id)
    REFERENCES hotel_database.guests (guest_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_bookings_employees1
    FOREIGN KEY (employees_emp_id )
    REFERENCES hotel_database.employees (employee_id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

--------------------------------------------------------
----------  hotel_database.hotel_chain_has_hotel
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.hotel_chain_has_hotel;

CREATE TABLE hotel_database.hotel_chain_has_hotel (
  hotel_chains_hotel_chain_id INT NOT NULL,
  hotels_hotel_id INT NOT NULL,
  PRIMARY KEY (hotel_chains_hotel_chain_id,  hotels_hotel_id),
  CONSTRAINT fk_hotel_chains_has_hotels_hotel_chains1
    FOREIGN KEY (hotel_chains_hotel_chain_id)
    REFERENCES hotel_database.hotel_chain (hotel_chain_id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_hotel_chains_has_hotels_hotels1
    FOREIGN KEY (hotels_hotel_id)
    REFERENCES hotel_database.hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

);

--------------------------------------------------------
----------  hotel_database.rooms_booked
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.rooms_booked;

CREATE TABLE hotel_database.rooms_booked (
  rooms_booked_id INT NOT NULL,
  bookings_booking_id INT NOT NULL,
  rooms_room_id INT NOT NULL,
  PRIMARY KEY (rooms_booked_id, bookings_booking_id, rooms_room_id),
  CONSTRAINT fk_rooms_booked_bookings1
    FOREIGN KEY (bookings_booking_id)
    REFERENCES hotel_database.bookings (booking_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_rooms_booked_rooms1
    FOREIGN KEY (rooms_room_id)
    REFERENCES hotel_database.rooms (room_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

--------------------------------------------------------
----  hotel_database.hotel_services
--------------------------------------------------------
DROP TABLE IF EXISTS hotel_database.hotel_services;

CREATE TABLE  hotel_database.hotel_services (
  service_id INT NOT NULL,
  [service_name] VARCHAR(45) NULL,
  service_description VARCHAR(100) NULL,
  service_cost DECIMAL(10,2) NULL,
  PRIMARY KEY (service_id)
);

--------------------------------------------------------
----  hotel_database.hotel_services_used_by_guests
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.hotel_services_used_by_guests ;

CREATE TABLE hotel_database.hotel_services_used_by_guests (
  service_used_id INT NOT NULL,
  hotel_services_service_id INT NOT NULL,
  bookings_booking_id INT NOT NULL,
  PRIMARY KEY (service_used_id, hotel_services_service_id, bookings_booking_id),
  CONSTRAINT fk_hotel_services_has_bookings_hotel_services1
    FOREIGN KEY (hotel_services_service_id)
    REFERENCES hotel_database.hotel_services (service_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_hotel_services_has_bookings_bookings1
    FOREIGN KEY (bookings_booking_id)
    REFERENCES hotel_database.bookings (booking_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


--------------------------------------------------------
----------  hotel_database.hotel_has_service
--------------------------------------------------------

DROP TABLE IF EXISTS hotel_database.hotel_has_service;

CREATE TABLE hotel_database.hotel_has_service (
  hotels_hotel_id INT NOT NULL,
  hotel_services_service_id INT NOT NULL
  PRIMARY KEY (hotel_services_service_id,  hotels_hotel_id),
  CONSTRAINT fk_hotel_has_hotel_service_service1
    FOREIGN KEY (hotel_services_service_id)
    REFERENCES hotel_database.hotel_services (service_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_hotel_has_hotel_service_hotels1
    FOREIGN KEY (hotels_hotel_id)
    REFERENCES hotel_database.hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);