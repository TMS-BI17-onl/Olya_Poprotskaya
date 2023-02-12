CREATE PROCEDURE HumanResources.uspEmployee 
   @BusinessEntityID INT,   
	@NationalIDNumber nvarchar(50)   
AS   
UPDATE HumanResources.Employee SET NationalIDNumber = @NationalIDNumber
							WHERE BusinessEntityID = @BusinessEntityID

EXEC HumanResources.uspEmployee @BusinessEntityID = 15, @NationalIDNumber=879341111

--DROP PROCEDURE HumanResources.uspEmployee

--SELECT * FROM HumanResources.Employee


