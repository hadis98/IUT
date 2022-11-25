USE hotel;

CREATE TABLE hotel_database.Bookings_Audit(
auto_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
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
action_type VARCHAR(50) NOT NULL,
updated_date DATETIME NOT NULL,
CHECK(action_type = 'INS' OR action_type='DEL')
);

---------------------------------------------------------------------------
------------ log info after inserting row in Booking table ----------
---------------------------------------------------------------------------

CREATE TRIGGER booking_after_insert
ON hotel.hotel_database.bookings
AFTER INSERT 
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO hotel_database.Bookings_Audit
(booking_id,booking_date,duration_of_stay,check_in_date,
check_out_date,booking_payment_type,total_rooms_booked,
hotel_hotel_id,guests_guest_id,employees_emp_id,total_amount,
action_type,updated_date)
SELECT i.booking_id,i.booking_date,i.duration_of_stay,
i.check_in_date,i.check_out_date,i.booking_payment_type,
i.total_rooms_booked,i.hotel_hotel_id,i.guests_guest_id,
i.employees_emp_id,i.total_amount,
'INS',GETDATE()
FROM inserted AS i;
END;


---------------------------------------------------------------------------
------------ log info after deleting row in Booking table ----------
---------------------------------------------------------------------------
DROP TRIGGER IF EXISTS hotel.booking_after_delete;

CREATE TRIGGER booking_after_delete
ON hotel.hotel_database.bookings
AFTER DELETE
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO hotel_database.Bookings_Audit 
(booking_id,booking_date,duration_of_stay,check_in_date,check_out_date,
booking_payment_type,total_rooms_booked,hotel_hotel_id,guests_guest_id,
employees_emp_id,total_amount,action_type,updated_date)
SELECT i.booking_id,i.booking_date,i.duration_of_stay,i.check_in_date,
i.check_out_date,i.booking_payment_type,i.total_rooms_booked,
i.hotel_hotel_id,i.guests_guest_id,i.employees_emp_id,i.total_amount,
'DEL',GETDATE()
FROM deleted AS i;
END;

INSERT INTO hotel.hotel_database.bookings
(booking_id, booking_date, duration_of_stay, check_in_date,
check_out_date, booking_payment_type, total_rooms_booked,
hotel_hotel_id, guests_guest_id, employees_emp_id, total_amount)
 VALUES
	('16', '2021-11-15 00:00:00', '3', '2021-11-18 12:00:00', '2021-11-21 23:00:00', 'card', '1', '2', '5', '3', '678');


DELETE FROM hotel.hotel_database.bookings
WHERE booking_id = '16';

SELECT * FROM hotel_database.Bookings_Audit;


--DELETE FROM hotel_database.Bookings_Audit;
