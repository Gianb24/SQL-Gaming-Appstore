# Ruoli sul database

# Utilizzo del database.

USE AppStoreVidegiochi;

# --- Ruoli ---

# 1 - Amministratore

DROP ROLE IF EXISTS 'Amministratore';

CREATE ROLE 'Amministratore';

GRANT ALL ON AppStoreVidegiochi.* TO 'Amministratore';

# 2 - Sviluppatore

DROP ROLE IF EXISTS 'Sviluppatore';

CREATE ROLE 'Sviluppatore';

GRANT INSERT, UPDATE ON AppStoreVidegiochi.Sviluppatore TO 'Sviluppatore';
GRANT INSERT, UPDATE ON AppStoreVidegiochi.Videogioco TO 'Sviluppatore';
GRANT INSERT, UPDATE ON AppStoreVidegiochi.PEGI TO 'Sviluppatore';
GRANT INSERT, UPDATE ON AppStoreVidegiochi.Categoria TO 'Sviluppatore';
GRANT INSERT, UPDATE ON AppStoreVidegiochi.ListaVersioni TO 'Sviluppatore';

# 3 - Cliente

DROP ROLE IF EXISTS 'Cliente';

CREATE ROLE 'Cliente';

GRANT INSERT, UPDATE ON AppStoreVidegiochi.DatiAccesso TO 'Cliente';
GRANT INSERT ON AppStoreVidegiochi.DatiAnagrafici TO 'Cliente';
GRANT INSERT ON AppStoreVidegiochi.Recensione TO 'Cliente';
GRANT INSERT, UPDATE ON AppStoreVidegiochi.ListaDesideri TO 'Cliente';