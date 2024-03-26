----------------------------------------------------------------------------
------------------------- "I_OPE"."TB_TYPE_CLIENT" -------------------------
----------------------------------------------------------------------------
--- Sélection du nombre de données présentes dans la table "I_OPE"."TB_TYPE_CLIENT"
SELECT COUNT(1) FROM "I_OPE"."TB_TYPE_CLIENT";

--- Insertion des données dans la table "I_OPE"."TB_TYPE_CLIENT"
INSERT INTO "I_OPE"."TB_TYPE_CLIENT" ("CD_TYPE_CLIENT", "LB_TYPE_CLIENT")
VALUES 
('T004', 'Autre type');

--- Sélection des nouvelles données insérées dans la table "I_OPE"."TB_TYPE_CLIENT"
SELECT * FROM "I_OPE"."TB_TYPE_CLIENT" WHERE "CD_TYPE_CLIENT" = 'T004';

----------------------------------------------------------------------------
-------------------------- "I_OPE"."TB_CATEGORIE" --------------------------
----------------------------------------------------------------------------
--- Sélection du nombre de données présentes dans la table "I_OPE"."TB_CATEGORIE"
SELECT COUNT(1) FROM "I_OPE"."TB_CATEGORIE";

--- Insertion des données dans la table "I_OPE"."TB_CATEGORIE"
INSERT INTO "I_OPE"."TB_CATEGORIE" 
VALUES 
('C004', 'Autre catégorie');

--- Sélection des nouvelles données insérées dans la table "I_OPE"."TB_CATEGORIE"
SELECT * FROM "I_OPE"."TB_CATEGORIE" WHERE "CD_CATEGORIE" = 'C004';

----------------------------------------------------------------------------
----------------------- "I_OPE"."TB_SOUS_CATEGORIE" ------------------------
----------------------------------------------------------------------------
--- Sélection du nombre de données présentes dans la table "I_OPE"."TB_SOUS_CATEGORIE"
SELECT COUNT(1) FROM "I_OPE"."TB_SOUS_CATEGORIE";

--- Insertion des données dans la table "I_OPE"."TB_SOUS_CATEGORIE"
INSERT INTO "I_OPE"."TB_SOUS_CATEGORIE" 
VALUES 
('SC018','Inconnu', 'C004'),
('SC019','Autre sous catégorie', 'C004');

--- Sélection des nouvelles données insérées dans la table "I_OPE"."TB_SOUS_CATEGORIE"
SELECT * FROM "I_OPE"."TB_SOUS_CATEGORIE" WHERE "CD_SOUS_CATEGORIE" IN ('SC018', 'SC019');


----------------------------------------------------------------------------
----------------------- "I_OPE"."TB_CLIENT" --------------------------------
----------------------------------------------------------------------------
--- Sélection du nombre de données présentes dans la table "I_OPE"."TB_CLIENT"
SELECT COUNT(1) FROM "I_OPE"."TB_CLIENT";

--- Insertion des données dans la table "I_OPE"."TB_CLIENT"
INSERT INTO  "I_OPE"."TB_CLIENT"("ID_CLIENT", "NOM_CLIENT", "PREN_CLIENT",  "VILLE_CLIENT", "PAYS_CLIENT", "REGION_CLIENT", "CD_TYPE_CLIENT")
VALUES 
('99999999', 'Clients', 'Divers', 'Cotonou', 'Bénin', 'Afrique de l''Ouest', 'T004' );

--- Sélection des nouvelles données insérées dans la table "I_OPE"."TB_CLIENT"
SELECT * FROM "I_OPE"."TB_CLIENT" WHERE "ID_CLIENT" = '99999999';

----------------------------------------------------------------------------
----------------------- "I_OPE"."TB_PRODUIT" -------------------------------
----------------------------------------------------------------------------
--- Sélection du nombre de données présentes dans la table "I_OPE"."TB_PRODUIT"
SELECT COUNT(1) FROM "I_OPE"."TB_PRODUIT" ;

--- Création d'une table temporaire à partir d'une table existante 
CREATE TABLE "I_OPE"."TB_PRODUIT_TEMP" AS SELECT * FROM  "I_OPE"."TB_PRODUIT" LIMIT 0;

--- Insertion des données dans la table "I_OPE"."TB_PRODUIT_TEMP"
INSERT INTO  "I_OPE"."TB_PRODUIT_TEMP" ("CD_PRODUIT", "NOM_PRODUIT", "PRIX_ACHAT_PRODUIT", "PRIX_VENTE_PRODUIT", "CD_SOUS_CATEGORIE")
VALUES 
('P999999', 'Autre produit', 9.99, 14.99, 'SC018');

--- Insertion des données dans la table "I_OPE"."TB_PRODUIT"
INSERT INTO  "I_OPE"."TB_PRODUIT"
SELECT *
FROM "I_OPE"."TB_PRODUIT_TEMP";

--- Sélection des nouvelles données insérées dans la table "I_OPE"."TB_PRODUIT"
SELECT * FROM "I_OPE"."TB_PRODUIT" WHERE "CD_PRODUIT" = 'P999999';

--- Suppression de la table temporaire "I_OPE"."TB_PRODUIT_TEMP"
DROP TABLE IF EXISTS "I_OPE"."TB_PRODUIT_TEMP";

----------------------------------------------------------------------------
----------------------- "I_OPE"."TB_VENTE" ---------------------------------
----------------------------------------------------------------------------
--- Sélection du nombre de données présentes dans la table "I_OPE"."TB_VENTE"
SELECT COUNT(1) FROM "I_OPE"."TB_VENTE";

--- Insertion des données dans la table "I_OPE"."TB_VENTE"
INSERT INTO "I_OPE"."TB_VENTE"("ID_VENTE", "DT_VENTE", "ID_CLIENT")
VALUES
('CA-2022-AB10015140-00001', CURRENT_TIMESTAMP, '99999999');

--- Sélection des nouvelles données insérées dans la table "I_OPE"."TB_VENTE"
SELECT * FROM "I_OPE"."TB_VENTE" WHERE "ID_VENTE" = 'CA-2022-AB10015140-00001';


----------------------------------------------------------------------------
------------------------ "I_OPE"."TB_DETAIL_VENTE" -------------------------
----------------------------------------------------------------------------
--- Sélection du nombre de données présentes dans la table "I_OPE"."TB_DETAIL_VENTE"
SELECT COUNT(1) FROM "I_OPE"."TB_DETAIL_VENTE";

--- Insertion des données dans la table "I_OPE"."TB_DETAIL_VENTE"
INSERT INTO "I_OPE"."TB_DETAIL_VENTE"("ID_VENTE", "CD_PRODUIT", "QTE_VENTE", "PRIX_VENTE", "PRIX_ACHAT")
VALUES
('CA-2022-AB10015140-00001', 'P999999', 10, 14.99, 9.99)
;

--- Sélection des nouvelles données insérées dans la table "I_OPE"."TB_DETAIL_VENTE"
SELECT * FROM "I_OPE"."TB_DETAIL_VENTE" WHERE "ID_VENTE" = 'CA-2022-AB10015140-00001' AND "CD_PRODUIT" IN ('P999999') ;
