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
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
Create View ProductInfo
Select p.ProductID, p.ProductSubcategoryID, p.Name ,sd.OrderQty,sd.LineTotal
from Sales.SalesOrderDetail as sd
JOIN Production.Product as p
ON sd.ProductID = p.ProductID 
GROUP BY p.ProductID, p.ProductSubcategoryID, p.Name ,sd.OrderQty,sd.LineTotal









/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
select * from Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail
select * from Production.Product
select * from Production.ProductCategory
select * from Production.ProductSubcategory

Select 
