# Esempio di utilizzo delle operazioni sul database

# Utilizzo del database.

USE AppStoreVidegiochi;

# Operazione 1: Inserire un nuovo cliente indicando tutti i suoi dati, numero di telefono facoltativo.

CALL NuovoUtente (
	"etacram","7safwat.hack.33u@tronvenho.ga","2cAvgzB6SaGTK9Fy87Bx4kft",NULL,
	"Gaia","Menasce","F","MNSGAI00B48F660F","MONTEVERDE","2000-02-08"
);

SELECT * FROM DatiAccesso;
SELECT * FROM DatiAnagrafici;

# Operazione 2: Modifica dei dati di accesso (username, email, password o telefono) di un cliente.

CALL CambiaDatiAccesso (
	"etacram","idind","dhazem-mensis@keistopdow.gq","59JtuTxjAtyhzYabqUKwtmgh",NULL
);

SELECT * FROM DatiAccesso;

# Operazione 3: Inserire un nuovo sviluppatore indicando tutti i suoi dati.

CALL NuovoSviluppatore (
	"Nintendo","https://www.nintendo.co.jp/","support@nintendo.co.jp"
);

SELECT * FROM Sviluppatore;

# Operazione 4: Modifica dei dati (nome, sito web o email) di uno sviluppatore.

CALL ModificaSviluppatore (
	"Nintendo","Nintendo of Japan",NULL,NULL
);

SELECT * FROM Sviluppatore;

# Operazione 5: Inserire un nuovo videogioco e la relativa valutazione PEGI.

CALL NuovoVideogiocoValutazione (
	"com.nintendo.tetris",1.01,"Almeno 1 GB di RAM","Tetris",64.00,6.49,"La nuovissima versione del rompicapo russo che fa impazzire il mondo!!!","Nintendo of Japan",
	NULL,3
);

SELECT * FROM Videogioco;
SELECT * FROM PEGI;

# Operazione 6: Aggiornamento di un videogioco già esistente.

CALL ModificaVideogioco (
	"com.nintendo.tetris",NULL,NULL,NULL,128.00,9.99,"Direttamente dalla Russia, il nuovissimo rompicapo che sta facendo impazzire il mondo!!!",NULL,
	NULL,7
);

SELECT * FROM Videogioco;
SELECT * FROM PEGI;

# Operazione 7: Inserire una recensione relativa ad un videogioco.

CALL RecensioneVideogioco (
	"idind","com.nintendo.tetris","Bello!!!",5
);

SELECT * FROM Recensione;

# Operazione 8: Calcolare la media delle recensioni per un determinato videogioco.

CALL MediaRecensioniVideogioco (
	"com.ladia.sheepsquest"
);

# Operazione 9: Stampare tutti i videogiochi che fanno parte di una categoria.

CALL VideogiochiCategoria (
	7
);

# Operazione 10: Cercare tutti i videogiochi prodotti da uno sviluppatore.

CALL VideogiochiSviluppatore (
	"Intelligent Systems"
);

# Operazione 11: Aggiungere/Eliminare una categoria da un videogioco.

CALL AggiungiEliminaCategoriaVideogioco (
	"com.nintendo.tetris",14
);

CALL AggiungiEliminaCategoriaVideogioco (
	"com.alcachofa.mortadelo",7
);

SELECT * FROM Appartiene;

# Operazione 12: Aggiungere un videogioco alla lista degli acquisti di un utente, salvando anche i dati di pagamento.

CALL PagaVideogiocoConCarta (
	"com.nintendo.tetris","idind",
    4391805607261170,281,"Samuela Farro","2028-08-01"
);

CALL PagaVideogiocoConCodice (
	"com.mystman12.baldibasics","tiape",
    "AYSXQCU6B4FMAJKO"
);

SELECT * FROM Pagamento;
SELECT * FROM Carta;
SELECT * FROM ConCarta;
SELECT * FROM Scarica;
SELECT * FROM Codice;

# Operazione 13: Aggiungere o rimuovere un gioco dalla lista dei desideri.

CALL AggiungiEliminaDesideriVideogioco (
	"ariolari","com.intelligent.papermario"
);

CALL AggiungiEliminaDesideriVideogioco (
	"idind","com.intelligent.papermario"
);

SELECT * FROM ListaDesideri;

# Operazione 14: Stampare una lista contenente l’email di ogni cliente registrato.

SELECT * FROM EmailClienti;

# Operazione 15: Trovare ogni cliente che abbia acquistato un determinato videogioco.

CALL ClientiVideogioco (
	"com.microsoft.solitaire"
);

# Operazione 16: Stampare la lista delle versioni precedenti per un videogioco.

CALL VersioniPrecedentiVideogioco (
	"com.toolkit.mariofunletters"
);

CALL VersioniPrecedentiVideogioco (
	"com.microsoft.solitaire"
);