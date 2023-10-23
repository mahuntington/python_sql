 -- Find all airports that originate from New York

SELECT * FROM airports WHERE city = 'New York';



-- Find all destination airports in Paris

SELECT * FROM airports WHERE city = 'Paris';



-- Find out how many routes originate from New York

SELECT COUNT(*) FROM routes JOIN airports AS origin ON origin.iata_faa = routes.origin_code WHERE origin.city = 'New York';



-- Find out how many routes have destinations in Paris

SELECT COUNT(*) FROM routes JOIN airports AS destination ON destination.iata_faa = routes.dest_code WHERE destination.city = 'Paris';



-- Try to decide which statements are necessary and find how to combine them to find out how many routes originate from New York and land in Paris!

SELECT COUNT(*) FROM routes JOIN airports AS origin ON origin.iata_faa = routes.origin_code JOIN airports AS destination ON destination.iata_faa = routes.dest_code WHERE origin.city = 'New York' AND destination.city = 'Paris';
