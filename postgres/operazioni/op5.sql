/* Operazione 5: Inserire tutti i dati di un nuovo videogioco */
CREATE OR REPLACE PROCEDURE nuovo_videogioco (VARCHAR(64),DECIMAL(5,2),VARCHAR(128),VARCHAR(64),DECIMAL(8,2),DECIMAL(6,2),VARCHAR(512),VARCHAR(32),VARCHAR(256),etapegi)
LANGUAGE 'plpgsql'
AS $$
DECLARE 
id_tmp INT;
BEGIN
SELECT MAX(idpegi) INTO id_tmp FROM pegi;
id_tmp := id_tmp +1;
INSERT INTO videogioco(nomepacchetto,versione,requisiti,nome,dimensione,prezzo,descrizione,nomesviluppatore) VALUES ($1,$2,$3,$4,$5,$6,$7,$8);
INSERT INTO pegi(idpegi,videogioco,motivazione,minimoeta) VALUES (id_tmp,$1,$9,$10);
END;
$$