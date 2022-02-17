create database Zoo
go
use Zoo
create table species (
	id_Species int primary key,
	scientific_Name varchar(80) unique not null,
	common_Name varchar(50) not null,
	family varchar(80) not null,
	extintion_Danger bit not null
)

create table zoo (
	id_Zoo int primary key,
	country varchar(60) not null,
	city varchar(60) not null,
	name_Zoo varchar(60) not null,
	extension int not null,
	budget float null

)

create table specimens (
	id_Specimens int primary key,
	id_Species int not null,
	id_Zoo int not null,
	sex varchar(7) null,
	--male, female, asexual, other
	birth_Year int not null,
	origin_Country varchar(60) not null,
	alive bit not null
	

	constraint fkId1 foreign key
	(id_Species) references species(id_Species),
	constraint fkId2 foreign key
	(id_Zoo) references zoo(id_Zoo)
)

