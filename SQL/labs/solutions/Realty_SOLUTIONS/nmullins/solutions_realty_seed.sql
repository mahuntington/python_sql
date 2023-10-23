--enter your seed data below


INSERT INTO apartment(apartment_number, bedrooms, bathrooms, address, tenant, occupied, sq_ft, price) VALUES (3, 2, 3, '222 Ladybug Lane', 'Papa John',true, 1500,3000);

INSERT INTO apartment(apartment_number, bedrooms, bathrooms, address, tenant, occupied, sq_ft, price) VALUES (5, 6, 4, '999 My Street', 'rockin johnny',true, 1700,2000);

INSERT INTO apartment(apartment_number, bedrooms, bathrooms, address, tenant, occupied, sq_ft, price) VALUES (1, 8, 7, '64 Palace Drive', 'betty davis',true, 1250,1000);


INSERT INTO office(office_number, floor, sq_ft, cubicles, bathrooms, address, company, occupied, price) VALUES(3,6, 800,5,1,'405 Jersey Ave','My Biz',true, 2000);

INSERT INTO office(office_number, floor, sq_ft, cubicles, bathrooms, address, company, occupied, price) VALUES(6,12, 950, 5,2,'505 Pizza Boulevard','Too Much Trouble',true, 4000);

INSERT INTO office(office_number, floor, sq_ft, cubicles, bathrooms, address, company, occupied, price) VALUES(1,4, 1800,9,2,'905 Elbow Lane','Rocket Store',false, 7000);

INSERT INTO storefront(address, price, kitchen, sq_ft, owner, outdoor_seating)VALUES('234 Main St', 1200, true, 1500, 'Eddie', true);

INSERT INTO storefront(address, price, kitchen, sq_ft, owner, outdoor_seating)VALUES('35 Awesome Street', 1600, true, 1400, 'Joey', true);

INSERT INTO storefront(address, price, kitchen, sq_ft, owner, outdoor_seating)VALUES('234 Wonder Wall Place', 1000, false, 1200, 'Billie', false);


-- adding this on end to see the data added


SELECT * FROM apartment;
SELECT * FROM office;
SELECT * FROM storefront;