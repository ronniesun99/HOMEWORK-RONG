/*
1.	What is an object in SQL?
	 An object is any SQL resource, such as  schemas, journals, catalogs, tables, aliases, views, 
indexes, constraints, triggers, sequences, stored procedures, user-defined functions, 
user-defined types, global variables, and SQL packages. 

2.	What is Index? What are the advantages and disadvantages of using Indexes?
Indexes are special lookup tables that the database search engine can use to speed up data retrieval. Simply put, an index is a pointer to data in a table. 
	An index in a database is very similar to an index in the back of a book.
	An index helps to speed up SELECT queries and WHERE clauses, 
but it slows down data input, with the UPDATE and the INSERT statements. 
Indexes can be created or dropped with no effect on the data.

3.	What are the types of Indexes?
Clustered Index and Non-Clustered Index.

4.	Does SQL Server automatically create indexes when a table is created? If yes, under which constraints?
	Yes.When you define a primary key constraint on one or more columns, SQL Server automatically creates a unique, 
clustered index if a clustered index does not already exist on the table or view.
	
5.	Can a table have multiple clustered index? Why?
		No,There can be only one clustered index per table,
	because the data rows themselves can be stored in only one order.

6.	Can an index be created on multiple columns? Is yes, is the order of columns matter?
	Correct. Indexes can be composites - composed of multiple columns - and the order is important because of the leftmost principle. Reason is, that the database checks the list from left to right, and has to find a corresponding column reference matching the order defined. 

7.	Can indexes be created on views?
	Yes,Indexes can only be created on views which have the same owner as the referenced table or tables. 

8.	What is normalization? What are the steps (normal forms) to achieve normalization?
	Database Normalization is a process of organizing data to minimize redundancy (data duplication), which in turn ensures data consistency. 
	Three steps:
		1NF: No Repeating Groups
		2NF: Eliminate Redundant Data
		3NF: Eliminate Transitive Dependency

9.	What is denormalization and under which scenarios can it be preferable?
	Denormalization is a database optimization technique in which we add redundant data to one or more tables. 
This can help us avoid costly joins in a relational database.

10.	How do you achieve Data Integrity in SQL Server?
	Enforce Data Integrity by Database Constraints.
11.	What are the different kinds of constraint do SQL Server have?
	NOT NULL - Ensures that a column cannot have a NULL value
	UNIQUE - Ensures that all values in a column are different
	PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
	FOREIGN KEY - Prevents actions that would destroy links between tables
	CHECK - Ensures that the values in a column satisfies a specific condition
	DEFAULT - Sets a default value for a column if no value is specified
	CREATE INDEX - Used to create and retrieve data from the database very quickly

12.	What is the difference between Primary Key and Unique Key?
    There can be one primary key, but can contain multiple unique keys in a table.
	Primary Key does not allow null columns, but Unique Key allows null columns.
	Primary Key is a clustered index, unique key is a no-clustered index.
	The purpose of the primary key is to enforce entity integrity.The purpose of unique key is to enforce unique data.

13.	What is foreign key?
	A FOREIGN KEY is a field (or collection of fields) in one table, that refers to the PRIMARY KEY in another table.

14.	Can a table have multiple foreign keys?
	Yes.

15.	Does a foreign key have to be unique? Can it be null?
	The foreign key should be unique and non- NULL.

16.	Can we create indexes on Table Variables or Temporary Tables?
	Yes.

17.	What is Transaction? What types of transaction levels are there in SQL Server?
	Transactions are a logical unit of work. Transaction is a single recoverable unit of work that executes either completely or not at all.
	Transaction levels: Read Uncommitted (Lowest level); Read Committed; Repeatable Read; Serializable (Highest Level); Snapshot Isolation

*/


--Write queries for following scenarios
--1.	Write an sql statement that will display the name of each customer and the sum of order totals placed by that customer during the year 2002
-- Create table customer(cust_id int,  iname varchar (50)) create table order(order_id int,cust_id int,amount money,order_date smalldatetime)

create database assignment
use assignment
go

Create table customer(cust_id int,  iname varchar (50)) 
create table [order](order_id int,cust_id int,amount money,order_date smalldatetime)
select * from customer
select * from [order]

select c.iname, sum(o.amount) as order_total
from customer c
	left join [order] o
	on c.cust_id = o.cust_id
where year(o.order_date) = 2002	
group by c.iname


-- 2.  The following table is used to store information about company¡¯s personnel:
--Create table person (id int, firstname varchar(100), lastname varchar(100)) write a query that returns all employees whose last names  start with ¡°A¡±.

select id, firstname, lastname
from person
where lastname like 'A%'



--3.  The information about company¡¯s personnel is stored in the following table:
--Create table person(person_id int primary key, manager_id int null, name varchar(100)not null) The filed managed_id contains the person_id of the employee¡¯s manager.
--Please write a query that would return the names of all top managers(an employee who does not have  a manger, and the number of people that report directly to this manager.

select [name], count(manager_id) as total_num
from person
where name in (
		select [name] from person where manager_id is null)
group by [name]

--4.  List all events that can cause a trigger to be executed.
DML Statements like Insert , Delete or Update.

--5. Generate a destination schema in 3rd Normal Form.  Include all necessary fact, join, and dictionary tables, and all Primary and Foreign Key relationships.  The following assumptions can be made:
--a. Each Company can have one or more Divisions.
--b. Each record in the Company table represents a unique combination 
--c. Physical locations are associated with Divisions.
--d. Some Company Divisions are collocated at the same physical of Company Name and Division Name.
--e. Contacts can be associated with one or more divisions and the address, but are differentiated by suite/mail drop records.status of each association should be separately maintained and audited.

create schema nf


use nf
go 

create table assignment.nf.company(
	company_id int primary key identity(1,1),
	company_name varchar(50) not null
	)
create table assignment.nf.contact(
	contact_id int primary key identity(1,1),
	contact_name varchar(25) not null,
	suite_mail varchar(50)
	)
create table assignment.nf.division(
	division_id int primary key identity(1,1),
	division_name varchar(50) not null,
	company_id int not null,
	[location] varchar(25),
	contact_id int,
	foreign key(company_id) references assignment.nf.company(company_id),
	foreign key(contact_id) references assignment.nf.contact(contact_id)
	)



	
