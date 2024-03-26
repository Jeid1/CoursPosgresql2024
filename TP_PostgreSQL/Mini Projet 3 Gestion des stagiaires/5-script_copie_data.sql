----------------------------------------------------------------------------
-------- Script de copie des données csv dans les différentes tables -------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_RH";


----------------------------------------------------------------------------
-------------------- Table N°1 : "I_RH"."TB_STAGIAIRE" ---------------------
----------------------------------------------------------------------------
--- Sélection des données présentes dans la table "I_RH"."TB_STAGIAIRE"
SELECT * FROM "TB_STAGIAIRE";

--- Suppression des données présentes dans la table "I_RH"."TB_STAGIAIRE"
TRUNCATE "TB_STAGIAIRE" CASCADE;

---- Copie des données présentes dans le fichier TB_STAGIAIRE.csv
COPY  "TB_STAGIAIRE"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 3 Gestion des stagiaires\TB_STAGIAIRE.csv'
DELIMITER '|'
CSV HEADER;


----------------------------------------------------------------------------
------------------- Table N°2 : "I_RH"."TB_TYPE_CONTRAT" -------------------
----------------------------------------------------------------------------

--- Sélection des données présentes dans la table "I_RH"."TB_TYPE_CONTRAT"
SELECT * FROM "TB_TYPE_CONTRAT";

--- Suppression des données présentes dans la table "I_RH"."TB_TYPE_CONTRAT"
TRUNCATE "TB_TYPE_CONTRAT" CASCADE;

---- Copie des données présentes dans le fichier TB_TYPE_CONTRAT.csv
COPY  "TB_TYPE_CONTRAT"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 3 Gestion des stagiaires\TB_TYPE_CONTRAT.csv'
DELIMITER '|'
CSV HEADER;


----------------------------------------------------------------------------
-------------------- Table N°3 : "I_RH"."TB_EQUIPE" ------------------------
----------------------------------------------------------------------------

--- Sélection des données présentes dans la table "I_RH"."TB_EQUIPE"
SELECT * FROM "TB_EQUIPE";

--- Suppression des données présentes dans la table "I_RH"."TB_EQUIPE"
TRUNCATE "TB_EQUIPE" CASCADE;

---- Copie des données présentes dans le fichier TB_EQUIPE.csv
COPY  "TB_EQUIPE"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 3 Gestion des stagiaires\TB_EQUIPE.csv'
DELIMITER '|'
CSV HEADER;


----------------------------------------------------------------------------
------------------- Table N°4 : "I_RH"."TB_CONTRAT" ------------------------
----------------------------------------------------------------------------
										
--- Sélection des données présentes dans la table "I_RH"."TB_CONTRAT"
SELECT * FROM "TB_CONTRAT";

--- Suppression des données présentes dans la table "I_RH"."TB_CONTRAT"
TRUNCATE "TB_CONTRAT" CASCADE;

---- Copie des données présentes dans le fichier TB_CONTRAT.csv
COPY  "TB_CONTRAT"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 3 Gestion des stagiaires\TB_CONTRAT.csv'
DELIMITER '|'
CSV HEADER;									
	
										
----------------------------------------------------------------------------
---------------- Table N°5 : "I_RH"."TB_AFFECTATION_EQUIPE" ----------------
----------------------------------------------------------------------------

--- Sélection des données présentes dans la table "I_RH"."TB_AFFECTATION_EQUIPE"
SELECT * FROM "TB_AFFECTATION_EQUIPE";

--- Suppression des données présentes dans la table "I_RH"."TB_AFFECTATION_EQUIPE"
TRUNCATE "TB_AFFECTATION_EQUIPE" CASCADE;

---- Copie des données présentes dans le fichier TB_AFFECTATION_EQUIPE.csv
COPY  "TB_AFFECTATION_EQUIPE"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 3 Gestion des stagiaires\TB_AFFECTATION_EQUIPE.csv'
DELIMITER '|'
CSV HEADER;	