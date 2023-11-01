SELECT PED.CODFIL, PED.CODIGO, PED.CODCTS, PED.CODCLIFOR, IPE.CODPRO, SUM(IPE.NUMVOL) NUMVOL, SUM(IPE.QUANTI) QUANTI, 
ISNULL(IPE.CODLOT,'') CODLOT, ISNULL(IPE.SUBLOT,'') SUBLOT, CLI.RAZSOC, PRO.DESCRI DESCRI_PRODUTO, PRO.REFERE,
(
	SELECT sum(HISUAM.QUANTI)
	FROM HISUAM
	INNER JOIN WMSENF ENF ON ENF.CODENF=HISUAM.CODDOC AND ENF.CODFIL=HISUAM.FILDOC
	WHERE HISUAM.TIPDOC='ENF' AND ENF.CODPED=PED.CODIGO AND ENF.FILPED=PED.CODFIL AND HISUAM.CODPRO=IPE.CODPRO AND
	(isnull(HISUAM.CODLOT, '')=isnull(IPE.CODLOT,'') OR isnull(IPE.CODLOT,'') = '' )
) QTDCNF,
(
	SELECT sum(HISUAM.NUMVOL)
	FROM HISUAM
	INNER JOIN WMSENF ENF ON ENF.CODENF=HISUAM.CODDOC AND ENF.CODFIL=HISUAM.FILDOC
	WHERE HISUAM.TIPDOC='ENF' AND ENF.CODPED=PED.CODIGO AND ENF.FILPED=PED.CODFIL AND HISUAM.CODPRO=IPE.CODPRO AND
	(isnull(HISUAM.CODLOT, '')=isnull(IPE.CODLOT,'') OR isnull(IPE.CODLOT,'') = '' )
) VOLCNF,
SUM(IPE.QUANTI)
-
(
	SELECT sum(HISUAM.QUANTI)
	FROM HISUAM
	INNER JOIN WMSENF ENF ON ENF.CODENF=HISUAM.CODDOC AND ENF.CODFIL=HISUAM.FILDOC
	WHERE HISUAM.TIPDOC='ENF' AND ENF.CODPED=PED.CODIGO AND ENF.FILPED=PED.CODFIL AND HISUAM.CODPRO=IPE.CODPRO AND
	(isnull(HISUAM.CODLOT, '')=isnull(IPE.CODLOT,'') OR isnull(IPE.CODLOT,'')='')
) QTDDIV,
SUM(IPE.NUMVOL)
-
(
	SELECT sum(HISUAM.NUMVOL)
	FROM HISUAM
	INNER JOIN WMSENF ENF ON ENF.CODENF=HISUAM.CODDOC AND ENF.CODFIL=HISUAM.FILDOC
	WHERE HISUAM.TIPDOC='ENF' AND ENF.CODPED=PED.CODIGO AND ENF.FILPED=PED.CODFIL AND HISUAM.CODPRO=IPE.CODPRO AND
	(isnull(HISUAM.CODLOT, '')=isnull(IPE.CODLOT,'') OR isnull(IPE.CODLOT,'')='')
) VOLDIV,
ENF.STSCNF AS SITDOC, '0' AS FORAPEDIDO
FROM WMSPED PED
INNER JOIN WMSIPE IPE ON IPE.CODFIL=PED.CODFIL AND IPE.CODIGO=PED.CODIGO
INNER JOIN WMSENF ENF ON ENF.CODPED=PED.CODIGO AND ENF.FILPED=PED.CODFIL
INNER JOIN RODCLI CLI ON CLI.CODCLIFOR=PED.CODCLIFOR
INNER JOIN WMSPRO PRO ON IPE.CODPRO=PRO.CODIGO
WHERE ENF.CODCTS=147 --AND ISNULL(ENF.STSCNF,'')='E'
GROUP BY PED.CODFIL, PED.CODIGO, PED.CODCTS, PED.CODCLIFOR, IPE.CODPRO, isnull(IPE.CODLOT, ''), isnull(IPE.SUBLOT, ''),
CLI.RAZSOC, PRO.DESCRI, ENF.STSCNF, IPE.CODLOT, PRO.REFERE

SELECT * FROM WMSIPE

SELECT PED.CODFIL, PED.CODIGO, PED.CODCTS, PED.CODCLIFOR, --IPE.CODPRO, --SUM(IPE.NUMVOL) NUMVOL, SUM(IPE.QUANTI) QUANTI, 
CLI.RAZSOC, --PRO.DESCRI DESCRI_PRODUTO, PRO.REFERE,
ENF.STSCNF AS SITDOC
FROM WMSPED PED
--INNER JOIN WMSIPE IPE ON IPE.CODFIL=PED.CODFIL AND IPE.CODIGO=PED.CODIGO
INNER JOIN WMSENF ENF ON ENF.CODPED=PED.CODIGO AND ENF.FILPED=PED.CODFIL
INNER JOIN RODCLI CLI ON CLI.CODCLIFOR=PED.CODCLIFOR
--INNER JOIN WMSPRO PRO ON IPE.CODPRO=PRO.CODIGO
WHERE ENF.CODCTS=147