/* Operazione 1: Inserire tutti i dati di un nuovo utente */
CREATE OR REPLACE PROCEDURE nuovo_utente (VARCHAR(32),VARCHAR(64),VARCHAR(32),BIGINT,VARCHAR(32),VARCHAR(32),gender,CHAR(16),VARCHAR(64),DATE)
LANGUAGE 'plpgsql'
AS $$
BEGIN
INSERT INTO datiaccesso(username,email,password,telefono) VALUES ($1,$2,$3,$4);
INSERT INTO datianagrafici(username,nome,cognome,sesso,CF,luogonascita,datanascita) VALUES ($1,$5,$6,$7,$8,$9,$10);
END;
$$