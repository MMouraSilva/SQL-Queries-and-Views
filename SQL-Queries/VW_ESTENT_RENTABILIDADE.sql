--CREATE VIEW VW_ESTENT_RENTABILIDADE AS
SELECT VCCM.CODCON, VCCM.SERCON, VCCM.CODFIL, ENT.CODCLIFOR, ENT.NUMDOC, ENT.VLRLIQ, CLI.RAZSOC
FROM VW_CTRC_CHAVE_MATERIAIS VCCM
LEFT OUTER JOIN ESTENT ENT ON VCCM.CHAVE=ENT.REFERE
LEFT OUTER JOIN RODCLI CLI ON ENT.CODCLIFOR=CLI.CODCLIFOR