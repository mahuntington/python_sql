# PostGres - Advanced

## Lesson Objectives - important

1. Linking Tables
1. Alias
1. Indexes
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
1. Excel -> CSV -> MySQL

## Important

### Linking Tables

1. [Some Nice Visuals](http://code.tutsplus.com/articles/sql-for-beginners-part-3-database-relationships--net-8561)
1. One to Many/Many to One Relationships
	- customer has many orders
1. One to One Relationships
	- each user has one address
	- only one person at that address
1. Many to Many Relationships
	- actors and movies
1. Self Referncing Relationships
	- customer referral

### Alias

```sql
SELECT t1.column1 as col1, t2.column2 as col2
FROM table1 as t1
INNER JOIN table2 as t2
ON t1.common_filed = t2.common_field;
```

### Indexes

1. `CREATE INDEX index_name ON table_name (column_name);`
1. `CREATE INDEX index_name ON table_name (column1_name, column2_name);`
1. use `\d table_name` to view indexes
1. Primary Key

### Constraints

1. NOT NULL	
1. Unique
1. Foreign Keys

```sql
CREATE TABLE companies(
  id          SERIAL       PRIMARY KEY,
  name        VARCHAR(16)  NOT NULL UNIQUE,
  city        VARCHAR(16)
);
INSERT INTO companies ( city ) VALUES ('Palo Alto');
CREATE TABLE people(
  id          INT          PRIMARY KEY,
  name        VARCHAR(16)  NOT NULL,
  email       VARCHAR(32)  NOT NULL UNIQUE,
  company_id  INT          REFERENCES companies(id)
);
INSERT INTO people (name, email, company_id) VALUES ('bob', 'bob@bob.com', 999)
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
SELECT * FROM new_yorkers
```

### Functions

```sql
CREATE FUNCTION add_numbers(a integer, b integer) RETURNS integer AS $$
	BEGIN
		RETURN a + b;
	END;
$$ LANGUAGE plpgsql;

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

call add_person('matt');
```

### Triggers

### Transactions

### Locks

### Privileges

### Denormalization

### Excel -> CSV -> MySQL

### SQL Injection
