use hotel;

-------------------------
-----DROP TABLES ACCORDING TO THEIR FOREGIN KEYS
----------------------
DROP TABLE IF EXISTS hotel_database.hotel_has_service;
DROP TABLE IF EXISTS hotel_database.hotel_services_used_by_guests ;
DROP TABLE IF EXISTS hotel_database.hotel_services;
DROP TABLE IF EXISTS hotel_database.rooms_booked;
DROP TABLE IF EXISTS hotel_database.hotel_chain_has_hotel;
DROP TABLE IF EXISTS hotel_database.bookings;
DROP TABLE IF EXISTS hotel_database.employees;
DROP TABLE IF EXISTS hotel_database.department;
DROP TABLE IF EXISTS hotel_database.guests;
DROP TABLE IF EXISTS hotel_database.rooms;
DROP TABLE IF EXISTS hotel_database.room_type;
DROP TABLE IF EXISTS hotel_database.hotel;
DROP TABLE IF EXISTS hotel_database.star_ratings;
DROP TABLE IF EXISTS hotel_database.hotel_chain;
DROP TABLE IF EXISTS hotel_database.addresses;