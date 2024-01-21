/* Stored Procedure for each year.*/
/* Note you can ignore this code as it was just for fun */


CREATE Procedure TotalSalesperyear
@OrderDate INT
AS 
BEGIN
Select YEAR (OrderDate) as Year, Sum(TotalDue) AS TotalSales
from Sales.SalesOrderHeader
Where YEAR (OrderDate) = @OrderDate 
GROUP BY YEAR (OrderDate)  
END;

EXEC TotalSalesperyear @OrderDate = 2014


/* Total Sum of sales for each year*/
Select YEAR (OrderDate) as Year, Sum(TotalDue) AS TotalSales
from Sales.SalesOrderHeader
GROUP BY YEAR (OrderDate)
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/* View Created to join the Production.productsubcategory and Production.ProductCategory.  Uncheck to run view*/
/*CREATE VIEW ProductDetails AS*/ 
Select pd.ProductCategoryID, pc.ProductSubcategoryID, pd.Name , Pc.Name as ProductSubName
from Production.ProductCategory as pd
inner join Production.ProductSubcategory as pc
ON pd.ProductCategoryID = pc.ProductCategoryID
GROUP BY pd.ProductCategoryID, pc.ProductSubcategoryID, pd.Name , Pc.Name 
Select * from dbo.ProductDetails
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*Created View for ProductInfo. this joins the production.productID with the ProductID in the Sales Order table*/
/*Create VIEW ProductInfo AS*/

Select p.ProductID, p.ProductSubcategoryID, p.Name ,sd.OrderQty,sd.LineTotal
from Sales.SalesOrderDetail as sd
JOIN Production.Product as p
ON sd.ProductID = p.ProductID 

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

Select * from dbo.Productinfo
Select * from dbo.ProductDetails


/*Select Statement with join that shows each the product cateogry, quantity bought and the line total for each*/
select pp.ProductCategoryID, pp.Name as ProductCategory, pp.ProductSubName as Productname, pq.OrderQty, pq.LineTotal
from dbo.ProductDetails as pp
Join dbo.Productinfo as pq
ON pp.ProductSubcategoryID = pq.ProductSubcategoryID
GROUP BY pp.ProductCategoryID, pp.Name,pp.ProductSubName, pq.OrderQty, pq.LineTotal

/*Aggerate sales by Product category*/

select DISTINCT pp.ProductCategoryID, pp.Name, SUM(pq.OrderQty) as OrderQty, SUM(pq.LineTotal) as TotalSales
from dbo.ProductDetails as pp
Join dbo.Productinfo as pq
ON pp.ProductSubcategoryID = pq.ProductSubcategoryID
GROUP BY pp.ProductCategoryID,pp.Name

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*Total Sales by Region*/
Select s.TerritoryID, t.[Group],t.Name,t.CountryRegionCode, SUM(s.TotalDue) as Total, t.SalesYTD
from Sales.SalesOrderHeader as s
JOIN Sales.SalesTerritory as t
ON s.TerritoryID = t.TerritoryID
GROUP BY s.TerritoryID, t.[Group],t.Name,t.CountryRegionCode, t.SalesYTD


/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

select * from Sales.SalesTerritory
select * from Sales.SalesOrderDetail
select * from Sales.SalesTerritoryHistory
Select * from Person.ContactType
Select * from Sales.CreditCard
select * from Sales.SalesOrderHeader
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


Select * from Sales.vIndividualCustomer

/*Create VIEW Customerfinanicaldetails AS

SELECT c.CreditCardID, u.BusinessEntityID,c.CustomerID , c.AccountNumber, SUM(c.TotalDue) as TotalSales
from Sales.SalesOrderHeader as c
JOIN Sales.PersonCreditCard as u
ON c.CreditCardID = u.CreditCardID
GROUP BY c.CreditCardID, u.BusinessEntityID,c.CustomerID, c.AccountNumber

select * from Customerfinanicaldetails
Select * from Sales.Customer

/*Customer Finace tbale contaning the customerid, bussinessiD and total sales*/
/*CREATE VIEW CustomerFinance As*/

Select cc.CustomerID , cc.CreditCardID, cc.BusinessEntityID, sc.TerritoryID, cc.TotalSales
from Customerfinanicaldetails as cc
LEFT JOIN Sales.Customer as sc
ON cc.CustomerID = sc.CustomerID
GROUP BY cc.CustomerID, cc.CreditCardID, cc.BusinessEntityID, sc.TerritoryID,cc.TotalSales

SELECT * FROM dbo.CustomerFinance
Select * from Sales.vIndividualCustomer*/

/*Customer information*/
/*CREATE VIEW Customer AS*/

SELECT ic.BusinessEntityID, cf.CustomerID,ic.Title,ic.FirstName,ic.MiddleName,ic.LastName,ic.PhoneNumber,ic.PhoneNumberType, ic.EmailAddress, ic.AddressType,
ic.AddressLine1,ic.AddressLine2,ic.City,ic.StateProvinceName,ic.PostalCode,ic.CountryRegionName, cf.CreditCardID,cf.TerritoryID,SUM (cf.TotalSales) as Sales
from Sales.vIndividualCustomer as ic
JOIN dbo.CustomerFinance as cf
ON ic.BusinessEntityID = cf.BusinessEntityID
GROUP BY ic.BusinessEntityID, cf.CustomerID,ic.Title,ic.FirstName,ic.MiddleName,ic.LastName,ic.PhoneNumber,ic.PhoneNumberType, ic.EmailAddress, ic.AddressType,
ic.AddressLine1,ic.AddressLine2,ic.City,ic.StateProvinceName,ic.PostalCode,ic.CountryRegionName, cf.CreditCardID,cf.TerritoryID


