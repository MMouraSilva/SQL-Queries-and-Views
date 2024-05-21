CREATE PROCEDURE PROC_EQUALIZA_CONFERENCIA_ENTRADA
	@EntradaFisica INT
AS
BEGIN
	DECLARE @QtdHISUAM INT, @QtdWMSIEN INT, @QtdWMSLEN INT;
	DECLARE @LocEntFis TABLE (
		ID_LEN INT
	);

	SELECT @QtdHISUAM = COUNT(ID_HISUAM) FROM HISUAM WHERE CODDOC=@EntradaFisica;
	SELECT @QtdWMSIEN = COUNT(ID_IEN) FROM WMSIEN WHERE CODENF=@EntradaFisica;
	SELECT @QtdWMSLEN = COUNT(ID_LEN) FROM WMSLEN WHERE CODENF=@EntradaFisica;

	IF @QtdHISUAM > @QtdWMSIEN AND @QtdWMSIEN < @QtdWMSLEN
		BEGIN
			INSERT INTO @LocEntFis (ID_LEN)
			SELECT ID_LEN FROM WMSLEN WLEN
			WHERE FILENF=4 AND CODENF=@EntradaFisica AND
			NOT EXISTS (SELECT * FROM WMSIEN IEN WHERE IEN.CODENF=WLEN.CODENF AND IEN.ID_IEN=WLEN.ID_IEN);

			DELETE WMSLEN WHERE ID_LEN IN (SELECT ID_LEN FROM @LocEntFis);

			INSERT INTO WMSIEN (CODENF, CODFIL, CODPRO, CODLOT, QUANTI, DATATU, USUATU, NUMVOL, PESBRU, CODUAM, DATINC, USUINC, QTDFIS, VOLFIS, CODEMB)
			SELECT UAM.CODDOC, UAM.FILDOC, UAM.CODPRO, UAM.CODLOT, UAM.QUANTI, UAM.DATINC, UAM.USUEND, UAM.NUMVOL, UAM.PESBRU, UAM.CODUAM, UAM.DATINC, UAM.USUEND, UAM.QUANTI, UAM.NUMVOL, UAM.CODEMB
			FROM HISUAM UAM
			WHERE TIPDOC='ENF' AND FILDOC=4 AND CODDOC=@EntradaFisica AND 
			NOT EXISTS (SELECT * FROM WMSIEN WIEN WHERE WIEN.CODLOT=UAM.CODLOT AND WIEN.CODENF=UAM.CODDOC AND WIEN.CODFIL=UAM.FILDOC)

			INSERT INTO WMSLEN (ID_IEN, CODPRO, QUANTI, NUMVOL, CODARM, CODARE, CODLOT, CODUAM, CODENF, FILENF)
			SELECT ID_IEN, CODPRO, QUANTI, NUMVOL, 'AC2P', 'AC2P', CODLOT, CODUAM, CODENF, CODFIL
			FROM WMSIEN IEN
			WHERE CODFIL=4 AND CODENF=@EntradaFisica AND
			NOT EXISTS (SELECT * FROM WMSLEN WLEN WHERE WLEN.ID_IEN=IEN.ID_IEN AND WLEN.CODENF=IEN.CODENF AND WLEN.FILENF=IEN.CODFIL)

			UPDATE WMSENF SET STSCNF='F' WHERE CODENF=@EntradaFisica
		END;
	ELSE IF @QtdHISUAM > @QtdWMSIEN AND @QtdWMSIEN = @QtdWMSLEN
		BEGIN
			INSERT INTO WMSIEN (CODENF, CODFIL, CODPRO, CODLOT, QUANTI, DATATU, USUATU, NUMVOL, PESBRU, CODUAM, DATINC, USUINC, QTDFIS, VOLFIS, CODEMB)
			SELECT UAM.CODDOC, UAM.FILDOC, UAM.CODPRO, UAM.CODLOT, UAM.QUANTI, UAM.DATINC, UAM.USUEND, UAM.NUMVOL, UAM.PESBRU, UAM.CODUAM, UAM.DATINC, UAM.USUEND, UAM.QUANTI, UAM.NUMVOL, UAM.CODEMB
			FROM HISUAM UAM
			WHERE TIPDOC='ENF' AND FILDOC=4 AND CODDOC=@EntradaFisica AND 
			NOT EXISTS (SELECT * FROM WMSIEN WIEN WHERE WIEN.CODLOT=UAM.CODLOT AND WIEN.CODENF=UAM.CODDOC AND WIEN.CODFIL=UAM.FILDOC)

			INSERT INTO WMSLEN (ID_IEN, CODPRO, QUANTI, NUMVOL, CODARM, CODARE, CODLOT, CODUAM, CODENF, FILENF)
			SELECT ID_IEN, CODPRO, QUANTI, NUMVOL, 'AC2P', 'AC2P', CODLOT, CODUAM, CODENF, CODFIL
			FROM WMSIEN IEN
			WHERE CODFIL=4 AND CODENF=@EntradaFisica AND
			NOT EXISTS (SELECT * FROM WMSLEN WLEN WHERE WLEN.ID_IEN=IEN.ID_IEN AND WLEN.CODENF=IEN.CODENF AND WLEN.FILENF=IEN.CODFIL)

			UPDATE WMSENF SET STSCNF='F' WHERE CODENF=@EntradaFisica
		END;
	ELSE
		BEGIN
			SELECT 'Ordem de Servi�o n�o apresenta erros.' AS MENSAGEM
		END;
END;
GO