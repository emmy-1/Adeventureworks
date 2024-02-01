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
/*Select YEAR (OrderDate) as Year, Month(OrderDate) as month, DAY(OrderDate) as Day, Sum(TotalDue) AS TotalSales
from Sales.SalesOrderHeader
GROUP BY YEAR (OrderDate),Month(OrderDate),DAY(OrderDate)*/

select * from Sales.SalesOrderHeader
/* Common Table Experssion to extract the SALES DETAILS*/
With SalesOrder AS (
    select SalesOrderID,RevisionNumber,OrderDate, Count(SalesOrderID) as OrderCount ,Year(OrderDate) as OrderYear, Month(OrderDate) as OrderMonth, Day(OrderDate) as OrderDay, DueDate, ShipDate, Status,
    OnlineOrderFlag, SalesOrderNumber, PurchaseOrderNumber, AccountNumber, CustomerID, SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID,
    ShipMethodID, CreditCardID,CreditCardApprovalCode, CurrencyRateID,SubTotal,TaxAmt,Freight,TotalDue
    From Sales.SalesOrderHeader
    GROUP BY SalesOrderID,RevisionNumber,OrderDate, Year(OrderDate), Month(OrderDate), Day(OrderDate), DueDate, ShipDate, Status,
    OnlineOrderFlag, SalesOrderNumber, PurchaseOrderNumber, AccountNumber, CustomerID, SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID,
    ShipMethodID, CreditCardID,CreditCardApprovalCode, CurrencyRateID,SubTotal,TaxAmt,Freight,TotalDue 
)
select * from SalesOrder 

/* PROUDCT BY SALES*/
Select SalesOrderID, OrderQty,ProductID,UnitPrice,LineTotal, SUM(UnitPrice * OrderQty) as Reveune
from Sales.SalesOrderDetail
Group BY SalesOrderID, OrderQty,ProductID,UnitPrice,LineTotal
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/* View Created to join the Production.productsubcategory and Production.ProductCategory.  Uncheck to run view*/
/*CREATE VIEW ProductDetails AS*/ 
Select pd.ProductCategoryID, pc.ProductSubcategoryID, pd.Name , Pc.Name as ProductSubName
from Production.ProductCategory as pd
inner join Production.ProductSubcategory as pc
ON pd.ProductCategoryID = pc.ProductCategoryID
GROUP BY pd.ProductCategoryID, pc.ProductSubcategoryID, pd.Name , Pc.Name 

Select * from dbo.ProductDetails
Select * from Production.Product



select * from Production.ProductCategory
select * from Production.ProductSubCategory

/*Finding the profit and Profit margine*/

Select SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, unitPrice, UnitPriceDiscount,LineTotal
from Sales.SalesOrderDetail

select * from Production.Product

/*CREATE VIEW Productinfomation AS

Select tth.SalesOrderID, tth.SalesOrderDetailID, tth.CarrierTrackingNumber, tth.OrderQty, tth.ProductID, tth.SpecialOfferID, tth.unitPrice, 
tth.UnitPriceDiscount,tth.LineTotal,ytt.ProductNumber, ytt.SafetyStockLevel, ytt.ReorderPoint,ytt.StandardCost, ytt.ListPrice, 
ytt.DaysToManufacture,ytt.ProductSubcategoryID
from Sales.SalesOrderDetail as tth
INNER JOIN Production.Product ytt
ON tth.ProductID = ytt.ProductID 
Group BY tth.SalesOrderID, tth.SalesOrderDetailID, tth.CarrierTrackingNumber, tth.OrderQty, tth.ProductID, tth.SpecialOfferID, tth.unitPrice, 
tth.UnitPriceDiscount,tth.LineTotal,ytt.ProductNumber, ytt.SafetyStockLevel, ytt.ReorderPoint,ytt.StandardCost, ytt.ListPrice, 
ytt.DaysToManufacture,ytt.ProductSubcategoryID*/

/* Common Expression table to calculate the profit from each sales Calculation*/

with Product As
(
Select SalesOrderID, SalesOrderDetailID,CarrierTrackingNumber,OrderQty, ProductID, SpecialOfferID,unitPrice, 
UnitPriceDiscount,LineTotal,ProductNumber,SafetyStockLevel,ReorderPoint,StandardCost, (StandardCost * OrderQty) As Costofgoods,
ListPrice, DaysToManufacture,ProductSubcategoryID
From Productinfomation
GROUP BY SalesOrderID, SalesOrderDetailID,CarrierTrackingNumber,OrderQty, ProductID, SpecialOfferID,unitPrice, 
UnitPriceDiscount,LineTotal,ProductNumber,SafetyStockLevel,ReorderPoint,StandardCost, 
ListPrice, DaysToManufacture,ProductSubcategoryID
)
Select SalesOrderID, SalesOrderDetailID,CarrierTrackingNumber,OrderQty, ProductID, SpecialOfferID,unitPrice, 
UnitPriceDiscount,LineTotal,ProductNumber,SafetyStockLevel,ReorderPoint,StandardCost, Costofgoods,SUM(LineTotal - Costofgoods) AS Profit,
ListPrice, DaysToManufacture,ProductSubcategoryID
From Product
GROUP BY SalesOrderID, SalesOrderDetailID,CarrierTrackingNumber,OrderQty, ProductID, SpecialOfferID,unitPrice, 
UnitPriceDiscount,LineTotal,ProductNumber,SafetyStockLevel,ReorderPoint,StandardCost, Costofgoods,
ListPrice, DaysToManufacture,ProductSubcategoryID


Select TerritoryID, Name, CountryRegionCode, [Group], SalesYTD, SalesLastYear,CostYTD,CostLastYear
from Sales.SalesTerritory
Select * from Sales.SalesOrderHeader
Select * from Sales.SalesOrderDetail





SELECT ProductID, Name, ProductNumber, SafetyStockLevel, ReorderPoint,StandardCost, ListPrice, DaysToManufacture,ProductSubcategoryID
From Production.Product

SELECT
    sod.SalesOrderID,
    sod.ProductID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.LineTotal,
    soh.TaxAmt,
    soh.Freight,
    soh.TotalDue
FROM
    Sales.SalesOrderDetail AS sod
JOIN
    Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY sod.SalesOrderID,
    sod.ProductID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.LineTotal,
    soh.TaxAmt,
    soh.Freight,
    soh.TotalDue


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


/*Product inventory*/
/*Create View Productinventory*/

Select * from Production.Product
Select * from Production.ProductInventory
Select p1.ProductID, p1.ProductNumber, p1.ProductSubcategoryID, p1.Name, psc.Name as Subcategory, p1.SafetyStockLevel,p2.Quantity,  p2.LocationID, p2.Shelf, p2.Bin, p1.DaysToManufacture, p1.SellStartDate as SellStartDate,
p1.SellEndDate as SellEndDate, p1.StandardCost, p1.ListPrice, p1.ReorderPoint /*(SellStartDate - SellEndDate) as Selftime */
from Production.Product as p1
INNER JOIN Production.ProductInventory as p2
ON p1.ProductID = p2.ProductID
LEFT JOIN  -- Use LEFT JOIN to handle cases where ProductSubcategoryID is NULL
    Production.ProductSubcategory AS psc ON p1.ProductSubcategoryID = psc.ProductSubcategoryID
GROUP BY  p1.ProductID, p1.ProductNumber, p1.ProductSubcategoryID, p1.Name, psc.Name, p1.SafetyStockLevel, p2.Quantity, p2.LocationID, p2.Shelf, p2.Bin,  p1.DaysToManufacture,p1.SellStartDate, 
p1.SellEndDate, p1.StandardCost, p1.ListPrice, p1.ReorderPoint



/* Supply Chain Process*/

/*Total Order placed by year, month, Quater*/

select * from Sales.SalesOrderHeader
select YEAR(OrderDate) as Year, DATEPART(QUARTER, OrderDate) AS OrderQuarter, MONTH(OrderDate) as Month, COUNT(DISTINCT SalesOrderID) AS TotalOrders, SUM(TotalDue) as Total_Order_value
, AVG(TotalDue) as AverageOrderValue
from Sales.SalesOrderHeader
GROUP BY  YEAR(OrderDate),MONTH(OrderDate),DATEPART(QUARTER, OrderDate)




/*CUSTOMER SEGEMENTATION*/

CREATE VIEW CustomerDemo AS (
Select * from Sales.vPersonDemographics
Where DateFirstPurchase IS NOT NULL
)
select Distinct YEAR(BirthDate)
from dbo.CustomerDemo
select Distinct Occupation
from dbo.CustomerDemo

/* CUSTOMER SEGEMENTS */
/*Create View CustomerSegment AS*/
select BusinessEntityID, TotalPurchaseYTD, DateFirstPurchase, Day(DateFirstPurchase) as dayofpurchase,  BirthDate,
                                CASE
                                WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 18 AND 25 THEN '18-25'
                                WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
                                WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 36 AND 45 THEN '36-45'
                                WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 46 AND 55 THEN '46-55'
                                WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 56 AND 65 THEN '56-65'
                                WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) >= 66 THEN '66+'
                                ELSE 'Unknown'
    END AS AgeGroup,
MaritalStatus, YearlyIncome , (SELECT CASE 
                                WHEN YearlyIncome = '0-25000' THEN 'Least Income'
                                WHEN YearlyIncome = '25001-50000' THEN 'Low Income'
                                WHEN YearlyIncome = '50001-75000' THEN 'Medium Income'
                                WHEN YearlyIncome = '75001-100000 'THEN 'High Income'
                                WHEN YearlyIncome ='greater than 100000' THEN 'Highest Income'
                                ELSE 'Unknown'
                                END
                                ) AS IncomeGroup,
                                Gender, TotalChildren,
                                CASE
                                WHEN TotalChildren > '0' THEN 'TRUE'
                                ELSE 'FALSE'
                                END As ParentalStatus,
                                NumberChildrenAtHome, Education, Occupation,
                                 CASE
                                WHEN Education = 'Graduate Degree' THEN 'Highly Educated '
                                WHEN Education = 'Bachelors' THEN 'Educated'
                                WHEN Education IN ('High School', 'Partial High School', 'Partial College') THEN 'Least Educated'
                                ELSE 'Other'
    END AS EducationSegment,
     HomeOwnerFlag,NumberCarsOwned,CASE 
                                    WHEN NumberCarsOwned >'0' THEN 'TRUE'
                                    Else 'FALSE'
                                    END AS OwnsAcar

                            from dbo.CustomerDemo


Select Distinct IncomeGroup from dbo.CustomerSegment