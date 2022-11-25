use hotel;

---------------------------------------------------------------------------
------------ does a hotel exists according to its name ----------
---------------------------------------------------------------------------
DROP FUNCTION IF EXISTS is_hotel_name_valid;

CREATE FUNCTION is_hotel_name_valid(
@hotel_name VARCHAR(50)
)
RETURNS bit
AS
BEGIN
IF EXISTS (
SELECT 1
FROM hotel.hotel_database.hotel
WHERE hotel_name = @hotel_name
)
RETURN 1;
RETURN 0;
END;

SELECT 
CASE
WHEN dbo.is_hotel_name_valid('test') =0 THEN 'does not exist'
ELSE 'exists'
END AS hotel_existance;

SELECT 
CASE
WHEN dbo.is_hotel_name_valid('ADAMS INN') =0 THEN 'does not exist'
ELSE 'exists'
END AS hotel_existnace;



---------------------------------------------------------------------------
------------ number of available rooms in specific hotel and date----------
---------------------------------------------------------------------------
DROP FUNCTION IF EXISTS get_available_rooms_number;

CREATE FUNCTION get_available_rooms_number(  
    @hotel_name VARCHAR(50),  
    @booking_date DATETIME
)  
RETURNS INT
AS   
BEGIN  
IF (dbo.is_hotel_name_valid(@hotel_name) = 0)
RETURN 'hotel does not exists';
RETURN(
SELECT 
h.hotel_room_capacity - num_reservations.booked_rooms AS available_rooms 
FROM (
SELECT h.hotel_name,SUM(b.total_rooms_booked) AS booked_rooms
FROM hotel.hotel_database.hotel AS h
JOIN hotel.hotel_database.bookings AS b 
ON (h.hotel_id = b.hotel_hotel_id)
WHERE h.hotel_name = @hotel_name AND
b.booking_date = @booking_date
GROUP BY h.hotel_name
)AS num_reservations
INNER JOIN hotel.hotel_database.hotel AS h
ON (num_reservations.hotel_name = h.hotel_name)
);
END;   

SELECT dbo.get_available_rooms_number('ADAMS INN','2018-08-08 00:00:00.000') AS available_room_number;


---------------------------------------------------------------------------
------------ show number of services each hotel has
---------------------------------------------------------------------------
DROP FUNCTION IF EXISTS num_services;

CREATE FUNCTION num_services(  
    @hotel_name VARCHAR(50)
)  
RETURNS INT
AS   
BEGIN  
	DECLARE @num_service INT;
SELECT @num_service = 	
number_of_services
FROM (
SELECT  hotels_hotel_id,COUNT(*) AS number_of_services
FROM  hotel.hotel_database.hotel_has_service
GROUP BY hotels_hotel_id
) AS t
INNER JOIN hotel.hotel_database.hotel AS h
ON(t.hotels_hotel_id = h.hotel_id)
WHERE hotel_name = @hotel_name;
RETURN @num_service;
END;   

SELECT dbo.num_services('ADAMS INN') AS num_services;


---------------------------------------------------------------------------
------------ show number of reservation for each type of room
---------------------------------------------------------------------------
DROP FUNCTION IF EXISTS num_reserve_per_type;
CREATE FUNCTION num_reserve_per_type()  
RETURNS @ReturnTable TABLE(
	hotel_name VARCHAR(50) NOT NULL,
	room_type VARCHAR(50) NOT NULL,
	num_reservation_per_type INT
)
AS   
BEGIN  
INSERT @ReturnTable
SELECT hotel_name, t.name AS room_type,COUNT(*) AS num_reservation_per_type
FROM  hotel.hotel_database.rooms_booked AS b
INNER JOIN hotel.hotel_database.rooms AS r
ON (b.rooms_room_id = r.room_id)
INNER JOIN hotel.hotel_database.room_type AS t
ON (t.room_type_id= r.rooms_type_rooms_type_id)
INNER JOIN hotel.hotel_database.hotel AS h
ON (h.hotel_id= r.hotel_hotel_id)
GROUP BY hotel_name, t.name
RETURN;
END;   

SELECT *
FROM num_reserve_per_type()
ORDER BY hotel_name, num_reservation_per_type DESC;