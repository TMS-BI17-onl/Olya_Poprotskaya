CREATE VIEW vTopManagers1
AS
SELECT TOP 50 FirstName, LastName, 
			COUNT (RATING) AS cnt_m,
			RANK() OVER (ORDER BY COUNT(RATING) DESC) AS rnk
FROM
(SELECT LastName, FirstName, SalesDate,COUNT(M.ManagerID) AS cnt,
	CASE WHEN COUNT(M.ManagerID) >= 10 THEN 3
	 WHEN COUNT(M.ManagerID) BETWEEN 5 AND 9 THEN 2
	 WHEN COUNT(M.ManagerID) <5 THEN 1
END AS RATING
FROM Sales s JOIN Managers m ON s.ManagerID=m.ManagerID
GROUP BY FirstName, LastName, SalesDate
--order by cnt desc
) T
GROUP BY FirstName, LastName
ORDER BY cnt_m DESC

SELECT *
FROM vTopManagers1