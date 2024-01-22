/*Order Fulfillment Performance:*/
select * from Sales.SalesOrderHeader
Select SalesOrderID, RevisionNumber, OrderDate, DueDate , AVG(DATEDIFF(day, OrderDate, ShipDate)) AS AverageFulfillmentTime
FROM Sales.SalesOrderHeader
Group BY  SalesOrderID, RevisionNumber, OrderDate, DueDate,  (DATEDIFF(day, OrderDate, ShipDate))

SELECT
    Status,
    COUNT(*) AS OrderCount
FROM
    Sales.SalesOrderHeader
GROUP BY
    Status;


