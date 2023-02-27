--1
SELECT P.FirstName, P.LastName, Ph.PhoneNumber
FROM Person.Person P
	JOIN Person.PersonPhone Ph ON P.BusinessEntityID=Ph.BusinessEntityID
WHERE PhoneNumber LIKE '4%5'

--2
SELECT P.FirstName, p.LastName, h.BirthDate, 
	CASE WHEN BirthDate <= dateadd(YY,+17, getdate()) AND BirthDate <= dateadd(YY,-20, getdate()) THEN 'Adolescence'
	     WHEN BirthDate <= dateadd(YY,+21, getdate()) AND BirthDate <= dateadd(YY,-59, getdate()) THEN 'Adults'
		 WHEN BirthDate <= dateadd(YY,+60, getdate()) AND BirthDate <= dateadd(YY,-75, getdate())  THEN 'Eldery'
	ELSE 'Senile'
	END as Category
FROM HumanResources.Employee h
	JOIN Person.Person p ON h.BusinessEntityID=p.BusinessEntityID

--3
SELECT Color, MAX(StandardCost) AS MAX_COST
FROM Production.Product
GROUP BY Color

Mark: 6
