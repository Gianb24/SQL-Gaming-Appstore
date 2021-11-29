# Utenti (di esempio) sul database

# Utilizzo del database.

USE AppStoreVidegiochi;

# --- Utenti ---

# Le password sono state generate con il generatore online di RANDOM.ORG (https://www.random.org/passwords/).

# 1 - Amministratore

DROP USER IF EXISTS 'admin';

CREATE USER 'admin' IDENTIFIED BY 'RSFCPRJrFxpDBDT283TC4wxj';
GRANT 'Amministratore' TO 'admin';

# 2 - Sviluppatore

DROP USER IF EXISTS 'isystems';

CREATE USER 'isystems' IDENTIFIED BY '8BpjGWBnrTTMfLzzYk3Sa3Kr';
GRANT 'Sviluppatore' TO 'isystems';

DROP USER IF EXISTS 'interplay';

CREATE USER 'interplay' IDENTIFIED BY 'nrmud3fdW2aXRBxSUjUaKKmm';
GRANT 'Sviluppatore' TO 'interplay';

DROP USER IF EXISTS 'rare';

CREATE USER 'rare' IDENTIFIED BY 'kefYmRnFE3mhWPWurVKMgVzb';
GRANT 'Sviluppatore' TO 'rare';

DROP USER IF EXISTS 'mystman12';

CREATE USER 'mystman12' IDENTIFIED BY 'rAxUh6cM7vdbvLR6EL6YdmGZ';
GRANT 'Sviluppatore' TO 'mystman12';

# 3 - Cliente

DROP USER IF EXISTS 'mesoso';

CREATE USER 'mesoso' IDENTIFIED BY 'LZZLJhZvWZ3FhFVPANZ5HVgh';
GRANT 'Cliente' TO 'mesoso';

DROP USER IF EXISTS 'osinavv';

CREATE USER 'osinavv' IDENTIFIED BY 'EJAbPHM6qXKRngW3XV6pCuTA';
GRANT 'Cliente' TO 'osinavv';

DROP USER IF EXISTS 'rentosil';

CREATE USER 'rentosil' IDENTIFIED BY 'GJRSPGzWKBqbKkaSf5G2fkWB';
GRANT 'Cliente' TO 'rentosil';

DROP USER IF EXISTS 'genomiar';

CREATE USER 'genomiar' IDENTIFIED BY 'yTJRhKtzNNervL5KpsPhbDH5';
GRANT 'Cliente' TO 'genomiar';