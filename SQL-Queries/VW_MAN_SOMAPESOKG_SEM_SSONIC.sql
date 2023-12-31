--CREATE VIEW VW_MAN_SOMAPESOKG_SEM_SSONIC AS
SELECT CON.DATCAD, MAN.DATEMI, MAN.CODFIL, MAN.TIPMAN, MAN.SERMAN, MAN.CODMAN, MAN.CODLIN, IMA.FILDOC, IMA.SERDOC, IMA.CODDOC, CON.TOTFRE AS FRETE_CLIENTE,
IMA.CUSMAN AS CUSTODOC, MAN.CUSMAN AS CUSTOMAN, MAN.CUSPED AS CUSPED, CON.CODPAG,
(
	SELECT SUM (PESOKG)
	FROM RODIMA I
	INNER JOIN RODCON C ON I.FILDOC=C.CODFIL AND I.SERDOC=C.SERCON AND I.CODDOC=C.CODCON
	INNER JOIN RODCLI CL ON C.CODPAG=CL.CODCLIFOR
	WHERE I.CODMAN=MAN.CODMAN AND I.FILMAN=MAN.CODFIL AND I.SERMAN=MAN.SERMAN AND REPLACE(LEFT(CL.CODCGC, 10), '.', '') <> '47705660'
) AS SOMA_PESOKG, IMA.PESOKG 
FROM RODMAN MAN
INNER JOIN RODIMA IMA ON MAN.CODFIL=IMA.FILMAN AND MAN.CODMAN=IMA.CODMAN AND MAN.SERMAN=IMA.SERMAN
INNER JOIN RODCON CON ON IMA.FILDOC=CON.CODFIL AND IMA.SERDOC=CON.SERCON AND IMA.CODDOC=CON.CODCON
WHERE MAN.TIPMAN IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14) AND MAN.SITUAC IN ('D', 'E', 'B') AND IMA.TIPDOC='C'

UNION ALL

SELECT ORD.DATCAD, MAN.DATEMI, MAN.CODFIL, MAN.TIPMAN, MAN.SERMAN, MAN.CODMAN, MAN.CODLIN, IMA.FILDOC, IMA.SERDOC, IMA.CODDOC, ORD.TOTFRE AS FRETE_CLIENTE,
IMA.CUSMAN AS CUSTODOC, MAN.CUSMAN AS CUSTOMAN, MAN.CUSPED AS CUSPED, ORD.CODPAG,
(
	SELECT SUM (PESOKG)
	FROM RODIMA I
	INNER JOIN RODORD O ON I.FILDOC=O.CODFIL AND I.SERDOC=O.SERORD AND I.CODDOC=O.CODIGO
	INNER JOIN RODCLI CL ON O.CODPAG=CL.CODCLIFOR
	WHERE I.CODMAN=MAN.CODMAN AND I.FILMAN=MAN.CODFIL AND I.SERMAN=MAN.SERMAN AND REPLACE(LEFT(CL.CODCGC, 10), '.', '') <> '47705660'
) AS SOMA_PESOKG, IMA.PESOKG
FROM RODMAN MAN
INNER JOIN RODIMA IMA ON MAN.CODFIL=IMA.FILMAN AND MAN.CODMAN=IMA.CODMAN AND MAN.SERMAN=IMA.SERMAN
INNER JOIN RODORD ORD ON IMA.FILDOC=ORD.CODFIL AND IMA.SERDOC=ORD.SERORD AND IMA.CODDOC=ORD.CODIGO
WHERE MAN.TIPMAN IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14) AND MAN.SITUAC IN ('D', 'E', 'B') AND IMA.TIPDOC='O'