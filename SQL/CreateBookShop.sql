create database VitaliiBookShopPublisher
Go
use VitaliiBookShopPublisher
Go

CREATE TABLE Country(
Id INT PRIMARY KEY NOT NULL IDENTITY,
CountryName nvarchar(20),
);
--DROP TABLE Country


CREATE TABLE Publish
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
PublishName nvarchar(30) NOT NULL,
CountryId INT CONSTRAINT FK_Publish_Country Foreign KEY  References Country(Id)
);
--DROP TABLE Publish

CREATE TABLE Address
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
Street nvarchar(20) NOT NULL default 'no street',
City nvarchar(20) NOT NULL,
CountryId INT CONSTRAINT FK_Address_Country Foreign KEY  References Country(Id)
);
--DROP TABLE Address


CREATE TABLE Author
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
AuthorName varchar(30) NOT NULL,
AddressId INT CONSTRAINT Fk_Author_Address FOREIGN KEY REFERENCES Address(Id),
PublishId INT CONSTRAINT Fk_Author_Publish FOREIGN KEY REFERENCES Publish(Id)
);
--DROP TABLE Author

CREATE TABLE Category
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
CategotyName nvarchar(50) NOT NULL
);
--DROP TABLE Category

CREATE TABLE Book
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
BookName nvarchar(250) NOT NULL,
Description varchar(MAX) NULL,
NumberPages INT,
Price Money NOT NULL,
PublishDate Date DEFAULT GETDATE(),
AuthorId INT CONSTRAINT Fk_Book_Author FOREIGN KEY REFERENCES Author(Id),
CategoryId INT CONSTRAINT Fk_Book_Category FOREIGN KEY REFERENCES Category(Id)
);
--DROP TABLE Book

CREATE TABLE UserProfile
(
Id INT PRIMARY KEY IDENTITY,
Email nvarchar(30) UNIQUE NOT NULL CHECK (Email LIKE '%@%'),
Password nvarchar(20) NOT NULL CHECK (LEN(Password)>6),
CONSTRAINT FK_UserProfile_Author FOREIGN KEY(Id) REFERENCES Author(Id)
);
--DROP TABLE UserProfile

CREATE TABLE Shop
(
Id INT PRIMARY KEY IDENTITY,
ShopName nvarchar(30) NOT NULL,
CountryId INT CONSTRAINT Fk_Shop_Country FOREIGN KEY REFERENCES Country(Id)
);
--DROP TABLE Shop

CREATE TABLE Incomes
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
ShopId INT NOT NULL,
BookId INT NOT NULL,
DateIncomes Date NOT NULL,
Amount INT NOT NULL,
CONSTRAINT Fk_Incomes_Shop Foreign Key (ShopId) REFERENCES Shop(Id),
CONSTRAINT Fk_Incomes_Book Foreign Key (BookId) REFERENCES Book(Id),
);
--DROP TABLE Incomes
CREATE TABLE Sales
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
ShopId INT NOT NULL,
BookId INT NOT NULL,
DateSale Date NOT NULL,
Amount INT NOT NULL,
SalePrice money NOT NULL,
CONSTRAINT Fk_Sales_Shop Foreign Key (ShopId) REFERENCES Shop(Id),
CONSTRAINT Fk_Sales_Book Foreign Key (BookId) REFERENCES Book(Id),
);
--DROP TABLE Sales

-----------INSERT VALUES--------------------------
Go
INSERT INTO Country Values
(N'China'),
(N'Poland'),
(N'Ukraine')
;
Go
INSERT INTO Address VALUES
(N'BigStreet',N'Vroclav',(SELECT Id FROM Country WHERE CountryName=N'Poland')),
(N'Bednarska',N'Varshava',(SELECT Id FROM Country WHERE CountryName=N'Poland')),
(N'Gdanska',N'Branevo',(SELECT Id FROM Country WHERE CountryName=N'Poland')),
(N'Миру',N'Рівне',(SELECT Id FROM Country WHERE CountryName=N'Ukraine')),
(N'Соборна',N'Рівне',(SELECT Id FROM Country WHERE CountryName=N'Ukraine')),
(N'Хрещатик',N'Київ',(SELECT Id FROM Country WHERE CountryName=N'Ukraine')),
(N'Cisy',N'Ninbo',(SELECT Id FROM Country WHERE CountryName=N'China'))

INSERT INTO Publish VALUES
(N'CoolPublisher',(SELECT Id FROM Country WHERE CountryName=N'Poland')),
(N'ZirkaBook',(SELECT Id FROM Country WHERE CountryName=N'Ukraine')),
(N'Ababagalamaga',(SELECT Id FROM Country WHERE CountryName=N'Ukraine'))

INSERT INTO Author VALUES
(N'Ivanov',(SELECT Id FROM Address WHERE Street=N'Миру'),(SELECT Id FROM Publish WHERE PublishName=N'ZirkaBook')),
(N'Petrov',(SELECT Id FROM Address WHERE Street=N'Миру'),(SELECT Id FROM Publish WHERE PublishName=N'ZirkaBook')),
(N'Верн Жюль',(SELECT Id FROM Address WHERE Street=N'Миру'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
(N'Воронцов Николай',(SELECT Id FROM Address WHERE Street=N'Миру'),(SELECT Id FROM Publish WHERE PublishName=N'ZirkaBook')),
(N'Андерсен Ханс Кристиан',(SELECT Id FROM Address WHERE Street=N'Миру'),(SELECT Id FROM Publish WHERE PublishName=N'ZirkaBook')),
(N'Романова М.',(SELECT Id FROM Address WHERE Street=N'Bednarska'),(SELECT Id FROM Publish WHERE PublishName=N'CoolPublisher')),
(N'Скоттон Р',(SELECT Id FROM Address WHERE Street=N'Bednarska'),(SELECT Id FROM Publish WHERE PublishName=N'CoolPublisher')),
(N'Фани Марсо',(SELECT Id FROM Address WHERE Street=N'Gdanska'),(SELECT Id FROM Publish WHERE PublishName=N'CoolPublisher'))

INSERT INTO UserProfile VALUES
(N'ivanov@mail.ru','qwertyy')

INSERT INTO Category VALUES
(N'Історичні'),
(N'Наукові'),
(N'Дитячі'),
(N'Дорослі'),
(N'Художні'),
(N'Фантастика'),
(N'Поезія')



INSERT INTO Book  VALUES
(N'Roksolana',NULL,100,250.5,N'12.10.2005',1,1),
(N'Volodimyr',NULL,NULL,400.5,N'10.05.2016',1,2),
(N'Yaroslav',NULL,200,250.5,N'2.06.2017',3,5),
(N'Ігри у які грають люди',N'Something',150,25.2,N'12.12.2016',3,2),
(N'Психологічний помічник',N'Психологія101',110,25.5,N'10.10.2015',6,2),
(N'Снежная королева',N'Сказка',110,25.5,N'10.10.2016',5,3),
(N'Белий мишка',N'Сказка',110,25.5,N'10.10.2017',1,2),
(N'Милашки-очаровашки',N'Миниатюрная книжка «Белый мишка» серии «Милашки-очаровашки» создана специально для самых маленьких читателей. ',110,25.5,N'10.10.2015',2,3),
(N'Шмяк и пингвины',N'Котенок Шмяк и его друзья живут весело. ',110,25.5,N'10.10.2014',3,4),
(N'Рассел ищет клад',N'Что вас ждет под обложкой: Однажды ворона принесла Расселу изрядно потрепанную карту сокровищ Лягушачьей низины. ',110,25.5,N'10.10.2015',4,2),
(N'Котенок Шмяк. Давай играть!',N'Наконец-то к котёнку Шмяку в гости пришли друзья, и можно вместе поиграть.',120,30.5,N'10.10.2017',5,5)


INSERT INTO Shop VALUES
('PolandShop',2),
('Slovo',3)

INSERT INTO Incomes VALUES
(1,11,'12.10.2017',20),
(2,10,GetDate(),20),
(1,9,GetDate(),10),
(2,8,GetDate(),5),
(2,7,GetDate(),7),
(2,6,GetDate(),15),
(2,5,GetDate(),30)

INSERT INTO Sales VALUES
(1,11,'12.10.2017',5,60),
(2,11,GetDate(),5,70.5),
(1,10,GetDate(),3,80.3),
(2,9,GetDate(),2,100),
(2,7,GetDate(),7,70.8),
(2,5,GetDate(),10,250)

