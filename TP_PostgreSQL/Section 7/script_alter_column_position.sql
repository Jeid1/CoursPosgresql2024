-------------------------------------------------------------------------------------------------
-----------------  Modifier la position d'une colonne (Alter column position)  ------------------
-------------------------------------------------------------------------------------------------
-- Définition du schéma à utiliser
SET SEARCH_PATH = 'I_OPE';

-- Script actuel de création de la table TB_FOURNISSEUR
-- Ce script doit être exécuté après chaque méthode
DROP TABLE IF EXISTS "TB_FOURNISSEUR";
CREATE TABLE "TB_FOURNISSEUR"
(
"ID_FRS"			VARCHAR(50) NOT NULL,
"RAISON_SOCIAL_FRS" VARCHAR(100) NOT NULL,
"CD_POSTAL_FRS"		VARCHAR(100) NOT NULL,
"VILLE_FRS"			VARCHAR(100) NOT NULL,
"PAYS_FRS"			VARCHAR(100) NOT NULL,
"REGION_FRS" 		VARCHAR(100) NOT NULL,
"NUM_TEL_FRS"		VARCHAR(100) NOT NULL,
"CD_TYPE_FRS" 	    VARCHAR(20) NOT NULL,
CONSTRAINT "TB_FOURNISSEUR_PKEY" PRIMARY KEY("ID_FRS") ,
CONSTRAINT "TB_TYPE_FOURNISSEUR_FKEY" FOREIGN KEY("CD_TYPE_FRS") REFERENCES "TB_TYPE_FOURNISSEUR"("CD_TYPE_FRS")
);

-- Insertion des données dans la table TB_FOURNISSEUR
INSERT INTO "TB_FOURNISSEUR" VALUES ('FRS001','Fournisseur 1','00229','Cotonou','Benin','Littoral','21 21 21 21','A001');
SELECT * FROM "TB_FOURNISSEUR";



/*1ère méthode : Création d'une nouvelle table 
	1- Création d'une nouvelle table avec les colonnes dans 
	   l'ordre que vous désirez
	2- Copie des données de l'ancienne table vers la nouvelle
	3- Suppression de l'ancienne table 
	4- Renommage de la nouvelle table 
	5- Renommage des contraintes
*/

-- Création de la table TB_FOURNISSEUR_TEMP
DROP TABLE IF EXISTS "TB_FOURNISSEUR_TEMP";
CREATE TABLE "TB_FOURNISSEUR_TEMP"
(
"ID_FRS"			VARCHAR(50)  NOT NULL,
"RAISON_SOCIAL_FRS" VARCHAR(100) NOT NULL,
"NUM_TEL_FRS"		VARCHAR(100) NOT NULL,
"CD_POSTAL_FRS"		VARCHAR(100) NOT NULL,
"VILLE_FRS"			VARCHAR(100) NOT NULL,
"PAYS_FRS"			VARCHAR(100) NOT NULL,
"REGION_FRS" 		VARCHAR(100) NOT NULL,
"CD_TYPE_FRS" 	    VARCHAR(20)  NOT NULL,
CONSTRAINT "TB_FOURNISSEUR_TEMP_PKEY" PRIMARY KEY("ID_FRS") ,
CONSTRAINT "TB_TYPE_FOURNISSEUR_TEMP_FKEY" 
			FOREIGN KEY("CD_TYPE_FRS") 
			REFERENCES "TB_TYPE_FOURNISSEUR"("CD_TYPE_FRS")
);

-- Copie des éléments de l'ancienne table vers la nouvelle
INSERT INTO "TB_FOURNISSEUR_TEMP" 
SELECT "ID_FRS", "RAISON_SOCIAL_FRS", "NUM_TEL_FRS", 
       "CD_POSTAL_FRS", "VILLE_FRS", "PAYS_FRS", "REGION_FRS", "CD_TYPE_FRS" 
FROM   "TB_FOURNISSEUR";

-- Affichage des données
SELECT * FROM "TB_FOURNISSEUR_TEMP" ;

-- Suppression de l'ancienne table 
DROP TABLE IF EXISTS "TB_FOURNISSEUR";

-- Renommage de la nouvelle table
ALTER TABLE "TB_FOURNISSEUR_TEMP" RENAME TO "TB_FOURNISSEUR";

-- Renommage des contraintes
ALTER TABLE "TB_FOURNISSEUR" RENAME CONSTRAINT "TB_FOURNISSEUR_TEMP_PKEY" TO "TB_FOURNISSEUR_PKEY";
ALTER TABLE "TB_FOURNISSEUR" RENAME CONSTRAINT "TB_TYPE_FOURNISSEUR_TEMP_FKEY" TO "TB_TYPE_FOURNISSEUR_FKEY";



/*2ème méthode : Création d'une vue
	1- Renommage de la table actuelle
	2- Création d'une vue portant le nom de la table
	   avec les colonnes dans l'ordre que vous désirez
*/
-- Renommage de la table actuelle
ALTER TABLE "TB_FOURNISSEUR" RENAME TO "TB_FOURNISSEUR_TEMP";

-- Création d'une vue portant le nom de la table 
CREATE VIEW "TB_FOURNISSEUR" AS
SELECT "ID_FRS", "RAISON_SOCIAL_FRS", "NUM_TEL_FRS", "CD_POSTAL_FRS", "VILLE_FRS", "PAYS_FRS", "REGION_FRS", "CD_TYPE_FRS"
FROM "TB_FOURNISSEUR_TEMP";

-- Sélection des données
SELECT * FROM "TB_FOURNISSEUR";
SELECT * FROM "TB_FOURNISSEUR_TEMP";

-- Insertion des données dans la vue 
INSERT INTO "TB_FOURNISSEUR" VALUES ('FRS002','Fournisseur 2','21 21 21 21', '00229','Cotonou','Benin','Littoral','A001');

-- Suppression de la vue
DROP VIEW IF EXISTS "TB_FOURNISSEUR";

-- Renommage de la table TB_FOURNISSEUR_TEMP
ALTER TABLE "TB_FOURNISSEUR_TEMP" RENAME TO "TB_FOURNISSEUR";


/*3ème méthode : Ajout de nouvelles colonnes 
				 et mise à jour des données
	1- Création de nouvelles colonnes
	2- Mise à jour des données
	3- Suppression des anciennes colonnes
    4- Redéfinition des contraintes 
*/
-- Ajout de nouvelles colonnes à la table 
ALTER TABLE "TB_FOURNISSEUR" ADD COLUMN "ID_FRS_TEMP" 				VARCHAR(50) ,
						   	 ADD COLUMN "RAISON_SOCIAL_FRS_TEMP"    VARCHAR(100),
						   	 ADD COLUMN "NUM_TEL_FRS_TEMP" 			VARCHAR(100),
						  	 ADD COLUMN "CD_POSTAL_FRS_TEMP" 		VARCHAR(100),
						  	 ADD COLUMN "VILLE_FRS_TEMP" 			VARCHAR(100),
						   	 ADD COLUMN "PAYS_FRS_TEMP" 			VARCHAR(100),
							 ADD COLUMN "REGION_FRS_TEMP" 			VARCHAR(100),
						     ADD COLUMN "CD_TYPE_FRS_TEMP" 			VARCHAR(20);
                           
 -- Mise à jour des données
 UPDATE "TB_FOURNISSEUR" 
 SET "ID_FRS_TEMP" = "ID_FRS",
	 "RAISON_SOCIAL_FRS_TEMP" = "RAISON_SOCIAL_FRS",
	 "NUM_TEL_FRS_TEMP" = "NUM_TEL_FRS",
	 "CD_POSTAL_FRS_TEMP" = "CD_POSTAL_FRS",
	 "VILLE_FRS_TEMP" = "VILLE_FRS",
	 "PAYS_FRS_TEMP" = "PAYS_FRS",
	 "REGION_FRS_TEMP" = "REGION_FRS",
	 "CD_TYPE_FRS_TEMP" = "CD_TYPE_FRS";
     
-- Suppression des anciennes colonnes
ALTER TABLE "TB_FOURNISSEUR" DROP COLUMN "ID_FRS",
						     DROP COLUMN "RAISON_SOCIAL_FRS",
						     DROP COLUMN "CD_POSTAL_FRS",
						     DROP COLUMN "VILLE_FRS",
						     DROP COLUMN "PAYS_FRS",
							 DROP COLUMN "REGION_FRS",
							 DROP COLUMN "NUM_TEL_FRS",
						     DROP COLUMN "CD_TYPE_FRS";
                           
-- Renommage des nouvelles colonnes 
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "ID_FRS_TEMP" TO "ID_FRS";
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "RAISON_SOCIAL_FRS_TEMP" TO "RAISON_SOCIAL_FRS";
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "NUM_TEL_FRS_TEMP" TO "NUM_TEL_FRS";
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "VILLE_FRS_TEMP" TO "VILLE_FRS";
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "PAYS_FRS_TEMP" TO "PAYS_FRS";
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "REGION_FRS_TEMP" TO "REGION_FRS";
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "CD_TYPE_FRS_TEMP" TO "CD_TYPE_FRS";

-- Ajout à la table TB_FOURNISSEUR une clé primaire et une clé étrangère
ALTER TABLE "TB_FOURNISSEUR" ADD CONSTRAINT "TB_FOURNISSEUR_PKEY" PRIMARY KEY("ID_FRS") ,
						     ADD CONSTRAINT "TB_TYPE_FOURNISSEUR_FKEY" FOREIGN KEY("CD_TYPE_FRS") REFERENCES "TB_TYPE_FOURNISSEUR"("CD_TYPE_FRS");
						   
-- Définition de la contrainte NOT NULL sur les différentes colonnes
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "ID_FRS" SET NOT NULL;
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "RAISON_SOCIAL_FRS" SET NOT NULL;
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "NUM_TEL_FRS" SET NOT NULL;
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "VILLE_FRS" SET NOT NULL;
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "PAYS_FRS" SET NOT NULL;
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "REGION_FRS" SET NOT NULL;
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "CD_TYPE_FRS" SET NOT NULL;

-- Affichage des données
SELECT * FROM "TB_FOURNISSEUR"; 