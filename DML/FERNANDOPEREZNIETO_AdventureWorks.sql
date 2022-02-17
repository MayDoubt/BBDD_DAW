use AdventureWorks2017
go

-- Ej 1 Nombre de empleados

Select P.FirstName, P.LastName from Person.Person P
inner join HumanResources.Employee HR on HR.BusinessEntityID = P.BusinessEntityID
order by P.LastName asc

--Ej 2 Clientes que sean empleados

Select P.FirstName, P.LastName from Person.Person P
inner join Sales.Customer S on S.CustomerID=P.BusinessEntityID
inner join HumanResources.Employee HR on HR.BusinessEntityID = S.PersonID
order by P.LastName asc

--Ej 3 Empleados de California

Select P.FirstName, P.LastName, PSP.Name from Person.Person P
inner join HumanResources.Employee H on H.BusinessEntityID=P.BusinessEntityID
inner join Person.BusinessEntityAddress pb ON pb.BusinessEntityID=p.BusinessEntityID
inner join Person.Address PA on PA.AddressID=PB.AddressID
inner join Person.StateProvince PSP on PSP.StateProvinceID=PA.StateProvinceID
WHERE PSP.Name='California'

--Ej 4 Pedido más caro

Select top 1 SalesOrderID, MAX(TotalDue) as moreExpensiveOrderCost from Sales.SalesOrderHeader SOH
group by SalesOrderID
order by moreExpensiveOrderCost desc

--Ej 5 Clientes cuyo nombre empiece por 'C'

Select P.FirstName, P.LastName from Person.Person P
inner join Sales.Customer C on C.PersonID=P.BusinessEntityID
where P.FirstName like 'C%'
order by P.LastName asc

--Ej 6 Total ventas 2011

Select Count(SOH.SalesOrderID) as TotalOrders2011 from Sales.SalesOrderHeader SOH
where year(SOH.OrderDate) = 2011

--Ej 7 Total importe ventas 2011

Select Cast(SUM(TotalDue) as varchar) +'€' as TotalDue2011 from Sales.SalesOrderHeader SOH
where year(SOH.OrderDate)=2011 and TotalDue is not null

--Ej 8 Importe de todas las ventas de cada año

Select Cast(Cast(SUM(TotalDue) as decimal(18,2)) as varchar) +'€' as TotalDuexYear, year(OrderDate) as years from Sales.SalesOrderHeader
group by year(OrderDate)
order by years desc

--Ej 9 Nombre y Apellidos del cliente que más apellidos ha realizado

Select top 1 P.FirstName, P.LastName, Count(SOH.CustomerID) as orderCount from Person.Person P
inner join Sales.Customer S on S.PersonID=P.BusinessEntityID
inner join Sales.SalesOrderHeader SOH on SOH.CustomerID=S.CustomerID
group by SOH.CustomerID, P.FirstName, P.LastName
order by orderCount desc

--Ej 10 Ranking de los 10 clientes (Nombre y Apellidos con los pedidos más caros)

Select top 10 P.FirstName, P.LastName, cast(cast(MAX(TotalDue) as decimal(18,2)) as varchar) +'€' as moreExpensivesOrderCost from Person.Person P
inner join Sales.Customer S on S.PersonID=P.BusinessEntityID
inner join Sales.SalesOrderHeader SOH on SOH.CustomerID=S.CustomerID
group by s.CustomerID, P.FirstName, P.LastName
order by MAX(TotalDue) desc

--Ej 11 Media de los pedidos de los clientes de California

Select cast(cast(AVG(MediaOrders) as decimal(18,2)) as varchar) + '€' as MediaFromCaliforniaOrders from
	(Select P.FirstName, P.LastName, PSP.Name, AVG(SOH.TotalDue) as MediaOrders from Person.Person P
	inner join Sales.Customer SC on SC.PersonID=P.BusinessEntityID
	inner join Sales.SalesOrderHeader SOH on SOH.CustomerID=SC.CustomerID
	inner join Person.BusinessEntityAddress pb ON pb.BusinessEntityID=p.BusinessEntityID
	inner join Person.Address PA on PA.AddressID=PB.AddressID
	inner join Person.StateProvince PSP on PSP.StateProvinceID=PA.StateProvinceID
	where PSP.Name='California'
	group by P.FirstName, P.LastName, P.BusinessEntityID, PSP.Name) as t1

--Queda ambigüa la pregunta puesto que puede ser lo que se gastan de media los clientes californianos en pedidos o lo que se gasta de media por cliente californiano individual
--no obstante de ahí saldrían las dos puesto que la subconsulta es la media individual y la grande es la general

--Ej 12 Producto más caro comprado

Select top 1 P.Name, cast(MAX(SOD.UnitPrice) as varchar) +'€' as MostExpensiveProduct from Sales.SalesOrderDetail SOD
inner join Production.Product P on P.ProductID=SOD.ProductID
group by P.Name
order by MAX(SOD.UnitPrice) desc

--El inner join a producto es solo para que salga el nombre y el cast para que tenga el simbolo del euro xD

--Ej 13 Producto comprado más veces

Select top 1 P.Name, SUM(SOD.OrderQty) as timesSold from Sales.SalesOrderDetail SOD
inner join Production.Product P on P.ProductID=SOD.ProductID
group by SOD.ProductID, P.Name
order by timesSold DESC

--Ej 14 Cliente que más productos distintos ha comprado

Select top 1 P.FirstName, P.LastName, COUNT(SOD.ProductID) as distinctProducts from Person.Person P
inner join Sales.Customer SC on SC.PersonID=P.BusinessEntityID
inner join Sales.SalesOrderHeader SOH on SOH.CustomerID=SC.CustomerID
inner join Sales.SalesOrderDetail SOD on SOD.SalesOrderID=SOH.SalesOrderID
group by P.FirstName, P.LastName
order by distinctProducts desc

(select SC.CustomerID, ProductID, p.LastName, p.FirstName, COUNT(1) as productCount from Sales.Customer SC
inner join Person.Person P on P.BusinessEntityID=SC.PersonID
inner join Sales.SalesOrderHeader SOH on SOH.CustomerID=SC.CustomerID
inner join Sales.SalesOrderDetail SOD on SOD.SalesOrderID=SOH.SalesOrderID
group by P.FirstName, P.LastName

--Ej 15 Ranking de los 20 productos más vendidos

 Select top 15 P.Name, SUM(SOD.OrderQty) as timesBought from Production.Product P
 inner join Sales.SalesOrderDetail SOD on SOD.ProductID=P.ProductID
 group by P.Name
 order by timesBought desc
