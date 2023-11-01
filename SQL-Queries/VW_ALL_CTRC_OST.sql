--CREATE VIEW VW_ALL_CTRC_OST AS
SELECT CODCON AS 'CODIGO', SERCON AS 'SERIE', CODFIL, DATCAD, SITUAC, USUATU, CODDES, CODREM,
CODPAG, CODMOT, PLACA, FREVAL, FREPES, ICMVLR AS 'ICMS/ISS', VLCOMP, VLRENT, TOTFRE, FILMAN, CODMAN, SERMAN, 'CTRC' AS TIPDOC
FROM RODCON

UNION ALL

SELECT CODIGO, SERORD AS 'SERIE', CODFIL, DATCAD, SITUAC, USUATU, CODDES, CODREM,
CODPAG, CODMOT, PLACA, FREVAL, FREPES, VLRISS AS 'ICMS/ISS', VLCOMP, VLRENT, TOTFRE, FILMAN, CODMAN, SERMAN, 'OST' AS TIPDOC
FROM RODORD