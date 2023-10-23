-- Open up psql and create a sql_lab database if you haven't already done so. 
-- If you already have a sql_lab database, no need to create it again.

-- Write SQL commands under the prompts below, and run the file to get results.

-- In case there is already a televisions table, drop it

-- DROP DATABASE televisions;



CREATE DATABASE televisions;

\connect televisions;

-- Create a televisions table
--  The table should have id, model_name, screen_size, resolution,
--  price, release_date, photo_url

CREATE TABLE televisions(id serial, model_name varchar(20), screen_size int, resolution int, price int, release_date int, photo_url varchar(140));

-- Insert 4 televisions into the tv_models table
INSERT INTO televisions(model_name, screen_size, resolution, price, photo_url) VALUES ('samsung', 55, 1080, 1999, 'www.photo1.com');

INSERT INTO televisions(model_name, screen_size, resolution, price, photo_url) VALUES ('samsung', 55, 1080, 1999,'www.photo2.com');

INSERT INTO televisions(model_name, screen_size, resolution, price, photo_url) VALUES ('sony', 32, 1080, 1999, 'www.photo3.com');

INSERT INTO televisions(model_name, screen_size, resolution, price, photo_url) VALUES ('lg', 27, 1080, 1999, 'www.photo4.com');

-- Select all entries from the tv_models table


-- HUNGRY FOR MORE? 
-- Look at this afternoon's instructor notes and read on altering tables before attempting below

-- Alter the tv_models, removing the resolution column
--  and add vertical_resolution and horizontal_resolution columns

ALTER TABLE televisions DROP COLUMN resolution;
ALTER TABLE televisions ADD COLUMN vertical_resolution int;
ALTER TABLE televisions ADD COLUMN horizontal_resolution int;



SELECT * FROM televisions;