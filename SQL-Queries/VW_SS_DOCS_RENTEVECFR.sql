--CREATE VIEW VW_SS_DOCS_RENTEVECFR AS
SELECT VDR.*, ACE.ID_ACE, ACE.QUANTI, ACE.VLRUNI, EVE.DESCRI
FROM VW_SS_DOCS_RENTCFR VDR
LEFT OUTER JOIN RODCEV CEV ON VDR.CODCFR=CEV.CODCFR AND VDR.SERCFR=CEV.SERCFR AND VDR.FILCFR=CEV.FILCFR
LEFT OUTER JOIN RODACE ACE ON CEV.ID_ACE=ACE.ID_ACE
LEFT OUTER JOIN RODEVE EVE ON ACE.CODEVE=EVE.CODEVE
WHERE ACE.SITUAC NOT IN ('I', 'C') AND ACE.SITUAC IS NOT NULL