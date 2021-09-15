use adventureworks2019
go

--1--
select 
	ProductID, [Name],Color, ListPrice
from
	Production.Product

--2--
select 
	ProductID, [Name],Color, ListPrice
from
	Production.Product
where
	ListPrice = 0

--3--
select 
	ProductID, [Name],Color, ListPrice
from
	Production.Product
where
	Color is Null

--4--
select 
	ProductID, [Name],Color, ListPrice
from
	Production.Product
where
	Color is not Null

--5--
select 
	ProductID, [Name],Color, ListPrice
from
	Production.Product
where
	Color is not Null and ListPrice > 0 

--6--
select [Name], Color
from
	Production.Product
where
	Color is not Null

--7--
select [Name], Color
from
	Production.Product 
where
	Color in ('Black', 'Silver')
	--and Color like '%[C]%'

--8
select
	ProductID, [Name]
from
	Production.Product
where
	ProductID between 400 and 500

--9
select
	ProductID, [Name], Color
from
	Production.Product
where Color in('Black', 'Blue')

--10
select [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[ModifiedDate]
from
	Production.Product
where [Name] like '[S]%'

--11
select
	[Name], ListPrice
from
	Production.Product
where [Name] like '[S]%'
      and (ListPrice = 0 or ListPrice = 53.99)
order by [Name]

--12
select
	[Name], ListPrice
from
	Production.Product
where [Name] like '[a, s]%'
order by [Name]

--13
select [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[ModifiedDate]
from Production.Product
where 
--[Name] like 'spo%' 
--	and [Name] like '___[^k]%'
	[Name] like 'spo[^k]%' 
order by [Name]

--14
select distinct color
from Production.Product
order by color desc

--15





