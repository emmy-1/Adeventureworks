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
select * from Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail
select * from Production.Product
select * from Production.ProductCategory
select * from Production.ProductSubcategory

Select 
