DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS destinations;
DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS continents;
DROP TABLE IF EXISTS cities;

CREATE TABLE cities(

  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  visited BOOLEAN

);

CREATE TABLE countries(

  id SERIAL PRIMARY KEY,
  name VARCHAR(255)

);

CREATE TABLE continents(

  id SERIAL PRIMARY KEY,
  name VARCHAR(255)

);

CREATE TABLE destinations(

  id SERIAL PRIMARY KEY,
  city_id INT REFERENCES cities( id ) ON DELETE CASCADE

);

CREATE TABLE locations(

  id SERIAL PRIMARY KEY,
  country_id INT REFERENCES countries( id ) ON DELETE CASCADE,
  continent_id INT REFERENCES continents( id ) ON DELETE CASCADE

);

CREATE TABLE trips(

  id SERIAL PRIMARY KEY,
  location_id INT REFERENCES locations(id),
  destination_id INT REFERENCES destinations(id) ON DELETE CASCADE

);
