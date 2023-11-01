SELECT HISUAM.*, PRO.REFERE, PRO.DESCRI DESCRI_PRO, EMB.DESCRI DESCRI_EMB, UAM.DESCRI DESCRI_UAM, ENF.FILPED, ENF.CODPED,
(
	SELECT sum(IPE.QUANTI)
	FROM WMSIPE IPE
	WHERE IPE.CODFIL=ENF.FILPED AND IPE.CODIGO=ENF.CODPED AND IPE.CODPRO=HISUAM.CODPRO AND
	isnull(IPE.CODLOT, '')=isnull(HISUAM.CODLOT, '') AND isnull(IPE.SUBLOT, '')=isnull(HISUAM.SUBLOT, '')
) QTDDOC,
(
	SELECT sum(IPE.NUMVOL)
	FROM WMSIPE IPE
	WHERE IPE.CODFIL=ENF.FILPED AND IPE.CODIGO=ENF.CODPED AND IPE.CODPRO=HISUAM.CODPRO AND
	isnull(IPE.CODLOT, '')=isnull(HISUAM.CODLOT, '') AND isnull(IPE.SUBLOT, '')=isnull(HISUAM.SUBLOT, '')
) VOLDOC,
(
	SELECT sum(TOTUAM.QUANTI)
	FROM HISUAM TOTUAM
	WHERE TOTUAM.FILDOC=HISUAM.FILDOC AND TOTUAM.CODDOC=HISUAM.CODDOC AND TOTUAM.CODPRO=HISUAM.CODPRO AND TOTUAM.CODUAM=HISUAM.CODUAM
) QTDCNF,
(
	SELECT sum(TOTUAM.NUMVOL)
	FROM HISUAM TOTUAM
	WHERE TOTUAM.FILDOC=HISUAM.FILDOC AND TOTUAM.CODDOC=HISUAM.CODDOC AND TOTUAM.CODPRO=HISUAM.CODPRO AND TOTUAM.CODUAM=HISUAM.CODUAM
) VOLCNF,
(
	SELECT sum(IPE.QUANTI)
	FROM WMSIPE IPE
	WHERE IPE.CODFIL=ENF.FILPED AND IPE.CODIGO=ENF.CODPED AND IPE.CODPRO=HISUAM.CODPRO AND isnull(IPE.CODLOT, '')=isnull(HISUAM.CODLOT, '') AND
	isnull(IPE.SUBLOT, '')=isnull(HISUAM.SUBLOT, '')
)
-
(
	SELECT sum(TOTUAM.QUANTI)
	FROM HISUAM TOTUAM
	WHERE TOTUAM.FILDOC=HISUAM.FILDOC AND TOTUAM.CODDOC=HISUAM.CODDOC AND TOTUAM.CODPRO=HISUAM.CODPRO
) QTDDIV,
(
	SELECT sum(IPE.NUMVOL)
	FROM WMSIPE IPE
	WHERE IPE.CODFIL=ENF.FILPED AND IPE.CODIGO=ENF.CODPED AND IPE.CODPRO=HISUAM.CODPRO AND isnull(IPE.CODLOT, '')=isnull(HISUAM.CODLOT, '') AND
	isnull(IPE.SUBLOT, '')=isnull(HISUAM.SUBLOT, '')
)
-
(
	SELECT sum(TOTUAM.NUMVOL)
	FROM HISUAM TOTUAM
	WHERE TOTUAM.FILDOC=HISUAM.FILDOC AND TOTUAM.CODDOC=HISUAM.CODDOC AND TOTUAM.CODPRO=HISUAM.CODPRO
) VOLDIV
FROM HISUAM
INNER JOIN WMSPRO PRO ON PRO.CODIGO=HISUAM.CODPRO
LEFT OUTER JOIN WMSEMB EMB ON EMB.CODEMB=HISUAM.CODEMB
INNER JOIN WMSUAM UAM ON UAM.CODUAM=HISUAM.CODUAM
LEFT OUTER JOIN WMSENF ENF ON ENF.CODFIL=HISUAM.FILDOC AND ENF.CODENF=HISUAM.CODDOC
WHERE HISUAM.ID_HISUAM>0 AND HISUAM.TIPDOC='ENF' AND HISUAM.TIPDOC='ENF' AND
EXISTS(SELECT 1 FROM WMSENF WHERE HISUAM.CODDOC=WMSENF.CODENF AND HISUAM.FILDOC=WMSENF.CODFIL) AND UAM.DESCRI=1993 --AND WMSENF.CODPED=49560 AND WMSENF.FILPED=4)