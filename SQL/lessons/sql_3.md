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

1. `CREATE INDEX index_name ON table_name (column_name);`
1. `CREATE INDEX index_name ON table_name (column1_name, column2_name);`
1. Primary Key
1. use `\d table_name` to view indexes

### Default Values

```sql
CREATE TABLE people (id SERIAL, name VARCHAR(16), age INT DEAFULT 0);
\d people

INSERT INTO people (name) VALUES ('matt');
SELECT * FROM people;
```

### Constraints

1. NOT NULL	
1. Unique
1. Foreign Keys

```sql
CREATE TABLE companies(
	id SERIAL,
	name VARCHAR(16)  NOT NULL,
	city VARCHAR(16)
);

INSERT INTO companies ( city ) VALUES ('Palo Alto');

CREATE TABLE people(
	id INT,
	name VARCHAR(16),
	email VARCHAR(32) UNIQUE,
	company_id INT REFERENCES companies(id)
);

\d people

INSERT INTO people (name, email, company_id) VALUES ('bob', 'bob@bob.com', 999) -- bad company_id
INSERT INTO people (name, email, company_id) VALUES ('bob', 'bob@bob.com', 1) -- not unique email
```

### Distinct

```sql
SELECT DISTINCT city FROM people;
```

## Good to Know About

### EER Diagrams

![](https://cdn.tutsplus.com/cdn-cgi/image/width=992/net/uploads/legacy/538_sql3/ss_6.png)

### Unions

```sql
SELECT name FROM people UNION SELECT name FROM companies; -- show distinct values
SELECT name FROM people UNION ALL SELECT name FROM companies; -- show duplicates
```

### Truncate

```sql
TRUNCATE TABLE people; -- delete all data, but don't delete table itself
```

### Views

```sql
CREATE VIEW new_yorkers AS SELECT * FROM people WHERE city = 'NYC';

\dv

SELECT * FROM new_yorkers
```

### Functions

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

```sql
BEGIN;

INSERT INTO people (name) VALUES ('matt');

SELECT * FROM people;

-- start a different session and run SELECT * FROM people;
-- Switch back to original session

COMMIT;

-- in other session run SELECT * FROM people;
```

OR

```sql
BEGIN;

INSERT INTO people (name) VALUES ('matt');

SELECT * FROM people;

asdfasdfasdfasdfasdfasdf;

ROLLBACK;

SELECT * FROM people;
```

### Locks

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

```sql
CREATE USER youruser;
\du

-- new session
psql -U youruser -d supertest_lab
SELECT * FROM people;

-- original session
GRANT ALL ON people TO youruser;

-- switch sessions again
SELECT * FROM people;

```

### Denormalization

| id | name | age | company_id | company_name | company_address |
|----|------|-----|------------|--------------|-----------------|
| 1  | matt | 43  | 1          | google       | SF              | 

### Excel -> CSV -> SQL

- Create sheet
- File -> Download -> .csv
- `COPY people (name, age, ancestry, city) FROM '/Users/matthuntington/Downloads/people.csv' DELIMITER ',' CSV;`

### SQL Injection

- input with value `Huntington'; DROP TABLE people;`
