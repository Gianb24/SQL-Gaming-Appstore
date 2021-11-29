/* Operazione 7: Inserire una recensione relativa ad un gioco */
CREATE OR REPLACE PROCEDURE nuova_recensione (VARCHAR(32),VARCHAR(64),VARCHAR(256),INT)
LANGUAGE 'plpgsql'
AS $$
DECLARE 
id_tmp INT;
BEGIN
SELECT MAX(idrecensione) INTO id_tmp FROM recensione;
id_tmp := id_tmp +1;
INSERT INTO recensione(username,videogioco,idrecensione,testo,valutazione,data_recensione) VALUES ($1,$2,id_tmp,$3,$4,CURRENT_DATE);
END;
$$