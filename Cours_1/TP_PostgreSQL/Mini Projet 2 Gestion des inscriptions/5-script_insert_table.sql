----------------------------------------------------------------------------
-------- Script d'insertion des données dans les différentes tables --------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_SCOLARITE";


----------------------------------------------------------------------------
------------------ Table N°1 : "I_SCOLARITE"."TB_PAYEUR" -------------------
----------------------------------------------------------------------------
-- Sélection des données présentes dans la table "TB_PAYEUR"
SELECT * FROM "TB_PAYEUR";

-- Insertion de trois formations dans la table "TB_PAYEUR"
INSERT INTO "TB_PAYEUR" ("CD_CNI_PAYEUR", "LB_NOM_PAYEUR","LB_PREN_PAYEUR", "LB_ADR_PAYEUR", "LB_TEL_PAYEUR")
VALUES 
	('CN000099', 'ADDA', 'Raoul', 'Benin', '99-99-99-99'),
	('CN000098', 'ADDA', 'Léonard', 'Benin', '99-99-99-96')
RETURNING * ; -- Permet d'afficher les lignes insérées dans la console de sortie

	
	
-- Vérification des différentes contraintes 
	/* Rappel : 
		1- Clé primaire = "ID_PAYEUR"
		2- Clé Unique = "CD_CNI_PAYEUR"
	*/
-- 1- Clé primaire = "ID_PAYEUR". 
INSERT INTO "TB_PAYEUR" ("ID_PAYEUR","CD_CNI_PAYEUR", "LB_NOM_PAYEUR","LB_PREN_PAYEUR", "LB_ADR_PAYEUR", "LB_TEL_PAYEUR")
VALUES 
	(1, 'CN00009', 'ADDA', 'Raoul', 'Benin', '99-99-99-99');

-- 2- Clé Unique = "CD_CNI_PAYEUR". 
INSERT INTO "TB_PAYEUR" ("CD_CNI_PAYEUR", "LB_NOM_PAYEUR","LB_PREN_PAYEUR", "LB_ADR_PAYEUR", "LB_TEL_PAYEUR")
VALUES 
	('CN000099', 'ADDA', 'Raoul', 'Benin', '99-99-99-99');
	
-- Suppression des données si besoin 
TRUNCATE "TB_PAYEUR" CASCADE;

-- Reprendre le numéro de séquence des payeurs par 1
ALTER SEQUENCE "TB_PAYEUR_ID_PAYEUR_seq" RESTART WITH 1;


----------------------------------------------------------------------------
----------------- Table N°2 : "I_SCOLARITE"."TB_FORMATION" -----------------
----------------------------------------------------------------------------

-- Sélection des données présentes dans la table "TB_FORMATION"
SELECT * FROM "TB_FORMATION";

-- Insertion de trois formations dans la table "TB_FORMATION"
INSERT INTO "TB_FORMATION" 
VALUES 
	('FORM001', 'Informatique de gestion', 2500, 'ENS001'),
	('FORM002', 'Mathématiques', 3500, 'ENS002'),
	('FORM003', 'Banques Assurances', 4500, 'ENS008')
RETURNING * ; -- Permet d'afficher les lignes insérées dans la console de sortie


-- Vérification des différentes contraintes 
	/* Rappel : 
		1- Clé primaire = "ID_FORMATION"
		2- Clé étrangère = "ID_RESPO_FORMATION"  
	*/
-- 1- Clé primaire = "ID_FORMATION"
INSERT INTO "TB_FORMATION"
VALUES 
	('FORM003', 'Informatique de gestion', 2500, 'ENS001');

-- 2- Clé étrangère = "ID_RESPO_FORMATION"  
INSERT INTO "TB_FORMATION"
VALUES 
	('FORM005', 'Informatique de gestion', 2500, 'ENS999');
	
-- Suppression des données si besoin 
TRUNCATE "TB_FORMATION" CASCADE;



----------------------------------------------------------------------------
-------------- Table N°3 : "I_SCOLARITE"."TB_INSCRIPTION" ------------------
----------------------------------------------------------------------------

-- Sélection des données présentes dans la table "TB_INSCRIPTION"
SELECT * FROM "TB_INSCRIPTION";

-- Insertion de quatres inscriptions dans la table "TB_INSCRIPTION"
INSERT INTO "TB_INSCRIPTION"  ("DT_INSCRIPTION", "LB_TYPE_PAIEMENT_SOUHAITE", "ID_ETUDIANT", "ANNEE_SCOLAIRE", "ID_FORMATION")
VALUES 
	('2021-09-30', 'Unique', 'ET001', 2022,'FORM001'),
	('2021-09-30', 'Unique', 'ET002', 2022,'FORM001'),
	('2021-09-30', 'Echéancier', 'ET003', 2022,'FORM001'),
	('2021-09-30', 'Echéancier', 'ET004', 2022,'FORM001'),
	('2021-09-30', 'Unique', 'ET005', 2022,'FORM001'),
	('2021-09-30', 'Unique', 'ET006', 2022,'FORM001'),
	('2021-09-30', 'Echéancier', 'ET007', 2022,'FORM001'),
	('2021-09-30', 'Echéancier', 'ET008', 2022,'FORM001'),
	('2021-09-30', 'Unique', 'ET009', 2022,'FORM002'),
	('2021-09-30', 'Unique', 'ET010', 2022,'FORM002'),
	('2021-09-30', 'Echéancier', 'ET011', 2022,'FORM002'),
	('2021-09-30', 'Echéancier', 'ET012', 2022,'FORM002'),
	('2021-09-30', 'Unique', 'ET013', 2022,'FORM002'),
	('2021-09-30', 'Unique', 'ET014', 2022,'FORM002'),
	('2021-09-30', 'Echéancier', 'ET015', 2022,'FORM002'),
	('2021-09-30', 'Echéancier', 'ET016', 2022,'FORM002'),
	('2021-09-30', 'Unique', 'ET017', 2022,'FORM003'),
	('2021-09-30', 'Unique', 'ET018', 2022,'FORM003'),
	('2021-09-30', 'Echéancier', 'ET019', 2022,'FORM003'),
	('2021-09-30', 'Echéancier', 'ET020', 2022,'FORM003'),
	('2021-09-30', 'Unique', 'ET021', 2022,'FORM003'),
	('2021-09-30', 'Unique', 'ET022', 2022,'FORM003')
RETURNING * ; -- Permet d'afficher les lignes insérées dans la console de sortie


-- Vérification des différentes contraintes 
	/* Rappel : 
		1- Clé primaire = "ID_INSCRIPTION". 
		2- Clé étrangère = "ID_ETUDIANT"
		3- Clé étrangère = "ID_FORMATION"
		4- Clé Unique = ("ID_ETUDIANT", "ANNEE_SCOLAIRE")
		5- Valeurs possibles pour la colonne "LB_TYPE_PAIEMENT_SOUHAITE" = ('Unique', 'Echéancier')  
	*/
-- 1- Clé primaire = "ID_INSCRIPTION". 
INSERT INTO "TB_INSCRIPTION"  ("ID_INSCRIPTION", "DT_INSCRIPTION", "LB_TYPE_PAIEMENT_SOUHAITE", "ID_ETUDIANT", "ANNEE_SCOLAIRE", "ID_FORMATION")
VALUES 
	(1, '2021-09-30', 'Unique', 'ET001', 2022,'FORM001');

-- 2- Clé étrangère = "ID_ETUDIANT"
INSERT INTO "TB_INSCRIPTION"  ("DT_INSCRIPTION", "LB_TYPE_PAIEMENT_SOUHAITE", "ID_ETUDIANT", "ANNEE_SCOLAIRE", "ID_FORMATION")
VALUES 
	('2021-09-30', 'Unique', 'ET999', 2022,'FORM001');
	
-- 3- Clé étrangère = "ID_FORMATION"
INSERT INTO "TB_INSCRIPTION"  ("DT_INSCRIPTION", "LB_TYPE_PAIEMENT_SOUHAITE", "ID_ETUDIANT", "ANNEE_SCOLAIRE", "ID_FORMATION")
VALUES 
	('2021-09-30', 'Unique', 'ET001', 2023, 'FORM005');
	
-- 4- Clé Unique = ("ID_ETUDIANT", "ANNEE_SCOLAIRE")
INSERT INTO "TB_INSCRIPTION"  ("DT_INSCRIPTION", "LB_TYPE_PAIEMENT_SOUHAITE", "ID_ETUDIANT", "ANNEE_SCOLAIRE", "ID_FORMATION")
VALUES 
	('2021-09-30', 'Unique', 'ET001', 2022,'FORM002');	
	
-- 5- Valeurs possibles pour la colonne = ('Unique', 'Echéancier')
INSERT INTO "TB_INSCRIPTION"  ("DT_INSCRIPTION", "LB_TYPE_PAIEMENT_SOUHAITE", "ID_ETUDIANT", "ANNEE_SCOLAIRE", "ID_FORMATION")
VALUES 
	('2021-09-30', 'Uniques', 'ET005', 2022,'FORM002');		


-- Suppression des données si besoin 
TRUNCATE "TB_INSCRIPTION" CASCADE;

-- Reprendre le numéro de séquence des inscriptions par 1
ALTER SEQUENCE "TB_INSCRIPTION_ID_INSCRIPTION_seq" RESTART WITH 1;


----------------------------------------------------------------------------
------------------ Table N°4 : "I_SCOLARITE"."TB_PAIEMENT" -----------------
----------------------------------------------------------------------------

-- Sélection des données présentes dans la table "TB_PAIEMENT"
SELECT * FROM "TB_PAIEMENT";

-- Insertion de quatres inscriptions dans la table "TB_PAIEMENT"
INSERT INTO "TB_PAIEMENT"  ("DT_PAIEMENT", "MT_PAYE", "LB_MODE_PAIEMENT", "ID_PAYEUR", "ID_INSCRIPTION")
VALUES 
	('2021-09-30', 2500, 'Virement', null, 1),
	('2021-09-30', 2500, 'Virement', null, 2),
	('2021-09-30', 1000, 'Carte Bancaire', 1, 3),
	('2021-09-30', 1500, 'Carte Bancaire', null, 4),
	('2021-09-30', 2500, 'Virement', null, 5),
	('2021-09-30', 2500, 'Virement', null, 6),
	('2021-09-30', 1000, 'Carte Bancaire', 1, 7),
	('2021-09-30', 1500, 'Carte Bancaire', null, 8),
	('2021-09-30', 3500, 'Virement', null, 9),
	('2021-09-30', 3500, 'Virement', null, 10),
	('2021-09-30', 1000, 'Carte Bancaire', 1, 11),
	('2021-09-30', 1500, 'Carte Bancaire', null, 12),
	('2021-09-30', 3500, 'Virement', null, 13),
	('2021-09-30', 3500, 'Virement', null, 14),
	('2021-09-30', 1000, 'Carte Bancaire', 1, 15),
	('2021-09-30', 1500, 'Carte Bancaire', null, 16),
	('2021-09-30', 4500, 'Virement', null, 17),
	('2021-09-30', 4500, 'Virement', null, 18),
	('2021-09-30', 1000, 'Carte Bancaire', 1, 19),
	('2021-09-30', 1500, 'Carte Bancaire', null, 20),
	('2021-09-30', 4500, 'Virement', null, 21),
	('2021-09-30', 4500, 'Virement', null, 22)
RETURNING * ; -- Permet d'afficher les lignes insérées dans la console de sortie

-- Vérification des différentes contraintes 
	/* Rappel : 
		1- Clé primaire = "ID_PAIEMENT". 
		2- Clé étrangère = "ID_PAYEUR"
		3- Clé étrangère = "ID_INSCRIPTION"
	*/
-- 1- Clé primaire = "ID_PAIEMENT". 
INSERT INTO "TB_PAIEMENT"  ("ID_PAIEMENT", "DT_PAIEMENT", "MT_PAYE", "LB_MODE_PAIEMENT", "ID_PAYEUR", "ID_INSCRIPTION")
VALUES 
	(1,'2021-09-30', 1000, 'Carte Bancaire', null, 3);	

-- 2- Clé étrangère = "ID_PAYEUR"
INSERT INTO "TB_PAIEMENT"  ("DT_PAIEMENT", "MT_PAYE", "LB_MODE_PAIEMENT", "ID_PAYEUR", "ID_INSCRIPTION")
VALUES 
	('2021-09-30', 1000, 'Carte Bancaire', 5, 3);
	
-- 3- Clé étrangère = "ID_INSCRIPTION"
INSERT INTO "TB_PAIEMENT"  ("DT_PAIEMENT", "MT_PAYE", "LB_MODE_PAIEMENT", "ID_PAYEUR", "ID_INSCRIPTION")
VALUES 
	('2021-09-30', 1000, 'Carte Bancaire', 2, 50);
	
-- Suppression des données si besoin 
TRUNCATE "TB_PAIEMENT" CASCADE;

-- Reprendre le numéro de séquence des inscriptions par 1
ALTER SEQUENCE "TB_PAIEMENT_ID_PAIEMENT_seq" RESTART WITH 1;



----------------------------------------------------------------------------
------------------ Table N°5 : "I_SCOLARITE"."TB_ECHEANCE" -----------------
----------------------------------------------------------------------------

-- Sélection des données présentes dans la table "TB_ECHEANCE"
SELECT * FROM "TB_ECHEANCE";

-- Insertion de neuf échéancier dans la table "TB_ECHEANCE"
INSERT INTO "TB_ECHEANCE"  ("DT_ECHEANCE", "MT_ECHEANCE", "ID_INSCRIPTION", "LB_MODE_PAIEMENT")
VALUES 
	('2021-09-30', 1000, 3, 'Carte Bancaire'),
	('2022-01-30',  500, 3, 'Prélèvement'),
	('2022-02-28',  500, 3, 'Prélèvement'),
	('2022-03-30',  500, 3, 'Prélèvement'),
	('2021-09-30', 1500, 12, 'Carte Bancaire'),
	('2022-01-30',  500, 12, 'Prélèvement'),
	('2022-02-28',  500, 12, 'Prélèvement'),
	('2022-03-30',  500, 12, 'Prélèvement'),
	('2022-04-30',  500, 12, 'Prélèvement')
RETURNING * ; -- Permet d'afficher les lignes insérées dans la console de sortie

-- Mise à jour des données : Ajout d'un paiement 
UPDATE "TB_ECHEANCE" 
SET    "ID_PAIEMENT"= 1
WHERE  "ID_ECHEANCE" = 1;

UPDATE "TB_ECHEANCE" 
SET    "ID_PAIEMENT"= 2
WHERE  "ID_ECHEANCE" = 5;

-- Vérification des différentes contraintes 
	/* Rappel : 
		1- Clé primaire = "ID_ECHEANCE" 
		2- Clé étrangère = "ID_INSCRIPTION"
		3- Valeurs possibles pour la colonne "LB_MODE_PAIEMENT" = ('Virement', 'Carte Bancaire', 'Prélèvement')  
	*/

-- 1- Clé primaire = "ID_ECHEANCE"
INSERT INTO "TB_ECHEANCE"  ("ID_ECHEANCE", "DT_ECHEANCE", "MT_ECHEANCE", "ID_INSCRIPTION", "LB_MODE_PAIEMENT")
VALUES 
	(1, '2021-09-30', 1000, 3, 'Carte Bancaire');

-- 2- Clé étrangère = "ID_INSCRIPTION"
INSERT INTO "TB_ECHEANCE"  ("DT_ECHEANCE", "MT_ECHEANCE", "ID_INSCRIPTION", "LB_MODE_PAIEMENT")
VALUES 
	('2021-09-30', 1000, 50, 'Carte Bancaire');
	
-- 3- Valeurs possibles pour la colonne "LB_MODE_PAIEMENT" = ('Virement', 'Carte Bancaire', 'Prélèvement')  
INSERT INTO "TB_ECHEANCE"  ("DT_ECHEANCE", "MT_ECHEANCE", "ID_INSCRIPTION", "LB_MODE_PAIEMENT")
VALUES 
	('2021-09-30', 1000, 1, 'Carte Bancaires');
	
	
-- Suppression des données si besoin 
TRUNCATE "TB_ECHEANCE" ;

-- Reprendre le numéro de séquence des inscriptions par 1
ALTER SEQUENCE "TB_ECHEANCE_ID_ECHEANCE_seq" RESTART WITH 1;	