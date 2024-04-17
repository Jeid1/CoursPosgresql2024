----------------------------------------------------------------------------------------------------------------
---------------------------------------------------- Fonction CASE  --------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- 1/ Liste des produits avec chaque tranche de prix
SELECT "CD_PRODUIT" AS "Code produit", "NOM_PRODUIT" AS "Nom produit", 
       "PRIX_VENTE_PRODUIT" as "Prix de vente",
		CASE 
			WHEN "PRIX_VENTE_PRODUIT" <  50  										 
				THEN '1-Moins de 50'
			WHEN "PRIX_VENTE_PRODUIT" >= 50  AND "PRIX_VENTE_PRODUIT" < 101 
				THEN '2-Entre 50 et 100'
			WHEN "PRIX_VENTE_PRODUIT" >= 101 AND "PRIX_VENTE_PRODUIT" < 151
				THEN '3-Entre 101 et 150'
			WHEN "PRIX_VENTE_PRODUIT" >= 151 AND "PRIX_VENTE_PRODUIT" < 201
				THEN '4-Entre 151 et 200'
			WHEN "PRIX_VENTE_PRODUIT" >= 201  
				THEN '5-Plus de 200'
		END AS "Tranche de prix"	
FROM "I_OPE"."TB_PRODUIT" 
ORDER BY 4;


-- 2/ Nombre de produits par tranche de prix de vente
SELECT 
		CASE 
			WHEN "PRIX_VENTE_PRODUIT" <  50  										 
				THEN '1-Moins de 50'
			WHEN "PRIX_VENTE_PRODUIT" >= 50  AND "PRIX_VENTE_PRODUIT" < 101 
				THEN '2-Entre 50 et 100'
			WHEN "PRIX_VENTE_PRODUIT" >= 101 AND "PRIX_VENTE_PRODUIT" < 151
				THEN '3-Entre 101 et 150'
			WHEN "PRIX_VENTE_PRODUIT" >= 151 AND "PRIX_VENTE_PRODUIT" < 201
				THEN '4-Entre 151 et 200'
			WHEN "PRIX_VENTE_PRODUIT" >= 201  
				THEN '5-Plus de 200'
		END AS "Tranche de prix", 
		COUNT("CD_PRODUIT") AS "Nombre de produits"	
FROM "I_OPE"."TB_PRODUIT" 
GROUP BY 1
ORDER BY 1;

-- 3/ Nombre de produits par tranche de prix avec une fonction d'agrégation
SELECT 
SUM
(
	CASE WHEN "PRIX_VENTE_PRODUIT" <  50 THEN 1
	     ELSE 0
	END 	     
) AS "1-Moins de 50",
SUM
(
	CASE WHEN "PRIX_VENTE_PRODUIT" >= 50  AND "PRIX_VENTE_PRODUIT" < 101  THEN 1
	     ELSE 0
	END 	     
) AS "2-Entre 50 et 100",
SUM
(
	CASE WHEN "PRIX_VENTE_PRODUIT" >= 101 AND "PRIX_VENTE_PRODUIT" < 151 THEN 1
	     ELSE 0
	END 	     
) AS "3-Entre 101 et 150",
SUM
(
	CASE WHEN "PRIX_VENTE_PRODUIT" >= 151 AND "PRIX_VENTE_PRODUIT" < 201 THEN 1
	     ELSE 0
	END 	     
) AS "4-Entre 151 et 200",
SUM
(
	CASE WHEN "PRIX_VENTE_PRODUIT" >  201  THEN 1
	     ELSE 0
	END 	     
) AS "5-Plus de 201"

FROM "I_OPE"."TB_PRODUIT" ;

----------------------------------------------------------------------------------------------------------------