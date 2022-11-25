use AdventureWorks2012
go

CREATE TABLE TempPersons (
    PersonID smallint primary key not null,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

insert into TempPersons values(1,'ghafouri','hadis','Isfahan','Isfahan');
select * from TempPersons ;