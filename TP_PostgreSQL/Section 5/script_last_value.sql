----------------------------------------------------------------------------------------------------------------
------------------------------------------------- Fonction LAST_VALUE  -----------------------------------------
----------------------------------------------------------------------------------------------------------------
-- 1/ Produit ayant le meilleur montant de vente pour chaque vente
SELECT DISTINCT "ID_VENTE" AS "Identifiant vente", 

	LAST_VALUE("CD_PRODUIT") 
	OVER (
		PARTITION BY "ID_VENTE" 
		ORDER BY "QTE_VENTE"*"PRIX_VENTE" ASC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Produit",
		
	LAST_VALUE("QTE_VENTE"*"PRIX_VENTE") 
	OVER (
		PARTITION BY "ID_VENTE" 
		ORDER BY "QTE_VENTE"*"PRIX_VENTE" ASC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Montant"
		
FROM "I_OPE"."TB_DETAIL_VENTE";


-- 2/ Produit ayant le plus bas montant de vente pour chaque vente
SELECT DISTINCT "ID_VENTE" AS "Identifiant vente", 

	LAST_VALUE("CD_PRODUIT") 
	OVER (
		PARTITION BY "ID_VENTE" 
		ORDER BY "QTE_VENTE"*"PRIX_VENTE" DESC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Produit",
		
	LAST_VALUE("QTE_VENTE"*"PRIX_VENTE") 
	OVER (
		PARTITION BY "ID_VENTE" 
		ORDER BY "QTE_VENTE"*"PRIX_VENTE" DESC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Montant"
		
FROM "I_OPE"."TB_DETAIL_VENTE";
----------------------------------------------------------------------------------------------------------------

--- Détail d'une vente donnée
SELECT "ID_VENTE", "CD_PRODUIT", "QTE_VENTE"*"PRIX_VENTE" AS "MONTANT"	 
FROM "I_OPE"."TB_DETAIL_VENTE"
WHERE "ID_VENTE" = 'CA-2015-SV20365140-42268'
ORDER BY "QTE_VENTE"*"PRIX_VENTE" ASC