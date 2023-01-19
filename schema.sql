/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT NOT NULL,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species TEXT
);

/* owners */
CREATE SEQUENCE owner_id_seq;

create table owners (
	id int primary key default nextval('owner_id_seq'),
	full_name VARCHAR(255),
	age int
);

/* species */
CREATE SEQUENCE specie_id_seq;
create table species (
	id int primary key default nextval('specie_id_seq'),
	name VARCHAR(255),
);

/* set primary key to animals table*/
CREATE SEQUENCE animal_id_seq;

ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals
ALTER COLUMN id SET DEFAULT nextval('animal_id_seq');

/* Remove column species*/
ALTER TABLE animals
DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table*/
ALTER TABLE animals
ADD COLUMN species_id INT;
ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species (id);

/* Add column owner_id which is a foreign key referencing the owners table*/
ALTER TABLE animals
ADD COLUMN owner_id INT;
ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners (id);

