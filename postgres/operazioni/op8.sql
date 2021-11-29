/* Operazione 8: Calcolare media per un videogioco */
CREATE OR REPLACE PROCEDURE avg_recensioni (VARCHAR(64),INOUT avg_tmp DECIMAL (2,1))
LANGUAGE 'plpgsql'
AS $$
BEGIN
SELECT AVG(valutazione) INTO $2 FROM recensione WHERE videogioco LIKE $1;
END;
$$