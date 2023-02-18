--task2
CREATE TABLE People (
	ID			INT IDENTITY(1,1),
	FirstName	NVARCHAR(20),
	ParentName	NVARCHAR(20),
	LastName	NVARCHAR(20),
	ID_Father	INT,
	ID_Mother INT
);

INSERT INTO People(FirstName, ParentName, LastName, ID_Father, ID_Mother)
VALUES
(N'Дмитрий',N'Алексеевич', N'Иванов', 1,1), 
(N'Олег', N'Ивановмч', N'Смирнов', 2,2), 
(N'Дмитрий', N'Геннадьевич', N'Липский', 3,3), 
(N'Николай',N'Александрович', N'Орехов',4,4)

SELECT *
FROM People

SELECT CONCAT (p1.LastName,' ', p1.FirstName, ' ', p1.ParentName) AS FIO,
		CONCAT (p2.LastName,' ', (LEFT(p2.ParentName, 7)), N'й') AS FIO_Father
FROM People p1 JOIN People p2 ON p1.ID_Father=p2.ID
WHERE p1.FirstName = N'Дмитрий'
