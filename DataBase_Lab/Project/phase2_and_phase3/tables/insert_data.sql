use hotel;


INSERT INTO hotel.hotel_database.addresses
(address_id,building_number, address_line,city, [state], country, zipcode)
VALUES 
	 (1,80, 'Allen Street', 'Toronto','ON','Canada','44023'),
	 (2,23, 'Yonge Street', 'Victoria','BC','Canada','78045'),
	 (3,44, 'Astor Place', 'Halifax','ON','Canada','85013'),
	 (4,45, 'Baxter Street', 'Victoria','BC','Canada','48180'),
	 (5,18, 'Bayard Street', 'Regina','ON','Canada','37110'),
	 (6,29, 'Beach Street', 'San Diego','California','USA','61109'),
	 (7,123, 'Beekman Place', 'Charlottetown','PE','Canada','54481'),
	 (8,789, 'Bleecker Street', 'Houston','Texas','USA','85501'),
	 (9,11, ' Gandhi Road', 'San Antonio','Texas','USA','534076'),
	 (10,7, 'Idle rd', 'Saskatoon','SK','Bangladesh','66218'),
	 (11,410, 'Vanier Park', 'Kitchener','ON','Canada','95111'),
	 (12,86, 'Greenfield', 'London','ON','England','234987'),
	 (13,89, 'Jacob Rd', 'Los Angeles','California','USA','467289'),
	 (14,85, 'Martin Street', 'Ottawa','BC','Canada','263987'),
	 (15,13, 'Josseph St. Street', 'Guelph','BC','Canada','267387'),
	 (16,156, 'James Road', 'Fort Worth','Texas','USA','263762'),
	 (17,333, 'Atomic Street', 'Ottawa','New York','USA','756145'),
	 (18,98, 'Saint Jake Rd', 'Seattle','Washington','USA','675846'),
	 (19,536, 'Thames Rd', 'Yellowknife','NT','Canada','515 287'),
	 (20,123, 'Robson Street', 'Yellowknife','NT','Canada','515 287'),
	 (21,6649, 'N Blue Gum St', 'New Orleans','LA','USA','70116'),
	 (22,4, 'B Blue Ridge Blvd', 'Brighton','MI','USA','48116'),
	 (23,8, 'W Cerritos Ave #54', 'Bridgeport','NJ','USA','8014'),
	 (24,639, 'Main St', 'New Orleans','LA','USA','99501'),
	 (25,1, 'Central Ave', 'Hamilton','OH','USA','48310'),
	 (26,86, 'Nw 66th St #8673', 'Hamilton','OH','USA','80919'),
	 (27,39, 'Cedar Ave #84', 'Hamilton','OH','USA','10013'),
	 (28,2, 'Thorburn Ave', 'Hamilton','OH','USA','94545'),
	 (29,386, '9th Ave N', 'Hamilton','OH','USA','60624'),
	 (30,7562, 'Atlantic Ave', 'Hamilton','OH','USA','18509'),
	 (31,44, 'South Dr', 'Hamilton','OH','USA','95965'),
	 (32,8231, 'E Liberty St', 'Ridgefield Park','NJ','USA','12771'),
	 (33,312, 'Ralph Ct', 'Dunellen','NJ','USA','44142'),
	 (34,864, 'Distribution Way', 'New York','NY','USA','7003'),
	 (35,426, 'Wolf St', 'Metairie','LA','USA','99501'),
	 (36,128, 'Bransten Rd', 'New York','NY','USA','19102'),
	 (37,17, 'Morena Blvd', 'Camarillo','CA','USA','45217'),
	 (38,775, 'W 17th St', 'San Antonio','TX','USA','90248');



INSERT INTO hotel.hotel_database.star_ratings
(star_rating, star_rating_image) 
VALUES
	(1,'/images/one_star.jpg'),
	(2,'/images/two_star.jpg'),
	(3,'/images/three_star.jpg'),
	(4,'/images/four_star.jpg'),
	(5,'/images/five_star.jpg');

INSERT INTO hotel.hotel_database.department
(department_id, department_name, department_description)
VALUES
	(1,'Front Office','reservation,reception,registration,room assignment,settlement of bills of a resident guest.'),
	(2,'Housekeeping','cleanliness,maintenance,aesthetic upkeep of rooms,public areas,back areas,surroundings.'),
	(3,'Food and Beverage Service','looks after the service of food and drinks to guests.'),
	(4,'Food Production','All the food and beverages that are served to the hotel guest is prepared in the kitchen.'),
	(5,'Maintenance','responsible for repairing and maintaining the plant and machinery, water treatment and distribution, boilers and water heating, sewage treatment etc.'),
	(6,'Credits','maintains all the financial transactions.'),
	(7,'Security','responsible for the overall security of the hotel building, in-house guests, visitors, day users, and employees of the hotel.'),
	(8,'Marketing','increase the sales of the hotel’s products and services.'),
	(9,'Purchase','responsible for procuring the inventories of all the departments of a hotel.'),
	(10,'Information Technology','responsible for the day-to-day support of all IT systems, business systems, office systems, computer networks, and telephony systems.');


INSERT INTO hotel.hotel_database.room_type
(room_type_id, name,cost, description, smoke_friendly, pet_friendly)
 VALUES 
	(1, 'Single','90','A room assigned to one person. May have one or more beds.',0,1),
	(2, 'Double','100','A room assigned to two people. May have one or more beds.',1,1),
	(3, 'Triple','110','A room assigned to three people. May have two or more beds.',0,0),
	(4, 'Quad','115','A room assigned to four people. May have two or more beds.',1,1),
	(5, 'Queen','125','A room with a queen-sized bed. May be occupied by one or more people.',0,1),
	(6, 'King','130','A room with a king-sized bed. May be occupied by one or more people.',0,1),
	(7, 'Twin','125',' A room with two beds. May be occupied by one or more people.',1,1),
	(8, 'Double-double','140',' A room with two double (or perhaps queen) beds. May be occupied by one or more people.',1,1),
	(9, 'Studio','115',' A room with a studio bed – a couch that can be converted into a bed. May also have an additional bed.',0,1);
	


INSERT INTO hotel.hotel_database.guests
(guest_id, guest_first_name, guest_last_name,guest_gender,
guest_contact_number, guest_email, guest_credit_card,
guest_id_proof, addresses_address_id)
VALUES 
	(1,'James','Butt','m','504-621-8927','jbutt@gmail.com','5555555555554444','/images/drivingLicense1023',21),
	(2,'Josephine','Darakjy','m','810-292-9388','josephine_darakjy@darakjy.org','5105105105105100','/images/passport45612',22),
	(3,'Art','Venere','f','856-636-8749','art@venere.org','4111111111111111','/images/drivingLicense4889',23),
	(4,'Lenna','Paprocki','f','907-385-4412','lpaprocki@hotmail.com','4012888888881881','/images/drivingLicense8945',24),
	(5,'Donette','Foller','m','513-570-1893','donette.foller@cox.net','378282246310005','/images/passport7896',25);
	



INSERT INTO hotel.hotel_database.hotel_chain
(hotel_chain_id, hotel_chain_name, hotel_chain_contact_number,
hotel_chain_email, hotel_chain_website, hotel_chain_head_office_address_id) 
VALUES
	(1,'Best Western Hotels','456-865-8956','bw123@gmail.com','https://www.bestwestern.com/',1),
	(2,'China Town Hotels','110-526-5647','chinatown123@gmail.com','https://www.chinatown.com/',2),
	(3,'Elite Hotels','546-874-6547','elite.tea213@gmail.com','https://www.elitendhe.com/',3),
	(4,'Cosmopolitan Hotels','852-741-9765','cosmo.hotels123@gmail.com','https://www.cosmopolitan.com/',4),
	(5,'Prestige Hotels','657-784-3647','prestige2453@gmail.com','https://www.prestige.com/',5);
	

INSERT INTO hotel.hotel_database.hotel
(hotel_id, hotel_name, hotel_contact_number, hotel_email,
hotel_website_address, hotel_description, hotel_floor_count,
hotel_room_capacity, hotel_chain_id, addresses_address_id,
star_ratings_star_rating, check_in_time, check_out_time)
	VALUES 
		(1,'ADAMS INN','202-745-3600','adamsInn@gmail.com','http://adamsinn.com/','A Great Hotel For Vacations.',2,26,1,6,4,'12:00:00','23:00:00'),
		(2,'AKA WHITE HOUSE','202-904-2500','akawhitehouse@gmail.com','http://www.stayaka.com/locations/white_house','A Great Hotel With Best Views.',6,142,1,7,5,'14:00:00','11:00:00'),
		(3,'HOTEL HIVE','202-849-8499','hotelhive@gmail.com','http://www.hotelhive.com','A Fantastic Hotel With Best Prices.',4,50,2,8,4,'12:00:00','23:00:00'),
		(4,'AMERICAN GUEST HOUSE','202-588-1180','americanGuestHouse@gmail.com','http://www.americanguesthouse.com/','A Nice Hotel Near Sea.',2,12,2,9,5,'13:00:00','23:00:00'),
		(5,'ASANTE SANA INN','202-570-1281','asanteSanaInn@gmail.com',NULL,'A Nice Hotel Near Nature.',1,6,3,10,4,'7:00:00','22:00:00'),
		(6,'AVENUE SUITES HOTEL','202-333-8060','avenueSuitesHotel@gmail.com','https://www.avenuesuitesgeorgetown.com/','A 2-mile drive from Besh Ba Gowah Archaeological Park.',7,124,4,11,5,'09:00:00','22:00:00'),
		(7,'BEACON HOTEL AND CORPORATE QUARTERS','202-296-2100','beaconHotelAndCorporateQuarters@gmail.com','http://www.beaconhotelwdc.com/','A 3-mile drive from Fairview Park.',4,60,5,12,4,'11:00:00','22:00:00'),
		(8,'GEORGETOWN INN WEST END','547-876-5422','georgetownInnWestEnd@gmail.com','https://www.georgetowninnwestend.com/','A 4-mile drive from Conestoga Mall',5,76,6,13,3,'12:00:00','23:00:00');		
		
	
INSERT INTO hotel.hotel_database.rooms
(room_id, room_number, rooms_type_rooms_type_id, hotel_hotel_id)
 VALUES 
	(1,100,1,1),
	(2,101,1,1),
	(3,102,2,1),
	(4,103,2,1),
	(5,104,3,1),
	(6,105,4,1),
	(7,106,5,1),
	(8,107,5,1),
	(9,108,6,1),
	(10,109,6,1),
	(11,110,6,1),
	(12,121,2,2),
	(13,122,3,2),
	(14,123,4,2),
	(15,124,5,2),
	(16,125,1,3),
	(17,126,1,3),
	(18,127,2,3),
	(19,128,2,3),
	(20,129,3,3),
	(21,70,3,4),
	(22,71,5,4),
	(23,72,6,4),
	(24,73,6,4),
	(25,74,7,4),
	(26,75,7,4),
	(27,76,7,4),
	(28,77,8,4),
	(29,78,8,4),
	(30,79,9,4),
	(31,80,9,4),
	(32,1132,1,5),
	(33,1133,2,5),
	(34,1134,2,5),
	(35,1135,3,5),
	(36,1136,3,5),
	(37,1137,4,6),
	(38,1138,5,6),
	(39,1139,6,6),
	(40,1140,7,6);


INSERT INTO hotel.hotel_database.hotel_services
(service_id, service_name, service_description, service_cost)
 VALUES
	(1,'24-hour Room Service','There will be 24-hour Room Service to take care of customers needs',20),
	(2,'Currency Exchange','Foreign Currency Exchange facility available',40),
	(3,'Laundry','Laundry/Dry Cleaning available same day',10),
	(4,'Entertainment Room','Book and watch movies',50),
	(5,'Swimming Pool','Pool access to all the guests',60),
	(6,'Gym','24 Hours Gym',100),
	(7,'Free wireless internet access','Free Wifi',0),
	(8,'Babysitting on request','24 Hours Gym',140),
	(9,'Car Rental','24 Hours Access to Cars',200);


INSERT INTO hotel.hotel_database.employees
(employee_id, employee_first_name, employee_last_name,
employee_gender, employee_designation, employee_contact_number,employee_email,
department_department_id, addresses_address_id, hotel_hotel_id)
 VALUES 
 (1,'Jen','Fen','m','Waiter','123-789-7896','jen.rds@gmail.com',1,14,1),
 (2,'Tom','Pitt','m','Manager','565-789-7896','tom.pit@gmail.com',3,15,1),
 (3,'David','Lawrence','m','Cashier','852-789-7896','david.lawr@gmail.com',2,16,1),
 (4,'Joseph','Aniston','m','Cook','765-789-7896','joseph.anis@gmail.com',2,17,1),
 (5,'Yuki','Whobrey','f','Manager','313-288-7937','yuki_whobrey@aol.com',3,18,1),
 (6,'Fletcher','Flosi','f','Waiter','815-828-2147','fletcher.flosi@yahoo.com',1,19,2),
 (7,'Bette','Nicka','f','Manager','610-545-3615','bette_nicka@cox.net',3,20,2),
 (8,'Veronika','Inouye','f','Cashier','972-303-9197','vinouye@aol.com',2,21,2),
 (9,'Willard','Kolmetz','m','Cook','518-966-7987','willard@hotmail.com',2,22,2),
 (10,'Maryann','Royster','f','Manager','732-658-3154','mroyster@royster.com',3,23,2),
 (11,'Alisha','Slusarski','f','Waiter','715-662-6764','alisha@slusarski.com',1,24,3),
 (12,'Allene','Iturbide','f','Manager','913-388-2079','allene_iturbide@cox.net',3,25,3),
 (13,'Chanel','Caudy','m','Cashier','410-669-1642','chanel.caudy@caudy.org',2,26,3),
 (14,'Ezekiel','Chui','m','Cook','212-582-4976','ezekiel@chui.com',2,27,3),
 (15,'Willow','Kusko','m','Manager','936-336-3951','wkusko@yahoo.com',3,28,3),
 (16,'Bernardo','Figeroa','m','Waiter','614-801-9788','bfigeroa@aol.com',1,29,4),
 (17,'Ammie','Corrio','f','Manager','505-977-3911','ammie@corrio.com',3,30,4),
 (18,'Francine','Vocelka','f','Cashier','201-709-6245','francine_vocelka@vocelka.com',2,31,4),
 (19,'Ernie','Stenseth','f','Cook','732-924-7882','ernie_stenseth@aol.com',2,32,4),
 (20,'Albina','Glick','m','Manager','215-934-8655','albina@glick.com',3,33,4),
 (21,'Alishia','Sergi','f','Waiter','818-423-4007','asergi@gmail.com',1,34,5),
 (22,'Solange','Shinko','m','Manager','401-458-2547','solange@shinko.com',3,35,5),
 (23,'Jose','Stockham','m','Cashier','215-211-9589','jose@yahoo.com',2,36,5),
 (24,'Rozella','Ostrosky','f','Cook','401-960-8259','rozella.ostrosky@ostrosky.com',2,37,1),
 (25,'Valentine','Gillian','m','Manager','732-234-1546','valentine_gillian@gmail.com',3,38,5);



 INSERT INTO hotel.hotel_database.hotel_chain_has_hotel
 (hotel_chains_hotel_chain_id, hotels_hotel_id)
 VALUES
 (1,1),
 (1,2),
 (1,3),
 (2,4),
 (2,5),
 (3,6),
 (3,7),
 (4,8);


INSERT INTO hotel.hotel_database.bookings
(booking_id, booking_date, duration_of_stay, check_in_date,
check_out_date, booking_payment_type, total_rooms_booked,
hotel_hotel_id, guests_guest_id, employees_emp_id, total_amount)
 VALUES
	('1', '2017-08-08 00:00:00', '1', '2017-08-10 12:00:00', '2017-08-15 23:00:00', 'cash', '1', '1', '1', '3', '190'),
	('2', '2018-06-08 00:00:00', '2', '2018-06-08 12:00:00', '2018-06-28 23:00:00', 'card', '1', '1', '2', '1', '430'),
	('3', '2018-06-08 00:00:00', '3', '2018-06-08 12:00:00', '2018-06-18 23:00:00', 'card', '1', '1', '1', '3', '800'),
	('4', '2018-06-08 00:00:00', '2', '2018-06-08 12:00:00', '2018-06-10 23:00:00', 'card', '1', '1', '4', '1', '290'),
	('5', '2019-06-08 00:00:00', '3', '2019-06-08 12:00:00', '2019-06-11 23:00:00', 'card', '1', '1', '2', '3', '350'),
	('6', '2019-06-08 00:00:00', '1', '2019-06-08 12:00:00', '2019-06-09 23:00:00', 'card', '1', '2', '3', '3', '270'),
	('7', '2019-08-13 00:00:00', '2', '2019-06-13 12:00:00', '2019-06-15 23:00:00', 'cash', '2', '2', '5', '4', '380'),
	('8', '2020-08-10 00:00:00', '2', '2020-08-11 12:00:00', '2020-08-13 23:00:00', 'card', '1', '2', '3', '3', '550'),
	('9', '2020-08-10 00:00:00', '4', '2020-08-12 12:00:00', '2020-08-16 23:00:00', 'card', '1', '3', '4', '3', '870'),
	('10', '2020-08-14 00:00:00', '2', '2020-08-15 12:00:00', '2020-08-17 23:00:00', 'cash', '2', '3', '5', '4', '280'),
	('11', '2020-08-14 00:00:00', '3', '2020-08-16 12:00:00', '2020-08-19 23:00:00', 'cash', '1', '4', '1', '3', '590'),
	('12', '2021-08-14 00:00:00', '7', '2021-08-17 12:00:00', '2021-09-24 23:00:00', 'card', '1', '4', '2', '1', '2300'),
	('13', '2021-09-14 00:00:00', '6', '2021-09-15 12:00:00', '2021-09-21 23:00:00', 'card', '1', '4', '1', '3', '1100'),
	('14', '2021-10-14 00:00:00', '2', '2021-10-16 12:00:00', '2021-10-18 23:00:00', 'cash', '2', '5', '4', '1', '290'),
	('15', '2021-11-14 00:00:00', '1', '2021-11-17 12:00:00', '2021-11-18 23:00:00', 'cash', '3', '5', '2', '3', '350');


INSERT INTO hotel.hotel_database.rooms_booked
(rooms_booked_id, bookings_booking_id, rooms_room_id) 
VALUES 
('1', '1', '1'),
('2', '2', '2'),
('3', '2', '3'),
('4', '3', '4'),
('5', '3', '5'),
('6', '3', '6'),
('7', '4', '7'),
('8', '4', '8'),
('9', '5', '9'),
('10', '5', '10'),
('11','5','11'),
('12','6','12'),
('13','7','13'),
('14','7','14'),
('15', '11', '15'),
('16', '12', '16'),
('17', '13', '17'),
('18', '14', '18'),
('19', '14', '19'),
('20', '15', '20'),
('21', '15', '21'),
('22', '15', '22');


INSERT INTO hotel.hotel_database.hotel_services_used_by_guests 
(service_used_id, hotel_services_service_id, bookings_booking_id) 
 VALUES 
 ('1', '1', '1'),
 ('2', '2', '1'),
 ('3', '1', '2'),
 ('4', '2', '2'),
 ('5', '2', '3'),
 ('6', '3', '3'),
 ('7', '4', '3'),
 ('8', '5', '3'),
 ('9', '3', '4'),
 ('10', '4', '4'),
 ('11', '7', '4'),
 ('12', '8', '4'),
 ('13', '2', '5'),
 ('14', '9', '5'),
 ('15', '3', '6'),
 ('16', '7', '7');


 INSERT INTO hotel.hotel_database.hotel_has_service(hotels_hotel_id, hotel_services_service_id)
 VALUES
 (1,1),
 (1,2),
 (1,3),
 (1,4),
 (1,5),
 (1,6),
 (2,1),
 (2,2),
 (2,3),
 (2,7),
 (2,8),
 (2,9),
 (3,1),
 (3,2),
 (3,3),
 (3,4),
 (3,7),
 (3,8),
 (4,1),
 (4,2),
 (4,3),
 (4,6),
 (4,7),
 (4,8),
 (4,9),
 (5,1),
 (5,2),
 (5,3),
 (5,4),
 (5,5),
 (5,6),
 (5,7),
 (6,1),
 (6,2),
 (6,4),
 (6,6),
 (6,8),
 (6,9);