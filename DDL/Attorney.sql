create database Attorney
go
use Attorney
create table clients (
	dni varchar(9) primary key,
	client_Name varchar(50) not null,
	client_Surname varchar(80) not null,
	phone_Number int null,
	street_Address varchar(80) not null,
	city_Address varchar(60) not null
)

create table attorney (
	id_Attorney int primary key,
	attorney_Name varchar(50) not null,
	attorney_Surname varchar(80) not null,
)
create table cases (
	id_Case int primary key,
	client_Dni varchar(9) not null,
	state_Case varchar(6) not null,
	--active, closed
	starting_Date date not null,
	ending_Date date null
	

	constraint fkId1 foreign key
	(client_Dni) references clients(dni)
)

create table attorneyCases (
	id_Attorney int,
	id_Case int

	constraint fkId2 foreign key
	(id_Attorney) references attorney(id_Attorney),
	constraint fkId3 foreign key
	(id_Case) references cases(id_Case),

	primary key (id_Attorney, id_Case)
)