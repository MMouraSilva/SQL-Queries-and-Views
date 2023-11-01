--CREATE VIEW VW_ULTIMO_ROMANEIO_DESCARGA_X_DOC AS
SELECT *
FROM (
	SELECT CON.CODFIL AS FILIAL, CON.SERCON AS SERIE, CON.CODCON AS CODIGO, CON.SITUAC, RMD.CODRMD, RMD.CODFIL AS CODFIL_RMD,
	RMD.SITUAC AS SITUAC_RMD, RMD.DATREF, RMD.CODVEI, IRD.NOTFIS, IRD.TIPDOC, IRD.CODCLIFOR, CLI.RAZSOC, CLI.FISJUR, CLI.CODCGC, CLI.CODCPF,
	CON.CODSEG, SEG.DESCRI, NFC.ID_NFC AS 'ID NF/IOS', NFC.SERIEN, NFC.VLRMER, NFC.VMERSE,
	ROW_NUMBER() OVER (PARTITION BY CON.CODCON, CON.CODFIL, CON.SERCON, IRD.NOTFIS ORDER BY RMD.DATREF DESC) AS DATA_ORDER
	FROM RODCON CON
	INNER JOIN RODIRD IRD ON CON.CODFIL=IRD.FILDOC AND CON.SERCON=IRD.SERDOC AND CON.CODCON=IRD.CODDOC
	LEFT OUTER JOIN RODRMD RMD ON IRD.CODRMD=RMD.CODRMD AND IRD.CODFIL=RMD.CODFIL
	LEFT OUTER JOIN RODNFC NFC ON IRD.FILDOC=NFC.CODFIL AND IRD.SERDOC=NFC.SERCON AND IRD.CODDOC=NFC.CODCON AND IRD.NOTFIS=NFC.NOTFIS
	INNER JOIN RODCLI CLI ON CON.CODPAG=CLI.CODCLIFOR
	INNER JOIN RODSEG SEG ON CON.CODSEG=SEG.CODSEG
	WHERE IRD.TIPDOC='C' AND RMD.DATREF>='2021-01-01'
) DOCS
WHERE DATA_ORDER<=1

UNION ALL

SELECT *
FROM (
	SELECT ORD.CODFIL AS FILIAL, ORD.SERORD AS SERIE, ORD.CODIGO, ORD.SITUAC, RMD.CODRMD, RMD.CODFIL AS CODFIL_RMD,
	RMD.SITUAC AS SITUAC_RMD, RMD.DATREF, RMD.CODVEI, IRD.NOTFIS, IRD.TIPDOC, IRD.CODCLIFOR, CLI.RAZSOC, CLI.FISJUR, CLI.CODCGC, CLI.CODCPF,
	ORD.CODSEG, SEG.DESCRI, IOS.ID_IOS AS 'ID NF/IOS', IOS.SERIEN, IOS.VLRMER, IOS.VMERSE,
	ROW_NUMBER() OVER (PARTITION BY ORD.CODIGO, ORD.CODFIL, ORD.SERORD, IRD.NOTFIS ORDER BY RMD.DATREF DESC) AS DATA_ORDER
	FROM RODORD ORD
	INNER JOIN RODIRD IRD ON ORD.CODFIL=IRD.FILDOC AND ORD.SERORD=IRD.SERDOC AND ORD.CODIGO=IRD.CODDOC
	LEFT OUTER JOIN RODRMD RMD ON IRD.CODRMD=RMD.CODRMD AND IRD.CODFIL=RMD.CODFIL
	LEFT OUTER JOIN RODIOS IOS ON IRD.FILDOC=IOS.CODORD AND IRD.SERDOC=IOS.SERORD AND IRD.CODDOC=IOS.CODORD AND IRD.NOTFIS=IOS.NOTFIS
	INNER JOIN RODCLI CLI ON ORD.CODPAG=CLI.CODCLIFOR
	INNER JOIN RODSEG SEG ON ORD.CODSEG=SEG.CODSEG
	WHERE IRD.TIPDOC='O' AND RMD.DATREF>='2021-01-01'
) DOCS
WHERE DATA_ORDER<=1