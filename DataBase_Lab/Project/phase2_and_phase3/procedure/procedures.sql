USE hotel;


----------------------------------------------------------
----find all guests from specific city--------
----------------------------------------------------------
DROP PROCEDURE IF EXISTS  guests_per_city;

CREATE PROCEDURE guests_per_city @City varchar(50)
AS
SELECT *
FROM  hotel.hotel_database.guests AS g
INNER JOIN  hotel.hotel_database.addresses AS a
ON(g.addresses_address_id = a.address_id)
WHERE city = @City;

EXEC  guests_per_city @City = 'New Orleans';



---------------------------------------------------------------
----find services which has a cost greater than input parameter
----------------------------------------------------------------
DROP PROCEDURE IF EXISTS findServices;

CREATE PROCEDURE findServices(@min_price AS DECIMAL)
AS
BEGIN
	SELECT service_name,service_description,service_cost
	FROM hotel.hotel_database.hotel_services
	WHERE service_cost >=@min_price
	ORDER BY service_cost;
END;

EXEC findServices 100;

----------------------------------------------------------
-------number of room reservation in a specific hotel
----------------------------------------------------------
DROP PROCEDURE IF EXISTS num_room_reservation;

CREATE PROCEDURE num_room_reservation(@hotel_name AS VARCHAR(50))
AS
BEGIN
SELECT hotel_name,COUNT(*)
FROM  hotel.hotel_database.rooms_booked AS b
INNER JOIN hotel.hotel_database.rooms AS r
ON (b.rooms_room_id = r.room_id)
INNER JOIN hotel.hotel_database.hotel AS h
ON (h.hotel_id= r.hotel_hotel_id)
WHERE hotel_name = @hotel_name
GROUP BY hotel_name
END;

EXEC  num_room_reservation 'ADAMS INN';


-------------------------------------------------------------------------------------------
--for a given hotel name, number of room reservation for each type of room
---------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS num_room_reservation_per_type;

CREATE PROCEDURE num_room_reservation_per_type(@hotel_name AS VARCHAR(50))
AS
BEGIN
SELECT t.name,COUNT(*) AS num_reservation_per_type
FROM  hotel.hotel_database.rooms_booked AS b
INNER JOIN hotel.hotel_database.rooms AS r
ON (b.rooms_room_id = r.room_id)
INNER JOIN hotel.hotel_database.room_type AS t
ON (t.room_type_id= r.rooms_type_rooms_type_id)
INNER JOIN hotel.hotel_database.hotel AS h
ON (h.hotel_id= r.hotel_hotel_id)
WHERE hotel_name = @hotel_name
GROUP BY t.name;
END;

EXEC  num_room_reservation_per_type 'ADAMS INN';


-------------------------------------------------------------------------------------------
---- which type of room was reserved most often?
---------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS max_reservation_per_type;

CREATE PROCEDURE max_reservation_per_type(@hotel_name AS VARCHAR(50))
AS
BEGIN
SELECT TOP 1 t.name AS room_type,COUNT(*) AS num_reservation_per_type
FROM  hotel.hotel_database.rooms_booked AS b
INNER JOIN hotel.hotel_database.rooms AS r
ON (b.rooms_room_id = r.room_id)
INNER JOIN hotel.hotel_database.room_type AS t
ON (t.room_type_id= r.rooms_type_rooms_type_id)
INNER JOIN hotel.hotel_database.hotel AS h
ON (h.hotel_id= r.hotel_hotel_id)
WHERE hotel_name = @hotel_name
GROUP BY t.name
ORDER BY num_reservation_per_type DESC;
END;


EXEC  max_reservation_per_type 'ADAMS INN';





