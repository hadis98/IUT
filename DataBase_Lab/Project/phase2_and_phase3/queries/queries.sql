use hotel;


---------------------------------------------------------------------------
------------- list all unique countries hotels are located in ----------
---------------------------------------------------------------------------

SELECT DISTINCT country 
FROM hotel.hotel_database.addresses
WHERE address_id IN (
	SELECT addresses_address_id
	FROM hotel.hotel_database.hotel
);


---------------------------------------------------------------------------
------------- number of hotels in a hotel chain ----------
---------------------------------------------------------------------------

SELECT hotel_chains_hotel_chain_id,COUNT(*) AS TOTAL_HOTELS_IN_CHAIN
FROM hotel.hotel_database.hotel_chain_has_hotel
GROUP BY hotel_chains_hotel_chain_id;


---------------------------------------------------------------------------
------ number of total,reserved,available rooms for every hotel ----------
---------------------------------------------------------------------------

WITH num_reservations (hotel_name,booked_rooms) AS
(
SELECT h.hotel_name,SUM(b.total_rooms_booked) AS booked_rooms
FROM hotel.hotel_database.hotel AS h
JOIN hotel.hotel_database.bookings AS b 
ON (h.hotel_id = b.hotel_hotel_id)
GROUP BY h.hotel_name
)
SELECT h.hotel_name,h.hotel_room_capacity,booked_rooms,h.hotel_room_capacity - booked_rooms AS available_rooms
FROM hotel.hotel_database.hotel AS h
INNER JOIN num_reservations AS n ON (n.hotel_name = h.hotel_name);


---------------------------------------------------------------------------
------------ number of reservation a customer has made in 1year----------
---------------------------------------------------------------------------
SELECT YEAR(b.booking_date) AS year,guests_guest_id,COUNT(*) AS num_reservations
FROM hotel.hotel_database.bookings AS b
GROUP BY YEAR(b.booking_date),guests_guest_id;

--how many distinct guest have made reservations for a specific month?





---------------------------------------------------------------------------
------------ show number of services each hotel has----------
---------------------------------------------------------------------------

SELECT hotel_name,number_of_services
FROM (
SELECT  hotels_hotel_id,COUNT(*) AS number_of_services
FROM  hotel.hotel_database.hotel_has_service
GROUP BY hotels_hotel_id
) AS t
INNER JOIN hotel.hotel_database.hotel AS h
ON(t.hotels_hotel_id = h.hotel_id);


SELECT  hotels_hotel_id,COUNT(*) AS number_of_services
FROM  hotel.hotel_database.hotel_has_service
GROUP BY hotels_hotel_id;















WITH num_reservations (hotel_name,booked_rooms) AS
(
SELECT h.hotel_name,SUM(b.total_rooms_booked) AS booked_rooms
FROM hotel.hotel_database.hotel AS h
JOIN hotel.hotel_database.bookings AS b 
ON (h.hotel_id = b.hotel_hotel_id)
WHERE h.hotel_name = 'ADAMS INN' AND
b.booking_date = '2018-08-08 00:00:00.000'
GROUP BY h.hotel_name
)
SELECT h.hotel_room_capacity - booked_rooms AS available_rooms
FROM hotel.hotel_database.hotel AS h
INNER JOIN num_reservations AS n
ON (n.hotel_name = h.hotel_name)