/* 1 - Amministratore */

DROP USER IF EXISTS admin;

CREATE USER admin WITH PASSWORD 'RSFCPRJrFxpDBDT283TC4wxj';
GRANT amministratore TO admin;

/* 2 - Sviluppatore */

DROP USER IF EXISTS isystems;

CREATE USER isystems WITH PASSWORD '8BpjGWBnrTTMfLzzYk3Sa3Kr';
GRANT sviluppatore TO isystems;

DROP USER IF EXISTS interplay;

CREATE USER interplay WITH PASSWORD 'nrmud3fdW2aXRBxSUjUaKKmm';
GRANT sviluppatore TO interplay;

DROP USER IF EXISTS rare;

CREATE USER rare WITH PASSWORD 'kefYmRnFE3mhWPWurVKMgVzb';
GRANT sviluppatore TO rare;

DROP USER IF EXISTS mystman12;

CREATE USER mystman12 WITH PASSWORD 'rAxUh6cM7vdbvLR6EL6YdmGZ';
GRANT sviluppatore TO mystman12;

/* 3 - Cliente */

DROP USER IF EXISTS mesoso;

CREATE USER mesoso WITH PASSWORD 'LZZLJhZvWZ3FhFVPANZ5HVgh';
GRANT cliente TO mesoso;

DROP USER IF EXISTS osinavv;

CREATE USER osinavv WITH PASSWORD 'EJAbPHM6qXKRngW3XV6pCuTA';
GRANT cliente TO osinavv;

DROP USER IF EXISTS rentosil;

CREATE USER rentosil WITH PASSWORD 'GJRSPGzWKBqbKkaSf5G2fkWB';
GRANT cliente TO rentosil;

DROP USER IF EXISTS genomiar;

CREATE USER genomiar WITH PASSWORD 'yTJRhKtzNNervL5KpsPhbDH5';
GRANT cliente TO genomiar;