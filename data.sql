/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, false, 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon', '2021-11-15', 2, true, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '1998-09-13', 3, true, 17);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Ditto', '2022-05-14', 4, true, 22);

/* Insert the following data into the owners table*/
insert into owners (full_name, age)
values ('Sam Smith', 34);

insert into owners (full_name, age)
values ('Jennifer Orwell', 19);

insert into owners (full_name, age)
values ('Melody Pond', 77);

insert into owners (full_name, age)
values ('Dean Winchester', 14);

insert into owners (full_name, age)
values ('Jodie Whittaker', 38);

insert into owners (full_name, age)
values ('Bob', 45);

/* Insert the following data into the species table*/
insert into species (name)
values ('Pokemon');

insert into species (name)
values ('Digimon');


/* If the name ends in "mon" it will be Digimon*/
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

/* All other animals are Pokemon*/
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE name not LIKE '%mon';

/* Sam Smith owns Agumon.*/
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

/* Jennifer Orwell owns Gabumon and Pikachu.*/
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Pikachu' or name = 'Gabumon';

/* Bob owns Devimon and Plantmon.*/
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' or name = 'Plantmon';

/* Melody Pond owns Charmander, Squirtle, and Blossom.*/
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' or name = 'Squirtle' or name = 'Blossom';

/* Dean Winchester owns Angemon and Boarmon.*/
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon' or name = 'Boarmon';


INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (species_id, vet_id) VALUES (
    (SELECT id FROM species WHERE name = 'Pokemon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher')
);
INSERT INTO specializations (species_id, vet_id) VALUES (
    (SELECT id FROM species WHERE name = 'Digimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
);
INSERT INTO specializations (species_id, vet_id) VALUES (
    (SELECT id FROM species WHERE name = 'Pokemon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
);
INSERT INTO specializations (species_id, vet_id) VALUES (
    (SELECT id FROM species WHERE name = 'Digimon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness')
);


INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-05-24'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-07-22'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Gabumon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-02'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-01-05'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-03-08'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-05-14'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Devimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2021-05-04'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Charmander'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-24'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-12-21'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-08-10'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2021-04-07'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Squirtle'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
	'2019-09-29'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-10-03'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-11-04'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-01-24'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-05-15'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-02-27'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-08-03'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-05-24'
);
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2021-01-11'
);

