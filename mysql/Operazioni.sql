# Operazioni sul database

# Utilizzo del database.

USE AppStoreVidegiochi;

# Definizione di un delimitatore.

DELIMITER $$

# Operazione 1: Inserire un nuovo cliente indicando tutti i suoi dati, numero di telefono facoltativo.

DROP PROCEDURE IF EXISTS NuovoUtente;
$$

CREATE PROCEDURE NuovoUtente(
	IN NomeUtente CHAR(32),
	IN eMail CHAR(64),
	IN Password CHAR(64),
	IN NumeroDiTelefono NUMERIC(15),
	IN Nome CHAR(48),
	IN Cognome CHAR(64),
	IN Sesso CHAR(1),
	IN CF CHAR(16),
	IN LuogoNascita CHAR(64),
	IN DataNascita DATE
)
BEGIN
	INSERT INTO DatiAccesso VALUE
    (NomeUtente,eMail,Password,Telefono)
    ;
	INSERT INTO DatiAnagrafici VALUE
    (NomeUtente,Nome,Cognome,Sesso,CF,LuogoNascita,DataNascita)
    ;
END;
$$

# Operazione 2: Modifica dei dati di accesso (username, email, password o telefono) di un cliente.

DROP PROCEDURE IF EXISTS CambiaDatiAccesso;
$$

CREATE PROCEDURE CambiaDatiAccesso (
	IN VecchioUsername CHAR(32),
	IN NuovoUsername CHAR(32),
	IN NuovaeMail CHAR(64),
	IN NuovaPassword CHAR(64),
	IN NuovoTelefono CHAR(64)
)
BEGIN
	# Username.
	IF NuovoUsername <> "" OR NuovoUsername <> NULL THEN
	UPDATE DatiAccesso
		SET
			Username = NuovoUsername
		WHERE
			Username = VecchioUsername
	;
	SET VecchioUsername = NuovoUsername;
    END IF;
    # eMail
	IF NuovaeMail <> "" OR NuovaeMail <> NULL THEN
	UPDATE DatiAccesso
		SET
			eMail = NuovaeMail
		WHERE
			Username = VecchioUsername
	;
    END IF;
    # Password.
	IF NuovaPassword <> "" OR NuovaPassword <> NULL THEN
	UPDATE DatiAccesso
		SET
			Password = NuovaPassword
		WHERE
			Username = VecchioUsername
	;
    END IF;
    # Telefono
	UPDATE DatiAccesso
		SET
			Telefono = NuovoTelefono
		WHERE
			Username = VecchioUsername
	;
END;
$$

# Operazione 3: Inserire un nuovo sviluppatore indicando tutti i suoi dati.

DROP PROCEDURE IF EXISTS NuovoSviluppatore;
$$

CREATE PROCEDURE NuovoSviluppatore (
	IN Nome CHAR(32),
    IN SitoWeb CHAR(32),
    IN eMail CHAR(64)
)
BEGIN
	INSERT INTO Sviluppatore VALUE
    (Nome,SitoWeb,eMail)
    ;
END;
$$

# Operazione 4: Modifica dei dati (nome, sito web o email) di uno sviluppatore.

DROP PROCEDURE IF EXISTS ModificaSviluppatore;
$$

CREATE PROCEDURE ModificaSviluppatore (
	IN VecchioNome CHAR(32),
	IN NuovoNome CHAR(32),
    IN NuovoSitoWeb CHAR(32),
    IN NuovaeMail CHAR(64)
)
BEGIN
	# Username.
	IF NuovoNome <> "" OR NuovoNome <> NULL THEN
	UPDATE Sviluppatore
		SET
			Nome = NuovoNome
		WHERE
			Nome = VecchioNome
	;
	SET VecchioNome = NuovoNome;
    END IF;
    # Sito web.
	IF NuovoSitoWeb <> "" OR NuovoSitoWeb <> NULL THEN
	UPDATE Sviluppatore
		SET
			SitoWeb = NuovoSitoWeb
		WHERE
			Nome = VecchioNome
	;
    END IF;
    # eMail.
	IF NuovaeMail <> "" OR NuovaeMail <> NULL THEN
	UPDATE Sviluppatore
		SET
			eMail = NuovaeMail
		WHERE
			Nome = VecchioNome
	;
    END IF;
END;
$$

# Operazione 5: Inserire un nuovo videogioco e la relativa valutazione PEGI.

DROP PROCEDURE IF EXISTS NuovoVideogiocoValutazione;
$$

CREATE PROCEDURE NuovoVideogiocoValutazione (
	IN NomePacchetto CHAR(64),
    IN Versione DECIMAL(5,2),
    IN Requisiti CHAR(128),
    IN Nome CHAR(64),
    IN Dimensione DECIMAL(8,4),
    IN Prezzo DECIMAL(8,2),
    IN Descrizione CHAR(255),
	IN NomeSvilupatore CHAR(32),
    
    IN Motivazione CHAR(255),
    IN MinimoEta INT UNSIGNED
)
BEGIN
	INSERT INTO Videogioco VALUE
    (NomePacchetto,Versione,Requisiti,Nome,Dimensione,Prezzo,Descrizione,NomeSvilupatore)
    ;
	INSERT INTO PEGI(Videogioco,Motivazione,MinimoEta) VALUE
    (NomePacchetto,Motivazione,MinimoEta)
    ;
END;
$$

# Operazione 6: Aggiornamento di un videogioco già esistente.

DROP PROCEDURE IF EXISTS ModificaVideogioco;
$$

CREATE PROCEDURE ModificaVideogioco (
	IN VecchioNomePacchetto CHAR(64),
	IN NuovoNomePacchetto CHAR(64),
    IN NuoviRequisiti CHAR(128),
    IN NuovoNome CHAR(64),
    IN NuovaDimensione DECIMAL(8,4),
    IN NuovoPrezzo DECIMAL(8,2),
    IN NuovaDescrizione CHAR(255),
	IN NuovoNomeSvilupatore CHAR(32),
    
	IN NuovaMotivazione CHAR(255),
    IN NuovoMinimoEta INT UNSIGNED
)
BEGIN
	# Nome pacchetto.
	IF NuovoNomePacchetto <> "" OR NuovoNomePacchetto <> NULL THEN
	UPDATE Videogioco
		SET
			NomePacchetto = NuovoNomePacchetto
		WHERE
			NomePacchetto = VecchioNomePacchetto
	;
	SET VecchioNomePacchetto = NuovoNomePacchetto;
    END IF;
    # Requisiti.
	IF NuoviRequisiti <> "" OR NuoviRequisiti <> NULL THEN
	UPDATE Videogioco
		SET
			Requisiti = NuoviRequisiti
		WHERE
			NomePacchetto = VecchioNomePacchetto
	;
    END IF;
    # Nome.
	IF NuovoNome <> "" OR NuovoNome <> NULL THEN
	UPDATE Videogioco
		SET
			Nome = NuovoNome
		WHERE
			NomePacchetto = VecchioNomePacchetto
	;
    END IF;
    # Dimensione.
	IF NuovaDimensione > 0 THEN
	UPDATE Videogioco
		SET
			Dimensione = NuovaDimensione
		WHERE
			NomePacchetto = VecchioNomePacchetto
	;
    END IF;
    # Prezzo.
	IF NuovoPrezzo >= 0 THEN
	UPDATE Videogioco
		SET
			Prezzo = NuovoPrezzo
		WHERE
			NomePacchetto = VecchioNomePacchetto
	;
    END IF;
    # Descrizione.
	IF NuovaDescrizione <> "" OR NuovaDescrizione <> NULL THEN
	UPDATE Videogioco
		SET
			Descrizione = NuovaDescrizione
		WHERE
			NomePacchetto = VecchioNomePacchetto
	;
    END IF;
    # Nome sviluppatore.
	IF NuovoNomeSvilupatore <> "" OR NuovoNomeSvilupatore <> NULL THEN
	UPDATE Videogioco
		SET
			NomeSvilupatore = NuovoNomeSvilupatore
		WHERE
			NomePacchetto = VecchioNomePacchetto
	;
    END IF;
    # Motivazione PEGI.
	IF NuovaMotivazione <> "" OR NuovaMotivazione <> NULL THEN
	UPDATE PEGI
		SET
			Motivazione = NuovaMotivazione
		WHERE
			Videogioco = VecchioNomePacchetto
	;
    END IF;
    # Minimo età PEGI.
	IF NuovoMinimoEta >= 3 THEN
	UPDATE PEGI
		SET
			MinimoEta = NuovoMinimoEta
		WHERE
			Videogioco = VecchioNomePacchetto
	;
    END IF;
END;
$$

# Operazione 7: Inserire una recensione relativa ad un videogioco.

DROP PROCEDURE IF EXISTS RecensioneVideogioco;
$$

CREATE PROCEDURE RecensioneVideogioco (
    IN Username CHAR(32),
    IN NomePacchettoVideogioco CHAR(64),
    IN Testo CHAR(255),
    IN Valutazione INT UNSIGNED
)
BEGIN
	INSERT INTO Recensione(Username,Videogioco,Testo,Valutazione,Data) VALUE
    (Username,NomePacchettoVideogioco,Testo,Valutazione,curdate())
    ;
END;
$$

# Operazione 8: Calcolare la media delle recensioni per un determinato videogioco.

DROP PROCEDURE IF EXISTS MediaRecensioniVideogioco;
$$

CREATE PROCEDURE MediaRecensioniVideogioco (
    IN NomePacchettoVideogioco CHAR(64)
)
BEGIN
	SELECT R.Videogioco AS NomePacchetto, V.Nome AS Nome,  AVG(R.Valutazione)
    FROM Recensione AS R, Videogioco AS V
    WHERE R.Videogioco = NomePacchettoVideogioco AND R.Videogioco = V.NomePacchetto
    GROUP BY R.Videogioco;
END;
$$

# Operazione 9: Stampare tutti i videogiochi che fanno parte di una categoria.

DROP PROCEDURE IF EXISTS VideogiochiCategoria;
$$

CREATE PROCEDURE VideogiochiCategoria (
    IN idCategoria INT UNSIGNED
)
BEGIN
	SELECT Videogioco AS NomePacchetto, V.Nome AS Nome, C.Nome AS Categoria
    FROM Categoria AS C, Appartiene AS A, Videogioco AS V
    WHERE C.idCategoria = A.Categoria AND V.NomePacchetto = A.Videogioco AND A.Categoria = idCategoria;
END;
$$

# Operazione 10: Cercare tutti i videogiochi prodotti da uno sviluppatore.

DROP PROCEDURE IF EXISTS VideogiochiSviluppatore;
$$

CREATE PROCEDURE VideogiochiSviluppatore (
    IN NomeSviluppatore CHAR(32)
)
BEGIN
	SELECT V.NomePacchetto AS NomePacchetto, V.Nome AS Nome
    FROM Videogioco AS V
    WHERE V.NomeSvilupatore = NomeSviluppatore;
END;
$$

# Operazione 11: Aggiungere/Eliminare una categoria da un videogioco.

DROP PROCEDURE IF EXISTS AggiungiEliminaCategoriaVideogioco;
$$

CREATE PROCEDURE AggiungiEliminaCategoriaVideogioco (
    IN NomePacchettoVideogioco CHAR(64),
	IN idCategoria INT UNSIGNED
)
AggiungiEliminaCategoriaVideogioco:BEGIN
	# Nel caso esiste già viene eliminato il record.
	IF EXISTS (
		SELECT *
        FROM Appartiene AS A
        WHERE A.Videogioco = NomePacchettoVideogioco AND A.Categoria = idCategoria
    ) THEN
		DELETE FROM Appartiene
        WHERE Appartiene.Videogioco = NomePacchettoVideogioco AND Appartiene.Categoria = idCategoria;
        LEAVE AggiungiEliminaCategoriaVideogioco;
    END IF;
    # Nel caso non esiste viene creato.
	IF NOT EXISTS (
		SELECT *
        FROM Appartiene AS A
        WHERE A.Videogioco = NomePacchettoVideogioco AND A.Categoria = idCategoria
    ) THEN
		INSERT INTO Appartiene VALUE
        (NomePacchettoVideogioco,idCategoria)
        ;
        LEAVE AggiungiEliminaCategoriaVideogioco;
    END IF;
END;
$$

# Operazione 12: Aggiungere un videogioco alla lista degli acquisti di un utente, salvando anche i dati di pagamento.

DROP PROCEDURE IF EXISTS PagaVideogiocoConCarta;
$$

CREATE PROCEDURE PagaVideogiocoConCarta (
    IN NomePacchettoVideogioco CHAR(64),
    IN Username CHAR(32),
	IN Numero NUMERIC(16),
    IN CVV2 NUMERIC(3),
    IN Titolare CHAR(32),
    IN Scadenza DATE
)
BEGIN
	IF NOT EXISTS (
		SELECT Numero
        FROM Carta AS C
        WHERE C.Numero = Numero
    ) THEN
		INSERT INTO Carta VALUE
        (Numero,CVV2,Titolare,Scadenza)
        ;
    END IF;
    
    INSERT INTO Pagamento(Username,Videogioco,Data) VALUE
    (Username,NomePacchettoVideogioco,curdate())
    ;
    
    INSERT INTO ConCarta VALUE
    (last_insert_id(),Numero)
    ;
    
    INSERT INTO Scarica VALUE
    (Username,NomePacchettoVideogioco,last_insert_id())
    ;
END;
$$

DROP PROCEDURE IF EXISTS PagaVideogiocoConCodice;
$$

CREATE PROCEDURE PagaVideogiocoConCodice (
    IN NomePacchettoVideogioco CHAR(64),
    IN Username CHAR(32),
	IN Codice CHAR(16)
)
BEGIN
	IF EXISTS (
		SELECT *
        FROM Codice AS C
        WHERE C.Codice = Codice AND C.Videogioco = NomePacchettoVideogioco
    ) THEN
		INSERT INTO Pagamento(Username,Videogioco,Data) VALUE
		(Username,NomePacchettoVideogioco,curdate())
		;
		
		INSERT INTO Scarica VALUE
		(Username,NomePacchettoVideogioco,last_insert_id())
		;
        
        DELETE FROM Codice AS C WHERE C.Codice = Codice;
    END IF;
END;
$$

# Operazione 13: Aggiungere o rimuovere un gioco dalla lista dei desideri.

DROP PROCEDURE IF EXISTS AggiungiEliminaDesideriVideogioco;
$$

CREATE PROCEDURE AggiungiEliminaDesideriVideogioco (
    IN Username CHAR(64),
    IN NomePacchettoVideogioco CHAR(64)
)
AggiungiEliminaDesideriVideogioco:BEGIN
	# Nel caso esiste già viene eliminato il record.
	IF EXISTS (
		SELECT *
        FROM ListaDesideri AS L
        WHERE L.Videogioco = NomePacchettoVideogioco AND L.Username = Username
    ) THEN
		DELETE FROM ListaDesideri
        WHERE ListaDesideri.Videogioco = NomePacchettoVideogioco AND ListaDesideri.Username = Username;
        LEAVE AggiungiEliminaDesideriVideogioco;
    END IF;
    # Nel caso non esiste viene creato.
	IF NOT EXISTS (
		SELECT *
        FROM ListaDesideri AS L
        WHERE L.Videogioco = NomePacchettoVideogioco AND L.Username = Username
    ) THEN
		INSERT INTO ListaDesideri VALUE
        (Username,NomePacchettoVideogioco,curdate())
        ;
        LEAVE AggiungiEliminaDesideriVideogioco;
    END IF;
END;
$$

# Operazione 14: Stampare una lista contenente l’email di ogni cliente registrato.

DROP VIEW IF EXISTS EmailClienti;
$$

CREATE VIEW EmailClienti
AS
	SELECT D.Nome AS Nome, D.Cognome AS Cognome, D.CF AS CodiceFiscale, DA.eMail AS eMail
    FROM DatiAccesso AS DA, DatiAnagrafici AS D
    WHERE DA.Username = D.Username;
$$

# Operazione 15: Trovare ogni cliente che abbia acquistato un determinato videogioco.

DROP PROCEDURE IF EXISTS ClientiVideogioco;
$$

CREATE PROCEDURE ClientiVideogioco (
    IN NomePacchettoVideogioco CHAR(64)
)
BEGIN
	SELECT DA.Username AS Username, DA.Nome AS Nome, DA.Cognome AS Cognome, DA.CF AS CodiceFiscale
    FROM DatiAnagrafici AS DA, Scarica AS S
    WHERE S.Username = DA.Username AND S.Videogioco = NomePacchettoVideogioco;
END;
$$

# Operazione 16: Stampare la lista delle versioni precedenti per un videogioco.

DROP PROCEDURE IF EXISTS VersioniPrecedentiVideogioco;
$$

CREATE PROCEDURE VersioniPrecedentiVideogioco (
    IN NomePacchettoVideogioco CHAR(64)
)
BEGIN
	SELECT Versione
    FROM ListaVersioni AS LV
    WHERE (LV.Versione) NOT IN (
		SELECT Versione
		FROM ListaVersioni AS LV
		WHERE LV.Data = (
			SELECT MAX(Data)
			FROM ListaVersioni
			WHERE Videogioco = NomePacchettoVideogioco
		)
    ) AND LV.Videogioco = NomePacchettoVideogioco
    
    UNION
    
    SELECT Versione
    FROM Videogioco AS V
    WHERE V.NomePacchetto = NomePacchettoVideogioco AND EXISTS (
		SELECT *
        FROM ListaVersioni
        WHERE Videogioco = NomePacchettoVideogioco
    );
END;
$$