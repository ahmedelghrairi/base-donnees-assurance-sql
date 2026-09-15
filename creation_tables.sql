-- =====================================================================
-- Création du schéma : base de données assurance habitation
-- =====================================================================

CREATE TABLE Region (
    Code_dep_code_commune VARCHAR(10) NOT NULL,
    reg_code INT,
    reg_nom VARCHAR(50),
    aca_nom VARCHAR(50),
    dep_nom VARCHAR(50),
    com_nom_maj_court VARCHAR(100),
    dep_code VARCHAR(5),
    dep_nom_num VARCHAR(50),
    PRIMARY KEY (Code_dep_code_commune)
);

CREATE TABLE Contrat (
    Contrat_ID INT NOT NULL,
    No_voie INT,
    B_T_Q CHAR(1),
    Type_de_voie VARCHAR(10),
    Voie VARCHAR(150),
    Code_dep_code_commune VARCHAR(10) NOT NULL,
    Code_postal VARCHAR(5),
    Surface INT,
    Type_local VARCHAR(30),
    Occupation VARCHAR(20),
    Type_contrat VARCHAR(50),
    Formule VARCHAR(30),
    Valeur_declaree_biens VARCHAR(30),
    Prix_cotisation_mensuel INT NOT NULL,
    PRIMARY KEY (Contrat_ID)
);

ALTER TABLE Contrat
    ADD CONSTRAINT region_contrat_fk
    FOREIGN KEY (Code_dep_code_commune)
    REFERENCES Region (Code_dep_code_commune)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
