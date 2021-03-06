--1.	In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why?
		Join,bacause join executes faster than subquery.
--2.	What is CTE and when to use it?
		CTE is Common Table Expressions.
--3.	What are Table Variables? What is their scope and where are they created in SQL Server?
		The table variable is a special type of the local variable that helps to store data temporarily, similar to the temp table in SQL Server. 
--4.	What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
The DELETE command is used to remove rows from a table.
A WHERE clause can be used to only remove some rows.
TRUNCATE removes all rows from a table. 
The operation cannot be rolled back and no triggers will be fired. 
TRUNCATE TABLE is faster and uses fewer system and transaction log resourcesas a DELETE.
--5.	What is Identity column? How does DELETE and TRUNCATE affect it?
An identity column is a columnin a database table that is made up of values generated by the database. 
This is much like an AutoNumber field.
Delete retains the identity and does not reset it to the seed value.
Truncate command reset the identity to its seed value.
--6.	What is difference between ??delete from table_name?? and ??truncate table table_name???
??delete from table_name?? is used to delect existing records in table_name by rows.
??truncate table table_name?? delect all the data inside table_name,but table is still exist.



use Northwind
go

--1.	List all cities that have both Employees and Customers.
select distinct City
from Employees 
where city in 
		(select city from Customers)

--2.	List all cities that have Customers but no Employee.
--a.	Use sub-query
select distinct City
from Customers
where city  not in 
		(select city from Employees)

--b.	Do not use sub-query
select distinct a.City
from customers a
	left join Employees b
		on a.city = b.City
where b.EmployeeID is null

--3.	List all products and their total order quantities throughout all orders.
select 
	ProductID ,
	count(quantity) as [total order quantities]
from [Order Details]
group by ProductID

--4.	List all Customer Cities and total products ordered by that city.
select 
	a.City,
	count(c.productid) as total_product_type,
	sum(c.quantity) as total_pruduct_quantity
from Customers a
	left join Orders b
		on a.CustomerID = b.CustomerID
	left join [Order Details] c
		on b.OrderID = c.OrderID
group by a.City

--5.	List all Customer Cities that have at least two customers.
--a.	Use union
select 
	city, 
	count(CustomerID) as count_customers
from Customers
group by city
having count(CustomerID) > 2
union
select 
	city, 
	count(CustomerID) as count_customers
from Customers
group by city
having count(CustomerID) = 2

--b.	Use sub-query and no union
select 
	city, 
	count(CustomerID) as count_customers
from Customers
group by city 


--6.	List all Customer Cities that have ordered at least two different kinds of products.
select 
	a.shipCity,
	count(distinct b.ProductID) as total_products
from orders a
	left join [Order Details] b
		on a.OrderID = b.OrderID
group by a.ShipCity
having count(distinct b.productid) >= 2
order by a.ShipCity

--7.	List all Customers who have ordered products, but have the ??ship city?? on the order different from their own customer cities.

select distinct a.Customerid, a.ContactName,b.ShipCity, a.City
from   Customers a
	left join Orders b
		on a.CustomerID = b.CustomerID
where b.ShipCity!=a.City


--8.	List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
select top 5 
	ProductID, 
	sum(Quantity) as sum_quantity,
	--sum(UnitPrice*Quantity) as total_price,
	--avg(unitprice),
	sum(UnitPrice*Quantity)/SUM(quantity) as Avg_Price
from [Order Details]
group by ProductID
order by sum_quantity desc


Select
	y.ProductID,
	--x.Avg_Price,
	y.ShipCity,
	y.total_quantity,
	y.popularity_rank
from
(
select 
	a.productid,
	b.ShipCity, 
	sum(a.Quantity) as total_quantity,
	RANK() over (
			partition by a.productid
			order by sum(a.Quantity) desc
			) as popularity_rank

from [Order Details] a
	left join orders b
		on a.OrderID = b.OrderID
where a.ProductID in (
						SELECT PRODUCTID FROM
						(
						select top 5 
								ProductID, 
								sum(Quantity) as sum_quantity,
								sum(UnitPrice*Quantity)/SUM(quantity) as Avg_Price
						from [Order Details]
						group by ProductID
						order by sum_quantity desc
						)X
					)
group by a.ProductID, b.ShipCity
--order by a.ProductID,b.ShipCity
) Y
where y.popularity_rank = 1

--9.	List all cities that have never ordered something but we have employees there.
--a.	Use sub-query
select city
from Employees 
where City not in (select shipcity  from Orders)

--b.	Do not use sub-query
select  a.OrderID,a.ShipCity, b.City
from orders a
	right join employees b
		on a.shipcity = b.city
where a.OrderID is null
--10.	List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)

--11. How do you remove the duplicates record of a table?
with cte as(
	select name1, name2,name3,
		ROW_NUMBER() over(
			partition by name2,name3
			order by name2,name3
		) row_num
	from TableName
)
delect from cte
where row_number>1
--12. Sample table to be used for solutions below- Employee ( empid integer, mgrid integer, deptid integer, salary integer) Dept (deptid integer, deptname text)
-- Find employees who do not manage anybody.
select empid
from Emploee
where empid is not in (select distinct mgrid from Employee)
--13. Find departments that have maximum number of employees. (solution should consider scenario having more than 1 departments that have maximum number of employees). Result should only have - deptname, count of employees sorted by deptname.
select deptname,count(empid) as num_of_emp
from dept a left join Employee 
		on a.deptid = b.deptid
group by deptname
--14. Find top 3 employees (salary based) in every department. Result should have deptname, empid, salary sorted by deptname and then employee with high to low salary.

