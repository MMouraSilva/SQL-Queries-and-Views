--CREATE VIEW VW_SS_DOCS_RENTMAN AS
SELECT DISTINCT VDR.*, MAN.CODMAN, MAN.SERMAN, MAN.CODFIL AS 'FILMAN', MAN.TIPMAN, MAN.CUSMAN, MAN.CUSPED, VPM.SOMA_PESCAL AS 'SOMA_PESCAL_MAN',
MAN.PLACA, VEI1.PROPRI AS 'PROPRI_CV', MAN.PLACA2, VEI2.PROPRI AS 'PROPRI_FT', VEI2.CODPRO AS 'CODPRO_FT', LIN.KMTPLA
FROM VW_SS_DOCS_RENTABILIDADE VDR
LEFT OUTER JOIN RODIMA IMA ON VDR.CODCON=IMA.CODDOC AND VDR.SERCON=IMA.SERDOC AND VDR.CODFIL=IMA.FILDOC
LEFT OUTER JOIN RODMAN MAN ON IMA.CODMAN=MAN.CODMAN AND IMA.SERMAN=MAN.SERMAN AND IMA.FILMAN=MAN.CODFIL
LEFT OUTER JOIN VW_MAN_SOMAPESCAL_SEM_SSONIC VPM ON IMA.CODMAN=VPM.CODMAN AND IMA.SERMAN=VPM.SERMAN AND IMA.FILMAN=VPM.CODFIL AND IMA.CODDOC=VPM.CODDOC AND IMA.SERDOC=VPM.SERDOC AND IMA.FILDOC=VPM.FILDOC
LEFT OUTER JOIN RODLIN LIN ON MAN.CODLIN=LIN.CODLIN
LEFT OUTER JOIN RODVEI VEI1 ON MAN.PLACA=VEI1.CODVEI
LEFT OUTER JOIN RODVEI VEI2 ON MAN.PLACA2=VEI2.CODVEI
WHERE MAN.SITUAC NOT IN ('I', 'C') AND VDR.CODFIL=16 AND VDR.SERCON='3' AND VDR.CODCON=157

SELECT DISTINCT * FROM VW_SS_DOCS_RENTMAN WHERE CODFIL=16 AND SERCON='3' AND CODCON=157