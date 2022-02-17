Create Database ExamenDDL_fernando_Perez
go
use ExamenDDL_fernando_Perez

--Ejercicio 2

drop table IF EXISTS [dbo].[Alumnado]

Create table Alumnado (
	id int primary key,
	nombre varchar(80) not null
)

alter table Alumnado add edad int not null default '-1'

--Ejercicio 3

drop table IF EXISTS [dbo].[libroAutor]
drop table IF EXISTS [dbo].[autor]
drop table IF EXISTS [dbo].[libro]

Create table libro (
	id int primary key,
	nombre varchar(80) not null
)
Create table autor (
	id int primary key,
	nombre varchar(80) not null
)

--Como se trata de una relación N-N vamos a crear otra tabla libroAutor con las foreign keys de ambas como PK

Create table libroAutor (
	id_Libro int not null,
	id_Autor int not null

	constraint FK_libro_libro Foreign key (id_Libro) references libro(id),
	constraint FK_autor_autor Foreign key (id_Autor) references autor(id)

)

	alter table libroAutor add constraint PK_LibroAutor primary key (id_Libro, id_Autor)

--Ejercicio 4

drop table IF EXISTS [dbo].[coche]

Create table coche (
	id int primary key,
	nombre varchar(80) not null,
	tipoCombustible int not null
)

alter table coche drop column tipoCombustible

--La información se elimina.

--Ejercicio 5

drop table IF EXISTS [dbo].[profesorClase]
drop table IF EXISTS [dbo].[profesor]
drop table IF EXISTS [dbo].[clase]

Create table profesor (
	id varchar(8) primary key,
	nombre varchar(80) not null
)

Create table clase (
	id int primary key,
	nombre varchar(80) not null
)

Create table profesorClase (
	dni_profesor varchar(8) not null,
	idclase int not null
)

	alter table profesorClase add constraint FK_profesor_profesor Foreign key (dni_profesor) references profesor(id)
	alter table profesorClase add constraint FK_clase_clase Foreign key (idclase) references clase(id)
	alter table profesorClase add constraint PK_profesorClase primary key (dni_profesor, idclase)

-- Hasta aquí la creación de la tabla (He creado las constraint con alter para no generar un nombre aleatorio)

	alter table profesorClase drop constraint PK_profesorClase
	alter table profesorClase drop constraint FK_profesor_profesor
	alter table profesorClase alter column dni_profesor varchar(9) not null
	alter table profesor alter column id varchar(9) not null
	alter table profesorClase add constraint FK_profesor_profesor Foreign key (dni_profesor) references profesor(id)
	alter table profesorClase add constraint PK_profesorClase primary key (dni_profesor, idclase)

--Ejercicio 6

	alter table coche add precio decimal(7,2) not null

--Ejercicio 7

drop table IF EXISTS [dbo].[seguidores]
drop table IF EXISTS [dbo].[megusta]
drop table IF EXISTS [dbo].[tweet]
drop table IF EXISTS [dbo].[usuario]
drop table IF EXISTS [dbo].[patrocinador]

Create table patrocinador (
	id int primary key,
	nombre varchar(80) not null
)

Create table usuario (
	id int primary key,
	email varchar(100) not null,
	usuario varchar(80) not null,
	contrasena varchar(15) not null,
	nombre varchar(80) not null,
	fechanacimiento date
)

Create table tweet (
	id int not null,
	id_usuario int not null,
	contenidotweet varchar(256) not null,
	fecha date not null,
	idPatrocinador int
)
alter table tweet add constraint PK_tweet primary key (id)
alter table tweet add constraint FK_idPatrocinador_patrocinador Foreign key (idPatrocinador) references patrocinador(id)

Create table megusta (
	idUsuario int not null,
	idTweet int not null
)

	alter table megusta add constraint FK_usuario Foreign key (idUsuario) references usuario(id)
	alter table megusta add constraint FK_tweet Foreign key (idTweet) references tweet(id)
	alter table megusta add constraint PK_megusta primary key (idUsuario, idTweet)

Create table seguidores (
	idSeguidor int not null,
	idSeguido int not null
)

	alter table seguidores add constraint FK_usuario1 Foreign key (idSeguidor) references usuario(id)
	alter table seguidores add constraint FK_usuario2 Foreign key (idSeguido) references usuario(id)
	alter table seguidores add constraint PK_seguidores primary key (idSeguidor, idSeguido)

--Ejercicio 8

drop table IF EXISTS [dbo].[clasificacion]
drop table IF EXISTS [dbo].[pilotos]
drop table IF EXISTS [dbo].[circuitos]
drop table IF EXISTS [dbo].[escuderia]

Create table escuderia (
	id_Escuderia int not null,
	nombre varchar(80) not null
)
alter table escuderia add constraint PK_escuderia primary key (id_Escuderia)

Create table circuitos (
	id_Circuito int not null,
	nombre varchar(100) not null,
	ciudad varchar (100) not null,
	pais varchar (100) not null,
	longitud decimal(5,2) not null --No se cuanto suelen medir los circuitos pero he calculado hasta 3 cifras por delante de la coma y dos decimales porque los km no son una medida pequeña
)
alter table circuitos add constraint PK_circuitos primary key (id_Circuito)

Create table pilotos (
	id_Piloto int not null,
	nombre varchar(80) not null,
	apellidos varchar(150) not null,
	nacionalidad varchar(100) not null,
	fnacimiento date not null,
	id_Escuderia int not null
)

alter table pilotos add constraint FK_Escuderia Foreign key (id_Escuderia) references escuderia(id_Escuderia)
alter table pilotos add constraint PK_pilotos primary key (id_Piloto)

Create table clasificacion (
	id_Piloto int not null,
	id_Circuito int not null,
	posicion int not null
)
	
	alter table clasificacion add constraint FK_Piloto Foreign key (id_Piloto) references pilotos(id_Piloto)
	alter table clasificacion add constraint FK_Circuito Foreign key (id_Circuito) references circuitos(id_Circuito)
	alter table clasificacion add constraint PK_clasificacion primary key (id_Piloto, id_Circuito)