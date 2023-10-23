------------------------------------
------------------------------------
-- Type the query you use to locate the data requested below the request in this file!
------------------------------------
------------------------------------

-- 1. List the names of all of the groomers.
SELECT name FROM groomers;


-- 2. List the names and breeds of all of the dogs.
SELECT name, breed FROM dogs;


-- 3. List the names of all of the dogs that are clients of Shawn.
SELECT dogs.name FROM dogs, groomers WHERE dogs.groomer=groomers.id AND groomers.name LIKE 'Shawn';



-- 4. List the name and breed of the first dog in Walt's list of clients.
SELECT dogs.name, dogs.breed FROM dogs, groomers WHERE dogs.id=groomers.dogs[1] AND groomers.name LIKE 'Walt';



-- 5. List all of the names and breeds of the dogs that are Paxton's groomer's clients. (You may need to do two commands to accomplish this. HFM? Try to figure out how to do it in one.)
SELECT groomer FROM owners WHERE name LIKE 'Paxton';
SELECT dogs.name, dogs.breed FROM dogs, groomers WHERE dogs.groomer=groomers.id AND groomers.id=5;

--or
SELECT dogs.name, dogs.breed FROM dogs, owners WHERE dogs.id = ANY (owners.dogs) AND owners.groomer = (SELECT groomers.id FROM owners, groomers WHERE groomers.id=owners.groomer AND owners.name LIKE 'Paxton');



-- 6.  List the average rate for all of the groomers.
SELECT AVG(rate) FROM groomers;



-- 7. List the number of dogs the two lowest paid groomers are responsible for. (You may need to do two commands to accomplish this. Also, check out cardinality. HFM? Try to figure out how to do it in one.)
SELECT id FROM groomers ORDER BY rate ASC LIMIT 2;
SELECT SUM(cardinality(dogs)) FROM groomers WHERE id = 2 OR id = 3;


--or
SELECT SUM(cardinality(dogs)) FROM groomers WHERE rate = (SELECT rate FROM groomers ORDER BY rate ASC LIMIT 1) OR rate = (SELECT rate FROM groomers ORDER BY rate ASC OFFSET 1 LIMIT 1);




-- 8. List how many dogs Ahna owns. (Check out cardinality)
SELECT cardinality(dogs) FROM owners WHERE name LIKE 'Ahna';



-- 9. List the two highest paid groomers.
SELECT name FROM groomers ORDER BY rate DESC LIMIT 2;


-- 10. Who grooms the most dogs?
SELECT name FROM groomers WHERE cardinality(dogs) = ( SELECT MAX(cardinality(dogs)) FROM groomers);


-- 11. List the three owners who are willing to pay the most for their dog grooming.
SELECT owners.name FROM groomers, owners WHERE owners.groomer=groomers.id ORDER BY groomers.rate DESC LIMIT 3;



-- 12. List the names and breeds of the dogs that belong to the owners who are paying $30 for their grooming using only one command.
SELECT dogs.name, dogs.breed FROM dogs, owners, groomers WHERE dogs.owner=owners.id AND owners.groomer=groomers.id AND groomers.rate = 30;




---------------
-- HUNGRY FOR MORE
---------------

-- 13. List the average rate of the two highest paid groomers.
SELECT AVG(rate) FROM groomers WHERE rate=(SELECT rate FROM groomers ORDER BY rate DESC LIMIT 1) OR rate=(SELECT rate FROM groomers ORDER BY rate DESC OFFSET 1 LIMIT 1);


-- 14. List the names and breeds of the two lowest paid groomers.
SELECT dogs.name, dogs.breed FROM dogs, groomers WHERE dogs.id=ANY (groomers.dogs) AND (groomers.rate = (SELECT rate FROM groomers ORDER BY rate ASC LIMIT 1) OR groomers.rate = (SELECT rate FROM groomers ORDER BY rate ASC OFFSET 1 LIMIT 1));
