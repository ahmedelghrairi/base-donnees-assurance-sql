# Base de données assurance habitation : modélisation et requêtes SQL

Un assureur habitation veut mieux analyser son portefeuille de contrats. Cet exercice couvre le cycle complet : comprendre les données, concevoir un schéma relationnel normalisé, créer et charger une base, puis répondre à 12 questions métier avec SQL.

Étude de cas complète, avec démarche et résultats : [voir sur mon portfolio](https://ahmedelghrairi.github.io/projets/assurance-sql.html)

## Contenu du dépôt

- `creation_tables.sql` : création des deux tables et de la clé étrangère
- `requetes_assurance.sql` : les 12 requêtes d'analyse, avec le résultat de chacune en commentaire
- `schema_relationnel.architect` : le modèle physique de données (SQL Power Architect)
- `base_assurance.db` : la base de données peuplée, au format SQLite. Le projet original a été réalisé sous MySQL, cette version est une reconstruction fidèle, vérifiée ligne à ligne, pour rester consultable sans installer MySQL
- `contrat.csv`, `region.csv` : les deux fichiers sources

## Les données

Deux fichiers : les contrats d'assurance habitation (adresse, surface, type de bien, formule de garantie, cotisation) et un référentiel géographique par commune (région, département, académie). Les deux se relient par une clé composite, `Code_dep_code_commune`, la concaténation du code département et du code commune : le code postal seul ne suffit pas, plusieurs communes peuvent le partager.

## La démarche

**Dictionnaire avant schéma.** Chaque colonne des deux fichiers sources est documentée avant toute modélisation : type MySQL, taille, contrainte, description. C'est ce dictionnaire qui a ensuite guidé directement la création des tables, sans aller-retour.

**Schéma en 3e forme normale.** Deux tables, une relation 1-N de région vers contrat, une seule clé étrangère. Le choix de la clé composite `Code_dep_code_commune` plutôt que le seul code département est documenté explicitement : un code département contient plusieurs communes, ce n'est pas une clé unique.

**Une jointure qui révèle un vrai problème de données.** Le fichier source contrat contient 30 335 lignes, mais seules 30 326 ont pu être chargées dans la base : 9 contrats pointent vers un `Code_dep_code_commune` absent du référentiel région, tous situés en outre-mer. Plutôt que de forcer leur insertion ou de les supprimer silencieusement, l'écart est identifié, quantifié et documenté.

**Douze requêtes, une méthode constante.** Pour chaque requête : identifier la question métier exacte, repérer les tables et colonnes nécessaires, choisir les bonnes fonctions (agrégation, jointure, filtre), puis vérifier que le résultat répond bien à la question posée, pas seulement qu'il s'exécute sans erreur.

## Quelques résultats

- 25 612 contrats sur des résidences principales, sur un portefeuille de 30 326 contrats chargés.
- Cotisation mensuelle moyenne de 19,33 €, avec un écart marqué par département : 36,40 € à Paris contre 17,07 € en Corse-du-Sud, le dixième département le plus cher.
- L'Île-de-France concentre 14 177 contrats, près de 47 % du portefeuille total à elle seule, loin devant la Provence-Alpes-Côte d'Azur (3 279).
- Un appartement de 92100 Boulogne-Billancourt a en moyenne une surface plus modeste que la moyenne nationale, cohérent avec la densité de la petite couronne parisienne.

## Outils

MySQL, SQL Power Architect, SQL.

Ahmed El Ghrairi, 2026.
