--CREATE VIEW VW_WMS_QTD_PEDIDO_DIVERGENTE AS
SELECT * FROM (
	SELECT IPE.CODIGO AS CODPED, IPE.CODFIL, IPE.CODPRO, PRO.REFERE, PRO.DESCRI, TXT.QUANTI AS QUANTI_PEDIDO, SUM(IPE.QUANTI) AS QUANTI_DIVERGENTE
	FROM WMSIPE IPE
	LEFT OUTER JOIN PEDIDO_ARMAZENAGEM_TXT TXT ON IPE.CODIGO=TXT.CODPED AND IPE.CODPRO=TXT.CODPRO
	LEFT OUTER JOIN WMSPRO PRO ON IPE.CODPRO=PRO.CODIGO
	WHERE
	(
		IPE.QUANTI<>(
			SELECT SUM(ATX.QUANTI)
			FROM PEDIDO_ARMAZENAGEM_TXT ATX
			WHERE ATX.CODPED=IPE.CODIGO AND ATX.CODFIL=IPE.CODFIL AND ATX.CODPRO=IPE.CODPRO
			GROUP�BY�ATX.CODPRO
		) OR 
		NOT EXISTS (	
			SELECT PTX.CODPRO
			FROM PEDIDO_ARMAZENAGEM_TXT PTX
			WHERE PTX.CODPED=IPE.CODIGO AND PTX.CODFIL=IPE.CODFIL AND PTX.CODPRO=IPE.CODPRO
		)
	)
	GROUP BY IPE.CODIGO, IPE.CODFIL, IPE.CODPRO, PRO.REFERE, PRO.DESCRI, TXT.QUANTI
) TAB WHERE QUANTI_PEDIDO<>QUANTI_DIVERGENTE OR QUANTI_PEDIDO IS NULL


--CREATE VIEW VW_WMS_CONFERE_REMESSA AS
SELECT TXT.CODPED, TXT.CODFIL, TXT.CODPRO, PRO.REFERE, PRO.DESCRI, TXT.QUANTI AS QUANTI_REMESSA
FROM PEDIDO_ARMAZENAGEM_TXT TXT
LEFT OUTER JOIN WMSPRO PRO ON TXT.CODPRO=PRO.CODIGO
WHERE TXT.CODPED=51628 AND
(
	NOT EXISTS (	
		SELECT PED.CODPRO
		FROM WMSIPE PED
		WHERE PED.CODIGO=TXT.CODPED AND PED.CODFIL=TXT.CODFIL AND PED.CODPRO=TXT.CODPRO
	)
)

SELECT * FROM WMSPLOC WHERE CODAAR='ABL2'

SELECT * FROM WMSIOS WHERE CODLOT='U315213055'

SELECT * FROM WMSAPT WHERE CODAPT=3207

SELECT * FROM WMSPRO WHERE REFERE='1005750'

SELECT CLI.RAZSOC, SUM(IPE.QUANTI) AS QUANTI_SA�DA FROM WMSIPE IPE
LEFT OUTER JOIN WMSOSA OSA ON IPE.CODIGO=OSA.CODPED AND IPE.CODFIL=OSA.FILPED
LEFT OUTER JOIN RODCLI CLI ON OSA.CODPRO=CLI.CODCLIFOR
WHERE IPE.CODIGO IN (51638, 51639, 51640, 51641, 51642, 51643, 51644, 51645, 51646, 51647, 51648, 51649, 51650, 51651, 51652, 51653, 51654, 51655, 51656, 51657, 51658, 51659, 51660,
51661, 51662, 51663, 51664, 51665, 51666, 51667, 51668, 51669, 51670, 51671, 51672, 51673, 51674)
GROUP BY CLI.RAZSOC
UNION ALL
SELECT 'TOTAL' AS RAZSOC, SUM(IPE.QUANTI) AS QUANTI_SA�DA
FROM WMSIPE IPE
WHERE IPE.CODIGO IN (51638, 51639, 51640, 51641, 51642, 51643, 51644, 51645, 51646, 51647, 51648, 51649, 51650, 51651, 51652, 51653, 51654, 51655, 51656, 51657, 51658, 51659, 51660,
51661, 51662, 51663, 51664, 51665, 51666, 51667, 51668, 51669, 51670, 51671, 51672, 51673, 51674)


SELECT * FROM WMSOSA WHERE CODOSA=

SELECT * FROM WMSPLOC WHERE CODUAM=13340 CODLOT='U315716336'

SELECT * FROM WMSPRO WHERE REFERE='1002555'

SELECT * FROM WMSIOS WHERE CODPRO=22565 AND DATINC>='2023-07-18'

SELECT PRO.REFERE, * FROM WMSPLOC PLOC
LEFT OUTER JOIN WMSPRO PRO ON PLOC.CODPRO=PRO.CODIGO
WHERE CODUAM=13577

select distinct pro.descri, ipe.coduam
from wmsipe ipe
left outer join wmspro pro on ipe.codpro=pro.codigo
where ipe.codigo=51664
group by pro.descri, ipe.coduam

SELECT * FROM VW_WMS_CONFERE_REMESSA WHERE CODPED=51684

--CREATE VIEW VW_WMS_CONFERE_REMESSA AS
SELECT TXT.CODPED, TXT.CODFIL, TXT.CODPRO, PRO.REFERE, PRO.DESCRI, TXT.QUANTI AS QUANTI_REMESSA
FROM PEDIDO_ARMAZENAGEM_TXT TXT
LEFT OUTER JOIN WMSPRO PRO ON TXT.CODPRO=PRO.CODIGO
WHERE TXT.CODPED=51628 AND
(
	NOT EXISTS (	
		SELECT PED.CODPRO
		FROM WMSIPE PED
		WHERE PED.CODIGO=TXT.CODPED AND PED.CODFIL=TXT.CODFIL AND PED.CODPRO=TXT.CODPRO
	)
)

SELECT PED.CODPRO
FROM WMSIPE PED
WHERE PED.CODIGO=51684 AND PED.CODFIL=4 AND PED.CODPRO=23818

SELECT * FROM WMSPRO WHERE CODIGO=23818

SELECT IPE.CODIGO, IPE.CODLOT, PRO.REFERE, PRO.DESCRI, IPE.CODUAM
FROM WMSIPE IPE
LEFT OUTER JOIN WMSPRO PRO ON IPE.CODPRO=PRO.CODIGO
WHERE IPE.CODIGO=51684 AND CODPRO=23814

SELECT DISTINCT CODUAM FROM WMSIPE WHERE CODIGO=51684

SELECT PRO.REFERE, * FROM WMSIPE IPE
LEFT OUTER JOIN WMSPRO PRO ON IPE.CODPRO=PRO.CODIGO
WHERE CODUAM=13617

SELECT * FROM WMSPRO WHERE CODIGO=22590

SELECT * FROM WMSEDI WHERE CODQUA='QCD03' AND CODRUA='RCD2'

SELECT PRO.REFERE, PRO.DESCRI, PLOC.CODUAM, CAST(SUM(PLOC.SALFIS) AS INT)
FROM WMSPLOC PLOC
LEFT OUTER JOIN WMSPRO PRO ON PLOC.CODPRO=PRO.CODIGO
WHERE CODUAM=13609
GROUP BY PRO.REFERE, PRO.DESCRI, PLOC.CODUAM

SELECT * FROM WMSIOS WHERE CODOSA=62435 AND CODPRO=23814
SELECT * FROM WMSIPE WHERE CODIGO=51659 AND CODLOT IN ('B316546376', 'B316546386', 'B316546377') AND 
SELECT * FROM WMSPLOC WHERE CODLOT IN ('B316546376', 'B316546386', 'B316546377')
SELECT * FROM WMSPLOC WHERE 

SELECT STSCNF, * FROM WMSOSA WHERE CODOSA=63251

SELECT STSCNF, * FROM WMSOSA WHERE CODOSA=62435
UPDATE WMSOSA SET STSCNF='C' WHERE CODOSA=62433
SELECT * FROM WMSOSA WHERE CODPED=51660

SELECT * FROM WMSPRO WHERE REFERE='1000274'

SELECT DISTINCT CODUAM FROM WMSIPE WHERE CODUAM=13571


SELECT * FROM WMSIOS WHERE CODUAM=10454

SELECT * FROM WMSPRON
WHERE CODLOT IN (
'B316728282',
'B316728283',
'B316728287',
'B317613053',
'B317613054',
'B317613055',
'B317613056',
'B317613302',
'B317613303',
'B317613304',
'B317613305',
'B317613336',
'B317613337',
'B317625855',
'B317625856')

UPDATE WMSPRON SET ID_IMD=IOS.ID_IMD
FROM WMSPRON PRON
LEFT OUTER JOIN WMSIOS IOS ON PRON.ID_IMD=IOS.ID_IMD
WHERE IOS.CODOSA=63249 AND IOS.CODLOT IN ('B316728282',
'B316728283',
'B316728287',
'B317613053',
'B317613054',
'B317613055',
'B317613056',
'B317613302',
'B317613303',
'B317613304',
'B317613305',
'B317613336',
'B317613337',
'B317625855',
'B317625856')

SELECT * FROM WMSPLOC WHERE CODUAM=10454

SELECT * FROM WMSMDA WHERE CODPED IN (51712, 51713, 51714, 51715, 51716,51717, 51718, 51737, 51738, 51739, 51740)

SELECT ENF.CODPED, OSA.CODOSA, * FROM WMSMDA MDA
LEFT OUTER JOIN WMSENF ENF ON MDA.CODENF=ENF.CODENF
LEFT OUTER JOIN WMSOSA OSA ON ENF.CODENF=OSA.CODENF
WHERE MDA.CODENF IN (
19259,
19260,
19261,
19262,
19263,
19264,
19265,
19266,
19267,
19268,
19269)

SELECT 
SUBSTRING(PED.OBSERV,30,17) AS ARQUIVO, PED.CODIGO AS PEDIDO, CAST(TOTAL AS int) AS TOTAL,
'UA' AS UA, '.' AS FISICA,
OSA.CODOSA AS OS, 'M50' AS TIP, PED.CLIPED, 'AGUARDANDO' AS STATUS, CLI.RAZSOC
FROM
(
SELECT
CODFIL, CODPED, SUM(QUANTI) AS TOTAL
 FROM PEDIDO_ARMAZENAGEM_TXT
 GROUP BY CODFIL, CODPED
 ) AS TTL
LEFT JOIN WMSPED PED ON TTL.CODFIL=PED.CODFIL AND TTL.CODPED=PED.CODIGO
LEFT JOIN WMSOSA OSA ON PED.CODFIL=OSA.FILPED AND PED.CODIGO=OSA.CODPED
LEFT JOIN RODCLI CLI ON OSA.CODPRO=CLI.CODCLIFOR
WHERE PED.CODCTS = '153' AND PED.SITUAC <> 'C'
ORDER BY�CODIGO,�CLIPED

SELECT * FROM WMSPRO WHERE CODIGO=22557

SELECT * FROM WMSIOS WHERE CODPRO=22585 AND CODARM<>'A4PB' AND CODARM<>'A4'

SELECT * FROM WMSPLOC WHERE CODLOT='B308622723'

SELECT PRO.DESCRI, IPE.CODLOT FROM WMSPLOC IPE
LEFT OUTER JOIN WMSPRO PRO ON IPE.CODPRO=PRO.CODIGO
WHERE IPE.CODLOT IN ('b310023867',
'b310023871',
'b310023874',
'u102211671',
'u102211672',
'u102211673',
'u310410361',
'u310410372',
'u310410373',
'u316412920')

SELECT * FROM WMSIPE WHERE CODUAM=013511

SELECT * FROM WMSPLOC WHERE CODUAM=013511

SELECT STSCNF, * FROM WMSOSA WHERE CODOSA=63256

UPDATE WMSIPE SET CODUAM='' WHERE CODUAM=013511

SELECT * FROM WMSIOS WHERE CODOSA=63941 AND CODLOT='B314923989'