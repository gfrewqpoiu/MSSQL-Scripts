USE Northwind;
GO
CREATE OR ALTER PROCEDURE Bestelldetails @CustID NCHAR(5)
AS
SELECT * from Orders
WHERE CustomerID = @CustID