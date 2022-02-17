use arepazo

--Ej 1 Saca una lista de todas las bebidas donde se vea el nombre, la descripción y el Precio de venta al publico

Select M.Nombre, M.Descripcion, cast(M.PrecioVenta as varchar) +'€' from Menu M
inner join TipoAlimento TP on TP.Id=M.Tipo
where TP.Descripcion='Bebidas'

--Ej 2 Sacar el menú del bar Arepazo. Debe estar ordenado por tipo de alimento (platos,tapas,bebidas) y por categoria

Select M.Nombre, M.Descripcion, cast(M.PrecioVenta as varchar) +'€' as PVP from Menu M
order by M.Tipo, M.Categoria

--Ej 3 Saca una comparativa entre el Precio de venta y el precio que nos cuesta la materia prima

Select M.Nombre, M.PrecioVenta, SUM(I.PrecioKg*R.CantidadEnKg) as CosteBruto from Menu M
inner join Receta R on R.idMenu=M.Id
inner join Ingredientes I on I.Id=R.idIngredientes
group by M.Nombre, M.PrecioVenta

--Ej 4 ¿Algún elemento del menú no es rentable?¿cual?(cuestan mas sus incredientes que el precio de venta, no entramos a valorar la mano de obra

Select Nombre,PrecioVenta, CosteBruto from
(Select M.Nombre, M.PrecioVenta, SUM(I.PrecioKg*R.CantidadEnKg) as CosteBruto from Menu M
inner join Receta R on R.idMenu=M.Id
inner join Ingredientes I on I.Id=R.idIngredientes
group by M.Nombre, M.PrecioVenta) as t1
where(PrecioVenta-CosteBruto)<0

--Ej5 Dame los datos del cliente que mas ha gastado

Select Top 1 C.Nombre, C.Apellido, cast(P.Total as varchar) + '€' from Clientes C
inner join Pedidos P on P.IdCliente=C.id
order by P.Total desc

--Ej6 ¿Cual es el elemento del Menú que más se ha vendido? Ten en cuenta las cantidades.
Select M.Nombre, SUM(PL.Cantidad) from Menu M
inner join PedidosLinea PL on PL.IdMenu=M.Id

Select * from clientes
