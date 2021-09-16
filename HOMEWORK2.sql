1.	What is a result set?
An SQL result set is a set of rows from a database, as well as metadata about the query such as the column names, and the types and sizes of each column. 

2.	What is the difference between Union and Union All?
UNION and UNION ALL are SQL operators used to concatenate 2 or more result sets.
UNION: only keeps unique records
UNION ALL: keeps all records, including duplicates

3.	What are the other Set Operators SQL Server has?
INTERSECT and EXCEPT.

4.	What is the difference between Union and Join?
Join:
(1)	It combines data from many tables based on a matched condition between them.
(2)	It combines data into new columns.
(3)	Number of columns selected from each table may not be same.
(4)	Datatypes of corresponding columns selected from each table can be different.
(5)	It may not return distinct columns.
Union:
1)	Union combines the result-set of two or more SELECT statements.
2)	It combines data into new rows.
3)	Number of columns selected from each table should be same.
4)	Datatypes of corresponding columns selected from each table should be same.
5)	It returns distinct rows.

5.	What is the difference between INNER JOIN and FULL JOIN?
Inner join returns only the matching rows between both the tables, non-matching rows are eliminated. Full Join returns all rows from both the tables (left & right tables), including non-matching rows from both the tables.

6.	What is difference between left join and outer join?
Left join is one kind of outer join, outer join has other two kind of join, right join and full join.

7.	What is cross join?
A cross join returns the Cartesian product of the sets of records from the two joined tables. Thus, it equates to an inner join where the join-condition always evaluates to True.

8.	What is the difference between WHERE clause and HAVING clause?
WHERE clause is used to filter the records from the table based on the specified condition, so it can be used without group by clause, it cannot contain aggregate function.
HAVING clause is used to filter record from the groups based on the specified condition. so it must be used out group by clause, it contain aggregate function.

9.	Can there be multiple group by columns?
Yes.


use AdventureWorks2019
go

--1
select count(ProductID)
from Production.Product

--2
select count(ProductSubcategoryID)
from Production.Product


--3
select ProductSubcategoryID, count(ProductSubcategoryID) as CountedProducts
from Production.Product
group by ProductSubcategoryID

--4
select count(ProductID)
from Production.Product
where ProductSubcategoryID is null

--5
select ProductID, sum(Quantity) as Sum_Quantity
from Production.ProductInventory
group by ProductID

--6
select ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having SUM(Quantity)<100

--7
select Shelf, ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by Shelf, ProductID 
having SUM(Quantity)<100

--8
select
	ProductID,
	avg(quantity) as TheAvg
from
	Production.ProductInventory
where 
	LocationID = 10
group by 
	ProductID

--9
select
	ProductID,
	Shelf,
	avg(quantity) as TheAvg
from
	Production.ProductInventory
group by 
	ProductID,
	Shelf

--10
select
	ProductID,
	Shelf,
	avg(quantity) as TheAvg
from
	Production.ProductInventory
where Shelf != 'N/A'
group by 
	ProductID,
	Shelf

--11
select 
	Color,
	Class,
	count(1) as TheCount,
	AVG(ListPrice)
from 
	Production.Product
where 
	Color is not null
	and Class is not null
group by 
	Color,
	Class

--12
select
	c.[Name] as Country,
	s.[Name] as Province	
from 
	Person.CountryRegion C
	full join Person.StateProvince S
		on c.CountryRegionCode = s.CountryRegionCode

--13
select
	c.[Name] as Country,
	s.[Name] as Province	
from 
	Person.CountryRegion C
	full join Person.StateProvince S
		on c.CountryRegionCode = s.CountryRegionCode
where c.Name in ( 'Germany', 'Canada')

use Northwind
go

--14
select 
	d.ProductID,
	o.OrderDate,
	p.ProductName
from dbo.Orders o
	left join dbo.[Order Details] d
		on o.OrderID = d.OrderID
	left join dbo.Products p
		on d.ProductID = p.ProductID
where o.OrderDate >= DATEADD(year,-25,getdate())

--15
select TOP 5
	ShipPostalCode,
	count(1) as order_count 
from
	dbo.Orders
where ShipPostalCode is not null
group by ShipPostalCode
order by order_count desc

--16
select TOP 5
	ShipPostalCode,
	count(1) as order_count 
from
	dbo.Orders
where OrderDate >= DATEADD(year,-20,getdate())
	and ShipPostalCode is not null
group by ShipPostalCode
order by order_count desc

--17
select 
	ShipCity,
	count(CustomerID) as count_customers
from
	dbo.Orders
group by ShipCity

--18
select 
	ShipCity,
	--count(distinct CustomerID) as count_customers_distinct,
	count(CustomerID) as count_customers
from
	dbo.Orders
group by ShipCity
having count(CustomerID) > 10
order by count_customers desc

--19
select 
	c.ContactName,
	o.OrderDate
from 
	dbo.Customers c
	right join dbo.Orders o
		on c.CustomerID = o.CustomerID
where o.OrderDate > '01/01/1998' 
order by o.OrderDate

--20
select 
	c.ContactName,
	max(o.OrderDate) as recent_order
from 
	dbo.Customers c
	right join dbo.Orders o
		on c.CustomerID = o.CustomerID
group by c.ContactName



--21
select 
	c.ContactName,
	sum(d.Quantity) as count_products
from
	dbo.Customers c
	left join dbo.Orders o
		on c.CustomerID = o.CustomerID
	left join dbo.[Order Details] d
		on o.OrderID = d.OrderID
group by c.ContactName

--22
select 
	o.CustomerID,
	sum(d.Quantity) as count_products
from
	dbo.Orders o
	left join dbo.[Order Details] d
		on o.OrderID = d.OrderID
group by o.CustomerID
having sum(d.Quantity) > 100
order by count_products 

--23
select 
	a.CompanyName as [Supplier Company Name],
	e.CompanyName as [shipping Company Name]
from
	dbo.Suppliers a
	cross join dbo.Shippers e


-- Alternatively -----
select 
	a.CompanyName as [Supplier Company Name],
	e.CompanyName as [shipping Company Name]
from
	dbo.Suppliers a
	left join dbo.Products b
		on a.SupplierID = b.SupplierID
	left join dbo.[Order Details] c
		on b.ProductID = c.ProductID
	left join dbo.Orders d
		on  c.OrderID = d.OrderID
	left join dbo.Shippers e
		on d.ShipVia = e.ShipperID
group by a.CompanyName, e.CompanyName
order by a.CompanyName


--24
select 
	a.OrderDate,
	c.ProductName
from
	dbo.Orders a
	left join dbo.[Order Details] b
		on a.OrderID = b.OrderID
	left join dbo.Products c
		on b.ProductID = c.ProductID
group by a.OrderDate,c.ProductName
order by a.OrderDate

--25
select 
	count(EmployeeID) as count_employee,
	--FirstName,
	--LastName,
	Title
from dbo.Employees
group by Title

--26
select 
	count(EmployeeID) as count_employees,
	ReportsTo
from
	dbo.employees
group by ReportsTo
having count(EmployeeID) > 2

--27
select 
	a.City as [Customer City],
	a.ContactName as [Customer Name],
	b.City as [Supplier City],
	b.ContactName as [Supplier Name]
from dbo.Customers a
	cross join dbo.Suppliers b
order by [Customer City]

--28
select 
	F1.T1,
	F2.T2
from F1
	inner join F2
	on F1.T1 = F2.T2
Result:  F1.T1  F2.T2
			2	2
			3	3

--29
select 
	F1.T1,
	F2.T2
from F1
	left join F2
	on F1.T1 = F2.T2
Result:  F1.T1  F2.T2
			1	null
			2	2
			3	3


	
	





