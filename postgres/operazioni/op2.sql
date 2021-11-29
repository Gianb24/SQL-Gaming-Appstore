/* Operazione 2: Modifica dei dati di accesso */
CREATE OR REPLACE PROCEDURE modifica_dati_accesso (VARCHAR(32),VARCHAR(32),VARCHAR(64),VARCHAR(32),BIGINT)
LANGUAGE 'plpgsql'
AS $$
BEGIN
IF $1 IS NULL THEN RAISE EXCEPTION 'Username non valido';
END IF;
IF $3 IS NOT NULL THEN
UPDATE datiaccesso SET email = $3 WHERE username LIKE $1;
END IF;
IF $4 IS NOT NULL THEN
UPDATE datiaccesso SET password = $4 WHERE username LIKE $1;
END IF;
IF $5 IS NOT NULL THEN
UPDATE datiaccesso SET telefono = $5 WHERE username LIKE $1;
END IF;
IF $2 IS NOT NULL THEN
UPDATE datiaccesso SET username = $2 WHERE username LIKE $1;
END IF;
END;
$$