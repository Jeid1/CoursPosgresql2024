-------------------------------------------------------------------------------------------------
-------------------------------------  Calcul Somme cumulée  ------------------------------------
-------------------------------------------------------------------------------------------------
-- Synthase SQL de la fonction
/*
SUM(expression) 
OVER (
    PARTITION BY partition_expression, ... 
    ORDER BY sort_expression [ASC | DESC], ...
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
*/


-- 1/ Cumul montant des ventes par année
SELECT "Année", "Montant vente",
	   SUM("Montant vente") 
	   OVER (ORDER BY "Année" 
			 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
			 AS "Cumul Montant vente"												   
FROM
--- Sous-requête : Montant des ventes par année														
(
	SELECT DATE_PART('YEAR', "DT_VENTE") AS "Année", 
		   ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2) 
		   AS "Montant vente"											  
	FROM "I_OPE"."TB_VENTE" V
	INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D 
	ON V."ID_VENTE" = D."ID_VENTE"
	GROUP BY DATE_PART('YEAR', "DT_VENTE")
)L;


--2/ Cumul montant des ventes par année et par mois
SELECT "Année", "Mois", "Montant vente",
	   SUM("Montant vente") 
	   OVER (PARTITION BY "Année" 
			 ORDER BY "Année", "N° Mois" 
			 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
			 AS "Cumul Montant vente"												   
FROM
--- Sous-requête : Montant des ventes par année et par mois														
(
	SELECT DATE_PART('YEAR', "DT_VENTE") AS "Année", 
	       DATE_PART('MONTH', "DT_VENTE") AS "N° Mois",
	       CASE
				WHEN DATE_PART('MONTH', "DT_VENTE") =  1 THEN 'Janvier'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  2 THEN 'Février'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  3 THEN 'Mars'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  4 THEN 'Avril'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  5 THEN 'Mai'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  6 THEN 'Juin'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  7 THEN 'Juillet'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  8 THEN 'Août'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  9 THEN 'Septembre'
				WHEN DATE_PART('MONTH', "DT_VENTE") = 10 THEN 'Octobre'
				WHEN DATE_PART('MONTH', "DT_VENTE") = 11 THEN 'Novembre'
				WHEN DATE_PART('MONTH', "DT_VENTE") = 12 THEN 'Décembre'
		   END AS "Mois",
		   ROUND(SUM("QTE_VENTE"*"PRIX_VENTE"),2) AS "Montant vente"											  
	FROM "I_OPE"."TB_VENTE" V
	INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
	GROUP BY  DATE_PART('YEAR', "DT_VENTE"), DATE_PART('MONTH', "DT_VENTE"),
	       CASE
				WHEN DATE_PART('MONTH', "DT_VENTE") =  1 THEN 'Janvier'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  2 THEN 'Février'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  3 THEN 'Mars'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  4 THEN 'Avril'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  5 THEN 'Mai'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  6 THEN 'Juin'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  7 THEN 'Juillet'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  8 THEN 'Août'
				WHEN DATE_PART('MONTH', "DT_VENTE") =  9 THEN 'Septembre'
				WHEN DATE_PART('MONTH', "DT_VENTE") = 10 THEN 'Octobre'
				WHEN DATE_PART('MONTH', "DT_VENTE") = 11 THEN 'Novembre'
				WHEN DATE_PART('MONTH', "DT_VENTE") = 12 THEN 'Décembre'
		   END
)L;		