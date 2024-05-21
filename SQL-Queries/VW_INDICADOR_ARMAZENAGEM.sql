--CREATE VIEW VW_INDICADOR_ARMAZENAGEM AS
SELECT DISTINCT CODARM, CODAAR, --CODQUA, CODAPT, CODUAM,
TOTAL_PRODUTOS, --PRODUTOS_POR_UA,
SUM(PRODUTOS_POR_UA) OVER(PARTITION BY CODARM, CODAAR) AS PRODUTOS_POR_LOCALIZACAO,
100 * SUM(PRODUTOS_POR_UA) OVER(PARTITION BY CODARM, CODAAR) / TOTAL_PRODUTOS AS PORCENTAGEM_PRODUTOS_POR_LOCALIZACAO,
COUNT(CODUAM) OVER() AS TOTAL_PALLETS,
COUNT(CODUAM) OVER(PARTITION BY CODARM, CODAAR) AS PALLETS_POR_LOCALIZACAO
FROM (
	SELECT PLOC.CODARM, PLOC.CODAAR, PLOC.CODQUA, PLOC.CODAPT, 
	SUM(PLOC.SALFIS) OVER() AS TOTAL_PRODUTOS,
	SUM(PLOC.SALFIS) OVER(PARTITION BY PLOC.CODUAM) AS PRODUTOS_POR_UA,
	PLOC.SALVOL, PLOC.CODUAM,
	IOS.VLRUNI, OSA.CODENF,
	ROW_NUMBER() OVER(PARTITION BY PLOC.CODUAM ORDER BY PLOC.CODUAM) AS PALLETS
	FROM WMSPLOC PLOC
	INNER JOIN WMSIOS IOS ON PLOC.ID_IMD=IOS.ID_IMD
	INNER JOIN WMSOSA OSA ON IOS.CODOSA=OSA.CODOSA AND IOS.FILOSA=OSA.CODFIL
	WHERE PLOC.CODUAM IS NOT NULL AND OSA.CODCTS=153 AND OSA.TIPDOC='E'
) AS TAB
WHERE PALLETS=1