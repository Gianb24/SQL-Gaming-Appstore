# Creazione del database e delle tabelle con trigger

# Eventuale cancellazione del database già esistente.

DROP DATABASE IF EXISTS AppStoreVidegiochi;

# Creazione del database.

CREATE DATABASE IF NOT EXISTS AppStoreVidegiochi;

# Utilizzo del database.

USE AppStoreVidegiochi;

# Creazione delle tabelle.

CREATE TABLE DatiAccesso (
	Username CHAR(32) PRIMARY KEY NOT NULL,
	Email CHAR(64) NOT NULL,
	Password CHAR(64) NOT NULL,
    Telefono NUMERIC(15)
);

CREATE TABLE Sviluppatore (
	Nome CHAR(32) PRIMARY KEY NOT NULL,
    SitoWeb CHAR(32) NOT NULL,
    eMail CHAR(64) NOT NULL
);

CREATE TABLE Videogioco (
	NomePacchetto CHAR(64) PRIMARY KEY NOT NULL,
    Versione DECIMAL(5,2) NOT NULL,
    Requisiti CHAR(128) NOT NULL,
    Nome CHAR(64) NOT NULL,
    Dimensione DECIMAL(8,4) NOT NULL,
    Prezzo DECIMAL(8,2) NOT NULL,
    Descrizione CHAR(255) NOT NULL,
	NomeSvilupatore CHAR(32) NOT NULL,
    
    FOREIGN KEY (NomeSvilupatore) REFERENCES Sviluppatore(Nome)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE DatiAnagrafici (
	Username CHAR(32) PRIMARY KEY NOT NULL,
    Nome CHAR(48) NOT NULL,
    Cognome CHAR(64) NOT NULL,
    Sesso CHAR(1) NOT NULL,
    CF CHAR(16) NOT NULL,
    LuogoNascita CHAR(64) NOT NULL,
    DataNascita DATE NOT NULL,
    
    UNIQUE (CF),
    
    FOREIGN KEY (Username) REFERENCES DatiAccesso(Username)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Pagamento (
	idPagamento INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Username CHAR(32) NOT NULL,
    Videogioco CHAR(64) NOT NULL,
    Data DATE NOT NULL,
    
    UNIQUE (Username,Videogioco),
    
    FOREIGN KEY (Username) REFERENCES DatiAccesso(Username)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE PEGI (
	idPEGI INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Videogioco CHAR(64) NOT NULL,
    Motivazione CHAR(255),
    MinimoEta INT UNSIGNED NOT NULL,
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE Categoria (
	idCategoria INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome CHAR(64) NOT NULL
);

CREATE TABLE Appartiene (
	Videogioco CHAR(64) NOT NULL,
    Categoria INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (Videogioco, Categoria),
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Categoria) REFERENCES Categoria(idCategoria)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Scarica (
    Username CHAR(32) NOT NULL,
    Videogioco CHAR(64) NOT NULL,
    Pagamento INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (Username, Videogioco, Pagamento),
    
    FOREIGN KEY (Username) REFERENCES DatiAccesso(Username)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Pagamento) REFERENCES Pagamento(idPagamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Recensione (
    Username CHAR(32) NOT NULL,
    Videogioco CHAR(64) NOT NULL,
    idRecensione INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Testo CHAR(255) NOT NULL,
    Valutazione INT UNSIGNED NOT NULL,
    Data DATE NOT NULL,
    
    UNIQUE (Username,Videogioco,idRecensione),
    
    FOREIGN KEY (Username) REFERENCES DatiAccesso(Username)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE ListaVersioni (
    Videogioco CHAR(64) NOT NULL,
    Versione DECIMAL(5,2) NOT NULL,
    Data DATE NOT NULL,
    
    PRIMARY KEY (Videogioco,Versione),
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE Codice (
	Codice CHAR(16) PRIMARY KEY NOT NULL,
    Scadenza DATE NOT NULL,
    Videogioco CHAR(64) NOT NULL,
    Pagamento INT UNSIGNED NOT NULL,
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Pagamento) REFERENCES Pagamento(idPagamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Carta (
	Numero NUMERIC(16) PRIMARY KEY NOT NULL,
    CVV2 NUMERIC(3) NOT NULL,
    Titolare CHAR(32) NOT NULL,
    Scadenza DATE NOT NULL
);

CREATE TABLE ConCarta (
	Pagamento INT UNSIGNED PRIMARY KEY NOT NULL,
    Carta NUMERIC(16) NOT NULL,
    
    UNIQUE (Pagamento,Carta),
    
    FOREIGN KEY (Pagamento) REFERENCES Pagamento(idPagamento)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Carta) REFERENCES Carta(Numero)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE ListaDesideri (
    Username CHAR(32) NOT NULL,
    Videogioco CHAR(64) NOT NULL,
    Data DATE NOT NULL,
    
	PRIMARY KEY (Username, Videogioco),
    
    FOREIGN KEY (Username) REFERENCES DatiAccesso(Username)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    FOREIGN KEY (Videogioco) REFERENCES Videogioco(NomePacchetto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

# Creazione dei trigger per i vincoli di input in inserimento e aggiornamento.
#
# Viene verificata la validità di:
#
# - eMail dei dati di accesso e sviluppatori (deve contentere la @)
# - dimensione di un videogioco (in qualunque unità la si può andare a misurare non può essere nulla)
# - sesso nei dati anagrafici  (ammessi solo "M" ed "F")
# - età minime nelle valutazioni PEGI (può esere solo 3,7,12,16 e 18 anni)
# - valutazioni nelle recensioni (può essere da 1 a 5 inclusi)
# - date di scadenza di carte di credito e codici download (non si possono immettere codici o carte di credito già scadute)

# Definizione di un delimitatore.

DELIMITER $$

# Trigger di inserimento.

CREATE TRIGGER Username_DatiAccesso_Inserimento
	BEFORE INSERT ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Username = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "L'username dell'utente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER eMail_DatiAccesso_Inserimento
	BEFORE INSERT ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Email NOT LIKE "%@%"
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "L'eMail dell'utente non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Password_DatiAccesso_Inserimento
	BEFORE INSERT ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Password = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La password dell'utente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Telefono_DatiAccesso_Inserimento
	BEFORE INSERT ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Telefono < 1000000
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il numero di telefono non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_Sviluppatore_Inserimento
	BEFORE INSERT ON Sviluppatore FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome dello sviluppatore non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER SitoWeb_Sviluppatore_Inserimento
	BEFORE INSERT ON Sviluppatore FOR EACH ROW
		BEGIN
			IF NEW.SitoWeb = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il sito web dello sviluppatore non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER eMail_Sviluppatore_Inserimento
	BEFORE INSERT ON Sviluppatore FOR EACH ROW
		BEGIN
			IF NEW.Email NOT LIKE "%@%"
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "L'eMail dello sviluppatore non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER NomePacchetto_Videogioco_Inserimento
	BEFORE INSERT ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.NomePacchetto = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome pacchetto del videogioco non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Versione_Videogioco_Inserimento
	BEFORE INSERT ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Versione < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La versione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Requisiti_Videogioco_Inserimento
	BEFORE INSERT ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Requisiti = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "I requisiti del videogioco non sono validi.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_Videogioco_Inserimento
	BEFORE INSERT ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome del videogioco non è valido.";
            END IF;
		END;
$$
        
CREATE TRIGGER Dimensione_Videogioco_Inserimento
	BEFORE INSERT ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Dimensione <= 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La dimensione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Prezzo_Videogioco_Inserimento
	BEFORE INSERT ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Prezzo < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il prezzo del videogioco non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Descrizione_Videogioco_Inserimento
	BEFORE INSERT ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Descrizione = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La descrizione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_DatiAnagrafici_Inserimento
	BEFORE INSERT ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Cognome_DatiAnagrafici_Inserimento
	BEFORE INSERT ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.Cognome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il cognome del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Sesso_DatiAnagrafici_Inserimento
	BEFORE INSERT ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.Sesso <> "M" AND NEW.Sesso <> "F"
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il sesso del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER CF_DatiAnagrafici_Inserimento
	BEFORE INSERT ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF char_length(NEW.CF) <> 16
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il codice fiscale del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER LuogoNascita_DatiAnagrafici_Inserimento
	BEFORE INSERT ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.LuogoNascita = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il luogo di nascita del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Motivazione_PEGI_Inserimento
	BEFORE INSERT ON PEGI FOR EACH ROW
		BEGIN
			IF NEW.Motivazione = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La motivazione della valutazione PEGI non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER MinimoEta_PEGI_Inserimento
	BEFORE INSERT ON PEGI FOR EACH ROW
		BEGIN
			IF NEW.MinimoEta <> 3 AND NEW.MinimoEta <> 7 AND NEW.MinimoEta <> 12 AND NEW.MinimoEta <> 16 AND NEW.MinimoEta <> 18
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La valutazione PEGI non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_Categoria_Inserimento
	BEFORE INSERT ON Categoria FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome della categoria non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Testo_Recensione_Inserimento
	BEFORE INSERT ON Recensione FOR EACH ROW
		BEGIN
			IF NEW.Testo = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il testo della recensione non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Valutazione_Recensione_Inserimento
	BEFORE INSERT ON Recensione FOR EACH ROW
		BEGIN
			IF NEW.Valutazione < 1 OR NEW.Valutazione > 5
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La valutazione della recensione non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Versione_ListaVersioni_Inserimento
	BEFORE INSERT ON ListaVersioni FOR EACH ROW
		BEGIN
			IF NEW.Versione < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La versione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Codice_Codice_Inserimento
	BEFORE INSERT ON Codice FOR EACH ROW
		BEGIN
			IF char_length(NEW.Codice) <> 16
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il codice inserito non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Scadenza_Codice_Inserimento
	BEFORE INSERT ON Codice FOR EACH ROW
		BEGIN
			IF datediff(NEW.Scadenza,curdate()) < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il codice inserito è scaduto.";
            END IF;
		END;
$$

CREATE TRIGGER Numero_Carta_Inserimento
	BEFORE INSERT ON Carta FOR EACH ROW
		BEGIN
			IF NEW.Numero < 1000000000000000
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il numero della carta non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER CVV2_Carta_Inserimento
	BEFORE INSERT ON Carta FOR EACH ROW
		BEGIN
			IF NEW.CVV2 < 100
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il CVV2 della carta non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Titolare_Carta_Inserimento
	BEFORE INSERT ON Carta FOR EACH ROW
		BEGIN
			IF NEW.Titolare = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il titolare della carta non è valido.";
            END IF;
		END;
$$


CREATE TRIGGER Scadenza_Carta_Inserimento
	BEFORE INSERT ON Carta FOR EACH ROW
		BEGIN
			IF datediff(NEW.Scadenza,curdate()) < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La carta di credito inserita è scaduta.";
            END IF;
		END;
$$

# Trigger di aggiornamento.

CREATE TRIGGER Username_DatiAccesso_Aggiornamento
	BEFORE UPDATE ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Username = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "L'username dell'utente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER eMail_DatiAccesso_Aggiornamento
	BEFORE UPDATE ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Email NOT LIKE "%@%"
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "L'eMail dell'utente non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Password_DatiAccesso_Aggiornamento
	BEFORE UPDATE ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Password = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La password dell'utente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Telefono_DatiAccesso_Aggiornamento
	BEFORE UPDATE ON DatiAccesso FOR EACH ROW
		BEGIN
			IF NEW.Telefono < 1000000
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il numero di telefono non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_Sviluppatore_Aggiornamento
	BEFORE UPDATE ON Sviluppatore FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome dello sviluppatore non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER SitoWeb_Sviluppatore_Aggiornamento
	BEFORE UPDATE ON Sviluppatore FOR EACH ROW
		BEGIN
			IF NEW.SitoWeb = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il sito web dello sviluppatore non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER eMail_Sviluppatore_Aggiornamento
	BEFORE UPDATE ON Sviluppatore FOR EACH ROW
		BEGIN
			IF NEW.Email NOT LIKE "%@%"
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "L'eMail dello sviluppatore non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER NomePacchetto_Videogioco_Aggiornamento
	BEFORE UPDATE ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.NomePacchetto = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome pacchetto del videogioco non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Versione_Videogioco_Aggiornamento
	BEFORE UPDATE ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Versione < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La versione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Requisiti_Videogioco_Aggiornamento
	BEFORE UPDATE ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Requisiti = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "I requisiti del videogioco non sono validi.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_Videogioco_Aggiornamento
	BEFORE UPDATE ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome del videogioco non è valido.";
            END IF;
		END;
$$
        
CREATE TRIGGER Dimensione_Videogioco_Aggiornamento
	BEFORE UPDATE ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Dimensione <= 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La dimensione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Prezzo_Videogioco_Aggiornamento
	BEFORE UPDATE ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Prezzo < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il prezzo del videogioco non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Descrizione_Videogioco_Aggiornamento
	BEFORE UPDATE ON Videogioco FOR EACH ROW
		BEGIN
			IF NEW.Descrizione = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La descrizione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_DatiAnagrafici_Aggiornamento
	BEFORE UPDATE ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Cognome_DatiAnagrafici_Aggiornamento
	BEFORE UPDATE ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.Cognome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il cognome del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Sesso_DatiAnagrafici_Aggiornamento
	BEFORE UPDATE ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.Sesso <> "M" AND NEW.Sesso <> "F"
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il sesso del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER CF_DatiAnagrafici_Aggiornamento
	BEFORE UPDATE ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF char_length(NEW.CF) <> 16
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il codice fiscale del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER LuogoNascita_DatiAnagrafici_Aggiornamento
	BEFORE UPDATE ON DatiAnagrafici FOR EACH ROW
		BEGIN
			IF NEW.LuogoNascita = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il luogo di nascita del cliente non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Motivazione_PEGI_Aggiornamento
	BEFORE UPDATE ON PEGI FOR EACH ROW
		BEGIN
			IF NEW.Motivazione = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La motivazione della valutazione PEGI non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER MinimoEta_PEGI_Aggiornamento
	BEFORE UPDATE ON PEGI FOR EACH ROW
		BEGIN
			IF NEW.MinimoEta <> 3 AND NEW.MinimoEta <> 7 AND NEW.MinimoEta <> 12 AND NEW.MinimoEta <> 16 AND NEW.MinimoEta <> 18
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La valutazione PEGI non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Nome_Categoria_Aggiornamento
	BEFORE UPDATE ON Categoria FOR EACH ROW
		BEGIN
			IF NEW.Nome = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il nome della categoria non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Testo_Recensione_Aggiornamento
	BEFORE UPDATE ON Recensione FOR EACH ROW
		BEGIN
			IF NEW.Testo = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il testo della recensione non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Valutazione_Recensione_Aggiornamento
	BEFORE UPDATE ON Recensione FOR EACH ROW
		BEGIN
			IF NEW.Valutazione < 1 OR NEW.Valutazione > 5
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La valutazione della recensione non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Versione_ListaVersioni_Aggiornamento
	BEFORE UPDATE ON ListaVersioni FOR EACH ROW
		BEGIN
			IF NEW.Versione < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La versione del videogioco non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Codice_Codice_Aggiornamento
	BEFORE UPDATE ON Codice FOR EACH ROW
		BEGIN
			IF char_length(NEW.Codice) <> 16
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il codice inserito non è valida.";
            END IF;
		END;
$$

CREATE TRIGGER Scadenza_Codice_Aggiornamento
	BEFORE UPDATE ON Codice FOR EACH ROW
		BEGIN
			IF datediff(NEW.Scadenza,curdate()) < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il codice inserito è scaduto.";
            END IF;
		END;
$$

CREATE TRIGGER Numero_Carta_Aggiornamento
	BEFORE UPDATE ON Carta FOR EACH ROW
		BEGIN
			IF NEW.Numero < 1000000000000000
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il numero della carta non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER CVV2_Carta_Aggiornamento
	BEFORE UPDATE ON Carta FOR EACH ROW
		BEGIN
			IF NEW.CVV2 < 100
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il CVV2 della carta non è valido.";
            END IF;
		END;
$$

CREATE TRIGGER Titolare_Carta_Aggiornamento
	BEFORE UPDATE ON Carta FOR EACH ROW
		BEGIN
			IF NEW.Titolare = ""
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "Il titolare della carta non è valido.";
            END IF;
		END;
$$


CREATE TRIGGER Scadenza_Carta_Aggiornamento
	BEFORE UPDATE ON Carta FOR EACH ROW
		BEGIN
			IF datediff(NEW.Scadenza,curdate()) < 0
            THEN
				SIGNAL SQLSTATE "45000"
                SET MESSAGE_TEXT = "La carta di credito inserita è scaduta.";
            END IF;
		END;
$$