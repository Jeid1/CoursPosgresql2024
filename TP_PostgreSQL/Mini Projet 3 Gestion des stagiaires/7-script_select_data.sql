----------------------------------------------------------------------------
---------------------------- Quelques requêtes  ----------------------------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_RH";


----------------------------------------------------------------------------
-------------------- Table N°1 : "I_RH"."TB_STAGIAIRE" ---------------------
----------------------------------------------------------------------------
-- Nombre total de stagiaires par civilité
SELECT CASE WHEN "LB_CIVILITE" ='Mr' THEN 'Masculin'
			ELSE 'Féminin'
		END AS "Civilité", COUNT(1) AS "Nb Stagiaires"
FROM "TB_STAGIAIRE"
GROUP BY "Civilité";


-- Âge des stagiaires avec leur tranche d'âge
SELECT "ID_STAGIAIRE" AS "Matricule", 
       "LB_CIVILITE" || ' ' || "LB_NOM_STAGIAIRE" || ' ' || "LB_PREN_STAGIAIRE" AS "Nom et prénoms",
	   "DT_NAISSANCE" AS "Dt Naissance", AGE(CURRENT_DATE, "DT_NAISSANCE") AS "Age exact",
	   DATE_PART('YEAR', AGE(CURRENT_DATE, "DT_NAISSANCE")) AS "Age en année",
	   CASE WHEN DATE_PART('YEAR', AGE(CURRENT_DATE, "DT_NAISSANCE")) < 20  THEN 'Moins de 20 ans'	
			WHEN DATE_PART('YEAR', AGE(CURRENT_DATE, "DT_NAISSANCE")) < 26  THEN '20 - 25'
			WHEN DATE_PART('YEAR', AGE(CURRENT_DATE, "DT_NAISSANCE")) < 31  THEN '26 - 30'
			WHEN DATE_PART('YEAR', AGE(CURRENT_DATE, "DT_NAISSANCE")) < 36  THEN '31 - 35'
			ELSE '36 et plus'
		END  AS "Tranche d''âge"					 
FROM "TB_STAGIAIRE"
ORDER BY "ID_STAGIAIRE";


-- Liste des stagiaires embauchés									   
SELECT *									   
FROM "TB_STAGIAIRE"
WHERE "BL_EMBAUCHE"
ORDER BY "ID_STAGIAIRE";

									   
									   
----------------------------------------------------------------------------
------------------- Table N°4 : "I_RH"."TB_CONTRAT" ------------------------
----------------------------------------------------------------------------								   

--- 1/ Sélection des contrats des stagiaires actifs
SELECT CTR.* 
FROM "TB_CONTRAT" CTR
	INNER JOIN "VW_STAGIAIRE_ACTIF" STG 
	ON STG."ID_STAGIAIRE" = CTR."ID_STAGIAIRE"
ORDER BY "ID_CONTRAT";

									   
--- 2/ Sélection des contrats des stagiaires inactifs
SELECT CTR.* 
FROM "TB_CONTRAT" CTR
	INNER JOIN "VW_STAGIAIRE_INACTIF" STG 
	ON STG."ID_STAGIAIRE" = CTR."ID_STAGIAIRE"
ORDER BY "ID_CONTRAT";									   
									   
									   
-- 3/ Nombre total de contrats de stage par année
SELECT DATE_PART('YEAR', "DT_DEBUT") AS "Année", COUNT(1) AS "Nb Contrats"
FROM "TB_CONTRAT"
GROUP BY DATE_PART('YEAR', "DT_DEBUT");


-- 4/ Nombre total de stagiaire contractuel par année
SELECT DATE_PART('YEAR', "DT_DEBUT") AS "Année", COUNT(DISTINCT "ID_STAGIAIRE") AS "Nb Stagiaires"
FROM "TB_CONTRAT"
GROUP BY DATE_PART('YEAR', "DT_DEBUT");


-- 5/ Effectif stagiaire par année
SELECT t."Année", COALESCE("Nb Stagiaires", 0)+ COALESCE("Nb Stagiaires2", 0)
FROM generate_series((SELECT MIN(DATE_PART('YEAR', "DT_DEBUT"))::integer FROM "TB_CONTRAT"), 
					 (SELECT MAX(DATE_PART('YEAR', "DT_FIN"))::integer FROM "TB_CONTRAT")) t ("Année")
	LEFT OUTER JOIN 
		(
			SELECT DATE_PART('YEAR', "DT_DEBUT") AS "Année" , COUNT(DISTINCT "ID_STAGIAIRE") as "Nb Stagiaires"						   
			FROM "TB_CONTRAT"								  
			GROUP BY DATE_PART('YEAR', "DT_DEBUT")
			ORDER BY DATE_PART('YEAR', "DT_DEBUT")
		) t1 on t1."Année" = t."Année"
	LEFT OUTER JOIN 
		(
			SELECT DATE_PART('YEAR', "DT_FIN") AS "Année" , COUNT(DISTINCT "ID_STAGIAIRE") as "Nb Stagiaires2"							   
			FROM "TB_CONTRAT"
			WHERE DATE_PART('YEAR', "DT_FIN") != DATE_PART('YEAR', "DT_DEBUT")
			GROUP BY DATE_PART('YEAR', "DT_FIN")
			ORDER BY DATE_PART('YEAR', "DT_FIN")		
		) t2 on t2."Année" = t."Année";		