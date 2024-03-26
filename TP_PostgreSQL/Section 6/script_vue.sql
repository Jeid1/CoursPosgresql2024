-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Création des vues ---------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

---------------------------------------- 1/Création de la vue : vente par client ----------------------------------------
-- Création de la vue : vente par client 
-- DROP VIEW IF EXISTS "I_OPE"."VW_VENTE_PAR_CLIENT";
CREATE VIEW "I_OPE"."VW_VENTE_PAR_CLIENT" AS 
SELECT "NOM_CLIENT"||' '||"PREN_CLIENT" AS "Nom et prénoms", 
COUNT(DISTINCT V."ID_VENTE") AS "Nombre de vente", 
SUM("QTE_VENTE"*"PRIX_VENTE") AS "Montant de vente"
FROM "I_OPE"."TB_CLIENT" C
INNER JOIN "I_OPE"."TB_VENTE" V 
    ON V."ID_CLIENT" = C."ID_CLIENT"
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D 
    ON V."ID_VENTE" = D."ID_VENTE"
GROUP BY "NOM_CLIENT"||' '||"PREN_CLIENT";

-- Affichage du résultat de la vue
SELECT * 
FROM "I_OPE"."VW_VENTE_PAR_CLIENT" ;

---------------------------------------- 2/Mise à jour de la vue : vente par client ----------------------------------------
-- Mise à jour de la vue : vente par client
CREATE OR REPLACE VIEW "I_OPE"."VW_VENTE_PAR_CLIENT" AS 
SELECT "NOM_CLIENT"||' '||"PREN_CLIENT" AS "Nom et prénoms", COUNT(DISTINCT V."ID_VENTE") AS "Nombre de vente", 
SUM("QTE_VENTE"*"PRIX_VENTE") AS "Montant de vente", SUM("QTE_VENTE") AS "Quantité vendue"
FROM "I_OPE"."TB_CLIENT" C
INNER JOIN "I_OPE"."TB_VENTE" V ON V."ID_CLIENT" = C."ID_CLIENT"
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
GROUP BY "NOM_CLIENT"||' '||"PREN_CLIENT";

-- Affichage du résultat de la vue
SELECT * 
FROM "I_OPE"."VW_VENTE_PAR_CLIENT" ;


---------------------------------------- 3/Création de la vue : Liste des clients ----------------------------------------
-- Création de la vue : Liste des clients
CREATE VIEW "I_OPE"."VW_LISTE_CLIENT" AS
SELECT *, "NOM_CLIENT"||' '||"PREN_CLIENT" AS "NOM_PRENOM_CLIENT"
FROM "I_OPE"."TB_CLIENT";

-- Affichage de la vue
SELECT * 
FROM "I_OPE"."VW_LISTE_CLIENT";


---------------------------- 4/Insertion des données dans la vue : "I_OPE"."VW_LISTE_CLIENT" ----------------------------
-- Insertion des données dans la vue : "I_OPE"."VW_LISTE_CLIENT"
INSERT INTO "I_OPE"."VW_LISTE_CLIENT"  
("ID_CLIENT", "NOM_CLIENT", "PREN_CLIENT", "CD_POSTAL_CLIENT", 
 "VILLE_CLIENT", "PAYS_CLIENT" , "REGION_CLIENT" , "CD_TYPE_CLIENT")
VALUES (999999, 'ADDA', 'Léonard', '00229', 'Cotonou', 'Benin', 'Littoral', 'T004');

-- Affichage du résultat de la vue
SELECT * 
FROM "I_OPE"."VW_LISTE_CLIENT" 
WHERE "ID_CLIENT"= '999999';


---------------------------- 5/Mise à jour des données dans la vue : "I_OPE"."VW_LISTE_CLIENT" ----------------------------
-- Mise à jour des données du client dont l'identifiant est '999999'
UPDATE "I_OPE"."VW_LISTE_CLIENT"  
SET "VILLE_CLIENT" = 'Porto Novo', 
    "REGION_CLIENT" = 'Ouémè'
WHERE "ID_CLIENT" = '999999' ;

-- Filtre sur le résultat de vue
SELECT * 
FROM "I_OPE"."VW_LISTE_CLIENT" 
WHERE "ID_CLIENT"= '999999';


---------------------------- 6/Suppression des données dans la vue : "I_OPE"."VW_LISTE_CLIENT" ----------------------------
-- Suppression des données du client dont l'identifiant est '999999'
DELETE 
FROM  "I_OPE"."VW_LISTE_CLIENT"  
WHERE "ID_CLIENT" = '999999' ;

-- Filtre sur le résultat de vue
SELECT * 
FROM "I_OPE"."VW_LISTE_CLIENT" 
WHERE "ID_CLIENT"= '999999';


---------------------------- 7/Suppression de la vue "I_OPE"."VW_LISTE_CLIENT" ----------------------------
-- Suppression de la vue "I_OPE"."VW_LISTE_CLIENT"
DROP VIEW IF EXISTS "I_OPE"."VW_LISTE_CLIENT";

-- Affichage de la vue
SELECT * 
FROM "I_OPE"."VW_LISTE_CLIENT";


---------------------------- 8/Création d'une vue temporaire "Vente par client" ----------------------------
-- Création d'une vue temporaire "Vente par client"
CREATE OR REPLACE TEMPORARY VIEW "Vente par client" AS 
SELECT "NOM_CLIENT"||' '||"PREN_CLIENT", COUNT(DISTINCT V."ID_VENTE") AS "Nombre de vente", 
SUM("QTE_VENTE"*"PRIX_VENTE") AS "Montant", SUM("QTE_VENTE") AS "Quantité vendue"
FROM "I_OPE"."TB_CLIENT" C
INNER JOIN "I_OPE"."TB_VENTE" V ON V."ID_CLIENT" = C."ID_CLIENT"
INNER JOIN "I_OPE"."TB_DETAIL_VENTE" D ON V."ID_VENTE" = D."ID_VENTE"
GROUP BY "NOM_CLIENT"||' '||"PREN_CLIENT";

-- Affichage de la vue
SELECT * FROM "Vente par client";
