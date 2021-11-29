/* Operazione 1 */
CALL nuovo_utente('etacram','7safwat.hack.33u@tronvenho.ga','2cAvgzB6SaGTK9Fy87Bx4kft',NULL,'Gaia','Menasce','F','MNSGAI00B48F660F','MONTEVERDE','2000-02-08');

/* Operazione 2 */
CALL modifica_dati_accesso('tiape','idind','tiape@gmail.com',NULL,NULL);

/* Operazione 3 */
CALL nuovo_sviluppatore('Nintendo','support@nintendo.co.jp','https://www.nintendo.co.jp/');

/* Operazione 4 */
CALL modifica_dati_sviluppatore ('Ladia Group','Ladia',NULL,'https://ladia.com/');

/* Operazione 5 */
CALL nuovo_videogioco('com.nintendo.tetris',1.01,'Almeno 1 GB di RAM','Tetris',64.00,6.49,'La nuovissima versione del rompicapo russo che fa impazzire il mondo!!!','Nintendo',NULL,'3');

/* Operazione 6 */
call modifica_dati_videogioco ('com.toolkit.mariofunletters',9.97,'Almeno 1.5 GB di RAM',NULL,NULL,NULL,NULL);

/* Operazione 7 */
CALL nuova_recensione('etacram','com.nintendo.tetris','Bello!!!',5);

/* Operazione 8 */
CALL avg_recensioni ('com.microsoft.solitaire',0);

/* Operazione 9 */
SELECT * FROM stampa_per_categoria(3);

/* Operazione 10 */
SELECT * FROM stampa_per_sviluppatore('Rare');

/* Operazione 11 */
CALL add_or_rmv_categoria('rmv','com.interplay.mariotyping2',5);
CALL add_or_rmv_categoria('add','com.interplay.mariotyping2',5);

/* Operazione 12_1 */
CALL acquisto_videogioco_codice ('idorone','BYSCQCU0B4FMDJKO','2030-04-10','com.microsoft.solitaire');

/* Operazione 12_2 */
CALL acquisto_videogioco_carta('idorone','com.ladia.sheepsquest','4510057928269039','711','lessandro Elena','2022-10-01'); /*carta esistente*/
CALL acquisto_videogioco_carta('idorone','com.intelligent.papermario','4610057928269039','101','Filippo Grande','2021-01-01');

/* Operazione 13 */
CALL aggiungi_desideri('talla','com.microsoft.solitaire');

/* Operazione 14 */
SELECT * FROM lista_email;

/* Operazione 15 */
SELECT * FROM lista_acquisti_videogioco('com.microsoft.solitaire');

/* Operazione 16 */
SELECT * FROM lista_versioni_precedenti('com.toolkit.mariofunletters');