--CREATE VIEW VW_ULTIMA_ENTRADA_PORTARIA_CARRETA AS
SELECT PLACA, TIPMOV, DATENT, DATSAI, CODFIL, CODPOR, OBSER1
FROM (
	SELECT MPO.PLACA, MPO.TIPMOV, MPO.DATENT, MPO.DATSAI, MPO.CODFIL, MPO.CODPOR, MPO.OBSER1,
	ROW_NUMBER() OVER (PARTITION BY VEI.CODVEI ORDER BY MPO.DATENT DESC) AS DATA_ORDER
	FROM RODVEI VEI
	INNER JOIN RODMPO MPO ON VEI.CODVEI=MPO.PLACA
	WHERE VEI.CODFRO=4
) DOCS
WHERE DATA_ORDER<=1 AND TIPMOV='E' AND DATSAI IS NULL