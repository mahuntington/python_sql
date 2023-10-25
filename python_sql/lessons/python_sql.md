# Python + SQL

## Lessons

1. Install a Python virtual environment
1. Install psychopg2-binary
1. Connect to Postgres via Python
1. Running Queries with Python
1. SQLite Basics
1. Migrating data to a SQLite
1. CSV Basics
1. Exporting data to CSV

## Install a Python virtual environment

A virtual environment allows us to create spaces that hold all of the dependencies need we for our various projects.  We can create as many as we like, wherever we like, and each virtual environment van be used for as many projects as we'd like.

Let's create one:

```python
python3 -m venv ~/my-env
```

Once created, we can activate it like so:

```python
source ~/my-env/bin/activate
```

Once activated, any python packages that we install will be installed just for that virtual environment.  We can switch between virtual environments simply by activating them, thus allowing us to have different sets of dependencies available to us for different projects.

## Install psychopg2-binary

The `psychopg2-binary` Python package facilitates communication between Python and PostgrSQL.  It's not necessary in order to do so, but it makes our lives *much* easier.

```
python -m pip install psycopg2-binary
```

## Connect to Postgres via Python

Once we've installed `psychopg2-binary`, we can import it just like any other package that comes as part of the default Python installation.

To connect to the database, we need to run `psycopg2.connect()` and supply the correct data.  To close the connection, run `connection.close()`

```python
import psycopg2
connection = psycopg2.connect(
    database="my_db"
)

# close connection
connection.close()
```

## Running Queries with Python

Running queries requires a "cursor" which is basically just something that performs operations on the database for us.

Let's create a cursor and then have it perform a `SELECT` query.  Once, the cursor has executed the query, it gives us a few functions that control have we view the data.  Let's fetch all of the rows returned from the execution of the query and place them in a list.  Note that each row is represented as a `tuple` is just an immutable list.  When you're done, you'll need to close the cursor with `cursor.close()` in addition to closing the connection (shown above)

```python
cursor = connection.cursor()

cursor.execute("SELECT * FROM people")
print(cursor.fetchall())

# close connection
cursor.close()
```

Now let's do a `SELECT` query, but let's also pass a value into the the query.  The `%s` below is replaced with the number `24` (I'll explain the list syntax in the next section).  This helps us prevent SQL injection.  `fetchone` returns just the single row, as a tuple (not inside a list).  Note that even if the `SELECT` statement had returned multiple rows, `fetchone` would give us only the first row as a tuple (not inside a list).

```python
cursor.execute("SELECT * FROM people WHERE id = %s", [24])
print(cursor.fetchone())
```

Now let's run an `INSERT` with two parameters passed in.  The order of the `%s` placeholders must match the order of the values in the list parameter.  The `conn.commit()` will write the changes to disk, giving us an opportunity to review what we've done or perform additional operations before they become permanent.

```python
cursor.execute("INSERT INTO people (name, age) VALUES (%s, %s)", ['Matt', 43])
connection.commit()
```

Delete is pretty simple once we know the basics

```python
cursor.execute("DELETE FROM people WHERE id = %s", [24]);
connection.commit()
```

Update is just more of the same, but make sure your array parameter matches the `%s` placeholders

```python
cursor.execute("UPDATE people SET name = %s, age = %s WHERE id = %s", ['Matt', 43, 20])
connection.commit()
```

## SQLite Basics

SQLite functionality comes as part of the default python installation (no packages to install!) and is very similar to `psycopg2-binary`.  Note that `sqlite3.connect()` takes as a parameter the location where the database file is stored.

```python
import sqlite3
connection = sqlite3.connect("mydb.db")

# close connection
connection.close()
```

Create a table (this could also be done in `psycopg2-binary` as well).  Note there is no need to close the cursor

```python
cursor = connection.cursor()
cursor.execute("CREATE TABLE people (name, age)")
```

`INSERT` is very similar to `psycopg2-binary`, but you use `?` instead of `%s`

```python
cursor.execute("INSERT INTO people (name, age) VALUES (?, ?)", ['Zagthorp', 543])
connection.commit()
```

Having the cursor execute a `SELECT` statement is very similar to `psycopg2-binary`, except that `cursor.execute` returns a result set that has the `fetchone`/`fetchall` functionality

```python
result = cursor.execute("SELECT * FROM people")
print(result.fetchall())
```

Selecting a single row works as expected

```python
result = cursor.execute("SELECT * FROM people WHERE name = ?", ['Matt'])
print(result.fetchone())
```

So does `DELETE`

```python
cursor.execute("DELETE FROM people WHERE name = ?", ['Bilbo'])
connection.commit()
```

and `UPDATE`

```python
cursor.execute("UPDATE people SET name = ? WHERE name = ?", ['Bilbo', 'Matthew'])
connection.commit()
```

At any point, you can use the `sqlite3` terminal command to interface with the database, just like you would with `psql`

```
sqlite3 mydb.db
```

## Migrating data to a SQLite

At this point, migrating data from PostgreSQL to SQLite is just a matter of putting together what we've learned

```python
# PostgreSQL

import psycopg2
conn = psycopg2.connect(
    database="my_db"
)
cursor = conn.cursor()
cursor.execute("SELECT * FROM people")

people = cursor.fetchall()

cursor.close()
conn.close()

# SQLite

import sqlite3

con = sqlite3.connect("mydb.db")
cur = con.cursor()
cur.execute("CREATE TABLE people (id, name, age)")

for person in people:
    cur.execute("INSERT INTO people (id, name, age) VALUES (?, ?, ?)", [person[0], person[1], person[2]])

con.commit()
con.close()
```

## CSV Basics

Let's create a basic CSV file that we'll import into PostgreSQL

```csv
1,matt,43
2,sally,34
3,zagthorp,999
```

Like SQLite, CSV functionality comes with Python.  First, `open()` (a global function in Python) the file you want to read.  Pass the `csvfile` reference variable into `csv.reader()` to get the representation of the CSV file in Python (basically a list of lists).  Loop/print and then close the file with `csvfile.close()`

```python
import csv

csvfile = open('mydb.csv')
people = csv.reader(csvfile)
for person in people:
    print(person)
csvfile.close()
```

Writing is pretty similar, except you need to pas `'w'` into `open()` as a second parameter.  Use `csv.writer()` to convert lists to CSV notation, and `writer.writerow()` to save a row to the file.  Don't forget to close the file!

```python
csvfile = open('mydb.csv', 'w')
writer = csv.writer(csvfile)
writer.writerow([1, 'matt', 43])
csvfile.close()
```

## Exporting data to CSV

This is very similar to how we exported to SQLite.  The PostgreSQL section doesn't change.

```python
# PostgreSQL

import psycopg2
conn = psycopg2.connect(
    database="my_db"
)
cursor = conn.cursor()

cursor.execute("SELECT * FROM people")

people = cursor.fetchall()

cursor.close()
conn.close()

# CSV

import csv

csvfile = open('mydb.csv', 'w')
writer = csv.writer(csvfile)
for person in people:
	writer.writerow(person)
csvfile.close()
```
