# Intro to SQL

## Lesson Objectives tools

1. Connect to Postgres through CLI
1. Create a Database
1. Create a table
1. Insert into the table
1. Select from table
1. Update the table
1. Delete from table

## Connect to Postgres through CLI

If you used homebrew to install, use this command to start up the postgres enviornment.

```
brew services start postgresql
```

You can use this command to stop the service if you would like or you can just leave it running in the background at all times (it will disconnect when you shut down your machine).

```
brew services stop postgresql
```

Lets start up the postgres shell:

```sql
psql -l (list all subdatabses) 
psql db_name (start psql shell, using the sub database db_name)
psql (start psql shell connecting to your username)
```

Once inside the `psql` app, you can list the sub databases like this:

```sql
\l
```

## Create a Database

Postgres has "sub-databases" (probably one for each app that you build)

Create a new database

```SQL
CREATE DATABASE foo;
```

Delete (drop) a database:

```sql
DROP DATABASE foo;
```

Connect to a different database:

```sql
\connect test_db;
```

## Data types

Postgres has the following data types:

1. int - whole number
1. decimal - float/decimal
1. bool - boolean
1. varchar(n) - small text
1. text - large text
1. timestamp - date

## Create a table

- Inside a database, we have tables, which are just like a spreadsheet or grid.  Rows are entries, and columns are properties of each row.
- You have to tell Postgres what data type each column is.  It's very 'strict'

Create a table called 'foo' with one column called 'name' which is a small text column:

```sql
CREATE TABLE foo ( name varchar(20) ); 
```

List (describe) your tables:

```sql
\dt
```

Delete (drop) a table:

```sql
DROP TABLE foo;
```

Create table with multiple columns
- `id` is a `serial`, which is a special integer that increments each time a new row is created)
- `name` is a 20 character string
- `age` is an integer
- `email` is a 32 character string

```sql
CREATE TABLE users ( id serial, name varchar(20), age int, email varchar(32) ); -
```

Describe the columns of the `users` table

```sql
\d users;
```

## Insert into the table

Make sure your values are in the same order that you specify they will be.  You can move them around as you like, as long as you're consistent

```sql
INSERT INTO users ( name, age, email ) VALUES ( 'Matt', 36, 'matt.huntington@generalassemb.ly');
```

## Select from table

There are lots of ways to alter how you retrieve data from a table:

Select all rows from the users table.  Display only the name column

```sql
SELECT name FROM users;
```

Select all rows from the users table.  Display all columns

```sql
SELECT * FROM users;
```

Select all rows from the user table where the name column is set to 'Matt'

```sql
SELECT * FROM users WHERE name = 'Matt';
```

Select all rows from the user table where the name column *contains* 'Matt' as a substring

```sql
SELECT * FROM users WHERE name LIKE '%Matt%'; 
```

Select all rows from the user table where the name column is set to 'Matt' AND the email column is set to matt.huntington@gmail.com

```sql
SELECT * FROM users WHERE name = 'Matt' AND email = 'matt.huntington@gmail.com';
```

Select all rows from the user table where *either* the name column is set to 'Matt' OR the email column is set to matt.huntington@gmail.com

```sql
SELECT * FROM users WHERE name = 'Matt' OR email = 'matt.huntington@gmail.com';
```

Select all rows from the user table where the age column is set to 36

```sql
SELECT * FROM users WHERE age = 36;
```

Select all rows from the user table where the age column is not set to 16

```sql
SELECT * FROM users WHERE age != 16;
```

Select all rows from the user table where the age column is greater than 26

```sql
SELECT * FROM users WHERE age > 26;
```

Select all rows from the user table where the age column is less than 46

```sql
SELECT * FROM users WHERE age < 46;
```

Select all rows from the user table where the age column is less than or equal to 36

```sql
SELECT * FROM users WHERE age <= 36;
```

Select all rows from the user table where the age column is greater than or equal to 36

```sql
SELECT * FROM users WHERE age >= 36; 
```

Select all rows from the user table where the age column has no value

```sql
SELECT * FROM users WHERE age IS NULL;
```

Select all rows from the user table where the age column has any value

```sql
SELECT * FROM users WHERE age IS NOT NULL;
```

## Update the table

Update the users table.  Set the name column to 'Matthew' for every row that has the id column set to 1.  **VERY IMPORTANT** If you do not specify a `WHERE` condition, or in some other way limit it, the query will alter **every row** in your table.  **WATCH OUT!!**

```sql
UPDATE users SET name = 'Matthew' WHERE id = 1;
```

## Delete from table

Delete all rows from the users table that have the id column set to 1.  **VERY IMPORTANT** If you do not specify a `WHERE` condition, or in some other way limit it, the query will delete **every row** in your table.  **WATCH OUT!!**

```sql
DELETE FROM users WHERE id = 1;
```
