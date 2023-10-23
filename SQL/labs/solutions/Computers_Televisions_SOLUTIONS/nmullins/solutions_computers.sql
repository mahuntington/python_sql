-- Open up psql and create a sql_lab database if you haven't already done so. 
-- If you already have a sql_lab database, no need to create it again.

-- Create computers database
CREATE DATABASE computers;
-- connect to computers database
\connect computers;

-- Write SQL commands under the prompts below, and run the file to get results:

-- 1. In case there is already a computers table, drop it

DROP TABLE computers;
 
-- *** FYI --- I added the delete command  at the beginning when I want to rerun instead of having to enter commands manually. while debugging.  But keep commented out if running whole thing to test.

-- 2. Create a computers table. The table should have id, make, model, cpu_speed, memory_size,price, release_date, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports, number_thunderbolt_ports);


CREATE TABLE computers (
  id SERIAL PRIMARY KEY,
  make VARCHAR(255) NOT NULL,
  model VARCHAR(255) NOT NULL,
  cpu_speed FLOAT NOT NULL,
  memory_size INTEGER NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  release_date DATE NOT NULL,
  photo_url VARCHAR(255) NOT NULL,
  storage_amount INTEGER NOT NULL,
  number_usb_ports INTEGER NOT NULL,
  number_firewire_ports INTEGER NOT NULL,
  number_thunderbolt_ports INTEGER NOT NULL
);



-- 3. Insert 4 computers into the computers table


INSERT INTO computers (make, model, cpu_speed, memory_size, price, release_date, photo_url, storage_amount, number_usb_ports, number_firewire_ports, number_thunderbolt_ports)
VALUES 
  ('Apple', 'MacBook Air', 1.1, 8, 999.99, '2020-03-18', 'https://example.com/macbook-air.jpg', 256, 2, 0, 2),
  ('Dell', 'Inspiron 15', 2.4, 16, 799.99, '2020-02-25', 'https://example.com/inspiron-15.jpg', 512, 3, 1, 0),
  ('Lenovo', 'ThinkPad X1 Carbon', 1.8, 16, 1299.99, '2020-01-15', 'https://example.com/thinkpad-x1-carbon.jpg', 512, 2, 1, 1),
  ('HP', 'Spectre x360', 2.2, 16, 1499.99, '2020-05-10', 'https://example.com/spectre-x360.jpg', 1, 3, 1, 1);



-- 4. Select all entries from the computers table

  SELECT * FROM computers;


------ HUNGRY FOR MORE? ------

-- Look at this afternoon's instructor notes and read on altering tables before attempting below:
-- 1. Alter the computers_models, removing the storage_amount column 
  ALTER TABLE computers DROP COLUMN storage_amount;
-- 2. Add storage_type and storage_size columns
  ALTER TABLE computers ADD COLUMN storage_type;
  ALTER TABLE computers ADD COLUMN storage_size;


