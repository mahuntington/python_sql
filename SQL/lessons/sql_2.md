# Intermediate SQL

## Video Link

[Intermediate SQL](https://www.youtube.com/watch?v=cYZVvWJu5Qs&list=PLdnONIhPScSQqXfMndCJRYWQl-0uApORf&index=22)

## Lesson Objectives tools1. Alter a table

1. Alter a table
1. Limit
1. Sorting
1. Aggregation
1. Joins

## Alter a table

```sql
ALTER TABLE users ADD COLUMN test VARCHAR(20); -- add an test string column
ALTER TABLE users DROP COLUMN test; -- drop the test column
ALTER TABLE users RENAME name TO first_name -- rename a column
ALTER TABLE users ADD COLUMN id serial PRIMARY KEY; -- add an id column that increments with each new row
ALTER TABLE users RENAME TO people; -- rename a table
ALTER TABLE people ALTER COLUMN first_name TYPE text; -- chang the data type of a column
```

## Limit

```sql
SELECT * FROM people LIMIT 1; -- select all rows from people table, but show only the first column
SELECT * FROM people LIMIT 1 OFFSET 1; -- select all rows from people table, but show only one column.  Skip the first row
```

## Sorting

```sql
SELECT * FROM people ORDER BY first_name ASC; -- select all rows from people table, order by name alphabetically
SELECT * FROM people ORDER BY first_name DESC; -- select all rows from people table, order by name reverse alphabetically
SELECT * FROM people ORDER BY age ASC; -- select all rows from people table, order by age ascending
SELECT * FROM people ORDER BY age DESC; -- select all rows from people table, order by age descending
```

## Aggregation

```sql
SELECT SUM(age), first_name FROM people GROUP BY first_name; -- divide all rows into groups by name.  Show the SUM of the ages of each group.  Also show what name each group has
SELECT AVG(age), first_name FROM people GROUP BY first_name; -- divide all rows into groups by name.  Show the AVG of the ages of each group.  Also show what name each group has
SELECT MIN(age), first_name FROM people GROUP BY first_name; -- divide all rows into groups by name.  Show the MAX of the ages of each group.  Also show what name each group has
SELECT MAX(age), first_name FROM people GROUP BY first_name; -- divide all rows into groups by name.  Show the MIN of the ages of each group.  Also show what name each group has
SELECT COUNT(age), first_name FROM people GROUP BY first_name; -- divide all rows into groups by name.  Show how many rows have a value in the age column.  Also show what name each group has
SELECT COUNT(*), first_name FROM people GROUP BY first_name; -- divide all rows into groups by name.  Show the number of rows in each group.  Also show what name each group has
SELECT array_agg(first_name), age FROM people GROUP BY age; -- divide all rows into groups by age.  List the names in each group and show what age each group has
```

## JOINS

```sql
SELECT * FROM people CROSS JOIN companies;
SELECT * FROM people JOIN companies ON people.employer_id = companies.id -- find all people who have an employer_id column set and show which company they work for
SELECT * FROM people LEFT JOIN companies ON people.employer_id = companies.id -- find all people have an employer_id column set and show which company they work for.  In addition to this set, add on all people who do not have an employer_id column set
SELECT * FROM people RIGHT JOIN companies ON people.employer_id = companies.id -- find all people have an employer_id column set and show which company they work for.  In addition to this set, add on all companies who do not have any people with employer_id columns set to the company's id column
SELECT * FROM people FULL OUTER JOIN companies ON people.employer_id = companies.id; -- find all people have an employer_id column set and show which company they work for.  In addition to this set, add on all companies who do not have any people with employer_id columns set to the company's id column and all people who do not have an employer_id column set
```

## Combining Statments

You can combine `WHERE`, `LIMIT`, `ORDER BY`, `OFFSET` with your `JOIN` statements:

```sql
SELECT * FROM people LEFT JOIN companies ON people.employer_id = companies.id WHERE first_name LIKE 'M%' ORDER BY age ASC LIMIT 2 OFFSET 1;
```

You can even add `GROUP BY` and aggregation functions too:

```sql
SELECT AVG(age), first_name FROM people LEFT JOIN companies ON people.employer_id = companies.id WHERE first_name LIKE 'M%' GROUP BY first_name ORDER BY avg ASC LIMIT 2 OFFSET 1;
```

The order where you add these in the statement matters.  The following breaks (`GROUP BY` must come before `ORDER BY`, `LIMIT`, `OFFSET`):

```sql
SELECT AVG(age), first_name FROM people LEFT JOIN companies ON people.employer_id = companies.id WHERE first_name LIKE 'M%' ORDER BY avg ASC LIMIT 2 OFFSET 1 GROUP BY first_name;
```

If it breaks, just try reordering until it works.  You can also research the order in which they need to come in the statement
