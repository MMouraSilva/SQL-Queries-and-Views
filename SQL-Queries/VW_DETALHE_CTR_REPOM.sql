--CREATE VIEW VW_DETALHE_CTR_REPOM AS
SELECT VDS.TIPO, VDS.DATCAD, VDS.CODCON, VDS.SERCON, VDS.CODFIL, VDS.SITUAC, VDS.TOTFRE, VDS.SOMA_PESCAL, FIL.CODEMP, CLIP.CODCLIFOR,
CLIP.FISJUR, CLIP.CODCGC, CLIP.CODCPF, CLIP.RAZSOC, IMACO.CODMAN, IMACO.SERMAN, IMACO.FILMAN, IMACO.SOMA_PESCAL_MAN, IMACO.CODIGO_CFR,
IMACO.SERSUB_CFR, IMACO.CODFIL_CFR, IMACO.VLRFRE, IMACO.SITUAC_CFR, IMACO.VLRPED, IMACO.OUTDEB, IMACO.OUTCRE, IMACO.SITUAC_MAN, IMACO.TIPMAN,
ORN.SOMA_PESCAL_NOT, ORN.CODORD_NOT, ORN.SERORD_NOT, ORN.FILORD_NOT, ORN.CODMAN_NOT, ORN.SERMAN_NOT, ORN.FILMAN_NOT, ORN.SOMA_PESCAL_MAN_NOT,
ORN.CODIGO_CFR_NOT, ORN.SERSUB_CFR_NOT, ORN.CODFIL_CFR_NOT, ORN.VLRFRE_NOT, ORN.VLRPED_NOT, ORN.OUTDEB_NOT, ORN.OUTCRE_NOT, ORN.TIPMAN_NOT
FROM VW_CTRC_OST_NF_SS VDS
LEFT OUTER JOIN RODFIL FIL ON VDS.CODFIL=FIL.CODFIL
LEFT OUTER JOIN RODCON CON ON VDS.CODCON=CON.CODCON AND VDS.SERCON=CON.SERCON AND VDS.CODFIL=CON.CODFIL
LEFT OUTER JOIN RODORD ORD ON VDS.CODCON=ORD.CODIGO AND VDS.SERCON=ORD.SERORD AND VDS.CODFIL=ORD.CODFIL
LEFT OUTER JOIN RODCLI CLIP ON VDS.CODPAG=CLIP.CODCLIFOR
LEFT OUTER JOIN VW_RODIMA_DETALHE_CTR_REPOM IMACO ON VDS.CODCON=IMACO.CODDOC_IMACO AND VDS.SERCON=IMACO.SERDOC_IMACO AND VDS.CODFIL=IMACO.FILDOC_IMACO
LEFT OUTER JOIN VW_RODORN_DETALHE_CTR_REPOM ORN ON VDS.CODNOT=ORN.CODNOT AND VDS.SERNOT=ORN.SERNOT AND VDS.FILNOT=ORN.FILNOT