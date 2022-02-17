create database DGT
go
use DGT

create table person (
	dni_Person varchar(9) not null,
	name_Person varchar(50) not null,
	surname_Person varchar(50) not null
	constraint dni_Person primary key (dni_Person)
)

create table fee (
	id_Fee int primary key,
	dni_Person varchar(9) not null,
	amount_Fee decimal(5,2) not null,
	plate varchar(7) not null

	constraint fkId1 foreign key
	(dni_Person) references person(dni_Person)
)