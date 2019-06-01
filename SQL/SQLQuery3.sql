--select * from Prodaks;
--select * from Prodaks where Price>10
--select * from Prodaks where Prodaks.Name like'%i%'
--select [Name],[Price]* Quantity
--select count(*) as 'Number of products' from Prodaks
--select sum([Price]*[Quantity]) as 'Total prise' from Prodaks
 --select max([Price]) as 'products' from Prodaks
 --select min([Price]) as 'products' from Prodaks
 select * from Prodaks where month ([DataIn])=10