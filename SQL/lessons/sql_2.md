# Intermediate SQL

## Lesson Objectives tools

1. Alter a table
1. Limit
1. Sorting
1. Aggregation
1. Joins

## Alter a table

After you've created a table, you can always make changes

Add a `test` string column

```sql
ALTER TABLE users ADD COLUMN test VARCHAR(20);
```

Drop (delete) the test column

```sql
ALTER TABLE users DROP COLUMN test;
```

Rename a column:

```sql
ALTER TABLE users RENAME name TO first_name
```

Add an id column that increments with each new row (we'll talk about `PRIMARY KEY` later)

```sql
ALTER TABLE users ADD COLUMN id serial PRIMARY KEY;
```

Rename a table

```sql
ALTER TABLE users RENAME TO people;
```

Change the data type of a column:

```sql
ALTER TABLE people ALTER COLUMN first_name TYPE text;
```

## Limit

Sometimes it's advantageous to display less than the entire data set:

- If you want to paginate the data for the end user
- If you have a really massive amount of data, and the queries take a long time to run

Select all rows from people table, but show only the two rows

```sql
SELECT * FROM people LIMIT 2;
```

Select all rows from people table, but show only the second pair of rows

```sql
SELECT * FROM people LIMIT 2 OFFSET 2;
```

## Sorting

With sorting, you can begin to start retrieving interesting information from your data

Select all rows from people table, order by name alphabetically:

```sql
SELECT * FROM people ORDER BY first_name ASC;
```

Select all rows from people table, order by name reverse alphabetically

```sql
SELECT * FROM people ORDER BY first_name DESC;
```

Select all rows from people table, order by age ascending:

```sql
SELECT * FROM people ORDER BY age ASC;
```

Select all rows from people table, order by age descending:

```sql
SELECT * FROM people ORDER BY age DESC;
```

## Aggregation

Aggregation is another way to retrieve interesting information about our data.  It will place table rows into groups that have the same values for the column you specify.  Then you can perform data analysis on each of those groups

Divide all rows into groups by `first_name`.  Show the `SUM` of the ages of each group.  Also show what `first_name` each group has

```sql
SELECT SUM(age), first_name FROM people GROUP BY first_name;
```

Divide all rows into groups by `first_name`.  Show the `AVG` of the ages of each group.  Also show what `first_name` each group has

```sql
SELECT AVG(age), first_name FROM people GROUP BY first_name;
```

Divide all rows into groups by `first_name`.  Show the `MAX` of the ages of each group.  Also show what `first_name` each group has

```sql
SELECT MIN(age), first_name FROM people GROUP BY first_name;
```

Divide all rows into groups by `first_name`.  Show the `MIN` of the ages of each group.  Also show what `first_name` each group has

```sql
SELECT MAX(age), first_name FROM people GROUP BY first_name;
```

Divide all rows into groups by `first_name`.  Show how many rows have a value in the age column.  Also show what `first_name` each group has

```sql
SELECT COUNT(age), first_name FROM people GROUP BY first_name;
```

Divide all rows into groups by `first_name`.  Show the number of rows in each group (how many rows have a value in *any* column).  Also show what `first_name` each group has

```sql
SELECT COUNT(*), first_name FROM people GROUP BY first_name;
```

Divide all rows into groups by `age`.  List the `first_name` values in each group and show what `age` each group has

```sql
SELECT array_agg(first_name), age FROM people GROUP BY age;
```

## JOINS

You can combine tables horizontally

Append each row of the `companies` table onto the end of each row of the `people` table.  Note, this is only for display purposes.  It does not save what is displayed anywhere in memory

```sql
SELECT * FROM people CROSS JOIN companies;
```

Do the same, but display only the rows where `people.employer_id` matches `companies.id`.  Note that when you have multiple tables, you'll need to specify which table which column belongs to.  Otherwise, as with the case of `id`, it could be ambiguous which table the column belongs to.  When one column (such as `people.employer_id`) references the `id` column of another table, it is called a "Foreign Key".

```sql
SELECT * FROM people JOIN companies ON people.employer_id = companies.id
```

Do the same as the previous example, but also display any rows from the `people` that were previously left off

```sql
SELECT * FROM people LEFT JOIN companies ON people.employer_id = companies.id
```

This is similar to `LEFT JOIN` but it displays any rows from the `companies` table that were previously left off

```sql
SELECT * FROM people RIGHT JOIN companies ON people.employer_id = companies.id
```
This is basically a combination of `LEFT JOIN` and `RIGHT JOIN`.  Display missing rows from *both* tables

```sql
SELECT * FROM people FULL OUTER JOIN companies ON people.employer_id = companies.id;
```

## Combining Statments

You can combine `WHERE`, `LIMIT`, `ORDER BY`, `OFFSET` with your `JOIN` statements:

```sql
SELECT * 
FROM people 
LEFT JOIN companies 
	ON people.employer_id = companies.id
WHERE first_name LIKE 'M%' 
ORDER BY age ASC 
LIMIT 2 
OFFSET 1;
```

You can even add `GROUP BY` and use aggregation functions too:

```sql
SELECT AVG(age), first_name 
FROM people 
LEFT JOIN companies 
	ON people.employer_id = companies.id 
WHERE first_name LIKE 'M%' 
GROUP BY first_name 
ORDER BY avg ASC 
LIMIT 2 
OFFSET 1;
```

The order where you add these in the statement matters.  The following breaks (`GROUP BY` must come before `ORDER BY`, `LIMIT`, `OFFSET`):

```sql
SELECT AVG(age), first_name 
FROM people 
LEFT JOIN companies 
	ON people.employer_id = companies.id 
WHERE first_name LIKE 'M%' 
ORDER BY avg ASC 
LIMIT 2 
OFFSET 1 
GROUP BY first_name;
```

If it breaks, just try reordering until it works.  You can also research the order in which they need to come in the statement
