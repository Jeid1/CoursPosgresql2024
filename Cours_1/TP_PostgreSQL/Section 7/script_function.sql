-------------------------------------------------------------------------------------------------
------------------------------------ Création des fonctions -------------------------------------
-------------------------------------------------------------------------------------------------

-- Synthase SQL de création d'une fonction
/*
CREATE OR REPLACE FUNCTION "Nom du schéma"."Nom de la fonction" (Les paramètres à déclarer) 
RETURN 
    Type de données à retourner"
LANGUAGE PLPGSQL 
AS $$ 
DECLARE 
     "Variables à déclarer"
BEGIN  
	"Définir les requêtes ou les formules logiques" 
END ;
$$;
*/

-- Synthase SQL de suppression d'une fonction
-- DROP FUNCTION IF EXISTS 'NOM_DE_LA_FONCTION'

-------------------------------------------------------------------------------------------------
--------- 1/Création d'une fonction permettant de concatener des chaînes de caractères ----------
-------------------------------------------------------------------------------------------------
--- Utilisation des paramètres non nommés
--- DROP FUNCTION IF EXISTS "I_OPE"."CONCAT"(text, text);
CREATE OR REPLACE FUNCTION "I_OPE"."CONCAT"(text, text)
RETURNS text
LANGUAGE PLPGSQL
AS $$
DECLARE
	v_ret text;
BEGIN

	v_ret := $1 || ' ' || $2 ;
	
	return v_ret ;
END ;
$$;

--- Afficher le nom et prénoms des clients en utilisant la fonction CONCAT
SELECT "I_OPE"."CONCAT"("NOM_CLIENT", "PREN_CLIENT") AS "Nom et prénoms"
FROM "I_OPE"."TB_CLIENT";


-------------------------------------------------------------------------------------------------
--------- 2/Création d'une fonction permettant de concatener des chaînes de caractères ----------
-------------------------------------------------------------------------------------------------
--- Utilisation des paramètres nommés
--- DROP FUNCTION IF EXISTS "I_OPE"."CONCAT_2"(val_1 text, val_2 text, separation text);
CREATE OR REPLACE FUNCTION "I_OPE"."CONCAT_2"(val_1 text, val_2 text, separation text default ' ')
RETURNS text
LANGUAGE PLPGSQL
AS $$
DECLARE
	v_ret text;
BEGIN
	v_ret := val_1 || separation || val_2 ;
	
	return v_ret ;
END;
$$;

--- Afficher le nom et prénoms des clients en utilisant la fonction CONCAT_2
SELECT "I_OPE"."CONCAT_2"("NOM_CLIENT", "PREN_CLIENT") AS "Nom et prénoms"
FROM "I_OPE"."TB_CLIENT";


-------------------------------------------------------------------------------------------------
-------- 3/Création d'une fonction permettant de calculer le montant des ventes / achats --------
-------------------------------------------------------------------------------------------------
--- Utilisation des paramètres nommés
--- DROP FUNCTION IF EXISTS "I_OPE"."MONTANT" (val_1 numeric, val_2 numeric);
CREATE OR REPLACE FUNCTION "I_OPE"."MONTANT" (val_1 numeric, val_2 numeric)
RETURNS numeric
LANGUAGE PLPGSQL
AS $$
DECLARE
	montant numeric;
BEGIN
	montant := val_1*val_2 ;
	
	return montant ;
END;
$$;

--- Afficher le montant des achats et des ventes en utilisant la fonction MONTANT
SELECT "ID_VENTE", "CD_PRODUIT", "I_OPE"."MONTANT"("QTE_VENTE", "PRIX_ACHAT") AS "Montant achat",
       "I_OPE"."MONTANT"("QTE_VENTE", "PRIX_VENTE") AS "Montant vente"
FROM "I_OPE"."TB_DETAIL_VENTE";


-------------------------------------------------------------------------------------------------
--- 4/Création d'une fonction permettant de calculer le nombre de produits par sous catégorie ---
-------------------------------------------------------------------------------------------------
--- Utilisation des paramètres non nommés
--- DROP FUNCTION IF EXISTS "I_OPE"."NB_PROD" (SOUS_CATEGORIE text);
CREATE OR REPLACE FUNCTION "I_OPE"."NB_PROD" (SOUS_CATEGORIE text)
RETURNS INTEGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	NB_PRODUIT INTEGER;	
BEGIN

	SELECT COUNT(1) INTO NB_PRODUIT 
	FROM "I_OPE"."TB_PRODUIT"
	WHERE "CD_SOUS_CATEGORIE" = SOUS_CATEGORIE;
	
	return NB_PRODUIT ;
END;
$$;

--- Afficher le nombre de produits par sous catégorie en utilisant la fonction NB_PROD
SELECT *, "I_OPE"."NB_PROD"("CD_SOUS_CATEGORIE")  AS "Nombre de produits"
FROM "I_OPE"."TB_SOUS_CATEGORIE";
