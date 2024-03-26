------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------- Utilisation des clauses IN et EXISTS  --------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
-- 1/ Afficher la liste des sous catégories des catégories 'Technologie' et 'Mobilier'
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       S."CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" S
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
WHERE "LB_CATEGORIE" IN ('Technologie','Mobilier')
ORDER BY S."CD_CATEGORIE" ASC;


-- 2/ Afficher la liste des sous catégories des catégories 'Technologie' et 'Mobilier' (Avec utilisation d'une sous requête : IN)
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       "CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" 
WHERE "CD_CATEGORIE" IN 
			(SELECT "CD_CATEGORIE"
			 FROM "I_OPE"."TB_CATEGORIE" 
			 WHERE "LB_CATEGORIE" IN ('Technologie','Mobilier'))																
ORDER BY "CD_CATEGORIE" ASC;

																									
-- 3/ Afficher la liste des sous catégories des catégories 'Technologie' et 'Mobilier' (Avec utilisation d'une sous requête : EXISTS)
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       "CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" S
WHERE EXISTS 
	  (SELECT "CD_CATEGORIE", "LB_CATEGORIE"
	   FROM "I_OPE"."TB_CATEGORIE" C 
	   WHERE C."CD_CATEGORIE" = S."CD_CATEGORIE" 
	   AND "LB_CATEGORIE" IN ('Technologie','Mobilier'))
ORDER BY "CD_CATEGORIE" ASC;																									

		  
------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------- Utilisation des clauses NOT IN et NOT EXISTS  ----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------							  
-- 4/ Afficher la liste des sous catégories des catégories différentes 'Technologie' et 'Mobilier'
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       S."CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" S
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
WHERE "LB_CATEGORIE" NOT IN ('Technologie','Mobilier')
ORDER BY S."CD_CATEGORIE" ASC;
							  

-- 5/ Afficher la liste des sous catégories des catégories différentes 'Technologie' et 'Mobilier' (Avec utilisation d'une sous requête : NOT IN)
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       "CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" 
WHERE "CD_CATEGORIE" NOT IN 
      (SELECT "CD_CATEGORIE" 
	   FROM "I_OPE"."TB_CATEGORIE" 
	   WHERE "LB_CATEGORIE" IN ('Technologie','Mobilier'))
ORDER BY "CD_CATEGORIE" ASC;

																									
-- 6/ Afficher la liste des sous catégories des catégories différentes 'Technologie' et 'Mobilier' (Avec utilisation d'une sous requête : NOT EXISTS)
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       "CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" S
WHERE NOT EXISTS 
	  (SELECT "CD_CATEGORIE", "LB_CATEGORIE"
	   FROM "I_OPE"."TB_CATEGORIE" C 
	   WHERE C."CD_CATEGORIE" = S."CD_CATEGORIE" 
	   AND "LB_CATEGORIE" IN ('Technologie','Mobilier'))
ORDER BY "CD_CATEGORIE" ASC;								  
												
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------