--database_01
create database ProjectManage

create schema pm

create table ProjectManage.pm.HeadOffice(
	officeid int primary key,
	name varchar(50) not null,
	country varchar(20),
	address varchar(100),
	phone_num varchar(10),
	director varchar(25))

create table pm.Projects(
	project_code int primary key identity,
	title varchar(50),
	officeid int not null,
	start_date datetime,
	end_date datetime,
	budget int,
	in_change_name varchar(25),
	foreign key(officeid) references pm.HeadOffice(officeid)
	)

--database_02

create database p2p

create table lenders(
	l_id int primary key identity(1,1),
	name varchar(25),
	available_money money,
	)
--drop table lenders

create table borrowers(
	b_id int primary key identity,
	name varchar(25),
	risk_value money
	)

create table loan(
	code int primary key,
	total_money money,
	deadline_of_refund datetime,
	rate real,
	purpose char(100),
	b_id int,
	foreign key (b_id) references borrowers(b_id)
	)
create table loan_detail(
	code int primary key,
	l_id int,
	invest_money money,
	foreign key (l_id) references lenders(l_id)
	)

--database_03

create database restaurant
go

create table course(
	course_id int primary key identity,
	name varchar(25),
	descrition char(100),
	photo VARBINARY(MAX),
	final_price money
	)

create table category(
	characterid int primary key identity,
	[name] varchar(25) not null,
	[description] varchar(100),
	in_charge_employee varchar(25)
	)

create table ingredient(
	ingredient_id int primary key,
	ingredient_name varchar(50),
	required_amount int,
	measurement_units varchar(25),
	current_amount int,
	)

create table recipe(
	course_id int primary key,
	ingredient_id int,
	num_ingredient tinyint,
	foreign key(ingredient_id) references ingredient(ingredient_id)
	)