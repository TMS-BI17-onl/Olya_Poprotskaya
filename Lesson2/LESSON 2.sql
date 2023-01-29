--1a
SELECT *
FROM Sales.SalesTerritory

--1b
SELECT TerritoryID, Name
FROM Sales.SalesTerritory

--1c
SELECT *
FROM Person.Person
WHERE LastName = 'Norman'

--1d
SELECT *
FROM Person.Person
WHERE EmailPromotion !=2

--3 exercise
/* Кроме агрегатных функций SUM, AVG, COUNT, MIN, MAX в языке T-SQL существуют
еще APPROX_COUNT_DISTINCT, CHECKSUM_AGG, COUNT_BIG, GROUPING, GROUPING_ID, 
STDEV, STDEVP, STRING_AGG, VAR, VARP 
*/
SELECT APPROX_COUNT_DISTINCT(Size) AS Approx_Size
FROM Production.Product;

SELECT CHECKSUM_AGG(CAST(StandardCost AS INT))  
FROM Production.Product;  
GO 

SELECT STDEV(Weight)  
FROM Production.Product;  
GO  

--4a
SELECT DISTINCT PersonType
FROM Person.Person
WHERE LastName LIKE 'M%'
	OR NOT EmailPromotion = 1

--4b
SELECT TOP 3 SpecialOfferID,   MAX (DiscountPct) AS Max_disc, ModifiedDate
FROM Sales.SpecialOffer
WHERE ModifiedDate BETWEEN	'2013-01-01' AND '2014-01-01'
GROUP BY SpecialOfferID, ModifiedDate

--4c
SELECT MIN (Weight) AS Min_weight, MAX (Size) AS Max_size
FROM Production.Product

--4d
SELECT ProductSubcategoryID, MIN (Weight) AS Min_weight, MAX (Size) AS Max_size
FROM Production.Product
GROUP BY ProductSubcategoryID

--4e
SELECT ProductSubcategoryID, Color, MIN (Weight) AS Min_weight, MAX (Size) AS Max_size
FROM Production.Product
WHERE Color  > '!'
GROUP BY ProductSubcategoryID, Color