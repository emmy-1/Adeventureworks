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
