----------------------------------------------------------------------------
------------------------- "I_OPE"."TB_TYPE_CLIENT" -------------------------
----------------------------------------------------------------------------
/*Mise à jour des données du type client 'T004' 
 présentes dans la table "I_OPE"."TB_TYPE_CLIENT" */
UPDATE "I_OPE"."TB_TYPE_CLIENT" 
SET "LB_TYPE_CLIENT" = 'Autres types'
WHERE "CD_TYPE_CLIENT" = 'T004';

--- Sélection des données du type client T004 présentes dans la table "I_OPE"."TB_TYPE_CLIENT"
SELECT * FROM "I_OPE"."TB_TYPE_CLIENT" WHERE "CD_TYPE_CLIENT" = 'T004';

----------------------------------------------------------------------------
-------------------------- "I_OPE"."TB_CATEGORIE" --------------------------
----------------------------------------------------------------------------
--- Mise à jour des données de la catégorie 'C004' présentes dans la table "I_OPE"."TB_CATEGORIE"
UPDATE "I_OPE"."TB_CATEGORIE" 
SET "LB_CATEGORIE" = 'Autres catégories'
WHERE "CD_CATEGORIE" = 'C004';


--- Sélection des données de la catégorie C004 présentes dans la table "I_OPE"."TB_CATEGORIE"
SELECT * FROM "I_OPE"."TB_CATEGORIE" WHERE "CD_CATEGORIE" = 'C004';

----------------------------------------------------------------------------
----------------------- "I_OPE"."TB_SOUS_CATEGORIE" ------------------------
----------------------------------------------------------------------------
--- Mise à jour des données du sous catégorie SC018 présente dans la table "I_OPE"."TB_SOUS_CATEGORIE"
UPDATE "I_OPE"."TB_SOUS_CATEGORIE" 
SET 
"LB_SOUS_CATEGORIE" = 'Non renseigné',
"CD_CATEGORIE"		= 'C003'
WHERE "CD_SOUS_CATEGORIE" = 'SC018';

--- Mise à jour des données du sous catégorie SC019 présente dans la table "I_OPE"."TB_SOUS_CATEGORIE"
UPDATE "I_OPE"."TB_SOUS_CATEGORIE" 
SET 
"LB_SOUS_CATEGORIE" = 'Autres sous catégories',
"CD_CATEGORIE"		= 'C003'
WHERE "CD_SOUS_CATEGORIE" = 'SC019';

--- Sélection des données du sous catégorie 'SC018', 'SC019' présentes dans la table "I_OPE"."TB_SOUS_CATEGORIE"
SELECT * FROM "I_OPE"."TB_SOUS_CATEGORIE" WHERE "CD_SOUS_CATEGORIE" IN ('SC018', 'SC019');


----------------------------------------------------------------------------
----------------------- "I_OPE"."TB_CLIENT" --------------------------------
----------------------------------------------------------------------------
--- Mise à jour des données du client '99999999' présentes dans la table "I_OPE"."TB_CLIENT"
UPDATE "I_OPE"."TB_CLIENT"
SET 
"NOM_CLIENT" 	   = 'Autres', 
"PREN_CLIENT"	   = 'Clients', 
"CD_POSTAL_CLIENT" ='00229'
WHERE "ID_CLIENT"  = '99999999';


--- Sélection des données du client 99999999 présentes dans la table "I_OPE"."TB_CLIENT"
SELECT * FROM "I_OPE"."TB_CLIENT" WHERE "ID_CLIENT" = '99999999';

----------------------------------------------------------------------------
----------------------- "I_OPE"."TB_PRODUIT" -------------------------------
----------------------------------------------------------------------------
--- Création d'une table temporaire à partir d'une table existante 
CREATE TABLE "I_OPE"."TB_PRODUIT_TEMP" AS SELECT * FROM  "I_OPE"."TB_PRODUIT" WHERE "CD_PRODUIT" = 'P999999';

/* Mise à jour des données présentes dans la table "I_OPE"."TB_PRODUIT" 
à partir des données de la table "I_OPE"."TB_PRODUIT_TEMP"*/
UPDATE  "I_OPE"."TB_PRODUIT" a
SET 
"PRIX_ACHAT_PRODUIT" = b."NEW_PRIX_ACHAT_PRODUIT",
"PRIX_VENTE_PRODUIT" = b."NEW_PRIX_VENTE_PRODUIT"
FROM 
(
SELECT "CD_PRODUIT", "NOM_PRODUIT", "PRIX_ACHAT_PRODUIT"+5 "NEW_PRIX_ACHAT_PRODUIT", 
       "PRIX_VENTE_PRODUIT"+5 "NEW_PRIX_VENTE_PRODUIT", "CD_SOUS_CATEGORIE"
FROM "I_OPE"."TB_PRODUIT_TEMP"
) b
WHERE a."CD_PRODUIT" = b."CD_PRODUIT";

--- Sélection des données du produit 'P999999' présentes dans la table "I_OPE"."TB_PRODUIT"
SELECT * FROM "I_OPE"."TB_PRODUIT" WHERE "CD_PRODUIT" = 'P999999';

--- Suppression de la table temporaire "I_OPE"."TB_PRODUIT_TEMP"
DROP TABLE IF EXISTS "I_OPE"."TB_PRODUIT_TEMP";