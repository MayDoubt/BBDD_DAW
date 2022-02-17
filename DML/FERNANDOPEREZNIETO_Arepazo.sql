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

Select M.Nombre, SUM(PL.Cantidad) as cantidad from Menu M
inner join PedidosLinea PL on PL.IdMenu=M.Id
group by M.Nombre
order by cantidad desc

--Ej7 Saca una factura desglosando el precio con iva y sin iva de cada linea del pedido numero 1.
      -- Los precios están con IVA y el IVA dependerá del tipo de elemento.
      -- En otra consulta, sacar el total desglosado, con IVA y sin IVA. Los gastos de envio no tienen IVA.
--Desglose
Select  M.Nombre as Producto, PL.Cantidad, cast(PL.PrecioVentaUnitario/((PL.IVA+100.00)/100) as decimal(5,2))as PrecioSinIVA, cast(PL.IVA as varchar) +'%' as IVA , PL.PrecioVentaUnitario, (PL.PrecioVentaUnitario*PL.Cantidad) as PrecioTotalUnidades from Pedidos P
inner join PedidosLinea PL on PL.IdPedido=P.Id
inner join Menu M on M.Id=PL.Id
where P.Id=1
order by PL.IVA desc
--Total SinIVA,ConIVA
Select 'Total' as ' ', SUM(PrecioSinIVA) as TotalSinIVA, SUM(PrecioVentaUnitario) as TotalConIVA  from
(Select  M.Nombre as Producto, PL.Cantidad, cast(PL.PrecioVentaUnitario/((PL.IVA+100.00)/100) as decimal(5,2))as PrecioSinIVA, PL.PrecioVentaUnitario from Pedidos P
inner join PedidosLinea PL on PL.IdPedido=P.Id
inner join Menu M on M.Id=PL.Id
where P.Id=1) as t1

--Ej8 Busca los elementos del menú  que nunca nadie ha pedido

Select M.Nombre from Menu M
left join PedidosLinea PL on M.Id=PL.IdMenu
where PL.IdMenu is null
order by M.Nombre desc

--Ej9 Calcula cuanto ha ingresado el Arepazo por meses y año. ( Sumando el total del pedido)

Set Language Spanish
Select DATENAME(month,Fecha_pedido) as months ,cast(SUM(P.Total) as varchar) + '€' as TotalMes from Pedidos P
group by DATENAME(month,Fecha_pedido), month(Fecha_pedido), year(Fecha_pedido)
order by year(Fecha_pedido), month(Fecha_pedido) asc

--Ej10 ¿Que cliente ha hecho mas pedidos?

Select Top 1 C.Nombre, C.Apellido, COUNT(P.Id) as numeroPedidos from Pedidos P
inner join Clientes C on C.id=P.IdCliente
group by C.Id,C.Nombre, C.Apellido
order by numeroPedidos desc

--Hay nombres repetidos por la generación aleatoria por eso hay que filtrar por ambas cosas y para asegurarse incluso del Id