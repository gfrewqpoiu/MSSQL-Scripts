USE Northwind;
GO
CREATE OR ALTER PROCEDURE NeueProzedur
AS 
BEGIN
	DECLARE c_customers CURSOR FOR
		SELECT Customers.ContactName FROM Customers
	DECLARE @zeile VARCHAR(MAX), @i int -- Mehrere Variablen gleichzeitig definieren.
	
	OPEN c_customers 
	FETCH NEXT FROM c_customers INTO @zeile 
	IF @@FETCH_STATUS != 0 
		print 'Kein Datensatz' 
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		print @zeile 
		FETCH NEXT FROM c_customers INTO @zeile
	END 
	
	CLOSE c_customers 
	DEALLOCATE c_customers
END;

EXEC NeueProzedur;