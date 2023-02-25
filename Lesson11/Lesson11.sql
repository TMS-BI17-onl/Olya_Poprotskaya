SELECT *
FROM [dbo].[data_for_merge]

CREATE TABLE Function_result (
	Function_name nvarchar(50),
	Function_count nvarchar(50)
)
MERGE Function_result target
USING 
	(SELECT Function_name, COUNT (Function_name) AS Function_count
	FROM
	( SELECT  Function_name, Name
	FROM
		(SELECT Alex, Carlos, Charles, Daniel, Esteban, Fred,
				George, Lando, Lewis
		FROM [dbo].[data_for_merge]) f
	UNPIVOT
		( Function_name FOR Name IN
			(Alex, Carlos, Charles, Daniel, Esteban, Fred,
				George, Lando, Lewis)
		) AS unp
	) AS unp
	GROUP BY Function_name
	) source
	ON target.Function_name=source.Function_name
WHEN MATCHED 
	THEN UPDATE SET target.Function_name =source.Function_name,
					target.Function_count =source.Function_count
WHEN NOT MATCHED BY TARGET
	THEN INSERT (Function_name, Function_count)
	VALUES (source.Function_name, source.Function_count)
;

SELECT *
FROM Function_result