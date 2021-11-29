/* Operazione 11: Aggiunge o rimuove categoria da videogioco. */
CREATE OR REPLACE PROCEDURE add_or_rmv_categoria (VARCHAR(3),VARCHAR(64),INT)
LANGUAGE 'plpgsql'
AS $$
BEGIN
IF $1 LIKE 'add' THEN
INSERT INTO appartiene(videogioco,categoria) VALUES ($2,$3);
ELSE
IF $1 LIKE 'rmv' THEN
DELETE FROM appartiene WHERE videogioco LIKE $2 AND categoria = $3;
ELSE
RAISE EXCEPTION 'Valori di input errati'
USING HINT = 'Utilizzare add per aggiungere o rmv per rimuovere';
END IF;
END IF;
END;
$$