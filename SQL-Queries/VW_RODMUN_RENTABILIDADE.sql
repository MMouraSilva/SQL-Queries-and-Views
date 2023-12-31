--CREATE VIEW VW_RODMUN_RENTABILIDADE AS
SELECT CON.CODCON, CON.SERCON, CON.CODFIL, MREM.ESTADO AS 'ESTADO_REM', MDEST.ESTADO AS 'ESTADO_DES', MCOL.ESTADO AS 'ESTADO_COL', MENT.ESTADO AS 'ESTADO_ENT'
FROM RODCON CON
LEFT OUTER JOIN RODCLI REM ON CON.CODREM=REM.CODCLIFOR
LEFT OUTER JOIN RODMUN MREM ON REM.CODMUN=MREM.CODMUN
LEFT OUTER JOIN RODCLI DEST ON CON.CODDES=DEST.CODCLIFOR
LEFT OUTER JOIN RODMUN MDEST ON DEST.CODMUN=MDEST.CODMUN
LEFT OUTER JOIN RODCLI COL ON CON.TERCOL=COL.CODCLIFOR
LEFT OUTER JOIN RODMUN MCOL ON COL.CODMUN=MCOL.CODMUN
LEFT OUTER JOIN RODCLI ENT ON CON.TERENT=ENT.CODCLIFOR
LEFT OUTER JOIN RODMUN MENT ON ENT.CODMUN=MENT.CODMUN