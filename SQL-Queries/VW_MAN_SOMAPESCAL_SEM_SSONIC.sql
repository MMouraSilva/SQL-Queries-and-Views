--CREATE VIEW VW_MAN_SOMAPESCAL_SEM_SSONIC AS
SELECT CON.DATCAD, MAN.DATEMI, MAN.CODFIL, MAN.TIPMAN, MAN.SERMAN, MAN.CODMAN, MAN.CODLIN, IMA.FILDOC, IMA.SERDOC, IMA.CODDOC, CON.TOTFRE AS FRETE_CLIENTE,
IMA.CUSMAN AS CUSTODOC, MAN.CUSMAN AS CUSTOMAN, MAN.CUSPED AS CUSPED, CON.CODPAG,
(
	SELECT SUM (NF.PESCAL)
	FROM RODIMA I
	LEFT OUTER JOIN RODCON C ON I.FILDOC=C.CODFIL AND I.SERDOC=C.SERCON AND I.CODDOC=C.CODCON
	LEFT OUTER JOIN RODNFC NF ON C.CODCON=NF.CODCON AND C.SERCON=NF.SERCON AND C.CODFIL=NF.CODFIL
	LEFT OUTER JOIN RODCLI CL ON C.CODPAG=CL.CODCLIFOR
	WHERE I.CODMAN=MAN.CODMAN AND I.FILMAN=MAN.CODFIL AND I.SERMAN=MAN.SERMAN AND (REPLACE(LEFT(CL.CODCGC, 10), '.', '') <> '47705660' OR CL.CODCGC IS NULL)
) AS SOMA_PESCAL, NFC.PESCAL
FROM RODMAN MAN
LEFT OUTER JOIN RODIMA IMA ON MAN.CODFIL=IMA.FILMAN AND MAN.CODMAN=IMA.CODMAN AND MAN.SERMAN=IMA.SERMAN
LEFT OUTER JOIN RODCON CON ON IMA.FILDOC=CON.CODFIL AND IMA.SERDOC=CON.SERCON AND IMA.CODDOC=CON.CODCON
LEFT OUTER JOIN RODNFC NFC ON CON.CODCON=NFC.CODCON AND CON.SERCON=NFC.SERCON AND CON.CODFIL=NFC.CODFIL
WHERE MAN.TIPMAN IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14) AND MAN.SITUAC IN ('D', 'E', 'B') AND IMA.TIPDOC='C'

UNION ALL

SELECT ORD.DATCAD, MAN.DATEMI, MAN.CODFIL, MAN.TIPMAN, MAN.SERMAN, MAN.CODMAN, MAN.CODLIN, IMA.FILDOC, IMA.SERDOC, IMA.CODDOC, ORD.TOTFRE AS FRETE_CLIENTE,
IMA.CUSMAN AS CUSTODOC, MAN.CUSMAN AS CUSTOMAN, MAN.CUSPED AS CUSPED, ORD.CODPAG,
(
	SELECT SUM (PESCAL)
	FROM RODIMA I
	LEFT OUTER JOIN RODORD O ON I.FILDOC=O.CODFIL AND I.SERDOC=O.SERORD AND I.CODDOC=O.CODIGO
	LEFT OUTER JOIN RODIOS OS ON O.CODIGO=OS.CODORD AND O.SERORD=OS.SERORD AND O.CODFIL=OS.FILORD
	LEFT OUTER JOIN RODCLI CL ON O.CODPAG=CL.CODCLIFOR
	WHERE I.CODMAN=MAN.CODMAN AND I.FILMAN=MAN.CODFIL AND I.SERMAN=MAN.SERMAN AND (REPLACE(LEFT(CL.CODCGC, 10), '.', '') <> '47705660' OR CL.CODCGC IS NULL)
) AS SOMA_PESOKG, IOS.PESCAL
FROM RODMAN MAN
LEFT OUTER JOIN RODIMA IMA ON MAN.CODFIL=IMA.FILMAN AND MAN.CODMAN=IMA.CODMAN AND MAN.SERMAN=IMA.SERMAN
LEFT OUTER JOIN RODORD ORD ON IMA.FILDOC=ORD.CODFIL AND IMA.SERDOC=ORD.SERORD AND IMA.CODDOC=ORD.CODIGO
LEFT OUTER JOIN RODIOS IOS ON ORD.CODIGO=IOS.CODORD AND ORD.SERORD=IOS.SERORD AND ORD.CODFIL=IOS.FILORD
WHERE MAN.TIPMAN IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14) AND MAN.SITUAC IN ('D', 'E', 'B') AND IMA.TIPDOC='O'