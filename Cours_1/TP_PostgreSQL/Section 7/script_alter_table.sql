-------------------------------------------------------------------------------------------------
-------------------------------------  FONCTION ALTER TABLE  ------------------------------------
-------------------------------------------------------------------------------------------------
-- Syntaxe SQL des différentes fonctions
/*
1- Ajout de colonnes 
	ALTER TABLE table_name ADD COLUMN column_name datatype column_constraint;

2- Suppression de colonnes
	ALTER TABLE table_name DROP COLUMN column_name;
	
3- Renommage de colonnes
	ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;
	
4- Renommage d'une table
	ALTER TABLE table_name RENAME TO new_table_name;	
	
5- Modification du type d'une colonne
	ALTER TABLE table_name ALTER COLUMN column_name [SET DATA] TYPE new_data_type;	
	
6- Modification de la valeur par défaut d'une colonne
	ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT value ;	
	
7- Suppression de la valeur par défaut d'une colonne
	ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT ;	
	
8- Définition de la contrainte NOT NULL
	ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL;	
	
9- Suppression de la contrainte NOT NULL
	ALTER TABLE table_name ALTER COLUMN column_name DROP NOT NULL;	
	
10- Ajout d'une contrainte : Primary Key and Foreign Key, UNIQUE, CHECK
	ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_definition;
	ALTER TABLE table_name ADD CHECK expression;	
*/



SET SEARCH_PATH = 'I_OPE';

-- Création de la table TB_TYPE_FOURNISSEUR
DROP TABLE IF EXISTS "TB_TYPE_FOURNISSEUR";
CREATE TABLE "TB_TYPE_FOURNISSEUR"
(
"CD_TYPE_FRS" VARCHAR(20) NOT NULL, 
"LB_TYPE_FRS" VARCHAR(20) NOT NULL, 
CONSTRAINT "TB_TYPE_FOURNISSEUR_PKEY" PRIMARY KEY("CD_TYPE_FRS")
);

-- Création de la table TB_FOURNISSEUR
DROP TABLE IF EXISTS "TB_FOURNISSEUR";
CREATE TABLE "TB_FOURNISSEUR"
(
"ID_FRS"			VARCHAR(50) NOT NULL,
"RAISON_SOCIAL_FRS" VARCHAR(100) NOT NULL,
"CD_POSTAL_FRS"		VARCHAR(100) NOT NULL,
"VILLE_FRS"			VARCHAR(100) NOT NULL,
"PAYS_FRS"			VARCHAR(100) 
);


-- 1.1 Ajout de la colonne REGION_FRS à la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" ADD COLUMN "REGION_FRS" VARCHAR(100) NOT NULL;

-- 1.2 Ajout des colonnes TEL_FRS et CD_TYPE_FRS, AUTRE_INFO_FRS, AUTRE_INFO_2_FRS, AUTRE_INFO_3_FRS à la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" ADD COLUMN "TEL_FRS" INTEGER,
						     ADD COLUMN "CD_TYPE_FRS" VARCHAR(20) NOT NULL,
                             ADD COLUMN "AUTRE_INFO_FRS" VARCHAR(100), 
                             ADD COLUMN "AUTRE_INFO_2_FRS" VARCHAR(100),
                             ADD COLUMN "AUTRE_INFO_3_FRS" VARCHAR(100);

                        
-- 2.1 Suppression de la colonne AUTRE_INFO_FRS de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" DROP COLUMN "AUTRE_INFO_FRS";

-- 2.2 Suppression de la colonne AUTRE_INFO_2_FRS et AUTRE_INFO_3_FRS de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" DROP COLUMN "AUTRE_INFO_2_FRS",
						     DROP COLUMN "AUTRE_INFO_3_FRS";


-- 3. Renommage de la colonne TEL_FRS de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" RENAME COLUMN "TEL_FRS" TO "NUM_TEL_FRS";


-- 4. Renommage de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" RENAME TO "TB_FRS";
ALTER TABLE "TB_FRS" RENAME TO "TB_FOURNISSEUR";


-- 5. Modification du type d'une colonne
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "NUM_TEL_FRS" TYPE VARCHAR(100) ;


-- 6. Définition de la valeur par défaut sur la colonne PAYS_FRS de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "PAYS_FRS" SET DEFAULT 'BENIN';


-- 7. Suppression de la valeur par défaut définie sur la colonne PAYS_FRS de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "PAYS_FRS" DROP DEFAULT ;


-- 8. Définition de la contrainte NOT NULL pour la colonne PAYS_FRS de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "PAYS_FRS" SET NOT NULL;


-- 9. Suppression de la contrainte NOT NULL pour la colonne PAYS_FRS de la table TB_FOURNISSEUR
ALTER TABLE "TB_FOURNISSEUR" ALTER COLUMN "PAYS_FRS" DROP NOT NULL;


-- 10.1 Ajout d'une contrainte d'unicité sur la colonne LB_TYPE_FRS
ALTER TABLE "TB_TYPE_FOURNISSEUR"  ADD CONSTRAINT "UNIQUE_SITE_FRS" UNIQUE ("LB_TYPE_FRS") ;

-- 10.2 Ajout d'une contrainte pour spécifier les valeurs précises de la colonne LB_TYPE_FRS
ALTER TABLE "TB_TYPE_FOURNISSEUR" ADD CHECK ("LB_TYPE_FRS" IN ('Grossite', 'Semi-Grossiste', 'Détaillant'));

	-- Insertion des données dans la table TB_TYPE_FOURNISSEUR
	INSERT INTO "TB_TYPE_FOURNISSEUR" VALUES ('A001','Autres');
	INSERT INTO "TB_TYPE_FOURNISSEUR" VALUES ('A001','Grossite');
	INSERT INTO "TB_TYPE_FOURNISSEUR" VALUES ('A002','Grossite');

-- 10.3 Ajout à la table TB_FOURNISSEUR une clé primaire et une clé étrangère
ALTER TABLE "TB_FOURNISSEUR"  ADD CONSTRAINT "TB_FOURNISSEUR_PKEY" PRIMARY KEY("ID_FRS") ,
							  ADD CONSTRAINT "TB_TYPE_FOURNISSEUR_FKEY" FOREIGN KEY("CD_TYPE_FRS") REFERENCES "TB_TYPE_FOURNISSEUR"("CD_TYPE_FRS");                         