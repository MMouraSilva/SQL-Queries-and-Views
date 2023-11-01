--CREATE VIEW VW_CALENDARIO AS
SELECT		[Date]
			,DATEPART(year,[Date]) AS [Year]
			,DATEPART(month,[Date]) AS [Month]
			,DATEPART(day,[Date]) AS [Day]
FROM		(
			SELECT
				(a.Number * 256) + b.Number AS N
			FROM 
				(
					SELECT number
					FROM master..spt_values
					WHERE type = 'P' AND number <= 255
				) a (Number),
				(
					SELECT number
					FROM master..spt_values
					WHERE type = 'P' AND number <= 255
				) b (Number)
			) numbers
CROSS APPLY (SELECT DATEADD(day,N,'2000-1-1') AS [Date]) d