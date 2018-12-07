/*CREATE DATABASE db_dragons;
USE db_dragons;

-- Création tables

CREATE TABLE dragons(
id_dragons MEDIUMINT(9) NOT NULL,
dragon varchar(45),
sexe char(1),
longueur int(5),
nb_ecaille int(10),
crache_feu CHAR(3),
comp_amoureux varchar(45),
CONSTRAINT id_dragons PRIMARY KEY(id_dragons),
KEY `dragon_idx` (`dragon`)
);

CREATE TABLE nourritures(
id_nourritures MEDIUMINT(9) NOT NULL,
produit varchar(45),
calories int(10),
CONSTRAINT id_nourritures PRIMARY KEY(id_nourritures),
KEY `produit_idx` (`produit`)
);

CREATE TABLE repas(
id_repas MEDIUMINT(9) NOT NULL,
dragon varchar(45),
produit varchar(45),
quantité int(10),
CONSTRAINT pk_id_repas PRIMARY KEY(id_repas),
KEY `fk_repas_dragon_idx` (`dragon`),
KEY `fk_repas_produit_idx` (`produit`),
CONSTRAINT fk_repas_dragon FOREIGN KEY(dragon) REFERENCES dragons (dragon),
CONSTRAINT fk_repas_produit FOREIGN KEY(produit) REFERENCES nourritures (produit)
);

CREATE TABLE aime(
id_aime MEDIUMINT(9) NOT NULL,
dragon_aimant varchar(45),
dragon_aime varchar(45),
force_amour varchar(45),
CONSTRAINT pk_id_aime PRIMARY KEY(id_aime),
KEY `fk_dragon_aimant_idx` (`dragon_aimant`),
KEY `fk_dragon_aime_idx` (`dragon_aime`),
CONSTRAINT fk_dragon_aimant FOREIGN KEY(dragon_aimant) REFERENCES dragons (dragon),
CONSTRAINT fk_dragon_aime FOREIGN KEY(dragon_aime) REFERENCES dragons (dragon)
);

-- Importation des données

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_dragons/bd_dragons.csv' 
INTO TABLE dragons
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_dragons/bd_nourritures.csv' 
INTO TABLE nourritures
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_dragons/bd_repas.csv' 
INTO TABLE repas
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/db_dragons/bd_aime.csv' 
INTO TABLE aime
FIELDS TERMINATED BY ';' 
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;*/

-- Questions

-- Question a 
SELECT d1.dragon 
FROM dragons AS d1 
INNER JOIN dragons AS d2 ON d1.dragon = d2.dragon
WHERE d1.crache_feu = 'oui';

-- Question b
SELECT d1.dragon 
FROM dragons AS d1 
INNER JOIN dragons AS d2 ON d1.dragon = d2.dragon
WHERE d1.crache_feu = 'oui' and d1.sexe = 'M';

-- Question c
SELECT d1.dragon 
FROM dragons AS d1 
INNER JOIN dragons AS d2 ON d1.dragon = d2.dragon
WHERE d1.crache_feu = 'non' and d1.sexe = 'F';

-- Question d
SELECT Dragon_aimant     
FROM aime ;

-- Question e
SELECT a1.dragon_aimant 
FROM aime AS a1, aime AS a2  
WHERE a1.dragon_aimant = a2.dragon_aimant
AND a1.force_amour = 'passionnément';

-- Question f
SELECT DISTINCT r1.dragon
FROM repas AS r1 
INNER JOIN repas AS r2 ON r1.dragon = r2.dragon
WHERE r1.produit = 'oeuf';

-- Question g
SELECT d.dragon
FROM dragons AS d 
WHERE d.dragon NOT IN
( SELECT d.dragon FROM aime WHERE d.dragon = dragon_aimant);

-- Question h
SELECT *
FROM aime AS a1, aime AS a2 
WHERE a1.dragon_aimant = a2.dragon_aime
AND a2.dragon_aimant = a1.dragon_aime;

-- Question i
SELECT d.dragon
FROM dragons AS d 
WHERE d.dragon NOT IN
( SELECT r.dragon FROM repas AS r WHERE d.dragon = r.dragon);

-- Question j
SELECT d.dragon
FROM dragons AS d 
WHERE d.dragon NOT IN
( SELECT d.dragon FROM aime WHERE dragon_aimant)
AND d.dragon NOT IN
( SELECT r.dragon FROM repas AS r  WHERE d.dragon = r.dragon);

-- Question k
SELECT DISTINCT r.dragon
FROM repas as r
GROUP BY r.dragon
HAVING COUNT(r.produit) > 2;