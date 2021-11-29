/* Operazione 3: Inserire tutti i dati di un nuovo sviluppatore */
CREATE OR REPLACE PROCEDURE nuovo_sviluppatore(VARCHAR(32),VARCHAR(64),VARCHAR(64))
LANGUAGE 'plpgsql'
AS $$
BEGIN
INSERT INTO sviluppatore(nome,email,sitoweb) VALUES ($1,$2,$3);
END;
$$