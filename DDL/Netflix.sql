create database Netflix
go
use Netflix
create table clients (
	id int primary key,
	email varchar(80) unique not null,
	client_Name varchar(50) not null,
	client_Surname varchar(80) not null,
	iban_Code varchar(24) unique not null
)

create table catalogue (
	id int primary key,
	content int not null,
	title varchar(80) not null,
	latin_Title varchar (80) null,
	main_Image varchar (2083) not null,
	main_Teaser varchar (2083) null,
	duration int not null,
	description varchar(500) not null
)

create table genres (
	id_Genre int primary key,
	title varchar(50) not null
)

create table users (
	id int primary key,
	avatar_Url varchar(2083) null,
	id_Client int not null

	constraint fkId1 foreign key
	(id_Client) references clients(id)
)

create table favourites (
	id_Users int,
	id_Catalogue int,
	favourite bit not null

	constraint fkId2 foreign key
	(id_Users) references users(id),
	constraint fkId3 foreign key
	(id_Catalogue) references catalogue(id),

	primary key (id_Users, id_Catalogue)
)

create table timeVisualized_film (
	id_Film int,
	id_User int,
	visualized_Time int not null

	constraint fkId4 foreign key
	(id_User) references users(id),
	constraint fkId5 foreign key
	(id_Film) references catalogue(id),

	primary key (id_Film, id_User)
)

create table seasons (
	id_Season int primary key,
	id_Serie int not null,
	title varchar(80) null,
	description varchar(500) null

	constraint fkIdSerie foreign key
	(id_Serie) references catalogue(id)
)

create table genres_Catalogue (
	id_Catalogue int,
	id_Genre int

	constraint fkId6 foreign key
	(id_catalogue) references catalogue(id),
	constraint fkId7 foreign key
	(id_Genre) references genres(id_Genre),

	primary key (id_Catalogue, id_Genre)
)

create table chapters (
	id_Chapter int primary key,
	id_Season int not null,
	title varchar(80) null,
	description varchar(500) null

	constraint fkId8 foreign key
	(id_Season) references seasons(id_Season)
)

create table timeVisualized_series (
	id_Chapter int,
	id_User int,
	visualized_Time int not null

	constraint fkId9 foreign key
	(id_User) references users(id),
	constraint fkId10 foreign key
	(id_Chapter) references chapters(id_Chapter),

	primary key (id_Chapter, id_User)
)
