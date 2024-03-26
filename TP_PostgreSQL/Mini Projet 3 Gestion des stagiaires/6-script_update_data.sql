----------------------------------------------------------------------------
------- Script de mise à jour des données dans les différentes tables ------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_RH";



----------------------------------------------------------------------------
-------------------- Table N°1 : "I_RH"."TB_STAGIAIRE" ---------------------
----------------------------------------------------------------------------
------------------------- Création de quelques vues ------------------------

-- Sélection des stagiaires actifs
CREATE VIEW "VW_STAGIAIRE_ACTIF" AS 
SELECT * FROM "TB_STAGIAIRE" WHERE "BL_ACTIF";

--- Sélection des stagiaires inactifs
CREATE VIEW "VW_STAGIAIRE_INACTIF" AS 
SELECT * FROM "TB_STAGIAIRE" WHERE NOT "BL_ACTIF";



----------------------------------------------------------------------------
------------------- Table N°4 : "I_RH"."TB_CONTRAT" ------------------------
----------------------------------------------------------------------------

--- Mettre à jour le champ "BL_ACTIF" de la table "I_RH"."TB_CONTRAT"
UPDATE  "TB_CONTRAT" 
SET 	"DT_ARRET_CONTRAT" = '2023-05-03', 
		"LB_MOTIF_ARRET"   = 'Absences répétées'
WHERE   "ID_CONTRAT"       = 'CSTG001';

SELECT *  FROM "TB_CONTRAT" ORDER BY "ID_CONTRAT";


--- Insertion d'un nouveau contrat dans la table "I_RH"."TB_CONTRAT"
INSERT INTO "TB_CONTRAT" ("ID_CONTRAT", "DT_DEBUT",  "DT_FIN", "CD_TYPE_CONTRAT", "ID_STAGIAIRE", "NB_SALAIRE", "DT_ARRET_CONTRAT", "LB_MOTIF_ARRET")
VALUES 
('CSTG041', '2021-09-23',  '2021-12-31', 'RSTG', 'STG005', 1500, '2021-12-23', 'Absences répétées') ;


--- Sélection des données présentes dans la table "I_RH"."TB_CONTRAT"
SELECT * FROM "TB_CONTRAT" ORDER BY "ID_CONTRAT" desc;



----------------------------------------------------------------------------
-------------------- Table N°1 : "I_RH"."TB_STAGIAIRE" ---------------------
----------------------------------------------------------------------------

--- Mettre à jour le champ "BL_ACTIF" de la table "I_RH"."TB_STAGIAIRE"
UPDATE "TB_STAGIAIRE" STG
SET "BL_ACTIF" = False

FROM 
(
	SELECT DISTINCT "ID_STAGIAIRE", "DT_ARRET_CONTRAT", 
		   LAST_VALUE("DT_FIN") 
		   OVER (
				PARTITION BY "ID_STAGIAIRE" 
				ORDER BY "DT_FIN"  ASC 
				RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as "LAST_DT_FIN"  
	FROM "TB_CONTRAT" 
) CTR
WHERE STG."ID_STAGIAIRE" = CTR."ID_STAGIAIRE"
AND   STG."BL_ACTIF" = True 
AND   ("LAST_DT_FIN" < CURRENT_DATE OR "DT_ARRET_CONTRAT" IS NOT NULL) ;


--- Mettre à jour le champ "BL_EMBAUCHE" de la table "I_RH"."TB_STAGIAIRE"
UPDATE "TB_STAGIAIRE" 
SET "BL_EMBAUCHE" = true
WHERE "ID_STAGIAIRE" = 'STG001';

select * from "TB_STAGIAIRE" order by "ID_STAGIAIRE";