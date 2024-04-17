-------------------------------------------------------------------------------------------------
--------------------------- Utilisation de la fonction ROW_NUMBER()   ---------------------------
-------------------------------------------------------------------------------------------------
-- Synthase SQL de la fonction ROW_NUMBER()
/*
ROW_NUMBER() 
	OVER(
		[PARTITION BY COLUMN_1, COLUMN_2, …]
		[ORDER BY COLUMN_3, COLUMN_4, …]
	)
*/

-- 1/ Liste des clients avec affichage du numéro de ligne
SELECT ROW_NUMBER () OVER () AS "N° Ligne", "ID_CLIENT" AS "Identifiant client", 
       "NOM_CLIENT" AS "Nom client", "PREN_CLIENT" AS "Prénom client"
FROM "I_OPE"."TB_CLIENT";


-- 2/ Liste des clients avec affichage du numéro de ligne (tri sur le nom et prénom)
SELECT ROW_NUMBER () OVER (ORDER BY "NOM_CLIENT", "PREN_CLIENT") AS "N° Ligne", "ID_CLIENT" AS "Identifiant client", 
       "NOM_CLIENT" AS "Nom client", "PREN_CLIENT" as "Prénom client"
FROM "I_OPE"."TB_CLIENT";


-- 3/ Liste des clients avec affichage du numéro de ligne (le numéro de ligne est réinitialisé à chaque type client)
SELECT ROW_NUMBER () OVER (PARTITION BY "CD_TYPE_CLIENT") AS "N° Ligne", "ID_CLIENT" AS "Identifiant client", 
       "NOM_CLIENT" AS "Nom client", "PREN_CLIENT" AS "Prénom client", "CD_TYPE_CLIENT" AS "Type client"
FROM "I_OPE"."TB_CLIENT"
ORDER BY "CD_TYPE_CLIENT";


-- 4/ Liste des clients avec affichage du numéro de ligne (le numéro de ligne est réinitialisé à chaque type client)
--    Tri sur le nom et prénom
SELECT ROW_NUMBER () OVER (PARTITION BY "CD_TYPE_CLIENT" ORDER BY "NOM_CLIENT", "PREN_CLIENT") AS "N° Ligne",  
       "ID_CLIENT" AS "Identifiant client", "NOM_CLIENT" AS "Nom client", "PREN_CLIENT" AS "Prénom client", 
	   "CD_TYPE_CLIENT" AS "Type client"
FROM "I_OPE"."TB_CLIENT"
ORDER BY "CD_TYPE_CLIENT";


-- 5/ Montant des ventes par client et par année avec affichage du numéro de ligne
SELECT ROW_NUMBER () OVER (ORDER BY SUM ("QTE_VENTE"*"PRIX_VENTE") DESC) AS "N° Ligne",
	   DATE_PART('YEAR',"DT_VENTE") AS "Année de vente",
       "NOM_CLIENT" AS "Nom client", "PREN_CLIENT" AS "Prénom client", 
	   ROUND(SUM ("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente"
FROM "I_OPE"."TB_VENTE" V
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
INNER JOIN "I_OPE"."TB_CLIENT" C ON V."ID_CLIENT" = C."ID_CLIENT"
GROUP BY DATE_PART('YEAR',"DT_VENTE"),"NOM_CLIENT", "PREN_CLIENT";


-- 6/ Montant des ventes par client et par année avec affichage du numéro de ligne partitionné par année de vente
SELECT ROW_NUMBER () OVER (PARTITION BY DATE_PART('YEAR',"DT_VENTE") ORDER BY SUM ("QTE_VENTE"*"PRIX_VENTE") DESC) AS "N° Ligne",
	   DATE_PART('YEAR',"DT_VENTE") AS "Année de vente", "NOM_CLIENT" AS "Nom client",
       "PREN_CLIENT" AS "Prénom client", ROUND(SUM ("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente"	   
FROM "I_OPE"."TB_VENTE" V
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
INNER JOIN "I_OPE"."TB_CLIENT" C ON V."ID_CLIENT" = C."ID_CLIENT"
GROUP BY DATE_PART('YEAR',"DT_VENTE"),"NOM_CLIENT", "PREN_CLIENT";


-- Top 2 des ventes client par année
SELECT "N° Ligne", "Année de vente", "Nom client",
       "Prénom client", "Montant vente"	
FROM 
/*Sous-requête (Montant des ventes par client et par année avec affichage  
  du numéro de ligne partitionné par année de vente)*/
	(
		SELECT ROW_NUMBER () OVER (PARTITION BY DATE_PART('YEAR',"DT_VENTE") 
			   ORDER BY SUM ("QTE_VENTE"*"PRIX_VENTE") DESC) AS "N° Ligne",
			   DATE_PART('YEAR',"DT_VENTE") AS "Année de vente", 
			   "NOM_CLIENT" AS "Nom client",
			   "PREN_CLIENT" AS "Prénom client", 
			   ROUND(SUM ("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente"	   
		FROM "I_OPE"."TB_VENTE" V
		INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
		INNER JOIN "I_OPE"."TB_CLIENT" C ON V."ID_CLIENT" = C."ID_CLIENT"
		GROUP BY DATE_PART('YEAR',"DT_VENTE"),"NOM_CLIENT", "PREN_CLIENT"
	) P
WHERE "N° Ligne" BETWEEN 1 AND 2;


