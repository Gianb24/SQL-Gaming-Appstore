/* Operazione 6: Aggiornamento di un videogioco già esistente. */
CREATE OR REPLACE PROCEDURE modifica_dati_videogioco (VARCHAR(64),DECIMAL(5,2),VARCHAR(128),VARCHAR(64),DECIMAL(8,2),DECIMAL(6,2),VARCHAR(512))
LANGUAGE 'plpgsql'
AS $$
DECLARE
ver_tmp DECIMAL(6,2);
BEGIN
IF $2 IS NOT NULL THEN
SELECT versione INTO ver_tmp FROM videogioco WHERE nomepacchetto LIKE $1;
INSERT INTO listaversioni(videogioco,versione,data_listaversioni) VALUES ($1,ver_tmp,CURRENT_DATE);
UPDATE videogioco SET versione = $2 WHERE nomepacchetto LIKE $1;
END IF;
IF $3 IS NOT NULL THEN
UPDATE videogioco SET requisiti = $3 WHERE nomepacchetto LIKE $1;
END IF;
IF $4 IS NOT NULL THEN
UPDATE videogioco SET nome = $4 WHERE nomepacchetto LIKE $1;
END IF;
IF $5 IS NOT NULL THEN
UPDATE videogioco SET dimensione = $5 WHERE nomepacchetto LIKE $1;
END IF;
IF $6 IS NOT NULL THEN
UPDATE videogioco SET prezzo = $6 WHERE nomepacchetto LIKE $1;
END IF;
IF $7 IS NOT NULL THEN
UPDATE videogioco SET descrizione = $7 WHERE nomepacchetto LIKE $1;
END IF;
END;
$$