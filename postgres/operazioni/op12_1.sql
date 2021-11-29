/* Operazione 12: Acquisto nuovo videogioco con codice */
CREATE OR REPLACE PROCEDURE acquisto_videogioco_codice (VARCHAR(32),VARCHAR(16),DATE,VARCHAR(64))
LANGUAGE 'plpgsql'
AS $$
DECLARE 
id_tmp INT;
BEGIN
IF $1 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $2 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $3 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $4 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
SELECT MAX(idpagamento) INTO id_tmp FROM pagamento;
id_tmp := id_tmp +1;
INSERT INTO pagamento(idpagmaneto,username,videogioco,data) VALUES (id_tmp,$1,$4,CURRENT_DATE);
INSERT INTO codice(codice,scadenza,videogioco,pagamento) VALUES ($2,$3,$4,id_tmp);
INSERT INTO scarica(username,videogioco,pagamento) VALUES ($1,$4,id_tmp);
END;
$$
