/* TRIGGER SU DATIACCESSO */
/* verifica che l'username non sia vuoto e che non ci siano spazi */
CREATE OR REPLACE FUNCTION check_username() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.username) = 0 
            THEN
				RAISE EXCEPTION 'Username vuoto.';
            END IF;
			
			IF POSITION(' ' IN NEW.username) > 0 THEN
				RAISE EXCEPTION 'Username con spazi.';
		END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_username BEFORE INSERT OR UPDATE ON datiaccesso
		FOR EACH ROW EXECUTE PROCEDURE check_username();
		
/* verifica che il numero di telefono sia composto da 10 cifre */
CREATE OR REPLACE FUNCTION check_telefono() RETURNS
	TRIGGER AS $$
		BEGIN
			IF NEW.telefono < 1000000000
            THEN
				RAISE EXCEPTION 'Il numero di telefono non è valido.';
            END IF;
			RETURN NEW;
		END;
	
		$$ LANGUAGE 'plpgsql';

	CREATE TRIGGER check_telefono BEFORE INSERT OR UPDATE ON datiaccesso 
	FOR EACH ROW EXECUTE PROCEDURE check_telefono();
	
/* verifica che la password sia piu' lunga di 4 caratteri */
	CREATE OR REPLACE FUNCTION check_password() RETURNS
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.password) < 5
            THEN
                RAISE EXCEPTION 'Password troppo corta.';
            END IF;
			RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		
	CREATE TRIGGER check_password BEFORE INSERT OR UPDATE ON datiaccesso 
	FOR EACH ROW EXECUTE PROCEDURE check_password();
	
/* verifica che l'email rispetti il formato standard */ 
	CREATE OR REPLACE FUNCTION check_email() RETURNS
	TRIGGER AS $$
		BEGIN
			IF (NEW.email) !~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'
            THEN
				RAISE EXCEPTION 'Email non valida.'
				USING HINT = 'Controlla che l''email sia valida.';
            END IF;
			RETURN NEW;
		END;
	
	$$ LANGUAGE 'plpgsql';
	
	CREATE TRIGGER check_email BEFORE INSERT OR UPDATE ON datiaccesso
	FOR EACH ROW EXECUTE FUNCTION check_email();
	
/* TRIGGER SU SVILUPPATORE */
CREATE OR REPLACE FUNCTION check_dev() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.nome) = 0 
            THEN
				RAISE EXCEPTION 'Nome sviluppatore vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_dev BEFORE INSERT OR UPDATE ON sviluppatore
		FOR EACH ROW EXECUTE PROCEDURE check_dev();
		

/* CREATE OR REPLACE FUNCTION check_website() RETURNS
	TRIGGER AS $$
		BEGIN
			IF (NEW.sitoweb) !~* '^[A-Za-z0-9._%-]+[.][A-Za-z]+$'
            THEN
				RAISE EXCEPTION 'Sito web non valido.';
            END IF;
			RETURN NEW;
		END;
	
	$$ LANGUAGE 'plpgsql';
	
	CREATE TRIGGER check_website BEFORE INSERT OR UPDATE ON sviluppatore
	FOR EACH ROW EXECUTE FUNCTION check_website(); */
	
	
	CREATE OR REPLACE FUNCTION check_email_dev() RETURNS
	TRIGGER AS $$
		BEGIN
			IF (NEW.email) !~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'
            THEN
				RAISE EXCEPTION 'Email non valida.'
				USING HINT = 'Controlla che l''email sia valida.';
            END IF;
			RETURN NEW;
		END;
	
	$$ LANGUAGE 'plpgsql';
	
	CREATE TRIGGER check_email_dev BEFORE INSERT OR UPDATE ON sviluppatore
	FOR EACH ROW EXECUTE FUNCTION check_email_dev();
	
/* TRIGGER VIDEOGIOCO */
CREATE OR REPLACE FUNCTION check_videogioco() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.nomepacchetto) = 0 
            THEN
				RAISE EXCEPTION 'Nome pacchetto vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_videogioco BEFORE INSERT OR UPDATE ON videogioco
		FOR EACH ROW EXECUTE PROCEDURE check_videogioco();
		
		
CREATE OR REPLACE FUNCTION check_requisiti() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.requisiti) = 0 
            THEN
				RAISE EXCEPTION 'Requisiti vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_requisiti BEFORE INSERT OR UPDATE ON videogioco
		FOR EACH ROW EXECUTE PROCEDURE check_requisiti();
		
	
CREATE OR REPLACE FUNCTION check_nome_videogioco() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.nome) = 0 
            THEN
				RAISE EXCEPTION 'Nome vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_nome_videogioco BEFORE INSERT OR UPDATE ON videogioco
		FOR EACH ROW EXECUTE PROCEDURE check_nome_videogioco();
		
		
CREATE OR REPLACE FUNCTION check_descrizione() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.descrizione) = 0 
            THEN
				RAISE EXCEPTION 'Descrizione vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_descrizione BEFORE INSERT OR UPDATE ON videogioco
		FOR EACH ROW EXECUTE PROCEDURE check_descrizione();
		
		
CREATE OR REPLACE FUNCTION check_prezzo() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF NEW.prezzo < 0 
            THEN
				RAISE EXCEPTION 'Prezzo minore di 0.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_prezzo BEFORE INSERT OR UPDATE ON videogioco
		FOR EACH ROW EXECUTE PROCEDURE check_prezzo();
		
		
CREATE OR REPLACE FUNCTION check_versione() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF NEW.versione < 0 
            THEN
				RAISE EXCEPTION 'Versione minore di 0.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_versione BEFORE INSERT OR UPDATE ON videogioco
		FOR EACH ROW EXECUTE PROCEDURE check_versione();
		
		
CREATE OR REPLACE FUNCTION check_dim() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF NEW.dimensione <= 0 
            THEN
				RAISE EXCEPTION 'Dimensione non puo'' essere 0 o minore.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_dim BEFORE INSERT OR UPDATE ON videogioco
		FOR EACH ROW EXECUTE PROCEDURE check_dim();
		
	
/* TRIGGER DATIANAGRAFICI */
CREATE OR REPLACE FUNCTION check_anag_nome() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.nome) = 0
            THEN
				RAISE EXCEPTION 'Nome vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_anag_nome BEFORE INSERT OR UPDATE ON datianagrafici
		FOR EACH ROW EXECUTE PROCEDURE check_anag_nome();
		
		
CREATE OR REPLACE FUNCTION check_anag_cognome() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.cognome) = 0 
            THEN
				RAISE EXCEPTION 'Cognome vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_anag_cognome BEFORE INSERT OR UPDATE ON datianagrafici
		FOR EACH ROW EXECUTE PROCEDURE check_anag_cognome();
		
		
CREATE OR REPLACE FUNCTION check_luogonascita() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.luogonascita) = 0 
            THEN
				RAISE EXCEPTION 'Luogo di nascita vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_luogonascita BEFORE INSERT OR UPDATE ON datianagrafici
		FOR EACH ROW EXECUTE PROCEDURE check_luogonascita();
		
/* verifica che il CF sia in un formato valido */
CREATE OR REPLACE FUNCTION check_cf() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.CF) <> 16 
            THEN
				RAISE EXCEPTION 'CF non valido.'
				USING HINT = 'Controlla il codice fiscale sia corretto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_cf BEFORE INSERT OR UPDATE ON datianagrafici
		FOR EACH ROW EXECUTE PROCEDURE check_cf();
		
		
/* TRIGGER CATEGORIA */
CREATE OR REPLACE FUNCTION check_categoria() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.nome) = 0
            THEN
				RAISE EXCEPTION 'Nome categoria vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_categoria BEFORE INSERT OR UPDATE ON categoria
		FOR EACH ROW EXECUTE PROCEDURE check_categoria();
		
		
/* TRIGGER RECENSIONE */
CREATE OR REPLACE FUNCTION check_review_testo() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.testo) = 0
            THEN
				RAISE EXCEPTION 'Testo recensione vuoto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_review_testo BEFORE INSERT OR UPDATE ON recensione
		FOR EACH ROW EXECUTE PROCEDURE check_review_testo();
		
		
CREATE OR REPLACE FUNCTION check_review() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF NEW.valutazione < 1 OR NEW.valutazione > 5
            THEN
				RAISE EXCEPTION 'Recensione vuota.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_review BEFORE INSERT OR UPDATE ON recensione
		FOR EACH ROW EXECUTE PROCEDURE check_review();
		
		
/* TRIGGER LISTAVERSIONI */
CREATE OR REPLACE FUNCTION check_lista_versione() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF NEW.versione < 0 
            THEN
				RAISE EXCEPTION 'Versione minore di 0.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_lista_versione BEFORE INSERT OR UPDATE ON listaversioni
		FOR EACH ROW EXECUTE PROCEDURE check_lista_versione();
		
/* verifica che la carta sia in un formato valido */
/* TRIGGER CARTA */
CREATE OR REPLACE FUNCTION check_carta() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF NEW.numero < 1000000000000000 /*si doveva aggiungere OR NEW.numero > 9999999999999999 */
            THEN
				RAISE EXCEPTION 'Carta non valida.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_carta BEFORE INSERT OR UPDATE ON carta
		FOR EACH ROW EXECUTE PROCEDURE check_carta();
		
/* verifica che il ccv2 sia in un formato valido */
CREATE OR REPLACE FUNCTION check_ccv2() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF NEW.ccv2 < 100 OR NEW.ccv2>999
            THEN
				RAISE EXCEPTION 'ccv2 non valido.'
				USING HINT = 'Il ccv2 deve avere 3 cifre.';

            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_ccv2 BEFORE INSERT OR UPDATE ON carta
		FOR EACH ROW EXECUTE PROCEDURE check_ccv2();
		
		
CREATE OR REPLACE FUNCTION check_titolare() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.titolare) = 0
            THEN
				RAISE EXCEPTION 'Titolare non valido.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_titolare BEFORE INSERT OR UPDATE ON carta
		FOR EACH ROW EXECUTE PROCEDURE check_titolare();
		
/* verifica che la carta non sia scaduta al momento dell'inserimento */	
CREATE OR REPLACE FUNCTION check_scad_carta() RETURNS 
	TRIGGER AS $$
	DECLARE
	scadenza_carta_month SMALLINT :=  EXTRACT(month from NEW.scadenza);
	scadenza_carta_year SMALLINT :=  EXTRACT(year from NEW.scadenza);
	curdate_month SMALLINT :=  EXTRACT(month from CURRENT_DATE);
	curdate_year SMALLINT :=  EXTRACT(year from CURRENT_DATE);
		BEGIN
			IF (scadenza_carta_year - curdate_year) < 0
            THEN
				RAISE EXCEPTION 'Carta scaduta.';
            END IF;
			IF (scadenza_carta_year - curdate_year) = 0 AND (scadenza_carta_month - curdate_month) < 0
            THEN
				RAISE EXCEPTION 'Carta scaduta.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';
		
		CREATE TRIGGER check_scad_carta BEFORE INSERT ON carta
		FOR EACH ROW EXECUTE PROCEDURE check_scad_carta();
		
/* verifica che il codice sia in un formato valido */
/* TRIGGER CODICE */
CREATE OR REPLACE FUNCTION check_codice() RETURNS 
	TRIGGER AS $$
		BEGIN
			IF LENGTH(NEW.codice) <> 16
            THEN
				RAISE EXCEPTION 'Codice non valido.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';

		CREATE TRIGGER check_codice BEFORE INSERT OR UPDATE ON codice
		FOR EACH ROW EXECUTE PROCEDURE check_codice();
		
/* verifica che il codice non sia scaduto al momento dell'inserimento */
CREATE OR REPLACE FUNCTION check_scad_codice() RETURNS 
	TRIGGER AS $$
	DECLARE
	scadenza_codice_month SMALLINT :=  EXTRACT(month from NEW.scadenza);
	scadenza_codice_year SMALLINT :=  EXTRACT(year from NEW.scadenza);
	curdate_month SMALLINT :=  EXTRACT(month from CURRENT_DATE);
	curdate_year SMALLINT :=  EXTRACT(year from CURRENT_DATE);
		BEGIN
			IF (scadenza_codice_year - curdate_year) < 0
            THEN
				RAISE EXCEPTION 'Codice scaduto.';
            END IF;
			IF (scadenza_codice_year - curdate_year) = 0 AND (scadenza_codice_month - curdate_month) < 0
            THEN
				RAISE EXCEPTION 'Codice scaduto.';
            END IF;
		RETURN NEW;
		END;
		
		$$ LANGUAGE 'plpgsql';
		
		CREATE TRIGGER check_scad_codice BEFORE INSERT ON codice
		FOR EACH ROW EXECUTE PROCEDURE check_scad_codice();