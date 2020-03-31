USE Northwind;
GO
BEGIN
-- Variablen Deklaration
DECLARE @count int = 0
SELECT @count = Count(*) from Customers
print concat('Anzahl Kunden: ', @count)
while @count < 10
	BEGIN
	if @count % 2 = 0
		print @count
	SET @count = @count +1
	END
END