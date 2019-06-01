SELECT * FROM Book
SELECT * FROM Sales
SELECT * FROM Author
SELECT * FROM Address
SELECT Book.BookName + ISNULL(Description ,'-')+ isnull (CONVERT (NVARCHAR(MAX),'-'),NumberPages) as Book FROM Book
SELECT ISNULL (Description ,'-')FROM Book
--- alias for table---
SELECT b.BookName FROM Book as b

----------WHERE--------------
SELECT * FROM Book
	WHERE BookName LIKE 'П%'

SELECT * FROM Book
	WHERE BookName LIKE  N'V%1%'

SELECT * FROM Book
	WHERE BookName BETWEEN 'A%' AND 'S%'

SELECT * FROM Book
	WHERE Prise>10 AND Prise <200

SELECT * FROM Book
	WHERE Prise BETWEEN 10 AND 200

SELECT * FROM Book WHERE PublishDate >'10.10.20016'

SELECT * FROM Book WHERE PublishDate > DATEADD("D",-30, GETDATE())

SELECT * FROM Book WHERE Book.Authorid= (SELECT TOP(1) id FROM Authorid WHERE AuthoridName = 'Ivanov')

-------------------------------OREDER BY--------------------

SELECT * FROM Book OREDER BY Prise DESC


--------------------------------FRTCH ----- TAKE ONLY ....ROM  ------------

SELECT * FROM Book ORDER BY Prise
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY


SELECT * FROM Author ORDER BY AuthorName


----------------------sum---------------------------------
SELECT SUM(Price) FROM Book

---------------------COUNT()------------------------------
SELECT COUNT(*) FROM Book 

-------------------------------AVG------------------------
SELECT AVG(Pricr) FROM Book

----------------------MAX--MIN----------------------------

SELECT MIN(Price) FROM Book
SELECT MAX(Price) FROM Book


---------------------GRUP B-------------------------------
SELECT AuthorId,CategoryId,AVG(Price),MAX(Price) FROM Book
GROUP BY AuthorId , CategoryId



-------------------HAVING---------------------------------

---------------------JOIN---------------------------------Обєднання таблиць  тобто виви д спільних даних
SELECT * FROM Book, Author
WHERE Book.AuthorId=Author.Id 

SELECT  BookName, AuthorName FROM Book JOIN Author on Book.AuthorId=Author.Id 

-------------------RIGHT OUTER JOIN------------------------------
SELECT  BookName, AuthorName FROM Book RIGHT OUTER JOIN Author on Book.AuthorId=Author.Id 
----------------------LEFT OUTER JOIN----------------------------
SELECT  BookName, AuthorName FROM Book LEFT OUTER JOIN Author on Book.AuthorId=Author.Id 


 SELECT BookName,ShopName,AuthorName,CountryName
	FROM((((Book LEFT OUTER JOIN Sales on Book.Id=Sales.BookId)
	LEFT OUTER JOIN Author on Book.AuthorId=Author.Id)
	LEFT OUTER JOIN Address on Author.AddressId=Address.Id)
	LEFT OUTER JOIN Country on Address.CountryId=Country.Id)
	LEFT OUTER JOIN Shop on Shop.CountryId=Shop.Id

---------------------------EXISTS------------------------------------






SELECT  AVG(SalePrice) ,MAX(SalePrice),COUNT(Amount) FROM Sales

SELECT * FROM Book WHERE PublishDate > DATEADD("D",-7, GETDATE())

--SELECT BookName,AuthorName,SalesId
--	FROM(Book LEFT OUTER JOIN Author on Book.AuthorId=Author.Id)
--	LEFT OUTER JOIN Sales on Book.Id=Sales.BookId

--SELECT DISTINCT AuthorName FROM Book WHERE NOT EXISTS (SELECT BookId FROM Sales WHERE Sales.BookId=Book.Id )
--	FROM(Book LEFT OUTER JOIN Author on Book.AuthorId=Author.Id)


SELECT DISTINCT AuthorName FROM Book JOIN Author on Book.AuthorId=Author.Id WHERE NOT EXISTS (SELECT BookId FROM Book LEFT OUTER JOIN Author on Book.AuthorId=Author.Id))