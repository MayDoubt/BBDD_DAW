use AdventureWorks2017
select count(1) from Person.Person where FirstName = 'Fernando'
use AdventureWorks2017

--Ej 1

select * from Person.Person

--Ej 2

select count(1) as TotalPerson from Person.Person 

--Ej 3

select top 30 * from Person.Person order by LastName asc

--Ej 4

select FirstName, MiddleName, LastName from Person.Person

--Ej 5

select replace(LoginID, 'adventure-works\', '')LoginID from HumanResources.Employee order by BirthDate asc

--Ej 6

select replace(LoginID, 'adventure-works\', '')LoginID from HumanResources.Employee where Gender = 'M'
select replace(LoginID, 'adventure-works\', '')LoginID from HumanResources.Employee where Gender = 'F'

--Ej 7

select count(1) as TotalMale from HumanResources.Employee where Gender = 'M'
select count(1) as TotalFemale from HumanResources.Employee where Gender = 'F'

--Ej 8

select count(1) as TotalOrders from Sales.SalesOrderHeader

--Ej 9

select MAX(TotalDue) as MostExpensiveOrder from Sales.SalesOrderHeader
select top 1 SalesOrderID,TotalDue from Sales.SalesOrderHeader order by TotalDue desc

--Ej 10

select AVG(TaxAmt) as AverageTax from Sales.SalesOrderHeader

--Ej 11

select max(ShipDate) as  LastShipDate,min(ShipDate) as FirstShipDate from Sales.SalesOrderHeader
select top 1 SalesOrderID, ShipDate as LastOrder from Sales.SalesOrderHeader order by ShipDate desc
select top 1 SalesOrderID, ShipDate as FirstOrder from Sales.SalesOrderHeader order by ShipDate asc

--Ej 12

select replace(LoginID, 'adventure-works\', '')LoginID from HumanResources.Employee

--Ej 13

select (FirstName +' '+LastName) as CompleteName from Person.Person

--Ej 14

select (TotalDue - SubTotal) as Diference from Sales.SalesOrderHeader

--Ej 15

select TotalDue, Subtotal+TaxAmt+Freight from Sales.SalesOrderHeader

--Ej 16

select SalesOrderID from Sales.SalesOrderHeader where (TotalDue - SubTotal - TaxAmt - Freight) <> 0

--Según el resultado de la anterior consulta si estarian bien calculados todos.