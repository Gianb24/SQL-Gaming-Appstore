/* 1 - Amministratore */

DROP ROLE IF EXISTS amministratore;

CREATE ROLE amministratore;

GRANT ALL ON DATABASE appstore TO amministratore;

/* 2 - Sviluppatore */

DROP ROLE IF EXISTS sviluppatore;

CREATE ROLE sviluppatore;

GRANT INSERT, UPDATE ON public.sviluppatore TO sviluppatore;
GRANT INSERT, UPDATE ON public.videogioco TO sviluppatore;
GRANT INSERT, UPDATE ON public.pegi TO sviluppatore;
GRANT INSERT, UPDATE ON public.categoria TO sviluppatore;
GRANT INSERT, UPDATE ON public.listaversioni TO sviluppatore;

/* 3 - Cliente */

DROP ROLE IF EXISTS cliente;

CREATE ROLE cliente;

GRANT INSERT, UPDATE ON public.datiaccesso TO cliente;
GRANT INSERT ON public.datianagrafici TO cliente;
GRANT INSERT ON public.recensione TO cliente;
GRANT INSERT, UPDATE ON public.listadesideri TO cliente;