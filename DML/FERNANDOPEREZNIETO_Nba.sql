Use nba
--Script añadir columna min jugados
--alter table EstadisticasPartidos add minutos_jugados int 
go
--update EstadisticasPartidos set minutos_jugados =(select top 1 * from string_split(tiempo_jugado,':'))

--Ej 1

Select J.nombre from jugadores J
where idequipo = (Select E.idequipo from Equipos E where E.nombre like '%Boston%')
order by J.nombre 

--Ej 2

Select top 1 j.nombre, sum(EP.puntos) as puntosTotales, avg(puntos) as media from EstadisticasPartidos EP
inner join Partidos P on EP.idpartido = P.idpartido
inner join jugadores J on j.idjugador = EP.idjugador
where P.temporada = 2020
group by J.idjugador, j.nombre
order by sum(EP.puntos) desc

--Ej 3

select top 1 E.nombre, COUNT(P.idganador) as PartidosGanados from Partidos P
inner join Equipos E on P.idganador=E.idequipo
WHERE P.fecha like '2019%'
GROUP BY P.idganador, E.nombre
ORDER BY COUNT(idganador) DESC

--Ej 4

select E.nombre, COUNT(P.idganador) as PartidosGanados from Partidos P
inner join Equipos E on P.idganador=E.idequipo
WHERE E.conferencia = 'E'
GROUP BY P.idganador, E.nombre
ORDER BY COUNT(idganador) DESC

select E.nombre, COUNT(P.idganador) as PartidosGanados from Partidos P
inner join Equipos E on P.idganador=E.idequipo
WHERE E.conferencia = 'O'
GROUP BY P.idganador, E.nombre
ORDER BY COUNT(idganador) DESC

--Ej 5

Select J.nombre, pais from jugadores J
WHERE pais = 'SPAIN'

--Ej 6

Select top 20 J.pais, COUNT(pais) as JugadoresAportados from jugadores J
GROUP BY pais
ORDER BY COUNT(pais) DESC

--Ej 7

Select top 10 J.nombre, MAX(EP.puntos) as RecordPuntosPartido from EstadisticasPartidos EP
inner join jugadores J on J.idjugador=EP.idjugador
GROUP BY J.idjugador, J.nombre
ORDER BY MAX(EP.puntos) DESC

--Ej 8

Select top 10 J.nombre, MAX(EP.asistencias) as RecordAsistenciasPartido from EstadisticasPartidos EP
inner join jugadores J on J.idjugador=EP.idjugador
GROUP BY J.idjugador, J.nombre
ORDER BY MAX(EP.asistencias) DESC

--Ej 9

Select top 10 J.nombre,
CAST(CAST((((sum(ep.triples)+0.0)/sum(ep.minutos_jugados))*100) as decimal(8,2)) as varchar)+'%' as TriplesxMin
from EstadisticasPartidos EP
inner join jugadores J on J.idjugador=EP.idjugador
WHERE ep.triples <> 0 AND ep.minutos_jugados <> 0
GROUP BY  J.nombre
ORDER BY CAST((((sum(ep.triples)+0.0)/sum(ep.minutos_jugados))*100) as decimal(8,2)) DESC

--Ej 10

Select top 1 J.nombre as jugadorMasBajito, altura from jugadores J
Where altura is not null
ORDER BY altura ASC

--Ej 11
--Como la pregunta puede dar a entender estas tres posibilidades te las dejo las tres

select top 1 idequipo_local as Equipo, avg(t1.mediaPuntos) as mediaPuntos from
	(select idequipo_local, AVG(marcador_local) as mediaPuntos from Partidos
	group by idequipo_local
	union all
	select idequipo_visitante, AVG(marcador_visitante) as mediaPuntos from Partidos
	group by idequipo_visitante) as t1
group by idequipo_local
order by mediaPuntos desc

select top 1 idequipo_local as Equipo, Sum(t1.sumPuntos) as sumPuntos from
	(select idequipo_local, Sum(marcador_local) as sumPuntos from Partidos
	group by idequipo_local
	union all
	select idequipo_visitante, Sum(marcador_visitante) as sumPuntos from Partidos
	group by idequipo_visitante) as t1
group by idequipo_local
order by sumPuntos desc

select top 1 idequipo_local as Equipo, Max(t1.maxPuntos) as maxPuntos from
	(select idequipo_local, Max(marcador_local) as maxPuntos from Partidos
	group by idequipo_local
	union all
	select idequipo_visitante, Max(marcador_visitante) as maxPuntos from Partidos
	group by idequipo_visitante) as t1
group by idequipo_local

--Ej 12

Select J.nombre, E.nombre from JugadoresEquipos JE
inner join jugadores J on J.idjugador=JE.idjugador
inner join Equipos E on E.idequipo=JE.idequipo
where J.nombre LIKE 'Ricky Rubio'

Select J.nombre, E.nombre from JugadoresEquipos JE
inner join jugadores J on J.idjugador=JE.idjugador
inner join Equipos E on E.idequipo=JE.idequipo
where JE.idjugador = 'rubiori01'

--Ej 13

Select top 1 SUM(PartidosPerdidos)as PartidosPerdidos, nombre  from
	(Select E.nombre as nombre, COUNT(idequipo_local) as PartidosPerdidos from Partidos P
	inner join Equipos E on E.idequipo=P.idequipo_local
	WHERE (P.idequipo_local <> idganador)
	GROUP BY E.nombre
	Union all
	Select E.nombre as nombre, COUNT(idequipo_visitante) as PartidosPerdidos from Partidos P
	inner join Equipos E on E.idequipo=P.idequipo_visitante
	WHERE (P.idequipo_visitante <> idganador)
	GROUP BY E.nombre) as t1
group by nombre
order by PartidosPerdidos desc

--Ej 14

select E.nombre, COUNT(P.idganador) as PartidosGanados from Partidos P
inner join Equipos E on P.idganador=E.idequipo
WHERE P.temporada = (Select MAX(temporada) from Partidos)
GROUP BY P.idganador, E.nombre
ORDER BY COUNT(idganador) DESC

--Ej 15

Select J.nombre from jugadores J
where J.draft_anyo = (Select J.draft_anyo from jugadores J where J.nombre like 'Ricky Rubio')
order by J.nombre

--Ej 16

Select top 1 E.nombre, Avg(year(getDate())-J.anyonacimiento) as Media from jugadores J
inner join Equipos E on E.idequipo = J.idequipo
group by E.nombre
Order by Avg(year(getDate())-J.anyonacimiento) desc

--Ej 17

Select count(J.nombre) as JugadoresConEmail from jugadores J
where J.email is not null and  J.email like '%hotmail%'

--Ej 18

Select top 20 J.nombre, MAX(altura) as maxAltura, idequipo from Jugadores J
group by idequipo, J.nombre
order by maxAltura desc

--Ej 18 (Bonus)
Select J.nombre, E.nombre, maxAltura from jugadores J
inner join (Select MAX(altura) as maxAltura, idequipo from Jugadores J
group by idequipo) Altura on J.idequipo=Altura.idequipo
inner join Equipos E on E.idequipo=J.idequipo
where maxAltura = J.altura
order by maxAltura desc

--Ej Bonus Jugadores con partido perfecto con al menos 20 puntos

Select J.nombre, EP.puntos , Ep.minutos_jugados from jugadores J
inner join EstadisticasPartidos EP on EP.idjugador=J.idjugador
where EP.intentosde2=EP.tirosde2 and EP.intentostirosLibros=Ep.tiroslibres and EP.intentosTriples=EP.triples and EP.puntos>20
order by Ep.minutos_jugados desc
