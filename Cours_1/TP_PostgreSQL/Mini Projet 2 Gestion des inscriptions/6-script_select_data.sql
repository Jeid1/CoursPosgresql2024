----------------------------------------------------------------------------
---------------------------- Quelques requêtes  ----------------------------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_SCOLARITE";


-- Total inscrit en 2022
SELECT 'Nombre total inscrit : '|| COUNT(1) AS "Nb Inscription"
FROM "TB_INSCRIPTION"
WHERE "ANNEE_SCOLAIRE" = 2022;


-- Liste des professeurs responsable d'une formation
SELECT F."NOM_FORMATION", E.*
FROM "TB_FORMATION" F
	INNER JOIN "TB_ENSEIGNANT" E 
		ON F."ID_RESPO_FORMATION" = E."ID_ENSEIGNANT";


-- Liste des échéances non réglées
SELECT *
FROM "TB_ECHEANCE" E
	LEFT JOIN "TB_PAIEMENT" P 
		ON E."ID_PAIEMENT" = P."ID_PAIEMENT"
WHERE "DT_ECHEANCE" < CURRENT_DATE
	AND (E."ID_PAIEMENT" IS NULL OR "MT_ECHEANCE" > "MT_PAYE");
