--CREATE VIEW VW_ULTIMO_ROMANEIO_CARGA_X_DOC AS
SELECT FILIAL, SERIE, CODIGO, SITUAC, CODRMC, CODFIL_RMC, SITUAC_RMC, DATREF, PLACA2, NOTFIS, TIPDOC
FROM (
	SELECT CON.CODFIL AS FILIAL, CON.SERCON AS SERIE, CON.CODCON AS CODIGO, CON.SITUAC, RMC.CODRMC, RMC.CODFIL AS CODFIL_RMC, RMC.SITUAC AS SITUAC_RMC,
	RMC.DATREF, RMC.PLACA2, IRC.NOTFIS, IRC.TIPDOC,
	ROW_NUMBER() OVER (PARTITION BY CON.CODCON, CON.CODFIL, CON.SERCON, IRC.NOTFIS ORDER BY RMC.DATREF DESC) AS DATA_ORDER
	FROM RODCON CON
	INNER JOIN RODIRC IRC ON CON.CODFIL=IRC.FILDOC AND CON.SERCON=IRC.SERDOC AND CON.CODCON=IRC.CODDOC
	LEFT OUTER JOIN RODRMC RMC ON IRC.CODRMC=RMC.CODRMC AND IRC.FILRMC=RMC.CODFIL
	WHERE IRC.TIPDOC='C' AND RMC.DATREF>='2021-01-01'
) DOCS
WHERE DATA_ORDER<=1

UNION ALL

SELECT FILIAL, SERIE, CODIGO, SITUAC, CODRMC, CODFIL_RMC, SITUAC_RMC, DATREF, PLACA2, NOTFIS, TIPDOC
FROM (
	SELECT ORD.CODFIL AS FILIAL, ORD.SERORD AS SERIE, ORD.CODIGO, ORD.SITUAC, RMC.CODRMC, RMC.CODFIL AS CODFIL_RMC, RMC.SITUAC AS SITUAC_RMC,
	RMC.DATREF, RMC.PLACA2, IRC.NOTFIS, IRC.TIPDOC,
	ROW_NUMBER() OVER (PARTITION BY ORD.CODCON, ORD.CODFIL, ORD.SERCON, IRC.NOTFIS ORDER BY RMC.DATREF DESC) AS DATA_ORDER
	FROM RODORD ORD
	INNER JOIN RODIRC IRC ON ORD.CODFIL=IRC.FILDOC AND ORD.SERORD=IRC.SERDOC AND ORD.CODIGO=IRC.CODDOC
	LEFT OUTER JOIN RODRMC RMC ON IRC.CODRMC=RMC.CODRMC AND IRC.FILRMC=RMC.CODFIL
	WHERE IRC.TIPDOC='O' AND RMC.DATREF>='2021-01-01'
) DOCS
WHERE DATA_ORDER<=1