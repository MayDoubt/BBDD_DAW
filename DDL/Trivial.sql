Create Database Trivial
go
use Trivial
create table players (
	id_Player int primary key,
	player_Name varchar(80) unique not null,
	player_Color varchar(10) not null
)

create table games (
	id_Game int primary key,
	game_Duration int not null,
	game_Date date not null
)

create table categories (
	id_Category int primary key,
	category_Color varchar(10) not null,
	category_Name varchar(50) not null
)

create table cards (
	id_Card int primary key,
	id_Category int not null,
	card_Question varchar(100) not null,
	card_Answer varchar(50) not null,
	card_Description varchar(100) null

	constraint fkId1 foreign key
	(id_Category) references categories(id_Category)
)

create table score (
	id_Player int,
	id_Game int,
	id_Card int,
	success bit not null,
	cheese bit not null,
	final bit not null

	--El campo final corresponde a la respuesta final del juego.

	constraint fkId2 foreign key
	(id_Player) references players(id_Player),
	constraint fkId3 foreign key
	(id_Game) references games(id_Game),
	constraint fkId4 foreign key
	(id_Card) references cards(id_Card),

	primary key (id_Player, id_Game, id_Card)
)