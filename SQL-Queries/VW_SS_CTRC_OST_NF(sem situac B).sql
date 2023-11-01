--CREATE VIEW [dbo].[VW_SS_CTRC_OST_NF] AS
SELECT 'CTRC' AS TIPO, C.SITUAC AS SITUACAO, C.DATCAD AS DATCAD, C.CODFIL AS CODFIL, C.ESTCOL AS UFCOLETA, FIL.RAZSOC AS NOM_FILIAL,
C.CODCON AS CODCON, C.SERCON AS SERCON, C.PLACA  AS PLACA, C.PLACA2 AS PLACA2, C.PLACA3 AS PLACA3, C.FREPES AS FREPES, C.CODMOT AS CODMOT, 
C.SITUAC AS SITUAC, C.OUTROS AS OUTROS, C.ICMVLR AS ICMVLR, C.CODDES, MDES.ESTADO AS UF_DESTINO, C.CODREM, MREM.ESTADO AS UF_ORIGEM,
C.CODPAG, C.TIPCON AS TIPO_DOC, NULL AS CODNOT, NULL AS FILNOT, NULL AS SERNOT, NULL AS CTRC_OST, NULL AS FILCON, C.DATLIQ AS DATLIQ, 
C.DATPAG AS DATPAG, C.TOTFRE AS TOTFRE, C.VLRLIQ AS VLRLIQ, C.FREVAL AS FREVAL, C.SITDUP AS SITDUP,	C.VLRPED AS PEDAGIO,
(SELECT ISNULL(SUM(QUANTI), 0)
FROM RODNFC I
WHERE I.CODCON = C.CODCON AND I.SERCON = C.SERCON AND I.CODFIL = C.CODFIL) AS SOMA_QUANTI,
(SELECT ISNULL(SUM(PESOKG), 0) FROM RODNFC I WHERE I.CODCON = C.CODCON AND I.SERCON = C.SERCON AND I.CODFIL = C.CODFIL) AS SOMA_PESOKG,
	(SELECT ISNULL(SUM(VLRMER), 0) FROM RODNFC I WHERE I.CODCON = C.CODCON AND I.SERCON = C.SERCON AND I.CODFIL = C.CODFIL) AS SOMA_VLRMER,
		(SELECT ISNULL(DBO.F_NOTAS(C.CODFIL, C.SERCON, C.CODCON, 'CTRC'), '')) AS NOTAS
		FROM RODCON C
		INNER JOIN RODFIL FIL  ON C.CODFIL = FIL.CODFIL
		INNER JOIN RODCLI DES  ON C.CODDES = DES.CODCLIFOR
		INNER JOIN RODMUN MDES ON DES.CODMUN = MDES.CODMUN
		INNER JOIN RODCLI REM ON C.CODREM = REM.CODCLIFOR
		INNER JOIN RODMUN MREM ON REM.CODMUN = MREM.CODMUN
		INNER JOIN RODCLI PAG  ON C.CODPAG = PAG.CODCLIFOR
		WHERE C.SITUAC NOT IN ('I', 'C')

UNION ALL

SELECT 'OST' AS TIPO, O.SITUAC AS SITUACAO, O.DATCAD AS DATCAD, O.CODFIL AS CODFIL, NULL  AS UFCOLETA, FIL.RAZSOC AS NOM_FILIAL, O.CODIGO AS CODCON, 
O.SERORD AS SERCON, O.PLACA  AS PLACA, O.PLACA2 AS PLACA2, O.PLACA3 AS PLACA3, O.FREPES AS FREPES, O.CODMOT AS CODMOT, O.SITUAC AS SITUAC, 
O.OUTROS AS OUTROS, O.ICMVLR AS ICMVLR, O.CODDES, MDES.ESTADO AS UF_DESTINO, O.CODREM, REM.ESTADO AS UF_ORIGEM, O.CODPAG, O.TIPORD AS TIPO_DOC, 
O.CODNOT, O.FILNOT, O.SERNOT, O.CODIGO AS CTRC_OST, O.FILCON, O.DATLIQ AS DATLIQ, O.DATPAG AS DATPAG, O.TOTFRE AS TOTFRE, O.VLRLIQ AS VLRLIQ, 
O.FREVAL AS FREVAL, O.SITDUP AS SITDUP, O.VLRPED AS PEDAGIO, 
(SELECT ISNULL(SUM(QUANTI), 0) FROM RODIOS I WHERE I.CODORD = O.CODIGO AND I.SERORD = O.SERORD AND I.FILORD = O.CODFIL) AS SOMA_QUANTI,
	(SELECT ISNULL(SUM(PESOKG), 0) FROM RODIOS I WHERE I.CODORD = O.CODIGO AND I.SERORD = O.SERORD AND I.FILORD = O.CODFIL) AS SOMA_PESOKG,
		(SELECT ISNULL(SUM(VLRMER), 0) FROM RODIOS I WHERE I.CODORD = O.CODIGO AND I.SERORD = O.SERORD AND I.FILORD = O.CODFIL) AS SOMA_VLEMER,
			(SELECT ISNULL(DBO.F_NOTAS(O.CODFIL, O.SERORD, O.CODIGO, 'OST'), '')) AS NOTAS
			FROM RODORD O 
			INNER JOIN RODFIL FIL  ON O.CODFIL = FIL.CODFIL
			INNER JOIN RODCLI DES  ON O.CODDES = DES.CODCLIFOR
			INNER JOIN RODMUN MDES ON DES.CODMUN = MDES.CODMUN
			INNER JOIN RODCLI REM  ON O.CODREM = REM.CODCLIFOR
			INNER JOIN RODMUN MREM ON REM.CODMUN = MREM.CODMUN
			INNER JOIN RODCLI PAG  ON O.CODPAG = PAG.CODCLIFOR
			WHERE O.SITUAC NOT IN ('I', 'C')

UNION ALL

SELECT 'NF' AS TIPO, D.SITUAC AS SITUACAO, D.DATEMI AS DATCAD, D.CODFIL AS CODFIL, NULL  AS UFCOLETA, FIL.RAZSOC AS NOM_FILIAL, D.CODIGO AS CODCON, 
D.SERSUB AS SERCON, NULL AS PLACA, NULL AS PLACA2, NULL AS PLACA3, NULL AS FREPES, NULL AS CODMOT, D.SITUAC AS SITUAC, NULL AS OUTROS, NULL AS ICMVLR, 
NULL AS CODDES,	NULL AS UF_DESTINO, NULL AS CODREM, NULL AS UF_ORIGEM, D.CODCLIFOR AS CODPAG, 'N' AS TIPO_DOC, D.CODIGO AS CODNOT, D.CODFIL AS FILNOT, 
D.SERSUB AS SERNOT, NULL AS CTRC_OST, NULL AS FILCON, NULL AS DATLIQ, NULL AS DATPAG, --(D.VLRSER+D.VLRISS) AS TOTFRE, 
(D.VLRSER) AS TOTFRE, (D.VLRSER) AS VLRLIQ, NULL AS FREVAL, D.SITDUP AS SITDUP, 0 AS PEDAGIO, 0 AS SOMA_QUANTI, 0 AS SOMA_PESOKG, 0 AS SOMA_VLRMER,
'' AS NOTAS
FROM ESTNOT D 
INNER JOIN RODFIL FIL  ON D.CODFIL = FIL.CODFIL
WHERE D.SERSUB NOT IN ('1', '2') AND D.SITUAC NOT IN ('C', 'I')