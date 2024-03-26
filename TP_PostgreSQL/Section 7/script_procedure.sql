-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- Création des procédures stockées -------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Synthase SQL d'une procédure stockée 
/*
CREATE OR REPLACE PROCEDURE 'NOM_DE_LA_PROCEDURE_STOCKÉE' (LES VARIABLES Á DÉCLARER)
LANGUAGE SQL | PLPGSQL
AS $$
BEGIN
	LES REQUÊTES SQL
END 
$$;
*/

-- DROP PROCEDURE IF EXISTS 'NOM_DE_LA_PROCEDURE_STOCKÉE'

---------------------------------------- 1/Création de la procédure stockée permettant d'insérer les données ------------
---------------------------------------- dans la table TB_CATEGORIE : NEW_CATEGORIE -------------------------------------

-- Sélection des données présentes dans la table "I_OPE"."TB_CATEGORIE"
SELECT * FROM "I_OPE"."TB_CATEGORIE"

-- Création de la procédure stockée : NEW_CATEGORIE
-- DROP PROCEDURE IF EXISTS "I_OPE"."NEW_CATEGORIE"
CREATE OR REPLACE PROCEDURE "I_OPE"."NEW_CATEGORIE"(code_categorie varchar(10), libellé_categorie varchar(100))
LANGUAGE PLPGSQL
AS $$																				   
BEGIN 
	INSERT INTO "I_OPE"."TB_CATEGORIE" VALUES (code_categorie, libellé_categorie);
END
$$;

-- Appel de la procédure stockée NEW_CATEGORIE pour insérer les données 																					   
CALL "I_OPE"."NEW_CATEGORIE" ('C005', 'Autres')	;														  
																						   
---------------------------------------- 2/Création de la procédure stockée permettant de mettre à jour les -----------
---------------------------------------- données dans la table TB_PRODUIT : UPDATE_PRIX_ACHAT_PRODUIT -----------------

-- Sélection des données présentes dans la table "I_OPE"."TB_PRODUIT" dont le code produit est 'FUR-BO-5957' ou 'FUR-CH-4421'																					   
SELECT * FROM "I_OPE"."TB_PRODUIT" WHERE "CD_PRODUIT" IN ('FUR-BO-5957', 'FUR-CH-4421')

-- Création de la procédure stockée : UPDATE_PRIX_ACHAT_PRODUIT
-- DROP PROCEDURE IF EXISTS "I_OPE"."UPDATE_PRIX_ACHAT_PRODUIT"																										  
CREATE OR REPLACE PROCEDURE "I_OPE"."UPDATE_PRIX_ACHAT_PRODUIT"
							(valeur1 numeric, valeur2 numeric, 
							 code_produit1 varchar(50), code_produit2 varchar(50))
LANGUAGE PLPGSQL																													 
AS $$
BEGIN																										
	UPDATE "I_OPE"."TB_PRODUIT"
	SET "PRIX_ACHAT_PRODUIT" = "PRIX_ACHAT_PRODUIT"+valeur1
	WHERE "CD_PRODUIT" IN (code_produit1) ; 

	UPDATE "I_OPE"."TB_PRODUIT"
	SET "PRIX_ACHAT_PRODUIT" = "PRIX_ACHAT_PRODUIT"+valeur2
	WHERE "CD_PRODUIT" IN (code_produit2) ;		
END 																										
$$;

-- Appel de la procédure stockée UPDATE_PRIX_ACHAT_PRODUIT pour mettre à jour les données
CALL "I_OPE"."UPDATE_PRIX_ACHAT_PRODUIT" (-1,-1,'FUR-BO-5957', 'FUR-CH-4421');	
																																  
---------------------------------------- 3/Création de la procédure stockée permettant de supprimer les données ----------
---------------------------------------- dans la table TB_CATEGORIE : DELETE_CATEGORIE -----------------------------------
																											
-- Sélection des données présentes dans la table "I_OPE"."TB_CATEGORIE"																											
SELECT * FROM "I_OPE"."TB_CATEGORIE"

-- Création de la procédure stockée : DELETE_CATEGORIE	
-- DROP PROCEDURE IF EXISTS "I_OPE"."DELETE_CATEGORIE"																	  
CREATE OR REPLACE PROCEDURE "I_OPE"."DELETE_CATEGORIE"(code_categorie varchar(10))
LANGUAGE PLPGSQL
AS $$															
BEGIN  
	DELETE FROM "I_OPE"."TB_CATEGORIE" WHERE "CD_CATEGORIE" = code_categorie;															
END
$$;

-- Appel de la procédure stockée DELETE_CATEGORIE pour supprimer les données																			
CALL "I_OPE"."DELETE_CATEGORIE" ('C006')	
																			
-------------------------------------------------------------------------------------------------------------------------																																			