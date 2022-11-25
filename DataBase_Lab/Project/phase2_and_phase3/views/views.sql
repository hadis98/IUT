USE hotel;


--------------------------------------------------------------------------------------
------------show hotel chain number,hotel details,star rating,list of its services ----------
---------------------------------------------------------------------------------------------

DROP VIEW  IF EXISTS hotel_database.hotel_services_info_view;

CREATE VIEW hotel_database.hotel_services_info_view
AS
SELECT c.hotel_chain_name,h.hotel_name,star_rating,service_name,service_description,service_cost
FROM hotel.hotel_database.hotel AS h
INNER JOIN hotel.hotel_database.star_ratings AS s
ON (s.star_rating= h.star_ratings_star_rating)
INNER JOIN hotel.hotel_database.hotel_chain AS c
ON (c.hotel_chain_id= h.hotel_chain_id)
INNER JOIN hotel.hotel_database.hotel_has_service AS has_service
ON (has_service.hotels_hotel_id = h.hotel_chain_id)
INNER JOIN hotel.hotel_database.hotel_services AS h_service
ON (h_service.service_id= has_service.hotel_services_service_id);

SELECT * FROM  hotel_database.hotel_services_info_view
ORDER BY hotel_name;


---------------------------------------------------------------------------
------------ show hotel rooms,room types ----------
---------------------------------------------------------------------------

DROP VIEW IF EXISTS hotel_database.hotel_rooms_info_view;

CREATE VIEW hotel_database.hotel_rooms_info_view
AS
SELECT c.hotel_chain_name,h.hotel_name,h.hotel_room_capacity,r.room_number,t.name AS room_type,t.cost , t.description,
CASE 
WHEN smoke_friendly ='0' THEN 'SMOKE IS NOT ALLOWED'
ELSE 'SMOKE IS ALLOWED'
END AS is_smoke_allowed,
CASE 
WHEN pet_friendly ='0' THEN 'PET IS NOT ALLOWED'
ELSE 'PET IS ALLOWED'
END AS is_pet_allowed
FROM hotel.hotel_database.hotel AS h
INNER JOIN hotel.hotel_database.rooms AS r
ON (h.hotel_id = r.hotel_hotel_id)
INNER JOIN hotel.hotel_database.room_type AS t
ON (r.rooms_type_rooms_type_id= t.room_type_id)
INNER JOIN hotel.hotel_database.hotel_chain AS c
ON (c.hotel_chain_id= h.hotel_chain_id);

SELECT * FROM  hotel_database.hotel_rooms_info_view;


---------------------------------------------------------------------------
------------show contact information for hotel chains and hotels ----------
---------------------------------------------------------------------------

DROP VIEW IF EXISTS hotel_database.hotel_contact_info_view;

CREATE VIEW hotel_database.hotel_contact_info_view
AS
SELECT c.hotel_chain_name,c.hotel_chain_contact_number,c.hotel_chain_email,c.hotel_chain_website,h.hotel_name,h.hotel_contact_number,h.hotel_email,h.hotel_website_address
FROM hotel.hotel_database.hotel AS h
INNER JOIN hotel.hotel_database.hotel_chain AS c
ON (c.hotel_chain_id= h.hotel_chain_id);

SELECT * FROM  hotel_database.hotel_contact_info_view;


---------------------------------------------------------------------------
------------get hotel employees information ----------
---------------------------------------------------------------------------
DROP VIEW IF EXISTS hotel_database.hotel_employee_info_view;

CREATE VIEW hotel_database.hotel_employee_info_view
AS
SELECT employee_first_name AS 'First Name',employee_last_name AS 'Last Name',
CASE
WHEN employee_gender = 'm' THEN 'Male'
ELSE 'Female'
END AS Gender,
employee_designation AS 'Role',
employee_contact_number AS 'Contact Number',
employee_email AS 'Email Address',
d.department_name AS 'Department',
h.hotel_name AS 'Hotel Name',
a.building_number +' '+a.address_line +' '+a.city + ' '+a.state + ' '+a.country AS 'Full Addrress',zipcode
FROM  hotel.hotel_database.employees AS e
INNER JOIN hotel.hotel_database.department AS d
ON (e.department_department_id = d.department_id)
INNER JOIN hotel.hotel_database.addresses AS a
ON (a.address_id= e.addresses_address_id)
INNER JOIN hotel.hotel_database.hotel AS h
ON (h.hotel_id= e.hotel_hotel_id);

SELECT * FROM  hotel_database.hotel_employee_info_view;



---------------------------------------------------------------------------
------------get hotel guests information ----------
---------------------------------------------------------------------------
DROP VIEW IF EXISTS hotel_database.hotel_guest_info_view;

CREATE VIEW hotel_database.hotel_guest_info_view
AS
SELECT guest_first_name AS 'First Name',guest_last_name AS 'Last Name',
CASE
WHEN guest_gender = 'm' THEN 'Male'
ELSE 'Female'
END AS Gender,
guest_contact_number AS 'Contact Number',
guest_email AS 'Email Address',
a.building_number +' '+a.address_line +' '+a.city + ' '+a.state + ' '+a.country AS 'Full Addrress',zipcode
FROM  hotel.hotel_database.guests AS g
INNER JOIN hotel.hotel_database.addresses AS a
ON (a.address_id= g.addresses_address_id)
WHERE guest_id IN(
SELECT guests_guest_id
FROM hotel.hotel_database.bookings
);

SELECT * FROM  hotel_database.hotel_guest_info_view;