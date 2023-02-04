--3
/* window functions Row_Number, Rank, Dense_Rank
will return the same result if the values are unique and not repeated
*/

--4a
SELECT  *
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'

SELECT  COUNT(DISTINCT UnitMeasureCode) AS cnt
FROM Production.UnitMeasure

INSERT INTO Production.UnitMeasure 
VALUES ('TT1', 'Test 1', '2020-09-09')

INSERT INTO Production.UnitMeasure 
VALUES ('TT2', 'Test 2', GETDATE())

--4b
SELECT UnitMeasureCode, Name, ModifiedDate
INTO Production.UnitMeasureTest
FROM Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'

INSERT INTO Production.UnitMeasureTest
SELECT *
FROM Production.UnitMeasure
WHERE UnitMeasureCode = 'CAN'

SELECT *
FROM Production.UnitMeasureTest
ORDER BY UnitMeasureCode

--4c
UPDATE Production.UnitMeasureTest
SET UnitMeasureCode = 'TTT'

--4d
DELETE
FROM Production.UnitMeasureTest

--4e
SELECT SalesOrderID, ProductID, LineTotal  
    ,AVG(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Avg"  
    ,MIN(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Min"  
    ,MAX(LineTotal) OVER (PARTITION BY SalesOrderID) AS "Max"  
FROM Sales.SalesOrderDetail   
WHERE SalesOrderID IN (43659,43664);

--4f
SELECT p.FirstName, p.LastName, a.SalesYTD
    ,ROW_NUMBER() OVER (ORDER BY a.SalesYTD) AS "Row Number"  
    ,RANK()		  OVER (ORDER BY a.SalesYTD) AS Rank		
    ,DENSE_RANK() OVER (ORDER BY a.SalesYTD) AS "Dense Rank"  
FROM Sales.SalesPerson AS a   
JOIN Person.Person AS p ON a.BusinessEntityID = p.BusinessEntityID   

SELECT p.FirstName, p.LastName, a.SalesLastYear
    ,ROW_NUMBER() OVER (ORDER BY a.SalesLastYear) AS "Row Number"  
FROM Sales.SalesPerson AS a   
JOIN Person.Person AS p ON a.BusinessEntityID = p.BusinessEntityID
WHERE a.SalesLastYear <> 0

SELECT *
	,CONCAT (UPPER (LEFT(LastName,3)), 'login', ISNULL(TerritoryGroup, ' ')) AS Login
FROM Sales.vSalesPerson

--4g  I don't know how else to get
SELECT DATENAME(weekday, dateadd(month,datediff (month,0,getdate()),0))

--5
/*
 ID	*	Name	DepName	
 1		NULL	A		 
 2		NULL	NULL	
 3		A		C		
 4		B		C	
  
count(1)	3
count(name)	2
count(id)	4
count(*)	3
 */
