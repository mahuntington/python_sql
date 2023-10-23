-- Open up psql and create a sql_lab database if you haven't already done so. 
-- If you already have a sql_lab database, no need to create it again.

-- Write SQL commands under the prompts below, and run the file to get results.

-- In case there is already a computers table, drop it

-- Create a computers table


--###############
--I added the delete command  at the beginning when I want to rerun instead of having to enter commands manually. while debugging.  But keep commented out if running whole thing to test.

DROP DATABASE computers;

---##############

CREATE DATABASE computers;

-- The table should have id, make, model, cpu_speed, memory_size,price, release_date, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports);

\connect computers;

CREATE TABLE computers(id serial, make varchar(20), model varchar(20), cpu_speed int, memory_size int, price int, release_date timestamp, photo_url varchar(140), storage_amount int, number_usb_ports int, number_firewire_ports int, number_thunderbolt_ports int);





-- Insert 4 computers into the computers table

INSERT INTO computers(make, model, cpu_speed, memory_size, price, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports) VALUES ('apple', 'desktop', 2200, 16, 2399, 'www.photo.com, 500', 8, 4, 2, 2);

INSERT INTO computers(make, model, cpu_speed, memory_size, price) VALUES ('pc', 'laptop', 220, 8, 1250);

INSERT INTO  computers(make, model, price, release_date) VALUES ('pc', 'pixelbook', 677, '1981-12-01 22:33:44');

--yyyy-mm-dd hh:mm:ss

INSERT INTO computers(make, model, price) VALUES ('apple', 'macbook pro', 3000);



-- Select all entries from the computers table


--run here to show homework up to this point. and comment out this select all to run first part. otherwise keep it commented out.

-- SELECT * FROM computers;


-- HUNGRY FOR MORE? 

-- Look at this afternoon's instructor notes and read on altering tables before attempting below

-- Alter the computers_models, removing the storage_amount column
-- and add storage_type and storage_size columns


ALTER TABLE computers DROP COLUMN storage_amount;
ALTER TABLE computers ADD COLUMN storage_type varchar(50);
ALTER TABLE computers ADD COLUMN storage_size int;



-- ########NOTES#######
--students will need to comment out first command and create table commands if they want to rerun code to debug. like for example if there are syntax errors. 
--they could get errors ERROR:  relation "computers" already exists
--another example ERROR:  INSERT has more target columns than expressions

SELECT * FROM computers;







