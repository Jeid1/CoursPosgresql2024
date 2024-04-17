----------------------------------------------------------------------------
----------------- Script de création des différentes tables ----------------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_RH";


----------------------------------------------------------------------------
-------------------- Table N°1 : "I_RH"."TB_STAGIAIRE" ---------------------
----------------------------------------------------------------------------
-- Création des ENUMs pour la civilité
-- DROP TYPE IF EXISTS "CIVILITE" ;										
CREATE TYPE "CIVILITE"	AS ENUM ('Mlle', 'Mme', 'Mr');

-- Script de création de la table	
-- DROP TABLE IF EXISTS "TB_STAGIAIRE" CASCADE ;
CREATE TABLE "TB_STAGIAIRE" 
(
"ID_STAGIAIRE" 		VARCHAR(10) NOT NULL,
"LB_CIVILITE" 		"CIVILITE"  NOT NULL,
"LB_NOM_STAGIAIRE" 	VARCHAR(100) NOT NULL,
"LB_PREN_STAGIAIRE" VARCHAR(100) NOT NULL,
"DT_NAISSANCE" 		DATE NOT NULL,
"LB_LIEU_NAISSANCE"	VARCHAR(100) NOT NULL,
"LB_NATIONALITE" 	VARCHAR(100) NOT NULL,
"CD_POSTAL" 		VARCHAR(100) NOT NULL,
"LB_VILLE" 			VARCHAR(100) NOT NULL,
"LB_PAYS" 			VARCHAR(100) NOT NULL,
"LB_ADRESSE" 		VARCHAR(100) NOT NULL,
"NUM_TEL" 			VARCHAR(100) NOT NULL,
"LB_DIPLOME_ELEVE" 	VARCHAR(100) NOT NULL,
"LB_SITUATION_MATR" VARCHAR(100) NOT NULL,
"NUM_NIR" 			VARCHAR(20) NOT NULL,
"BL_ACTIF" 			BOOLEAN NOT NULL,
"BL_EMBAUCHE" 		BOOLEAN NOT NULL,
CONSTRAINT "TB_STAGIAIRE_PKEY" PRIMARY KEY("ID_STAGIAIRE")
);


----------------------------------------------------------------------------
------------------- Table N°2 : "I_RH"."TB_TYPE_CONTRAT" -------------------
----------------------------------------------------------------------------

-- DROP TABLE IF EXISTS "TB_TYPE_CONTRAT" CASCADE ;
CREATE TABLE "TB_TYPE_CONTRAT" 
(
"CD_TYPE_CONTRAT" 		VARCHAR(10) NOT NULL,
"LB_TYPE_CONTRAT" 		VARCHAR(100) NOT NULL,
UNIQUE ("LB_TYPE_CONTRAT"),
CONSTRAINT "TB_TYPE_CONTRAT_PKEY" PRIMARY KEY("CD_TYPE_CONTRAT")
);


----------------------------------------------------------------------------
-------------------- Table N°3 : "I_RH"."TB_EQUIPE" ------------------------
----------------------------------------------------------------------------

-- DROP TABLE IF EXISTS "TB_EQUIPE" CASCADE;
CREATE TABLE "TB_EQUIPE" 
(
"CD_EQUIPE" 			VARCHAR(10) NOT NULL,
"LB_NOM_EQUIPE" 		VARCHAR(100) NOT NULL,
"LB_RESPONSABLE_EQUIPE"	VARCHAR(100) NOT NULL,
UNIQUE ("LB_NOM_EQUIPE"),
CONSTRAINT "TB_EQUIPE_PKEY" PRIMARY KEY("CD_EQUIPE")	
);


----------------------------------------------------------------------------
------------------- Table N°4 : "I_RH"."TB_CONTRAT" ------------------------
----------------------------------------------------------------------------
										
-- DROP TABLE IF EXISTS "TB_CONTRAT" ;		
CREATE TABLE "TB_CONTRAT" 
(
"ID_CONTRAT" 		VARCHAR(10) NOT NULL,
"DT_DEBUT" 			DATE NOT NULL,
"DT_FIN"			DATE ,
"CD_TYPE_CONTRAT" 	VARCHAR(10) NOT NULL,
"ID_STAGIAIRE" 		VARCHAR(10) NOT NULL,
"NB_SALAIRE" 		NUMERIC NOT NULL,
"DT_ARRET_CONTRAT" 	DATE,
"LB_MOTIF_ARRET" 	VARCHAR(50),	

CONSTRAINT "TB_CONTRAT_PKEY" PRIMARY KEY("ID_CONTRAT"),

CONSTRAINT "TB_TYPE_CONTRAT_FKEY" FOREIGN KEY("CD_TYPE_CONTRAT") 
	REFERENCES "TB_TYPE_CONTRAT"("CD_TYPE_CONTRAT"),

CONSTRAINT "TB_CONTRAT_STAGIAIRE_FKEY" FOREIGN KEY("ID_STAGIAIRE") 
	REFERENCES "TB_STAGIAIRE"("ID_STAGIAIRE")	
);										
	
										
----------------------------------------------------------------------------
---------------- Table N°5 : "I_RH"."TB_AFFECTATION_EQUIPE" ----------------
----------------------------------------------------------------------------

-- DROP TABLE IF EXISTS "TB_AFFECTATION_EQUIPE" ;
CREATE TABLE "TB_AFFECTATION_EQUIPE" 
(
"ID_STAGIAIRE" 			VARCHAR(10) NOT NULL,
"CD_EQUIPE" 			VARCHAR(10) NOT NULL,
"DT_DEBUT" 				DATE NOT NULL,
"DT_FIN" 				DATE ,
"LB_INFO_PROJET_ACTUEL" VARCHAR(100),
CONSTRAINT "TB_AFFECTATION_EQUIPE_PKEY" PRIMARY KEY("ID_STAGIAIRE", "CD_EQUIPE", "DT_DEBUT"),

CONSTRAINT "TB_AFFECTATION_STAGIAIRE_FKEY" FOREIGN KEY("ID_STAGIAIRE") 
	REFERENCES "TB_STAGIAIRE"("ID_STAGIAIRE"),
	
CONSTRAINT "TB_AFFECTATION_EQUIPE_FKEY" FOREIGN KEY("CD_EQUIPE") 
	REFERENCES "TB_EQUIPE"("CD_EQUIPE")
);