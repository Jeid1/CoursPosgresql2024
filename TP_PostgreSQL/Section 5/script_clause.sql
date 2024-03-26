------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------- Sélection des données avec les différentes clauses  ------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
-- 1/ Afficher la liste des sous catégories du code catégorie 'C001'
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       "CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE" 
WHERE "CD_CATEGORIE" = 'C001';


-- 2/ Afficher le nombre de produits par catégorie
SELECT C."CD_CATEGORIE" AS "Code catégorie", "LB_CATEGORIE" AS "Libellé catégorie", COUNT(1) AS "Nombre de produits"
FROM  "I_OPE"."TB_PRODUIT" P
INNER JOIN "I_OPE"."TB_SOUS_CATEGORIE" S ON P."CD_SOUS_CATEGORIE" = S."CD_SOUS_CATEGORIE"
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
GROUP BY C."CD_CATEGORIE", "LB_CATEGORIE";


-- 3.a/ Afficher le nombre de produits par catégorie trié par ordre croissant de libellé catégorie 
SELECT C."CD_CATEGORIE" AS "Code catégorie", "LB_CATEGORIE" AS "Libellé catégorie", COUNT(1) AS "Nombre de produits"
FROM  "I_OPE"."TB_PRODUIT" P
INNER JOIN "I_OPE"."TB_SOUS_CATEGORIE" S ON P."CD_SOUS_CATEGORIE" = S."CD_SOUS_CATEGORIE"
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
GROUP BY C."CD_CATEGORIE", "LB_CATEGORIE"
ORDER BY "LB_CATEGORIE" ASC;

-- 3.b/ Afficher le nombre de produits par catégorie trié par ordre décroissant de libellé catégorie 
SELECT C."CD_CATEGORIE" AS "Code catégorie", "LB_CATEGORIE" AS "Libellé catégorie", COUNT(1) AS "Nombre de produits"
FROM  "I_OPE"."TB_PRODUIT" P
INNER JOIN "I_OPE"."TB_SOUS_CATEGORIE" S ON P."CD_SOUS_CATEGORIE" = S."CD_SOUS_CATEGORIE"
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
GROUP BY C."CD_CATEGORIE", "LB_CATEGORIE"
ORDER BY "LB_CATEGORIE" DESC;


-- 4/ Afficher les catégories de produits dont le nombre de produits est inférieur à 1000 (Le résultat doit être trié par libellé catégorie)
SELECT C."CD_CATEGORIE" AS "Code catégorie", "LB_CATEGORIE" AS "Libellé catégorie", COUNT(1) AS "Nombre de produits"
FROM  "I_OPE"."TB_PRODUIT" P
INNER JOIN "I_OPE"."TB_SOUS_CATEGORIE" S ON P."CD_SOUS_CATEGORIE" = S."CD_SOUS_CATEGORIE"
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
GROUP BY C."CD_CATEGORIE", "LB_CATEGORIE"
HAVING COUNT(1)< 1000
ORDER BY "LB_CATEGORIE";


-- 5-a/ Afficher la catégorie ayant le plus de produits
SELECT C."CD_CATEGORIE" AS "Code catégorie", "LB_CATEGORIE" AS "Libellé catégorie", COUNT(1) AS "Nombre de produits"
FROM  "I_OPE"."TB_PRODUIT" P
INNER JOIN "I_OPE"."TB_SOUS_CATEGORIE" S ON P."CD_SOUS_CATEGORIE" = S."CD_SOUS_CATEGORIE"
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
GROUP BY C."CD_CATEGORIE", "LB_CATEGORIE"
ORDER BY COUNT(1) DESC
LIMIT 1;


-- 5-b/ Les autres catégories
SELECT C."CD_CATEGORIE" AS "Code catégorie", "LB_CATEGORIE" AS "Libellé catégorie", COUNT(1) AS "Nombre de produits"
FROM  "I_OPE"."TB_PRODUIT" P
INNER JOIN "I_OPE"."TB_SOUS_CATEGORIE" S ON P."CD_SOUS_CATEGORIE" = S."CD_SOUS_CATEGORIE"
INNER JOIN "I_OPE"."TB_CATEGORIE" C ON C."CD_CATEGORIE" = S."CD_CATEGORIE"
GROUP BY C."CD_CATEGORIE", "LB_CATEGORIE"
ORDER BY COUNT(1) DESC
OFFSET 1;

----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------