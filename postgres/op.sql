\i operazioni/op1.sql
\i operazioni/op2.sql
\i operazioni/op3.sql
\i operazioni/op4.sql
\i operazioni/op5.sql
\i operazioni/op6.sql
\i operazioni/op7.sql
\i operazioni/op8.sql
\i operazioni/op11.sql
\i operazioni/op12_1.sql
\i operazioni/op12_2.sql
\i operazioni/op13.sql


/* Operazione 9: Stampare tutti i videogiochi di una categoria. */
CREATE OR REPLACE FUNCTION stampa_per_categoria (INT)
RETURNS TABLE (videogioco_categoria VARCHAR(64))
AS $$
BEGIN
RETURN QUERY SELECT videogioco FROM appartiene WHERE categoria = $1;
END;
$$ LANGUAGE 'plpgsql';


/* Operazione 10: Cercare tutti i videogiochi prodotti da uno sviluppatore. */
CREATE OR REPLACE FUNCTION stampa_per_sviluppatore (VARCHAR(64))
RETURNS TABLE (videogioco_sviluppatore VARCHAR(32))
AS $$
BEGIN
RETURN QUERY SELECT nomepacchetto FROM videogioco WHERE nomesviluppatore = $1;
END;
$$ LANGUAGE 'plpgsql';


/* Operazione 14: Stampare lista email registrate */
CREATE OR REPLACE VIEW lista_email AS
SELECT email FROM datiaccesso;


/* Operazione 15: Trovare ogni cliente che abbia acquistato un determinato videogioco. */
CREATE OR REPLACE FUNCTION lista_acquisti_videogioco (VARCHAR(64))
RETURNS TABLE (_username VARCHAR(32),_videogioco VARCHAR(64),_pagamento INT)
AS $$
BEGIN
RETURN QUERY SELECT username,videogioco,pagamento FROM scarica WHERE videogioco = $1;
END;
$$ LANGUAGE 'plpgsql';

/* Operazione 16: Stampare la lista delle versioni precedenti per un videogioco. */
CREATE OR REPLACE FUNCTION lista_versioni_precedenti (VARCHAR(64))
RETURNS TABLE (_versione DECIMAL(5,2),_data_aggiornamento DATE)
AS $$
BEGIN
RETURN QUERY SELECT versione,data_listaversioni FROM listaversioni WHERE videogioco = $1;
END;
$$ LANGUAGE 'plpgsql';