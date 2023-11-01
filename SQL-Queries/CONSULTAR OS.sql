SELECT PRO.REFERE, PRO.DESCRI, IMD.CODLOT, MDA.NUMDOC, IMD.QUANTI, IMD.VLRTOT, IMD.VLRUNI, MDA.DATEMI, MDA.DATENT, MDA.SERIE, PRO.CODNCM,
IMD.CODFIS, PRO.CODUNI, 1 AS PALETE, NULL AS SUBLOT, NULL AS LOCALIZACAO, MDA.NFE_ID, MDA.CODCTS, NULL BASE, NULL AS VALOR, NULL AS ALIQUOT,
NULL AS REDUCAO, NULL AS CST, '47.705.660/0004-84' AS FILIAL, NULL AS PROPRIETARIO, 'TEMPORARIO' AS CODUAM, IMD.PESBRU, NULL AS VALIDADE,
IMD.SUBLOT AS FABRICACAO, NULL AS CODAUXPRO, NULL AS CODAUXCLI, NULL AS VALIDA, IMD.SUBLOT AS FABRIC, NULL AS PEDIDO, IMD.NUMVOL, IMD.PESBRU AS PESO,
NULL AS EMBALAGEM
FROM
WMSIMD IMD
LEFT JOIN WMSMDA MDA ON IMD.CODIGO=MDA.CODIGO AND IMD.CODFIL=MDA.CODFIL
LEFT JOIN WMSPRO PRO ON IMD.CODPRO=PRO.CODIGO
WHERE
MDA.CODCTS=151 AND MDA.SITUAC<>'C' AND  MDA.NFE_ID IS NOT NULL