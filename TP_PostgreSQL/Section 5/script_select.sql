-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------- Sélection des données -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
SELECT 'J''aime PostgreSQL';

-- 1/ Afficher la liste des catégories
SELECT "CD_CATEGORIE" "Code catégorie", "LB_CATEGORIE" AS "Libellé catégorie" 
FROM  "I_OPE"."TB_CATEGORIE";


-- 2/ Afficher la liste des sous catégories 
SELECT "CD_SOUS_CATEGORIE" AS "Code sous catégorie", "LB_SOUS_CATEGORIE" AS "Libellé sous catégorie", 
       "CD_CATEGORIE" as "Code catégorie"
FROM "I_OPE"."TB_SOUS_CATEGORIE";


-- 3/ Afficher la liste des produits
SELECT "CD_PRODUIT" AS "Code produit", "NOM_PRODUIT" AS "Nom produit", "PRIX_ACHAT_PRODUIT" as "Prix d''achat", 
       "PRIX_VENTE_PRODUIT" AS "Prix de vente", "CD_SOUS_CATEGORIE" AS "Code sous catégorie"
FROM  "I_OPE"."TB_PRODUIT";


-- 4/ Afficher la liste des types de client
SELECT "CD_TYPE_CLIENT" AS "Code type client", "LB_TYPE_CLIENT" AS "Libellé type client"
FROM "I_OPE"."TB_TYPE_CLIENT";


-- 5/ Afficher la liste des clients
SELECT "ID_CLIENT" AS "Identifiant client", "NOM_CLIENT" AS "Nom client", "PREN_CLIENT" AS "Prénom client", "CD_POSTAL_CLIENT" AS "Code postal",
       "VILLE_CLIENT" AS "Ville", "PAYS_CLIENT" AS "Pays", "REGION_CLIENT" AS "Région", "CD_TYPE_CLIENT" AS "Code type client"
FROM "I_OPE"."TB_CLIENT";


-- 6/ Afficher la liste des ventes
SELECT "ID_VENTE" AS "Identifiant vente", "DT_VENTE" AS "Date de vente", "ID_CLIENT" AS "Identifiant client"
FROM "I_OPE"."TB_VENTE";


-- 7/ Afficher la liste des détails de vente
SELECT "ID_VENTE" AS "Identifiant vente", "CD_PRODUIT" AS "Code produit", "QTE_VENTE" AS "Quantité vendue", 
       "PRIX_VENTE" AS "Prix de vente", "PRIX_ACHAT" AS "Prix d''achat"
FROM "I_OPE"."TB_DETAIL_VENTE";
