DROP database IF EXISTS appstore;
CREATE database appstore;
\c appstore;

CREATE TABLE datiaccesso (
	username VARCHAR(32) PRIMARY KEY,
	email VARCHAR(64) NOT NULL UNIQUE,
	password VARCHAR(32) NOT NULL,
    telefono BIGINT UNIQUE DEFAULT NULL
);
/* creazione di due indici secondari per ottimizzare una possibile ricerca basata su uno degli attributi */
	CREATE INDEX telefono ON datiaccesso(telefono);
	CREATE INDEX email ON datiaccesso(email);

CREATE TABLE sviluppatore (
	nome VARCHAR(32) PRIMARY KEY,
	email VARCHAR(64) NOT NULL UNIQUE,
	sitoweb VARCHAR(64) NOT NULL
);

CREATE TABLE videogioco (
	nomepacchetto VARCHAR(64) PRIMARY KEY,
	versione DECIMAL(5,2) NOT NULL,
	requisiti VARCHAR(128) NOT NULL,
	nome VARCHAR(64) NOT NULL,
	dimensione DECIMAL(8,2) NOT NULL,
	prezzo DECIMAL(6,2) NOT NULL,
	descrizione VARCHAR(512) NOT NULL,
	nomesviluppatore VARCHAR(32) NOT NULL,
	FOREIGN KEY (nomesviluppatore) REFERENCES sviluppatore(nome)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);

CREATE TYPE gender AS ENUM ('M', 'F', 'm', 'f');
CREATE TABLE datianagrafici (
	username VARCHAR(32) PRIMARY KEY,
	nome VARCHAR(32) NOT NULL,
	cognome VARCHAR(32) NOT NULL,
	sesso gender NOT NULL,
	CF CHAR(16) NOT NULL,
	luogonascita VARCHAR(64) NOT NULL,
	datanascita DATE NOT NULL,
	FOREIGN KEY (username) REFERENCES datiaccesso(username)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE pagamento (
	idpagamento SERIAL PRIMARY KEY,
	username VARCHAR(32) NOT NULL,
	videogioco VARCHAR(64) NOT NULL,
	data date NOT NULL,
	
	FOREIGN KEY (username) REFERENCES datiaccesso(username)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);

CREATE TYPE etapegi AS ENUM ('3', '7', '12', '16', '18');
CREATE TABLE pegi ( 
	idpegi SERIAL PRIMARY KEY,
	videogioco VARCHAR(64) NOT NULL,
	motivazione VARCHAR(256) DEFAULT NULL,
	minimoeta etapegi NOT NULL,
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE categoria (
	idcategoria SERIAL PRIMARY KEY,
	nome VARCHAR(32) NOT NULL
);

CREATE TABLE appartiene (
	videogioco VARCHAR(64) NOT NULL,
	categoria INT NOT NULL,
	
	PRIMARY KEY(videogioco,categoria),
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	
	FOREIGN KEY (categoria) REFERENCES categoria(idcategoria)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);

CREATE TABLE scarica (
	username VARCHAR(32) NOT NULL,
	videogioco VARCHAR(64) NOT NULL,
	pagamento INT NOT NULL,
	
	PRIMARY KEY(username,videogioco,pagamento),
	
	FOREIGN KEY (username) REFERENCES datiaccesso(username)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE NO ACTION
	ON UPDATE SET NULL,
	
	FOREIGN KEY (pagamento) REFERENCES pagamento(idpagamento)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE recensione (
	username VARCHAR(32) NOT NULL,
	videogioco VARCHAR(64) NOT NULL,
	idrecensione SERIAL PRIMARY KEY	NOT NULL,
	testo VARCHAR(256) NOT NULL,
	valutazione SMALLINT NOT NULL,
	data_recensione DATE NOT NULL,
	
	UNIQUE (username,videogioco,idrecensione),
	
	FOREIGN KEY (username) REFERENCES datiaccesso(username)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE SET NULL 
	ON UPDATE CASCADE
);

CREATE TABLE listaversioni (
	videogioco VARCHAR(64) NOT NULL,
	versione DECIMAL (5,2) NOT NULL,
	data_listaversioni DATE NOT NULL,
	
	PRIMARY KEY (videogioco,versione),
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);

CREATE TABLE codice (
	codice CHAR(16) PRIMARY KEY NOT NULL,
	scadenza DATE NOT NULL,
	videogioco VARCHAR(64) NOT NULL,
	pagamento INT NOT NULL,
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	FOREIGN KEY (pagamento) REFERENCES pagamento(idpagamento)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE carta (
	numero BIGINT PRIMARY KEY,
	ccv2 SMALLINT NOT NULL,
	titolare VARCHAR(64) NOT NULL,
	scadenza DATE NOT NULL
);

CREATE TABLE concarta (
	pagamento INT PRIMARY KEY,
	carta BIGINT NOT NULL,
	
	UNIQUE (pagamento,carta),
	
	FOREIGN KEY (pagamento) REFERENCES pagamento(idpagamento)
	ON DELETE NO ACTION 
	ON UPDATE CASCADE,
	
	FOREIGN KEY (carta) REFERENCES carta(numero)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);

CREATE TABLE listadesideri (
	username VARCHAR(32) NOT NULL,
	videogioco VARCHAR(64) NOT NULL,
	data_listadesideri DATE NOT NULL,
	
	PRIMARY KEY (username,videogioco),
	
	FOREIGN KEY (username) REFERENCES datiaccesso(username)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	FOREIGN KEY (videogioco) REFERENCES videogioco(nomepacchetto)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);


