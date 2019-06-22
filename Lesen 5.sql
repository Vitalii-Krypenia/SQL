go
--create function GetPrice() returns money
as
begin
declare @price money
select @price = Price from Book where Id = 4
return @price
end
go

--drop function GetPrice
go
print (dbo.GetPrice())

create table Test_1(
Id int primary key identity,
Name nvarchar(Max),
Price as dbo.GetPrice()
)
drop table Test_1
go
insert into Test_1 values('Frirst')

select * from Test_1
go
create function GetCategoryProfit (@Category nvarchar) returns int
as
begin
declare @Amount  int ;
declare @CName nvarchar;
select  @Amount=Sum(Amount) from Sales where
 BookId in(select BookId from Category where CategotyName = @CName) ;
 return @Amount;
end
go
print (dbo.GetCategoryProfit('??????'))

go
create function GetBooks (@authorId int) returns table
as
return(
select * from Book where AuthorId = @authorId)
go
select * from GetBooks(1)
go

--create function GetBookId(@ctgName nvarchar(MAX))returns table
--as
--return 
--(
--select Book.Id from Book INNER JOIN Category ON Book.CategoryId=Category.Id and Category.CategotyName=
--)
---------------------------------------------------------------------------------------------------------------
go
create trigger SaleInsert on Sales
instead of INSERT
as
---inserted
---@@rowcount
begin

declare @bookId INT;
select @bookId = BookId FROM inserted
 

--declare @salesAmount int, @incomesAmount INT;
--select @salesAmount = SUM(Amount) FROM Sales Where BookId = @bookId;
--select @incomesAmount = SUM(Amount) FROM Incomes Where BookId = @bookId;
--declare @existsBooks int = @incomesAmount - @salesAmount;
 declare @Prise money;
select @Prise = Price from Book; 
declare @amountToSale INT;
select @amountToSale = Amount FROM inserted
if(@amountToSale > @Prise)
    raiserror('OK', 0,1, @@rowcount)
else 
	begin
	select @Prise=@Prise*1.1;
	 raiserror('DONT GOOD', 0,1, @@rowcount)
end
end

--drop trigger SaleInsert
--create fulltext catalog Twx_BookId on dbo.Book(id);;
--go
--create fulltext index on dbo.Book(BookName, Deskription)
--key index ui_BookId
--on Text_Book;
--go
--key index PK_Book_321EC075769CD33


go

declare book_cursor cursor
 for select  Book.BookName from Book 
 open book_cursor;
 fetch next from Category.CategotyName from Category
 open category_cursor;
 while @@FETCH_STATUS = 0
 begin
 fetch next from category_cursor;
 end
 fetch next from book_cursor;
 deallocate book_cursor;
 deallocate category_cursor;

 --declare @fname varchar(50), @p money;

 --fetch next from book_cursor into @fname, @p;
 ---- display the variables values
 --print 'Name: '+@fname+ '  ціна '+convert(nvarchar(10),@p)
 --while @@FETCH_STATUS = 0
 --begin
 --fetch next from book_cursor into @fname, @p;
 --print 'Name: '+@fname+ '  ціна '+convert(nvarchar(10),@p)
 --end
 --close book_cursor;
 --deallocate book_cursor;
 go