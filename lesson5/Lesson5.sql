--6
CREATE TABLE Patients
(
    Patients_id		INT IDENTITY(1,1),
    FirstName		CHAR(100), 
    LastName		NVARCHAR(100), 
    SSN				uniqueidentifier NOT NULL  
						DEFAULT newid(),
	Email			AS (UPPER(LEFT(FirsTName,1)) + LEFT(LastName,3)
						+ '@mail.com'),
	Temp			FLOAT,		
	CreatedDate		DATETIME
);

SELECT *
FROM Patients

--7
INSERT INTO Patients(FirstName, LastName, Temp, CreatedDate)
VALUES
    ( 'Amelia','Brown', 37.0, '2023-01-05' ),
    ('Jack','Evans', 38.6, '2023-01-07'),
	( 'Thomas','Smith', 39.1 ,'2023-01-10')

--8
ALTER TABLE Patients ADD TempType AS 
	CASE
		WHEN Temp<37 THEN '<37C'
		WHEN Temp>37 THEN '>37C'
	ELSE '37C'
	END

--9
CREATE VIEW Patients_v AS
SELECT *, (Temp*9/5+32) AS Temp_F
FROM Patients

--10
CREATE FUNCTION temp_f(
    @temp_c float)
RETURNS FLOAT
AS 
BEGIN
    RETURN @temp_c*9/5+32
END;

--11
--failed to do(
--confuse(