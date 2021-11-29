/* Operazione 4: Modifica dei dati sviluppatore */
CREATE OR REPLACE PROCEDURE modifica_dati_sviluppatore (VARCHAR(32),VARCHAR(32),VARCHAR(64),VARCHAR(64))
LANGUAGE 'plpgsql'
AS $$
BEGIN
IF $1 IS NULL THEN RAISE EXCEPTION 'Nome non valido';
END IF;
IF $3 IS NOT NULL THEN
UPDATE sviluppatore SET email = $3 WHERE nome LIKE $1;
END IF;
IF $4 IS NOT NULL THEN
UPDATE sviluppatore SET sitoweb = $4 WHERE nome LIKE $1;
END IF;
IF $2 IS NOT NULL THEN
UPDATE sviluppatore SET nome = $2 WHERE nome LIKE $1;
END IF;
END;
$$