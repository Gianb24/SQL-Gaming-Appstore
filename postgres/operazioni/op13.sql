/* Operazione 13: Aggiungere o rimuovere un gioco dalla lista dei desideri. */
CREATE OR REPLACE PROCEDURE aggiungi_desideri (VARCHAR(32),VARCHAR(64))
LANGUAGE 'plpgsql'
AS $$
BEGIN
INSERT INTO listadesideri(username,videogioco,data_listadesideri) VALUES ($1,$2,CURRENT_DATE);
END;
$$