--CREATE VIEW VW_DETALHE_CTE_TERCEIRO AS
SELECT CON.DATCAD, CLIP.FISJUR, CLIP.CODCGC, CLIP.CODCPF, CLIP.RAZSOC AS 'RAZSOC_PAG', FIL.CODEMP, ENT.CODCLIFOR, ENT.VLRLIQ, CLIE.RAZSOC AS 'RAZSOC_ENT'
FROM RODCON CON
LEFT OUTER JOIN RODCLI CLIP ON CON.CODPAG=CLIP.CODCLIFOR
LEFT OUTER JOIN RODFIL FIL ON CON.CODFIL=FIL.CODFIL
LEFT OUTER JOIN VW_CTRC_CHAVE_MATERIAIS VCCM ON CON.CODCON=VCCM.CODCON AND CON.SERCON=VCCM.SERCON AND CON.CODFIL=VCCM.CODFIL
LEFT OUTER JOIN ESTENT ENT ON VCCM.CHAVE=ENT.REFERE
LEFT OUTER JOIN RODCLI CLIE ON ENT.CODCLIFOR=CLIE.CODCLIFOR
WHERE ENT.VLRLIQ IS NOT NULL AND ENT.CODCLIFOR NOT IN (6137, 484, 17019)