create Database EjDDL
go 
use EjDDL

--Ejercicio 1


create table personas (
	id int not null,
	nombre varchar(80) not null,
	apellidos varchar(80) not null

	constraint PK_id_personas primary key (id)
)

--Solución

alter table personas add edad int null


--Ejercicio 2

create table jugador(
	id int not null,
	nombre varchar(80) not null,
	apellidos varchar(80) not null

	constraint PK_id_jugador primary key (id)
)

create table equipo(
	id int not null,
	nombre varchar(80)
	
	constraint PK_id_Equipo primary key (id)
)

--Solución

alter table jugador add id_equipo int not null
alter table jugador add constraint fkId1 foreign key (id_Equipo) references equipo(id)

--Ejercicio 3

Create table carretesfotos(
	id int not null,
	nombre varchar(80) not null

	constraint PK_id_Carrete primary key (id)
)

--Solución

drop table carretesfotos

--Ejercicio 4

Create table libros(
	isbn varchar(10) not null,
	titulo varchar (100) not null

	constraint PK_isbn_libro primary key (isbn)
)

--Solución

alter table libros drop constraint PK_isbn_libro
alter table libros alter column isbn varchar(15) not null
alter table libros add constraint PK_isbn_libro primary key (isbn)


--Ejercicio 5

Create table videojuego(
	id int not null,
	nombre varchar(80) not null,
	precio int not null

	constraint PK_id_libro primary key (id)
)

--Solución

alter table videojuego alter column precio decimal(5,2)

--Ejercicio 6

--Solución

Create table cliente(
	id int not null,
	nombre varchar(80) not null,
	email varchar(100) not null

	constraint PK_id_cliente primary key (id)
)

Create table ingrediente(
	id int not null, 
	nombre varchar(80) not null,
	precioKg decimal(5,2) not null

	constraint PK_id_ingrediente primary key (id)
)

Create table menu(
	id int not null, 
	nombre varchar(80) not null,
	precio decimal(5,2) not null

	constraint PK_id_menu primary key (id)
)

Create table pedido(
	id int not null, 
	nombre varchar(80) not null,
	precio decimal(5,2) not null

	constraint PK_id_pedido primary key (id)
)

Create table pedidoslinea(
	id_Pedido int not null,
	id_Menu int not null,
	cantidad int not null,
	precio decimal(6,2)

	constraint fkId2 foreign key
	(id_Pedido) references pedido(id),
	constraint fkId3 foreign key
	(id_Menu) references menu(id),
	primary key (id_Pedido, id_Menu)
)

Create table receta(
	id_Menu int not null,
	id_Ingrediente int not null,
	cantidadEnKg int not null

	constraint fkId4 foreign key
	(id_Menu) references menu(id),
	constraint fkId5 foreign key
	(id_Ingrediente) references ingrediente(id),

	primary key (id_Menu, id_Ingrediente)
)

--Ejercicio 7

Create table ninos(
	id int not null, 
	nombre varchar(80) not null,
	apellidos varchar(150) not null,
	valoracion int not null,

	constraint PK_id_niño primary key (id)
)

Create table regalos(
	id int not null,
	nombre varchar(80) not null,
	peso int not null,
	id_Nino int not null

	constraint PK_id_regalo primary key (id)

	constraint fkId6 foreign key
	(id_Nino) references ninos(id)
)

Create table direcciones(
	id int not null,
	calle varchar(200) not null,
	numeroportal varchar(10) not null,
	cp int not null,
	localidad varchar (100) not null,
	id_Nino int not null

	constraint PK_id_direcciones primary key (id)

	constraint fkId7 foreign key
	(id_Nino) references ninos(id)
)

--Ejercicio 8

Create table person (
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

--Solución

alter table fee drop constraint fkId1
alter table person drop constraint dni_Person
alter table fee alter column dni_Person varchar(15) not null
alter table person alter column dni_Person varchar(15) not null
alter table person add constraint dni_Person primary key (dni_Person)
alter table fee add constraint fkId1 foreign key (dni_Person) references person(dni_Person) 