-- enter your schema for apartments, offices and storefronts below

-- already ran this code in CLI so it is commented out.

DROP DATABASE realty_db;

CREATE DATABASE realty_db;

DROP TABLE apartment;
DROP TABLE office;
DROP TABLE storefront;


CREATE TABLE apartment(id serial, apartment_number int, bedrooms int, bathrooms int, address varchar(180), tenant varchar(50),occupied boolean, sq_ft int, price int);

CREATE TABLE office(id serial, office_number int, floor int, sq_ft int, cubicles int, bathrooms int, address varchar(180), company varchar(30), occupied boolean, price int);

CREATE TABLE storefront(address varchar(180), occupied boolean, price int, kitchen boolean, sq_ft int, owner varchar(50), outdoor_seating boolean);



--Commands I added at the end to see tables created

SELECT * FROM apartment;
SELECT * FROM office;
SELECT * FROM storefront;

