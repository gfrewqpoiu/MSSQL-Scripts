USE Northwind;
GO
SELECT Count(*), SUBSTRING(ContactName, 1, CharIndex(' ', ContactName)) from Customers
GROUP BY SUBSTRING(ContactName, 1, CharIndex(' ', ContactName));