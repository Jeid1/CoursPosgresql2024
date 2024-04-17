-------------------------------------------------------------------------------------------------
--------------------------  Fusionner / Concaténer lignes et colonnes  --------------------------
-------------------------------------------------------------------------------------------------
-- Synthase SQL des fonctions
/*
	-- Fusion des lignes
	STRING_AGG(expression, 'separateur ligne')
	
	-- Fusion des colonnes
	NOM_DE_LA_TABLE::TEXT / NOM_DE_LA_SOUS_REQUÊTE::TEXT
	
*/

-------------------------------------------------------------------------------------------------
--------------------------- Fusionner plusieurs lignes en une seule  ----------------------------
-------------------------------------------------------------------------------------------------

-- 1/ Liste des catégories
SELECT *
FROM "I_OPE"."TB_CATEGORIE";

-- 2/ Liste des catégories (Fusion des lignes en une seule ligne)
SELECT STRING_AGG("CD_CATEGORIE", '|') AS "Code catégorie", 
       STRING_AGG("LB_CATEGORIE", '|') AS "Libellé catégorie"
FROM "I_OPE"."TB_CATEGORIE";

-- 3/ Liste des sous-catégories d'une catégorie de produit 
SELECT C."CD_CATEGORIE" AS "Code", C."LB_CATEGORIE" AS "Libellé", 
       STRING_AGG("CD_SOUS_CATEGORIE", '|') AS "Sous catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" S
INNER JOIN "I_OPE"."TB_CATEGORIE" C 
ON S."CD_CATEGORIE" = C."CD_CATEGORIE"
GROUP BY C."CD_CATEGORIE", C."LB_CATEGORIE";


-------------------------------------------------------------------------------------------------
-------------------------- Fusionner plusieurs colonnes en une seule  ---------------------------
-------------------------------------------------------------------------------------------------

-- 1/ Liste des catégories
SELECT
	  -- Concaténer toutes colonnes
	  "TB_CATEGORIE"::TEXT,
	  -- Enlever la parenthèse à droite
       RTRIM("TB_CATEGORIE"::TEXT, ')'),
	  -- Enlever la parenthèse à gauche
	   LTRIM(RTRIM("TB_CATEGORIE"::TEXT, ')'),'('),
	  -- Remplacer le caracère ',' par '|'
	   REPLACE(LTRIM(RTRIM("TB_CATEGORIE"::TEXT, ')'),'('),',','|'),
	  -- Remplacer le caracère '"' par ''
	   REPLACE(REPLACE(LTRIM(RTRIM("TB_CATEGORIE"::TEXT,')'),'('),',','|'),'"','') AS "Catégorie"
	  
FROM "I_OPE"."TB_CATEGORIE";

-- 2/ Liste des sous-catégories  
SELECT "CD_SOUS_CATEGORIE" || '|' || "LB_SOUS_CATEGORIE", 
	   REPLACE(REPLACE(LTRIM(RTRIM("TB_SOUS_CATEGORIE"::TEXT,')'),'('),
	   ',','|'),'"','') AS "Sous Catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE";

-- 3/ Liste des sous-catégories avec affichage de la catégorie
SELECT REPLACE(REPLACE(LTRIM(RTRIM(L::TEXT,')'),'('),',','|'),'"','') AS "Sous Catégories"
FROM
(
	-- Sous-requête : Liste des sous-catégories
	SELECT S.*, C."LB_CATEGORIE"
	FROM "I_OPE"."TB_SOUS_CATEGORIE" S
	INNER JOIN "I_OPE"."TB_CATEGORIE" C ON S."CD_CATEGORIE" = C."CD_CATEGORIE"
) L ;