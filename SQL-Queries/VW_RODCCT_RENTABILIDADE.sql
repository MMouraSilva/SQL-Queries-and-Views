--CREATE VIEW VW_RODCCT_RENTABILIDADE AS
SELECT CCT.CODCON, CCT.SERCON, CCT.CODFIL, CCT.ID_ACE, ACE.VLRUNI, ACE.QUANTI, ACE.SITUAC, CLI.CODCLIFOR, CLI.RAZSOC
FROM RODCCT CCT
LEFT OUTER JOIN RODACE ACE ON CCT.ID_ACE=ACE.ID_ACE
LEFT OUTER JOIN RODVEI VEI ON ACE.CODVEI=VEI.CODVEI
LEFT OUTER JOIN RODCLI CLI ON VEI.CODPRO=CLI.CODCLIFOR