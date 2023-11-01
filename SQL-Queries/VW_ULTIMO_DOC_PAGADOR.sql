--CREATE VIEW VW_ULTIMO_DOC_PAGADOR AS
SELECT *
FROM (
    SELECT CODPAG, PAGADOR, CODFIL, SERIE, CODIGO, DATCAD, SITUAC, CODREM, REMETENTE, CODDES, DESTINATARIO, TIPDOC,
	ROW_NUMBER() OVER (PARTITION BY CODPAG ORDER BY DATCAD DESC) AS DATA_ORDER
    FROM VW_ALL_CTRC_OST_NF
	WHERE SERIE NOT IN ('ST', 'AWB', 'NF') AND SITUAC='E') DOCS
WHERE DATA_ORDER<=1