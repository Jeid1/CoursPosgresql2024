-------------------------------------------------------------------------------------------------------------------------
-------------------------------- Création d'une table temporaire et insertion des données -------------------------------
-------------------------------------------------------------------------------------------------------------------------
/* Création d'une table temporaire "I_OPE"."TB_PRODUIT_TEMP" à partir de la table "I_OPE"."TB_PRODUIT" */
CREATE TABLE "I_OPE"."TB_PRODUIT_TEMP" AS SELECT * FROM  "I_OPE"."TB_PRODUIT";

/* Affichage des données de la table "I_OPE"."TB_PRODUIT_TEMP" */
SELECT * FROM "I_OPE"."TB_PRODUIT_TEMP";


/* Insertion des données dans la table "I_OPE"."TB_PRODUIT_TEMP" : 
Cette requête est à exécuter après chaque suppression complète des données présentes dans la table "I_OPE"."TB_PRODUIT_TEMP" 
*/
INSERT INTO "I_OPE"."TB_PRODUIT_TEMP" 
SELECT * FROM  "I_OPE"."TB_PRODUIT";



-------------------------------------------------------------------------------------------------------------------------
------------------------------------ Quelques requêtes SQL de suppression de données ------------------------------------
-------------------------------------------------------------------------------------------------------------------------

/* Suppression des données présentes dans la table "I_OPE"."TB_PRODUIT_TEMP"*/
--- 1ère solution
TRUNCATE TABLE "I_OPE"."TB_PRODUIT_TEMP";

--- 2ème solution 
DELETE FROM "I_OPE"."TB_PRODUIT_TEMP";


/* Suppression des données présentes dans la table "I_OPE"."TB_PRODUIT_TEMP" 
dont le prix d'achat est supérieur à 100*/
DELETE 
FROM "I_OPE"."TB_PRODUIT_TEMP"
WHERE "PRIX_ACHAT_PRODUIT" >100;


/* Suppression des données présentes dans la table "I_OPE"."TB_PRODUIT_TEMP" 
dont le code produit est présent dans la table  "I_OPE"."TB_PRODUIT"*/

--- 1ère solution
DELETE 
FROM "I_OPE"."TB_PRODUIT_TEMP" a
WHERE EXISTS (SELECT * 
			  FROM "I_OPE"."TB_PRODUIT" b 
			  WHERE a."CD_PRODUIT" = b."CD_PRODUIT") ;

--- 2ème solution
DELETE 
FROM "I_OPE"."TB_PRODUIT_TEMP" 
WHERE "CD_PRODUIT" IN (SELECT "CD_PRODUIT"
			  		   FROM "I_OPE"."TB_PRODUIT");
			  
--- 3ème solution : Uniquement sur postgresql
DELETE 
FROM "I_OPE"."TB_PRODUIT_TEMP" a
USING "I_OPE"."TB_PRODUIT" b 
WHERE a."CD_PRODUIT" = b."CD_PRODUIT";


/* Suppression de la table "I_OPE"."TB_PRODUIT_TEMP"*/
DROP TABLE IF EXISTS "I_OPE"."TB_PRODUIT_TEMP";