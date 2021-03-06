create database BookShopPublisher
Go
use BookShopPublisher
Go

CREATE TABLE Country(
Id INT PRIMARY KEY NOT NULL IDENTITY,
CountryName varchar(20),
);


CREATE TABLE Publish
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
PublishName varchar(30) NOT NULL,
CountryId INT CONSTRAINT FK_Publish_Country Foreign KEY  References Country(Id)
);

CREATE TABLE Address
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
Street varchar(20) NOT NULL default 'no street',
City varchar(20) NOT NULL,
CountryId INT CONSTRAINT FK_Address_Country Foreign KEY  References Country(Id)
);


CREATE TABLE Author
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
AuthorName varchar(30) NOT NULL,
AddressId INT CONSTRAINT Fk_Author_Address FOREIGN KEY REFERENCES Address(Id),
PublishId INT CONSTRAINT Fk_Author_Publish FOREIGN KEY REFERENCES Publish(Id)
);

CREATE TABLE Category
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
CategotyName varchar(50) NOT NULL
);

CREATE TABLE Book
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
BookName varchar(250) NOT NULL,
Description varchar(MAX) NULL,
NumberPages INT,
Price Money NOT NULL,
PublishDate Date DEFAULT GETDATE(),
AuthorId INT CONSTRAINT Fk_Book_Author FOREIGN KEY REFERENCES Author(Id),
CategoryId INT CONSTRAINT Fk_Book_Category FOREIGN KEY REFERENCES Category(Id)
);

CREATE TABLE UserProfile
(
Id INT PRIMARY KEY IDENTITY,
Email varchar(30) UNIQUE NOT NULL CHECK (Email LIKE '%@%'),
Password varchar(20) NOT NULL CHECK (LEN(Password)>6),
CONSTRAINT FK_UserProfile_Author FOREIGN KEY(Id) REFERENCES Author(Id)
);

CREATE TABLE Shop
(
Id INT PRIMARY KEY IDENTITY,
ShopName varchar(30) NOT NULL,
CountryId INT CONSTRAINT Fk_Shop_Country FOREIGN KEY REFERENCES Country(Id)
);

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
-----------INSERT VALUES--------------------------
Go
INSERT INTO Country Values
('China'),
('Poland'),
('Ukraine')
;
Go
INSERT INTO Address VALUES
('BigStreet','Vroclav',(SELECT Id FROM Country WHERE CountryName='Poland')),
('Bednarska','Varshava',(SELECT Id FROM Country WHERE CountryName='Poland')),
('Gdanska','Branevo',(SELECT Id FROM Country WHERE CountryName='Poland')),
('����','г���',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('�������','г���',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('��������','���',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('Cisy','Ninbo',(SELECT Id FROM Country WHERE CountryName='China'))

INSERT INTO Publish VALUES
('CoolPublisher',(SELECT Id FROM Country WHERE CountryName='Poland')),
('ZirkaBook',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('Ababagalamaga',(SELECT Id FROM Country WHERE CountryName='Ukraine'))

INSERT INTO Author VALUES
('Ivanov',(SELECT Id FROM Address WHERE Street='����'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('Petrov',(SELECT Id FROM Address WHERE Street='����'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('���� ����',(SELECT Id FROM Address WHERE Street='����'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('�������� �������',(SELECT Id FROM Address WHERE Street='����'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('�������� ���� ��������',(SELECT Id FROM Address WHERE Street='����'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('�������� �.',(SELECT Id FROM Address WHERE Street='Bednarska'),(SELECT Id FROM Publish WHERE PublishName='CoolPublisher')),
('������� �',(SELECT Id FROM Address WHERE Street='Bednarska'),(SELECT Id FROM Publish WHERE PublishName='CoolPublisher')),
('���� �����',(SELECT Id FROM Address WHERE Street='Gdanska'),(SELECT Id FROM Publish WHERE PublishName='CoolPublisher'))

INSERT INTO UserProfile VALUES
('ivanov@mail.ru','qwertyy')

INSERT INTO Category VALUES
('���������'),
('������'),
('������'),
('������'),
('�������'),
('����������'),
('�����')



INSERT INTO Book  VALUES
('Roksolana',NULL,100,250.5,'12.10.2005',1,1),
('Volodimyr',NULL,NULL,400.5,'10.05.2016',1,2),
('Yaroslav',NULL,200,250.5,'2.06.2017',3,5),
('���� � �� ������ ����','Something',150,25.2,'12.12.2016',3,2),
('������������ �������','���������101',110,25.5,'10.10.2015',6,2),
('������� ��������','������',110,25.5,'10.10.2016',5,3),
('����� �����','������',110,25.5,'10.10.2017',1,2),
('�������-����������','����������� ������ ������ ����� ����� ��������-���������� ������� ���������� ��� ����� ��������� ���������. ',110,25.5,'10.10.2015',2,3),
('���� � ��������','������� ���� � ��� ������ ����� ������. ',110,25.5,'10.10.2014',3,4),
('������ ���� ����','��� ��� ���� ��� ��������: ������� ������ �������� ������� ������� ����������� ����� �������� ���������� ������. ',110,25.5,'10.10.2015',4,2),
('������� ����. ����� ������!','�������-�� � ������ ����� � ����� ������ ������, � ����� ������ ��������.',120,30.5,'10.10.2017',5,5)


INSERT INTO Shop VALUES
('PolandShop',2),
('Slovo',3)

INSERT INTO Incomes VALUES
(1,11,'12.10.2017',20),
(2,14,GetDate(),20),
(1,12,GetDate(),10),
(2,13,GetDate(),5),
(2,12,GetDate(),7),
(2,14,GetDate(),15),
(2,15,GetDate(),30)

INSERT INTO Sales VALUES
(1,11,'12.10.2017',5,60),
(2,11,GetDate(),5,70.5),
(1,12,GetDate(),3,80.3),
(2,13,GetDate(),2,100),
(2,12,GetDate(),7,70.8),
(2,14,GetDate(),10,250)

