CREATE PROCEDURE Bestelldetails @CustID NCHAR(5)
AS
SELECT * from Orders
WHERE CustomerID = @CustID