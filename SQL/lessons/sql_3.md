# PostGres - Advanced

## Lesson Objectives - important

1. Linking Tables
1. Alias
1. Indexes
1. Default Values
1. Constraints
1. Distinct

## Lesson Objectives - good to know about

1. EER Diagrams
1. Unions
1. Truncate
1. Views
1. Functions
1. Stored Procedures
1. Triggers
1. Transactions
1. Locks
1. Privileges
1. Denormalization
1. Excel -> CSV -> SQL

## Important

### Linking Tables

You can have lots of different kinds of relationships between your data.  Here are the most common.  [This page has some nice ways to visualize the data](http://code.tutsplus.com/articles/sql-for-beginners-part-3-database-relationships--net-8561)

- One to Many/Many to One Relationships
	- This is the most common
	- One `customer` can have many `orders`
	- Many `orders` can belong to one `customer`
	- Each `order` row contains a `customer_id` column, which denotes which `customer` they belong to
- Many to Many Relationships
	- Not as common, but still prevalent
	- Each `actor` is in many `movies`
	- Each `movie` has many `actors` in it
	- A "linking table" exists which maps actors to movies
		- It contains only an `actor_id` and a `movie_id` column
		- You'll need to join `actors` to `actors_movies_linker` and then join that again to `movies` (yes, you can have multiple joins in one query)
- Self Referncing Relationships
	- Customer referral system
	- Each `customer` has a `referal_id` which points back to the `customer` table
	- This is just like the One to Many relationship, but both tables are the same
- One to One Relationships
	- Seats at a theater
	- Each `person` has only one `seat`
	- Each `seat` has only one `person`
	- This is just like a One to Many relationship, but there are no duplicate values in the foreign key column

### Alias

Sometimes table/column names can become difficult to read.  When this happens, sometimes it is easier to temporarily rename them within the context of the query.  Note this does not change anything in memory.

```sql
SELECT t1.column1 as col1, t2.column2 as col2
FROM table1 as t1
INNER JOIN table2 as t2
ON t1.common_filed = t2.common_field;
```

This can also help when you use the same table twice in one query.  Say you had a message tracker database.  This would be a Many to Many relationship, where the `messages` would act as the linking table.  It would contain Foreign Key references for both `sender_id` and `receiver_id`, but each column would point to the same `people` table.  In order to reference columns correctly, you would need to rename the `people` table at least once

```sql
SELECT *
FROM people AS senders
JOIN messages
	ON messages.sender_id = senders.id
JOIN people AS receivers
	ON messages.receiver_id = receivers.id
```

### Indexes

Indexes can speed up your queries. Basically, they duplicate a table and sort it based on a particular column or columns that you specify.

Create an index on a single column

```
CREATE INDEX index_name ON table_name (column_name);
```

You can use `\d table_name` to view indexes you've created on it.
Create an index on two columns:

```
CREATE INDEX index_name ON table_name (column1_name, column2_name);
```

### Default Values

You can create default values for a column so that if you create a row with that column blank, it will fill in the default value

```sql
CREATE TABLE people (id SERIAL, name VARCHAR(16), age INT DEAFULT 0);
\d people

INSERT INTO people (name) VALUES ('matt');
SELECT * FROM people;
```

### Constraints

1. `NOT NULL` ensures that a column is never left blank.  If so the user receives an error
1. `UNIQUE` ensures that each value in that column of the table are you unique (there are no duplicates)
1. `PRIMARY KEY` is a unique, not null constraint that ensures a unique way to identify each row.  This is usually how a table is sorted by default so that retrieving, sorting, joining, etc based on that column is fast
1. Foreign Keys are a way to ensure that a value placed in one column of a table appears somewhere in a specific column of another table.  Usually a join occurs `ON` these two columns, so it's important that the column that `REFERENCES` the other column doesn't have values that don't exist in the other table's column.  For example, if we had a `company_id` column in the `people` table that references the `id` column of the `companies` table, there could be missing data if the `company_id` column contained values that didn't exist in the `id` column of the `companies` table.  The `REFERENCES` constraint helps maintain data integrity.

```sql
CREATE TABLE companies(
	id SERIAL PRIMARY KEY,
	name VARCHAR(16)  NOT NULL,
	city VARCHAR(16)
);

INSERT INTO companies ( city ) VALUES ('Palo Alto');

CREATE TABLE people(
	id SERIAL PRIMARY KEY,
	name VARCHAR(16),
	email VARCHAR(32) UNIQUE,
	company_id INT REFERENCES companies(id)
);

\d people

INSERT INTO people (name, email, company_id) VALUES ('bob', 'bob@bob.com', 999) -- bad company_id
INSERT INTO people (name, email, company_id) VALUES ('bob', 'bob@bob.com', 1) -- not unique email
```

### Distinct

`DISTINCT` is useful for quickly seeing all the different values that a column may contain.

```sql
SELECT DISTINCT city FROM people;
```

If you have more than one column specified with distinct, it will display rows that have a distinct combination of those two columns.  In other words, for a row to be considered a duplicate, and thus removed, all columns specified must match those of another row

```sql
SELECT DISTINCT city, name FROM people;
```

## Good to Know About

### EER Diagrams

There are many apps out there that will help you visualize the relationships between your tables with Enhanced Entity-Relationship diagrams.  You can also draw your own by hand.  Some apps will even analyze your tables' Foreign Key constraints and generate one for you.  Some allow you to draw the EER diagram, and it will create the tables for you!

![good article on table relationships](https://cdn.tutsplus.com/cdn-cgi/image/width=992/net/uploads/legacy/538_sql3/ss_6.png)

### Unions

You can stack `SELECT` statements (usually on two different tables) on top of each other vertically.

This will show distinct rows

```sql
SELECT name FROM people UNION SELECT name FROM companies;
```

This show duplicate rows

```sql
SELECT name FROM people UNION ALL SELECT name FROM companies;
```

### Truncate

Use `TRUNCATE` to delete all rows from a table without deleting the table itself

```sql
TRUNCATE TABLE people;
```

### Views

Using a `VIEW` allows you to alias a `SELECT` statement as something that's easier to remember/use later

```sql
CREATE VIEW new_yorkers AS SELECT * FROM people WHERE city = 'NYC';

\dv

SELECT * FROM new_yorkers
```

### Functions

Functions as a part of a query

```sql
CREATE FUNCTION add_numbers(a integer, b integer) RETURNS integer AS $$
	BEGIN
		RETURN a + b;
	END;
$$ LANGUAGE plpgsql;

\df

SELECT add_numbers(2,4);
```

### Stored Procedures

If you have a set of commands that you run frequently, you can use a Stored Procedure to save these commands for later for easy execution

```sql
CREATE PROCEDURE add_person(new_name VARCHAR(16))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO people (name) VALUES (new_name);
END
$$;

\df

call add_person('matt');
```

### Triggers

Triggers allow you to run a Function (really a Stored Procedure) in response to something happening elsewhere in your database.  This can help maintain data integrity and allows for a small amount of automation

```sql
CREATE TABLE backup_people (id INT, name VARCHAR(16), age INT);

CREATE FUNCTION moveDeleted() RETURNS trigger AS $$
	BEGIN
		INSERT INTO backup_people VALUES (OLD.id, OLD.name, OLD.age);
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER archive_person
	BEFORE DELETE on people
	FOR EACH ROW
	EXECUTE PROCEDURE moveDeleted();

\df

DELETE FROM people WHERE id = 1;
```

### Transactions

If you have several steps that all need to be successful or else none of them are (e.g. transferring money between accounts), transactions are a great way to maintain data integrity

Anything after `BEGIN` will not be saved in the database until the `COMMIT` command has been run.  This will give you a chance to make sure things are as they should be before writing the changes to disk

```sql
BEGIN;

INSERT INTO people (name) VALUES ('matt');

SELECT * FROM people;

-- start a different session and run SELECT * FROM people;
-- Switch back to original session

COMMIT;

-- in other session run SELECT * FROM people;
```

If something goes wrong during your various commands, you can always `ROLLBACK` the changes that were made, so that you don't have to manually undo everything.

```sql
BEGIN;

INSERT INTO people (name) VALUES ('matt');

SELECT * FROM people;

asdfasdfasdfasdfasdfasdf;

ROLLBACK;

SELECT * FROM people;
```

### Locks

Locks are a great way to make sure nobody messes with your data until after all of your statements have been run.  This makes sure that someone doesn't change your data in the middle of your script in a way that could potentially affect the outcome.

```sql
BEGIN;
LOCK TABLE people IN ROW EXCLUSIVE MODE;
SELECT * FROM people WHERE id = 12 FOR UPDATE;

-- start a new session and run UPDATE people SET name = 'Matt' WHERE id = 12;
-- switch back to original session

UPDATE people SET age = 43 WHERE id = 12;
SELECT * FROM people;
END;
```

### Privileges

Privileges are a great way to make sure other users of the database don't do things they shouldn't do.

```sql
CREATE USER youruser;
\du

-- new session
psql -U youruser -d supertest_lab
SELECT * FROM people;

-- original session
GRANT SELECT ON people TO youruser;

-- switch sessions again
SELECT * FROM people;

```

### Denormalization

Joins can take a while when working on extremely large data sets.  Sometimes it might be best to combine the tables directly in memory so that you don't have to do any joins.  This can slow down your updates, deletes, and inserts though, and it introduces an area where errors could potentially occur.  In the example below, if Google changed its address, you would have to update all rows that referenced it.  This could be slow and error prone.

| id | name | age | company_id | company_name | company_address |
|----|------|-----|------------|--------------|-----------------|
| 1  | matt | 43  | 1          | google       | SF              | 

### Excel -> CSV -> SQL

Sometimes you may need to move from Excel to SQL.  To do this, use the following steps:

1. Create a new sheet
1. In the menu bar, run File -> Download -> .csv
1. In `psql` run:

```
COPY people (name, age) FROM '/Users/matthuntington/Downloads/people.csv' CSV;
```

### SQL Injection

People will often try to hack your database by entering SQL commands into your inputs on websites.  Often they will enter something like `Huntington'; DROP TABLE people;` in the hopes that your application will be built poorly enough that they'll wreck something.  This is easiest to fix at the application level, as opposed to the database level
