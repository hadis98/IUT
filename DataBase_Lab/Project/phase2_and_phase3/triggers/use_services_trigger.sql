USE hotel;

CREATE TABLE hotel_database.Services_Audit(
auto_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
service_used_id INT NOT NULL,
service_id INT NOT NULL,
booking_id INT NOT NULL,
action_type VARCHAR(50) NOT NULL,
updated_date DATETIME NOT NULL,
CHECK(action_type = 'INS')
);

---------------------------------------------------------------------------
------------ log info after inserting row in hotel_services_used_by_guests table ----------
---------------------------------------------------------------------------

CREATE TRIGGER service_after_insert
ON hotel.hotel_database.hotel_services_used_by_guests
AFTER INSERT 
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO hotel_database.Services_Audit
(service_used_id,service_id,booking_id,action_type,updated_date)
SELECT i.service_used_id,i.hotel_services_service_id,i.bookings_booking_id,
'INS',GETDATE()
FROM inserted AS i;
END;

INSERT INTO hotel.hotel_database.hotel_services_used_by_guests 
(service_used_id, hotel_services_service_id, bookings_booking_id) 
 VALUES 
 ('17', '8', '7');

SELECT * FROM hotel_database.Services_Audit;