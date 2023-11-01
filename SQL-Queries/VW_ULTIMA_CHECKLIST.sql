--CREATE VIEW VW_ULTIMA_CHECKLIST AS
SELECT *
FROM (
	SELECT VEI.CODVEI, ECK.CODECK, ECK.ENTSAI,ECK.DATREF,
	ROW_NUMBER() OVER (PARTITION BY VEI.CODVEI ORDER BY ECK.DATREF DESC) AS DATA_ORDER
	FROM RODVEI VEI
	INNER JOIN OSEECK ECK ON VEI.CODVEI=ECK.CODVEI
) DOCS
WHERE DATA_ORDER<=1
ORDER BY CODVEI