create database naturalParks
go
use naturalParks
create table autonomous_Community (
	id_Community int primary key,
	name_Community varchar(20) not null
)

create table natural_Park (
	id_Park int primary key,
	name_Park varchar(80) not null,
	date_Nom date null
)

create table park_Community(
	id_Park int,
	id_Community int

	constraint fkId1 foreign key
	(id_Park) references natural_Park(id_Park),
	constraint fkId2 foreign key
	(id_Community) references autonomous_Community(id_Community),

	primary key (id_Park, id_Community)
)

create table employees (
	id_employees int primary key,
	id_Park int not null,
	nif varchar(9) not null,
	phone_Number int null,
	street_Address varchar(80) null,
	ss_Number varchar(16) not null

	constraint fkId3 foreign key
	(id_Park) references natural_Park(id_Park)
)

create table area(
	id_Area int primary key,
	id_Park int not null,
	area_Name varchar(40) not null,
	area_Extension int not null

	constraint fkId4 foreign key
	(id_Park) references natural_Park(id_Park)
)

create table species(
	id_Specie int primary key,
	id_Area int,
	scientific_Name varchar(80) unique not null,
	common_Name varchar(50) not null,
	family varchar(7) not null,
	--animal, vegetal, mineral
	breeding_Start date null,
	--family subtype animal or vegetal
	breeding_Duration int null,
	--family subtype animal or vegetal
	feeding varchar(15) null,
	--vegetarian; carnivorous, omnivorous; other
	--family subtype animal
	geotype varchar(10) null,
	--family subtype mineral
)

create table species_Area(
	id_Area int,
	id_Specie int,
	n_specimens int not null

	constraint fkId5 foreign key
	(id_Area) references area(id_Area),
	constraint fkId6 foreign key
	(id_Specie) references species(id_Specie),

	primary key (id_Area, id_Specie)
)