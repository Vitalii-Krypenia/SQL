create database VitaliiShop
use VitaliiShop

create table Catrgory(
id int not null primary key,
CategoryName nvarchar(max) not null
);

create table Products(
id int primary key not null,
[Name] nvarchar(max) not null,
--Category nvarchar(max),
Price float check (Price > 1),
CategoryID int not null foreign key references Catrgory(id)
);


--drop table Catrgory
--drop table Products
--drop database VitaliiShop

create table Regesers(
id int not null primary key,
RegesersName nvarchar(max) not null
)

create table Films(
id int primary key not null,
FilmsName nvarchar(max) not null,
RegesersID int not null foreign key references Regesers(id)
)

drop table Regesers
drop table Films
