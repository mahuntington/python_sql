-- 1. The average square footage of all offices.

SELECT AVG(sq_ft) FROM office; 



-- 2. The total number of apartments.

SELECT MAX(id) FROM apartment;



-- 3. The apartments where there is no tenant

SELECT FROM apartment WHERE tenant IS NULL;



-- 4. The names of all of the companies

SELECT company FROM office;



-- 5. The number of cubicles and bathrooms in the 3rd office

SELECT cubicles, bathrooms FROM office WHERE id=3;



-- 6. The storefronts that have kitchens

SELECT kitchen FROM storefront WHERE kitchen='t';


--##############this one was a little tricky to figure out because it wasn't in the lesson MD. 


-- 7. The storefront with the highest square footage and outdoor seating

SELECT MAX(sq_ft) FROM storefront WHERE outdoor_seating='t';



-- 8. The office with the lowest number of cubicles

SELECT MIN(cubicles) FROM office;



-- 9. The office with the most cubicles and bathrooms

SELECT MAX(cubicles), MAX(bathrooms) FROM office;

