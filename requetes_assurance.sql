-- =====================================================================
-- Analyse du marché de l'assurance habitation - 12 requêtes SQL
-- =====================================================================


-- ---------------------------------------------------------------------
-- Requête 1 : Contrats et surface pour le code postal 92100
-- ---------------------------------------------------------------------
SELECT Contrat_ID, Surface
FROM contrat
WHERE Code_postal = '92100';
-- Résultat : 98 lignes


-- ---------------------------------------------------------------------
-- Requête 2 : Nom des régions de France
-- ---------------------------------------------------------------------
SELECT DISTINCT reg_nom
FROM region
ORDER BY reg_nom;
-- Résultat : 19 régions
-- Note : la table region contient une ligne par commune, ce qui entraîne
-- des répétitions du nom de la région. DISTINCT permet de ne conserver
-- qu'une seule occurrence de chaque région.


-- ---------------------------------------------------------------------
-- Requête 3 : Nombre de contrats sur les résidences principales
-- Résultat : 25612
-- ---------------------------------------------------------------------
SELECT COUNT(*) AS nb_contrats_residence_principale
FROM contrat
WHERE Type_contrat = 'Residence principale';


-- ---------------------------------------------------------------------
-- Requête 4 : Les 5 contrats avec les surfaces les plus élevées
-- Résultat : 104211, 105463, 130878, 100822, 109872
-- ---------------------------------------------------------------------
SELECT Contrat_ID
FROM contrat
ORDER BY Surface DESC
LIMIT 5;


-- ---------------------------------------------------------------------
-- Requête 5 : Prix moyen de la cotisation mensuelle
-- Résultat : 19.33
-- ---------------------------------------------------------------------
SELECT AVG(Prix_cotisation_mensuel) AS prix_moyen_cotisation
FROM contrat;


-- ---------------------------------------------------------------------
-- Requête 6 : Nombre de contrats par catégorie de valeur déclarée
-- ---------------------------------------------------------------------
SELECT Valeur_declaree_biens, COUNT(*) AS nb_contrats
FROM contrat
GROUP BY Valeur_declaree_biens;
-- Résultat : 0-25000 -> 22712 | 25000-50000 -> 6814 | 50000-100000 -> 696 | 100000+ -> 104


-- ---------------------------------------------------------------------
-- Requête 7 : Formules "integral" en région Pays de la Loire
-- Résultat : 589
-- ---------------------------------------------------------------------
SELECT COUNT(*) AS nb_integral_pays_de_la_loire
FROM contrat c
JOIN region r ON r.Code_dep_code_commune = c.Code_dep_code_commune
WHERE c.Formule LIKE '%integral%'
  AND r.reg_nom LIKE '%Pays%de%la%Loire%';


-- ---------------------------------------------------------------------
-- Requête 8 : Contrats, type et formule pour les maisons du 71
-- ---------------------------------------------------------------------
SELECT c.Contrat_ID, c.Type_contrat, c.Formule
FROM contrat c
JOIN region r ON r.Code_dep_code_commune = c.Code_dep_code_commune
WHERE c.Type_local = 'Maison'
  AND r.dep_code = '71';
-- Résultat : 4 lignes (114768, 114779, 114782, 114812)


-- ---------------------------------------------------------------------
-- Requête 9 : Surface moyenne des contrats à Paris
-- Résultat : 51.7695
-- ---------------------------------------------------------------------
SELECT AVG(c.Surface) AS surface_moyenne_paris
FROM contrat c
JOIN region r ON r.Code_dep_code_commune = c.Code_dep_code_commune
WHERE LOWER(r.aca_nom) LIKE '%paris%';


-- ---------------------------------------------------------------------
-- Requête 10 : Top 10 départements par prix moyen de cotisation
-- ---------------------------------------------------------------------
SELECT r.dep_nom, AVG(c.Prix_cotisation_mensuel) AS cotisation_moyenne
FROM contrat c
JOIN region r ON r.Code_dep_code_commune = c.Code_dep_code_commune
GROUP BY r.dep_nom
ORDER BY cotisation_moyenne DESC
LIMIT 10;
-- Résultat : Paris 36.40 | Hauts-de-Seine 26.27 | Val-de-Marne 19.82 | Yvelines 18.89
-- Rhône 18.49 | Ain 18.24 | Alpes-Maritimes 18.14 | Charente-Maritime 17.32
-- Haute-Savoie 17.15 | Corse-du-Sud 17.07


-- ---------------------------------------------------------------------
-- Requête 11 : Communes ayant eu au moins 150 contrats
-- ---------------------------------------------------------------------
SELECT r.com_nom_maj_court, COUNT(*) AS nb_contrats
FROM contrat c
JOIN region r ON r.Code_dep_code_commune = c.Code_dep_code_commune
GROUP BY r.com_nom_maj_court
HAVING COUNT(*) >= 150
ORDER BY nb_contrats DESC;
-- Résultat : 20 communes, de Paris 18 (515) à Paris 3 (159)


-- ---------------------------------------------------------------------
-- Requête 12 : Nombre de contrats par région
-- ---------------------------------------------------------------------
SELECT r.reg_nom, COUNT(*) AS nb_contrats
FROM contrat c
JOIN region r ON r.Code_dep_code_commune = c.Code_dep_code_commune
GROUP BY r.reg_nom
ORDER BY nb_contrats DESC;
-- Résultat : 16 régions, de Ile-de-France (14177) à La Réunion (8)
