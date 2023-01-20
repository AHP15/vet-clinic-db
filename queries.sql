/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';
SELECT name FROM animals WHERE neutered=true AND escape_attempts < 3;
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';


update animals set species='unspecified';
rollback;
select * from animals;

update animals set species='digimon' where name like '%mon';
commit;
update animals set species='pokemon' where species is NULL;
commit;
select * from animals;


begin;
  delete from animals where date_of_birth >= '2022-01-01';
  savepoint pdate;
  update animals set weight_kg = weight_kg * -1;
  rollback to pdate;
  update animals set weight_kg = weight_kg * -1 where weight_kg < 0;
commit;
select * from animals;

select count(*) from animals;

select count(*) from animals where escape_attempts=0;

select avg(weight_kg) from animals;

select avg(escape_attempts) as neutered from animals where neutered=true;
select avg(escape_attempts) as not_neutered from animals where neutered=false;

select max(weight_kg) from animals where neutered=true;
select min(weight_kg) from animals where neutered=true;
select max(weight_kg) from animals where neutered=false;
select min(weight_kg) from animals where neutered=false;

select avg(escape_attempts) as neutered from animals
 where neutered=true and date_of_birth > '1990-01-01' and date_of_birth < '2000-01-01';
select avg(escape_attempts) as not_neutered from animals
 where neutered=false and date_of_birth > '1990-01-01' and date_of_birth < '2000-01-01';


/* What animals belong to Melody Pond?*/
select name from animals
join owners
on animals.owner_id = owners.id
where owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon).*/
select animals.name from animals
join species
on animals.species_id = species.id
where species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal.*/
SELECT owners.full_name as owner_name, animals.name as animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species?*/
SELECT species.name, COUNT(animals.id) as total_animals
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell.*/
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape.*/
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;

/* Who owns the most animals?*/
SELECT owners.full_name, COUNT(animals.id) as total_animals
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

/* Who was the last animal seen by William Tatcher?*/
JOIN animals a ON v.animal_id = a.id
JOIN vets w ON v.vet_id = w.id
WHERE w.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see?*/
SELECT COUNT(DISTINCT v.animal_id)
FROM visits v
JOIN vets s ON v.vet_id = s.id
WHERE s.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties.*/
SELECT v.name, s.name as specialty
FROM vets v
LEFT JOIN specializations sp ON sp.vet_id = v.id
LEFT JOIN species s ON s.id = sp.species_id
ORDER BY v.name;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets s ON v.vet_id = s.id
WHERE s.name = 'Stephanie Mendez'
AND v.visit_date >= '2020-04-01'
AND v.visit_date <= '2020-08-30'
ORDER BY v.visit_date;

/* What animal has the most visits to vets?*/
SELECT a.name, COUNT(v.animal_id) as visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY v.animal_id, a.name
ORDER BY visits DESC
LIMIT 1;

/* Who was Maisy Smith's first visit?*/
SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets m ON v.vet_id = m.id
WHERE m.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit*/
SELECT a.name as animal_name, a.date_of_birth as animal_dob, a.escape_attempts as animal_escape_attempts,a.neutered as animal_neutered, a.weight_kg as animal_weight, a.species as animal_species,
v.name as vet_name, v.age as vet_age, v.date_of_graduation as vet_graduation_date, v.id as vet_id, v.visit_date
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
ORDER BY v.visit_date DESC
LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species?*/
SELECT COUNT(v.id)
FROM visits v
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations s ON s.vet_id = v.vet_id
WHERE s.species_id != a.species_id OR s.species_id IS NULL;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT s.name, COUNT(v.id) as visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets m ON v.vet_id = m.id
JOIN species s ON a.species_id = s.id
WHERE m.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visits DESC
LIMIT 1;