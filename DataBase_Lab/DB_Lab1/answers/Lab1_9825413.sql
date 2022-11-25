--drop table Students;
--drop table Departments;
--drop table Teachers;

--create table Departments(
--Name varchar(60) not null,
--ID char (5) primary key,
--Budget numeric(12,2),
--Category varchar(15)
--);

--create table Teachers(
--FristName varchar(20) not null,
--LastName varchar(30) not null,
--ID char(7) primary key,
--BirthYear int,
--DepartmentID char(5),
--Salary numeric(7,2) default 10000.00,
--foreign key (DepartmentID) references Departments(ID)
--);

--create table Students(
--FirstName varchar(20) not null,
--LastName varchar(30) not null,
--StudentNumber char(7) primary key,
--BirthYear int,
--DepartmentID char(5),
--AdvisorID char(7),
--foreign key (DepartmentID) references Departments(ID),
--foreign key(AdvisorID) references Teachers(ID)
--);

--insert into Departments values(
--'Electrical & Computer Engineering Department',
--'ECE',
--1200000.00,
--'Engineering');
--insert into Departments values(
--'Physics Department',
--'P',
--1000000.00,
--'Science');
--insert into Departments values(
--'Mechanical Engineering Department',
--'ME',
--1100000.00,
--'Engineering');

--select * from Departments;

--insert into Teachers values('Hosein','Yavari',1111111,1358,'ECE',11000);
--insert into Teachers values('Fatemeh','Mousavi',1111112,1357,'ECE',14000);
--insert into Teachers values('Reza','Hasanpour',1111113,1358,'P',10000);
--insert into Teachers values('Mohammad','Kazemi',1111114,1360,'ME',13000);

select * from Teachers ;


--insert into Students values('hadis','ghafouri',9825413,1380,'ECE',1111111);
--insert into Students values('hadi','hoseini',9823563,1380,'P',1111113);
--insert into Students values('fatemeh','karimi',9783543,1378,'ECE',1111112);
--insert into Students values('hasan','rajabi',9753593,1378,'ECE',1111112);
--insert into Students values('ehsan','emami',9613583,1377,'ECE',1111111);
--insert into Students values('shamim','tavakoli',9624593,1377,'ME',1111114);


--select * from Students;


--alter table  Students add  totCred numeric(3,0) not null  default (0);


--alter table Students drop column totCred;


--create table Courses(
--ID varchar(10) not null primary key,
--Title varchar(50) not null,
--Credits numeric(2,0),
--DepartmentID char(5),
--foreign key (DepartmentID) references Departments(ID)
--);

--create table Available_Courses(
--ID varchar(10) not null primary key,
--CourseID varchar(10),
--Semester varchar(10) check(Semester in ('fall','spring')),
--Year numeric(4,0),
--TeacherID char(7),
--foreign key (CourseID) references Courses(ID),
--foreign key (TeacherID) references Teachers(ID)
--);

--create table Taken_Courses(
--CourseID varchar(10),
--StudentID char(7),
--Semester varchar(10) check(Semester in ('fall','spring')),
--Year numeric(4,0),
--Grade varchar(2),
--primary key(CourseID,StudentID,Semester,Year),
--foreign key (CourseID) references Available_Courses(ID),
--foreign key (StudentID) references Students(StudentNumber)
--);


--create table Prerequisites (
--    CourseId     varchar(10) REFERENCES Courses(ID),
--    PrereqID varchar(10) REFERENCES Courses(ID),
--    PRIMARY KEY (CourseId,PrereqID)
--);

--INSERT INTO Courses  VALUES
--  (1,'DB', 3, 'ECE'),
--  (2,'Machine', 3, 'ME'),
--  (3,'AP', 3, 'ECE'),
--  (4,'Machine Learning', 4,'ECE');
--select * from Courses;


--INSERT INTO Available_Courses  VALUES
--  (1,1,'spring', 1399, 1111111),
--  (2,2,'fall', 1398, 1111114),
--  (3,3,'fall', 1400,1111111 ),
--  (4,4,'spring',1399,1111112);

--select * from Available_Courses;

--INSERT INTO Prerequisites  VALUES
--  (1, 3),
--  (4, 3);

--INSERT INTO Taken_Courses  VALUES
--  (3,9825413, 'fall',1400,18),
--  (2,9823563, 'fall',1398,15),
--  (1,9825413, 'spring',1399,17),
--  (3,9783543, 'fall',1400,19),
--  (4,9613583, 'spring',1399,13);

--select * from Taken_Courses;


--select * from Students s inner join Departments d on 
--(s.DepartmentID = d.ID)
--where StudentNumber =9825413;


--select * 
--from Students s
--where s.StudentNumber not in(
--select StudentNumber 
--from Students 
--inner join Taken_Courses t
--on(s.StudentNumber = t.StudentID)
--inner join Courses c
--on(c.ID = t.CourseID)
--where c.Title ='DB'
--)


--select * from Students;

--select * from Taken_Courses;
--update Taken_Courses 
--set Grade = Grade +1
--where Grade is not null And
--Grade <=19;