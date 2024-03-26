-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Création des tables --------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
-- 1/ Création de la table "Vente" : Table N°1
DROP TABLE IF EXISTS "Vente";
CREATE TABLE "Vente" 
(
 "NUMVENTE" INTEGER, 
 "DT_VENTE" TIMESTAMP,   
 "ID_CLIENT" INTEGER
);

-- 2/ Création de la table "Client" : Table N°2
DROP TABLE IF EXISTS "Client";
CREATE TABLE "Client" 
(
 "ID_CLIENT" INTEGER, 
 "PRENOM" VARCHAR(100)
);

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------- Insertion de quelques données ---------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
-- 1/ Insertion des données dans la table "Vente" : Table N°1
INSERT INTO "Vente" 
VALUES
(1, '05/08/2022',1),
(2, '06/08/2022',2),
(3, '06/08/2022',5);

--2/ Insertion des données dans la table "Client" : Table N°2
INSERT INTO "Client" 
VALUES
(1, 'Léonard'),
(2, 'Laurent'),
(3, 'Raoul'),
(4, 'Arena');													   

													  
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------ Requête pour chaque type de jointure -----------------------------------------
-------------------------------------------------------------------------------------------------------------------------												   
--1/ Jointure interne (INNER JOIN) entre les tables "Vente" et "Client" N
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
INNER JOIN "Client" N ON M."ID_CLIENT" = N."ID_CLIENT"
													   
--2/ Jointure externe gauche (LEFT JOIN ou LEFT OUTER JOIN) entre les tables "Vente" M et "Client" N Avec intersection de N
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
LEFT OUTER JOIN "Client" N ON M."ID_CLIENT" = N."ID_CLIENT"	
												   
						
--3/ Jointure externe gauche (LEFT JOIN ou LEFT OUTER JOIN) entre les tables "Vente" M et "Client" N Sans intersection de N
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
LEFT OUTER JOIN "Client" N ON M."ID_CLIENT" = N."ID_CLIENT"	
WHERE N."ID_CLIENT" IS NULL 	
													   

--4/ Jointure externe droite (LEFT JOIN ou LEFT OUTER JOIN) entre les tables "Vente" M et "Client" N Avec intersection de M
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
RIGHT OUTER JOIN "Client" N ON M."ID_CLIENT" = N."ID_CLIENT"
													   
													   
--5/ Jointure externe droite (LEFT JOIN ou LEFT OUTER JOIN) entre les tables "Vente" M et "Client" N Sans intersection de M
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
RIGHT OUTER JOIN "Client" N ON M."ID_CLIENT" = N."ID_CLIENT"
WHERE M."ID_CLIENT" IS NULL											   
													   
--6/ Jointure externe (FULL JOIN ou FULL OUTER JOIN) entre les tables "Vente" M et "Client" N avec intersection de M ou de N
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
FULL OUTER JOIN "Client" N ON M."ID_CLIENT" = N."ID_CLIENT"
													   
--7/  Jointure externe (FULL JOIN ou FULL OUTER JOIN) entre les tables "Vente" M et "Client" N sans intersection de M ou de N
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"												   
FROM "Vente" M 
FULL OUTER JOIN "Client" N ON M."ID_CLIENT" = N."ID_CLIENT"
WHERE N."ID_CLIENT" IS NULL 
OR 	N."ID_CLIENT" IS NULL 												   
						
													   
--8/ Jointure croisée (CROSS JOIN) entre les tables "Vente" M et "Client" N
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
CROSS JOIN "Client" N
													   
--9/ Jointure naturelle (NATURAL JOIN) entre les tables "Vente" M et "Client" N
SELECT "NUMVENTE" AS "N° Vente", "DT_VENTE" AS "Date Vente", M."ID_CLIENT" AS "Identifiant Client", "PRENOM" AS "Client"
FROM "Vente" M 
NATURAL JOIN "Client" N
