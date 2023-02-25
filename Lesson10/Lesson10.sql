--3
SELECT Year, January, February, December
FROM 
(SELECT DATENAME(YEAR,ModifiedDate) AS Year, OrderQty, DATENAME(MONTH, ModifiedDate) AS Month
    FROM Production.WorkOrder
	) AS p  
PIVOT
( 
	SUM(OrderQty)
	FOR Month IN (January, February, December)
) AS pvt
ORDER BY Year
