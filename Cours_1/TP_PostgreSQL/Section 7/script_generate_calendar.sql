-------------------------------------------------------------------------------------------------
------------------- Utilisation de fonction la generate_series et date_part  --------------------
-------------------------------------------------------------------------------------------------
-- Synthase SQL de la fonction generate_series
/*
generate_series(début type, fin type , pas) 

-- Explication : 
début : Début de la série 
Fin   : Fin de la série 
pas   : différence entre la ligne n et n+1

-- Exemple de type
integer, bigint, numeric, timestamp, date

-- Synthase SQL de la fonction date_part
DATE_PART(type, champ)

-- Exemple de type
century, decade, year, month, day, hour, minute, second, microseconds
milliseconds, dow, doy, epoch, isodow, isoyear, timezone, timezone_hour, timezone_minute

-- Exemple de champ
2020-01-01

-- Liens utiles
https://www.postgresql.org/docs/current/functions-srf.html
https://www.postgresqltutorial.com/postgresql-date-functions/postgresql-date_part/
*/


-- 1/ Créer une liste de valeurs de 1 à 10000
SELECT *
FROM generate_series(1, 10000) t ("Numéro");

-- 2/ Créer une liste de date allant du 01/01/2020 au 31/12/2025 
SELECT t.date::date  as "Date"
FROM generate_series('2020-01-01'::date, '2025-12-31'::date, '1 day'::interval) t (date);


-- 3/Créer un calendrier (Afficher la date, l'année, le semestre, le trimestre, le mois, la semaine)
SELECT  t.date::date AS "Date", 

        date_part('YEAR', t.date) AS "Année",
		
		'S'||
		CASE
			WHEN date_part('QUARTER', t.date) in (1, 2) THEN 1
			ELSE 2
		END AS "Semestre", 
		
		'T'||date_part('QUARTER', t.date) AS "Trimestre", 
		
		date_part('MONTH', t.date) AS "N° Mois", 
		
		CASE
			WHEN date_part('MONTH', t.date) =  1 THEN 'Janvier'
			WHEN date_part('MONTH', t.date) =  2 THEN 'Février'
			WHEN date_part('MONTH', t.date) =  3 THEN 'Mars'
			WHEN date_part('MONTH', t.date) =  4 THEN 'Avril'
			WHEN date_part('MONTH', t.date) =  5 THEN 'Mai'
			WHEN date_part('MONTH', t.date) =  6 THEN 'Juin'
			WHEN date_part('MONTH', t.date) =  7 THEN 'Juillet'
			WHEN date_part('MONTH', t.date) =  8 THEN 'Août'
			WHEN date_part('MONTH', t.date) =  9 THEN 'Septembre'
			WHEN date_part('MONTH', t.date) = 10 THEN 'Octobre'
			WHEN date_part('MONTH', t.date) = 11 THEN 'Novembre'
			WHEN date_part('MONTH', t.date) = 12 THEN 'Décembre'
		END AS "Mois",
		
		date_part('DAY', t.date) AS "Jour Mois",
		
		date_part('DOY', t.date) AS "Jour Année", 
		
		CASE
			WHEN date_part('DOW', t.date) = 0 THEN 7
			ELSE date_part('DOW', t.date)
		END AS "N° Jour Semaine", 
		
		CASE
			WHEN date_part('DOW', t.date) = 1 THEN 'Lundi'
			WHEN date_part('DOW', t.date) = 2 THEN 'Mardi'
			WHEN date_part('DOW', t.date) = 3 THEN 'Mercredi'
			WHEN date_part('DOW', t.date) = 4 THEN 'Jeudi'
			WHEN date_part('DOW', t.date) = 5 THEN 'Vendredi'
			WHEN date_part('DOW', t.date) = 6 THEN 'Samedi'
			WHEN date_part('DOW', t.date) = 0 THEN 'Dimanche'
		END AS "Jour Semaine",
		
		date_part('WEEK'::text, t.date) AS "N° Semaine" 
		
FROM generate_series('2020-01-01'::date, '2025-12-31'::date, '24 hours'::interval) t (date);





