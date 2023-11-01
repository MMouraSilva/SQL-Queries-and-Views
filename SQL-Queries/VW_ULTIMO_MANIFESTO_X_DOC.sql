--CREATE VIEW VW_ULTIMO_MANIFESTO_X_DOC AS
SELECT *
FROM (
    SELECT CON.CODFIL AS FILIAL, CON.SERCON AS SERIE, CON.CODCON AS CODIGO, CON.SITUAC, CON.DATINC, MAN.CODFIL AS FILMAN, MAN.SERMAN, MAN.CODMAN,
	MAN.SITUAC AS SITUAC_MAN, MAN.TIPMAN, MAN.DATEMI, MAN.PLACA2, IMA.TIPDOC, CON.TABPAD,
	ROW_NUMBER() OVER (PARTITION BY CON.CODCON, CON.CODFIL, CON.SERCON ORDER BY MAN.DATEMI DESC) AS DATA_ORDER
    FROM RODCON CON
	INNER JOIN RODMAN MAN ON CON.FILMAN=MAN.CODFIL AND CON.SERMAN=MAN.SERMAN AND CON.CODMAN=MAN.CODMAN
	INNER JOIN RODIMA IMA ON CON.CODFIL=IMA.FILDOC AND CON.SERCON=IMA.SERDOC AND CON.CODCON=IMA.CODDOC
	WHERE IMA.TIPDOC='C' AND MAN.CODMAN IS NOT NULL
) DOCS
WHERE DATA_ORDER<=1

UNION ALL

SELECT *
FROM (
    SELECT ORD.CODFIL AS FILIAL, ORD.SERORD AS SERIE, ORD.CODIGO, ORD.SITUAC , ORD.DATINC, MAN.CODFIL AS FILMAN, MAN.SERMAN, MAN.CODMAN,
	MAN.SITUAC AS SITUAC_MAN, MAN.TIPMAN, MAN.DATEMI, MAN.PLACA2, IMA.TIPDOC, ORD.TABPAD,
	ROW_NUMBER() OVER (PARTITION BY ORD.CODIGO, ORD.CODFIL, ORD.SERORD ORDER BY MAN.DATEMI DESC) AS DATA_ORDER
    FROM RODORD ORD
	INNER JOIN RODMAN MAN ON ORD.FILMAN=MAN.CODFIL AND ORD.SERMAN=MAN.SERMAN AND ORD.CODMAN=MAN.CODMAN
	INNER JOIN RODIMA IMA ON ORD.CODFIL=IMA.FILDOC AND ORD.SERORD=IMA.SERDOC AND ORD.CODIGO=IMA.CODDOC
	WHERE IMA.TIPDOC='O' AND MAN.CODMAN IS NOT NULL
) DOCS
WHERE DATA_ORDER<=1