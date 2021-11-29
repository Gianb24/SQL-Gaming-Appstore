## Specification definition
-**Op1:** Insert a new customer indicating all his data, optional telephone number.
-**Op2:** Edit of the access data (username, email, password or telephone) of a customer.
-**Op3:** Insert a new developer indicating all his data.
-**Op4:** Edit the data (name, website or email) of a developer.
-**Op5:** Insert a new video game and its PEGI rating.
-**Op6:** Update of an existing video game.
-**Op7:** Post a review about a video game.
-**Op8:** Calculate the average of reviews for a given video game.
-**Op9:** Print all video games that are part of a category.
-**Op10:** Search for all video games produced by a developer.
-**Op11:** Add / Delete a category from a video game.
-**Op12:** Add a video game to a user's shopping list, also saving payment information.
-**Op13:** Add or remove a game from your wish list.
-**Op14:** Print a list containing the email of each registered customer.
-**Op15:** Find every customer who has purchased a particular video game.
-**Op16:** Print the list of previous versions for a video game.

## Complete relational scheme in 3NF
![](https://i.ibb.co/VMZZwLV/normalizzato.png)

## MySQL
-**DatabaseTabelleTrigger.sql** contains the creation of the database, tables and various triggers used to check input constraints
-**DatiEsempio.sql** contains sample data to use to test the creation of databases, tables and triggers with also indications on how they were obtained
-**Operazioni.sql** contains the definition of the various operations using stored procedures or views, in the only case that no user input is required
-**OperazioniEsempio.sql** contains examples of using the defined operations
-**Ruoli.sql** contains the definition of possible roles
-**Utenti.sql** contains an example of users where their roles need to be managed

## PostgreSQL
-**appstore.sql** contains the creation of the database and tables
-**trigger.sql** contains the creation of triggers to create and verify input and update constraints
-**operazioni** The operations folder contains the files that allow the creation of procedures, functions and views to execute the previously defined specifications
-**operazioni_esempio.sql e dati.sql** contain examples of how to fill the various tables.
-**ruoli.sql** contains the definition of possible roles
-**utenti.sql** contains an example of users where their roles need to be managed