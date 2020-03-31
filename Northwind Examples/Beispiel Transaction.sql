BEGIN
DECLARE @count int = 0
while @count < 10
	BEGIN
	print @count
	SET @count = @count +1
	END
END