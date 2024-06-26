--ALTER VIEW VW_ENVIA_M51_EMAIL AS
SELECT PAT.CODPED, PAT.CODFIL, PAT.CODPRO, PAT.REFCLI, PAT.NUMITE, IPE.QUANTI, IPE.CODLOT, PED.SITUAC, PRF.REFPRF, PRO.CODUNI,
CAST(LIT.DATINC AS DATE) AS DATINC, SUBSTRING(LIT.ARQTXT,77,13) AS ARQTXT
FROM PEDIDO_ARMAZENAGEM_TXT PAT
LEFT OUTER JOIN WMSIPE IPE ON PAT.CODPED=IPE.CODIGO AND PAT.CODFIL=IPE.CODFIL AND PAT.CODPRO=IPE.CODPRO
LEFT OUTER JOIN WMSPED PED ON PAT.CODPED=PED.CODIGO AND PAT.CODFIL=PED.CODFIL
LEFT OUTER JOIN WMSPRO PRO ON PAT.CODPRO=PRO.CODIGO
LEFT OUTER JOIN WMSPRF PRF ON PAT.CODPRO=PRF.CODPRO
LEFT OUTER JOIN LOG_INTEGRACAO_TXT LIT ON PAT.CODPED=LIT.CODDOC AND PAT.CODFIL=LIT.FILDOC
WHERE PED.SITUAC<>'C' AND PAT.DATINC>='2024-03-8'
AND LIT.ARQTXT IS NOT NULL AND LIT.TIPARQ='WMS06' --AND PED.OBSERV NOT LIKE '%ARQUIVO M51 ENVIADO POR E-MAIL%'