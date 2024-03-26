----------------------------------------------------------------------------
----------------- Script de création des différentes tables ----------------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_SCOLARITE";


----------------------------------------------------------------------------
------------------ Table N°1 : "I_SCOLARITE"."TB_PAYEUR" -------------------
----------------------------------------------------------------------------

-- DROP TABLE IF EXISTS "TB_PAYEUR" CASCADE ;
CREATE TABLE "TB_PAYEUR" 
(
"ID_PAYEUR" 		SERIAL  NOT NULL,
"CD_CNI_PAYEUR" 	VARCHAR(100) NOT NULL,
"LB_NOM_PAYEUR" 	VARCHAR(100) NOT NULL,
"LB_PREN_PAYEUR" 	VARCHAR(100) NOT NULL,
"LB_ADR_PAYEUR" 	VARCHAR(100) NOT NULL,
"LB_TEL_PAYEUR" 	VARCHAR(100) NOT NULL,
UNIQUE ("CD_CNI_PAYEUR"),
CONSTRAINT "TB_PAYEUR_PKEY" PRIMARY KEY("ID_PAYEUR")
);


----------------------------------------------------------------------------
----------------- Table N°2 : "I_SCOLARITE"."TB_FORMATION" -----------------
----------------------------------------------------------------------------

-- DROP TABLE IF EXISTS "TB_FORMATION" CASCADE ;
CREATE TABLE "TB_FORMATION" 
(
"ID_FORMATION" 			VARCHAR(50) NOT NULL,
"NOM_FORMATION" 		VARCHAR(100) NOT NULL,
"NB_COUT_FORMATION" 	NUMERIC NOT NULL,
"ID_RESPO_FORMATION" 	VARCHAR(50) NOT NULL,
CONSTRAINT "TB_FORMATION_PKEY" PRIMARY KEY("ID_FORMATION"),
	
CONSTRAINT "TB_ENSEIGNANT_FORMATION_FKEY" FOREIGN KEY("ID_RESPO_FORMATION") 
	REFERENCES "TB_ENSEIGNANT"("ID_ENSEIGNANT")
);


----------------------------------------------------------------------------
-------------- Table N°3 : "I_SCOLARITE"."TB_INSCRIPTION" ------------------
----------------------------------------------------------------------------

-- DROP TABLE IF EXISTS "TB_INSCRIPTION" CASCADE;
CREATE TABLE "TB_INSCRIPTION" 
(
"ID_INSCRIPTION" 			SERIAL NOT NULL,
"DT_INSCRIPTION" 			TIMESTAMP NOT NULL,
"LB_TYPE_PAIEMENT_SOUHAITE"	VARCHAR(100) NOT NULL,
"ID_ETUDIANT" 				VARCHAR(50) NOT NULL,	
"ANNEE_SCOLAIRE"			NUMERIC NOT NULL,
"ID_FORMATION" 				VARCHAR(50) NOT NULL,
UNIQUE ("ID_ETUDIANT", "ANNEE_SCOLAIRE"),
CONSTRAINT "TB_INSCRIPTION_PKEY" PRIMARY KEY("ID_INSCRIPTION"),

CONSTRAINT "TB_INSCRIPTION_ETUDIANT_FKEY" FOREIGN KEY("ID_ETUDIANT") 
	REFERENCES "TB_ETUDIANT"("ID_ETUDIANT"),
	
CONSTRAINT "TB_INSCRIPTION_FORMATION_FKEY" FOREIGN KEY("ID_FORMATION") 
	REFERENCES "TB_FORMATION"("ID_FORMATION"),

CONSTRAINT "CHECK_TYPE_PAIEMENT" CHECK ("LB_TYPE_PAIEMENT_SOUHAITE" IN ('Unique', 'Echéancier'))	
);


----------------------------------------------------------------------------
--------------- Table N°4 : "I_SCOLARITE"."TB_PAIEMENT" --------------------
----------------------------------------------------------------------------

-- Créaion des ENUM pour le mode de paiement	
-- DROP TYPE IF EXISTS "MODE_PAIEMENT" ;										
CREATE TYPE "MODE_PAIEMENT"	AS ENUM ('Virement', 'Carte Bancaire', 'Prélèvement');	
									
-- Script de création de la table										
-- DROP TABLE IF EXISTS "TB_PAIEMENT" CASCADE;		
CREATE TABLE "TB_PAIEMENT" 
(
"ID_PAIEMENT" 		SERIAL NOT NULL,
"DT_PAIEMENT" 		TIMESTAMP NOT NULL,
"MT_PAYE"			NUMERIC NOT NULL,
"LB_MODE_PAIEMENT" 	"MODE_PAIEMENT" NOT NULL,
"ID_PAYEUR" 		INTEGER,
"ID_INSCRIPTION" 	INTEGER NOT NULL,	

CONSTRAINT "TB_PAIEMENT_PKEY" PRIMARY KEY("ID_PAIEMENT"),

CONSTRAINT "TB_PAIEMENT_PAYEUR_FKEY" FOREIGN KEY("ID_PAYEUR") 
	REFERENCES "TB_PAYEUR"("ID_PAYEUR"),

CONSTRAINT "TB_PAIEMENT_INSCRIPTION_FKEY" FOREIGN KEY("ID_INSCRIPTION") 
	REFERENCES "TB_INSCRIPTION"("ID_INSCRIPTION")	
);										
	
										
----------------------------------------------------------------------------
-------------------- Table N°5 : "I_NOTE"."TB_ECHEANCE" --------------------
----------------------------------------------------------------------------

-- DROP TABLE IF EXISTS "TB_ECHEANCE" ;
CREATE TABLE "TB_ECHEANCE" 
(
"ID_ECHEANCE" 		SERIAL NOT NULL,
"DT_ECHEANCE" 		TIMESTAMP NOT NULL,
"MT_ECHEANCE"		NUMERIC NOT NULL,
"LB_MODE_PAIEMENT" 	"MODE_PAIEMENT" NOT NULL,
"ID_INSCRIPTION" 	INTEGER NOT NULL,	
"ID_PAIEMENT" 		INTEGER ,
CONSTRAINT "TB_ECHEANCE_PKEY" PRIMARY KEY("ID_ECHEANCE"),

CONSTRAINT "TB_ECHEANCE_INSCRIPTION_FKEY" FOREIGN KEY("ID_INSCRIPTION") 
	REFERENCES "TB_INSCRIPTION"("ID_INSCRIPTION"),

CONSTRAINT "TB_ECHEANCE_PAIEMENT_FKEY" FOREIGN KEY("ID_PAIEMENT") 
	REFERENCES "TB_PAIEMENT"("ID_PAIEMENT")
);