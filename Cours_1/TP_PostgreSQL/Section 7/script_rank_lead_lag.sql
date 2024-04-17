-------------------------------------------------------------------------------------------------
------------------------------- Utilisation de la fonction RANK()   -----------------------------
-------------------------------------------------------------------------------------------------
-- Synthase SQL de la fonction RANK()
/*
RANK() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
*/
 
--1/ Liste des produits avec le rang en fonction du prix d'achat
SELECT "CD_PRODUIT" as "Code", "NOM_PRODUIT" AS "Nom produit", 
	   "PRIX_ACHAT_PRODUIT" AS "Prix d''achat",
       RANK() OVER (ORDER BY "PRIX_ACHAT_PRODUIT" DESC) AS "Rang"
FROM "I_OPE"."TB_PRODUIT";


-- 2/ Nombre de produits ayant le même rang et donc le même prix
SELECT  "Rang", "Prix d''achat", COUNT("Rang") AS "Nombre de produits"
FROM 
	-- Sous-requête : Liste des produits avec le rang en fonction du prix d'achat
	(
	SELECT "CD_PRODUIT" as "Code", "NOM_PRODUIT" AS "Nom produit", 
		   "PRIX_ACHAT_PRODUIT" AS "Prix d''achat",
		   RANK() OVER (ORDER BY "PRIX_ACHAT_PRODUIT" DESC) AS "Rang"
	FROM "I_OPE"."TB_PRODUIT"
	) produit
GROUP BY "Rang", "Prix d''achat"
HAVING COUNT("Rang") > 1
ORDER BY COUNT("Rang") DESC;


-- 3/ Détail des produits ayant le même prix
SELECT  "Code", "Nom produit", "Prix d''achat"
FROM 
	-- Sous-requête : Liste des produits avec le rang en fonction du prix d'achat
	(
		SELECT "CD_PRODUIT" as "Code", "NOM_PRODUIT" AS "Nom produit", "PRIX_ACHAT_PRODUIT" AS "Prix d''achat",
			   RANK() OVER (ORDER BY "PRIX_ACHAT_PRODUIT" DESC) AS "Rang"
		FROM "I_OPE"."TB_PRODUIT"
	) produit
	INNER JOIN 
	-- Sous-requête : Rang des produits ayant le même prix
	(
		SELECT  "Rang"
		FROM 
			(
			SELECT "CD_PRODUIT" as "Code", "NOM_PRODUIT" AS "Nom produit", "PRIX_ACHAT_PRODUIT" AS "Prix d''achat",
				   RANK() OVER (ORDER BY "PRIX_ACHAT_PRODUIT" DESC) AS "Rang"
			FROM "I_OPE"."TB_PRODUIT"
			) produit
		GROUP BY "Rang"
		HAVING COUNT("Rang") > 1
	) rang_produit ON rang_produit."Rang" = produit."Rang" ;


-------------------------------------------------------------------------------------------------
------------------------------- Utilisation de la fonction LEAD()   -----------------------------
-------------------------------------------------------------------------------------------------
-- Synthase SQL de la fonction LEAD()
/*
LEAD(expression [,offset [,default_value]]) 
OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
*/

--1/ Montant des ventes par année avec affichage du montant de l'année suivante
SELECT DATE_PART('YEAR', "DT_VENTE") AS "Année", 
	   ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente (Année actuelle)",
       LEAD(ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2),1) 
	   OVER (ORDER BY DATE_PART('YEAR', "DT_VENTE")) AS  "Montant vente (Année suivante)"
FROM "I_OPE"."TB_VENTE" V
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
GROUP BY DATE_PART('YEAR', "DT_VENTE");

																			   
-- 2/ Montant des ventes par mois et par année avec affichage 
--    du montant du mois et de l'année suivante																			   
SELECT DATE_PART('YEAR', "DT_VENTE") AS "Année", 
	   DATE_PART('MONTH', "DT_VENTE") AS "Mois",																	   
	   ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente (Mois actuel)",
       LEAD(ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2),1) 
	   OVER (PARTITION BY DATE_PART('YEAR', "DT_VENTE") 
			 ORDER BY DATE_PART('MONTH', "DT_VENTE")) AS  "Montant vente (Mois suivant)"
FROM "I_OPE"."TB_VENTE" V
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
GROUP BY DATE_PART('YEAR', "DT_VENTE"), DATE_PART('MONTH', "DT_VENTE")	
ORDER BY DATE_PART('YEAR', "DT_VENTE"), DATE_PART('MONTH', "DT_VENTE");																				   
																			   
																			   
-------------------------------------------------------------------------------------------------
------------------------------- Utilisation de la fonction LAG()   ------------------------------
-------------------------------------------------------------------------------------------------
-- Synthase SQL de la fonction LAG()
/*
LAG(expression [,offset [,default_value]]) 
OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
*/

--1/ Montant des ventes par année avec affichage du montant de l'année précédente
SELECT DATE_PART('YEAR', "DT_VENTE") AS "Année", 
	   ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente (Année actuelle)",
       LAG(ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2),1) 
	   OVER (ORDER BY DATE_PART('YEAR', "DT_VENTE")) AS  "Montant vente (Année précédente)"															  
FROM "I_OPE"."TB_VENTE" V
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
GROUP BY DATE_PART('YEAR', "DT_VENTE");
																															 

-- 2/ Montant des ventes par année avec affichage du montant de l'année précédente + Différence
SELECT DATE_PART('YEAR', "DT_VENTE") AS "Année", 
	   ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente (Année actuelle)",
       LAG(ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2),1) 
	   OVER (ORDER BY DATE_PART('YEAR', "DT_VENTE")) AS  "Montant vente (Année précédente)",
	   ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2) - 	
	   LAG(ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2),1) 
	   OVER (ORDER BY DATE_PART('YEAR', "DT_VENTE")) AS  "Différence(Année n -(n-1))" 																	  
FROM "I_OPE"."TB_VENTE" V
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
GROUP BY DATE_PART('YEAR', "DT_VENTE");																															 