/* Operazione 12: Acquisto nuovo videogioco con carta */

/* $1=username $2=videogioco $3=numero carta $4=ccv2 $5=titolare $6=scadenza */
CREATE OR REPLACE PROCEDURE acquisto_videogioco_carta (VARCHAR(32),VARCHAR(64),BIGINT,SMALLINT,VARCHAR(64),DATE)
LANGUAGE 'plpgsql'
AS $$
DECLARE 
id_tmp INT;
check_carta BOOLEAN;
BEGIN
IF $1 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $2 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $3 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $4 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $5 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
IF $6 IS NULL THEN RAISE EXCEPTION 'NULL non ammessi';
END IF;
SELECT MAX(idpagamento) INTO id_tmp FROM pagamento;
id_tmp := id_tmp +1;
SELECT EXISTS(SELECT numero FROM carta WHERE numero = $3) INTO check_carta; /*verifica booleana sulla subquery, uso check_carta come variabile tmp */
IF check_carta = 0 THEN 
INSERT INTO carta(numero,ccv2,titolare,scadenza) VALUES ($3,$4,$5,$6); /*se la carta non esiste la aggiunge alla tabella */
END IF;
INSERT INTO pagamento(idpagamento,username,videogioco,data) VALUES (id_tmp,$1,$2,CURRENT_DATE);
INSERT INTO concarta(pagamento,carta) VALUES (id_tmp,$3);
INSERT INTO scarica(username,videogioco,pagamento) VALUES ($1,$2,id_tmp);
END;
$$