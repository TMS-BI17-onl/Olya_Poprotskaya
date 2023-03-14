--TASK 1
SELECT ProductSubcategoryID, MIN(Weight) AS min_weight
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING MIN(Weight) > 150

--TASK 2
--1
SELECT Name, StandardCost
FROM Production.Product
WHERE StandardCost = (SELECT MAX(StandardCost) 
					FROM Production.Product)
					
--2
SELECT TOP 1 WITH TIES Name, StandardCost
FROM Production.Product
ORDER BY StandardCost DESC

--3
SELECT Name, StandardCost
FROM
	(SELECT Name, StandardCost, RANK() OVER (ORDER BY StandardCost DESC) as rnk
	FROM Production.Product
	) T
WHERE rnk=1

--4
SELECT Name, StandardCost
FROM
	(SELECT Name, StandardCost, MAX(StandardCost) OVER () as max_cost
	FROM Production.Product
	) T
WHERE StandardCost=max_cost

--TASK 3
SELECT Name
FROM
	(
	SELECT ID_Customer
	FROM FctOrders o 
	WHERE Rent_Date> DATEADD(YEAR, -1, GETDATE())
	)  O RIGHT JOIN DimCustomer c ON o.ID_Customer=c.ID_Customer
WHERE o.ID_Customer IS NULL

--TASK 4
SELECT e.Full_Name, COUNT(m.MaintenanceID) AS cnt
FROM FctMaintenance m 
	RIGHT JOIN DimEmployees e ON m.EmployeeNumber=e.EmployeeNumber
WHERE DATEDIFF(year, GETDATE(), M.Startdate)<=5
GROUP BY Full_Name

--TASK 5
SELECT u.email, n.category
FROM Notifications n 
		JOIN Users u ON n.user_id_bigint=u.id_bigint
WHERE u.email=alex@gmail.com and n.is_read>50