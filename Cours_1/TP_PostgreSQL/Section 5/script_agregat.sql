----------------------------------------------------------------------------------------------------------------
----------------------------------------------- Fonctions d'agrégations  ---------------------------------------
----------------------------------------------------------------------------------------------------------------

------------------------------------------------- Fonction SUM -------------------------------------------------
-- 1/ Montant total des ventes
SELECT SUM("QTE_VENTE"*"PRIX_VENTE") AS "Montant des ventes"
FROM "I_OPE"."TB_DETAIL_VENTE" ;


-- 2/ Montant de chaque vente
SELECT "ID_VENTE" AS "Identifiant vente", SUM("QTE_VENTE"*"PRIX_VENTE") AS "Montant des ventes"
FROM "I_OPE"."TB_DETAIL_VENTE"
GROUP BY "ID_VENTE";


------------------------------------------------- Fonction COUNT -------------------------------------------------
-- 3/ Nombre total de vente
SELECT COUNT("ID_VENTE") AS "Nombre de vente", COUNT(DISTINCT "ID_VENTE") AS "Nombre de vente distinct"
FROM "I_OPE"."TB_DETAIL_VENTE" ;


-- 4/ Nombre de produits par vente
SELECT "ID_VENTE" AS "Identifiant vente", COUNT("CD_PRODUIT") AS "Nombre de produit"
FROM "I_OPE"."TB_DETAIL_VENTE"
GROUP BY "ID_VENTE";


------------------------------------------------- Fonction AVG -------------------------------------------------
-- 5/ Moyenne des ventes
SELECT AVG("QTE_VENTE"*"PRIX_VENTE") AS "Moyenne des ventes"
FROM "I_OPE"."TB_DETAIL_VENTE" ;


-- 6/ Moyenne de chaque vente
SELECT "ID_VENTE" AS "Identifiant vente", AVG("QTE_VENTE"*"PRIX_VENTE") AS "Moyenne des ventes"
FROM "I_OPE"."TB_DETAIL_VENTE"
GROUP BY "ID_VENTE";

------------------------------------------------- Fonction MIN -------------------------------------------------
-- 7/ Montant minimum des ventes
SELECT MIN("QTE_VENTE"*"PRIX_VENTE") AS "Montant minimum"
FROM "I_OPE"."TB_DETAIL_VENTE" ;


-- 8/ Premier code produit
SELECT MIN("CD_PRODUIT") AS "Premier code produit"
FROM "I_OPE"."TB_PRODUIT" ;


------------------------------------------------- Fonction MAX -------------------------------------------------
-- 9/ Montant maximum des ventes
SELECT MAX("QTE_VENTE"*"PRIX_VENTE") AS "Montant maximum"
FROM "I_OPE"."TB_DETAIL_VENTE" ;


-- 10/ Dernier code produit
SELECT MAX("CD_PRODUIT") AS "Dernier code produit"
FROM "I_OPE"."TB_PRODUIT" 

----------------------------------------------------------------------------------------------------------------