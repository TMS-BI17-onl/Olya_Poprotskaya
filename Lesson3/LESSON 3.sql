--2a
SELECT Name, StandardCost,
CASE
    WHEN  StandardCost = 0 OR StandardCost IS NULL THEN 'Not for sale'
    WHEN StandardCost BETWEEN 1 AND  99 THEN '<$100'
	WHEN StandardCost BETWEEN 100 AND 499 THEN '<&500'
    ELSE '>=$500'
END as PriceRange
FROM Production.Product  

--2b
SELECT p1.ProductID, p1.[BusinessEntityID], p1.StandardPrice, p2.Name
FROM [Purchasing].[ProductVendor] p1
		JOIN  [Purchasing].[Vendor] p2 
		ON p1.[BusinessEntityID] = p2.[BusinessEntityID]
WHERE StandardPrice > 10 
	AND (Name LIKE '%X%' OR NAME LIKE 'N%')

--2c
SELECT Name
FROM Purchasing.Vendor p1
LEFT JOIN Purchasing.ProductVendor p2
ON p1.[BusinessEntityID] = p2.[BusinessEntityID]
WHERE p2.OnOrderQty IS NULL

--3a
SELECT  t1.Name, t2.ListPrice
FROM [Production].[ProductModel] AS t1, [Production].[Product] AS t2
WHERE t1.Name = t2.Name and t1.Name LIKE 'LL%'

--3b
SELECT Name
FROM Purchasing.Vendor
UNION
SELECT Name
FROM Sales.Store
ORDER BY Name

--3c
SELECT Name 
FROM Production.Product 
LEFT JOIN Sales.SpecialOfferProduct
ON Production.Product.ProductID =Sales.SpecialOfferProduct.ProductID
GROUP BY Name
HAVING COUNT (Sales.SpecialOfferProduct.SpecialOfferID) > 1