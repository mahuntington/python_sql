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

```python
python3 -m venv ~/my-env
source ~/my-env/bin/activate
```

## Install psychopg2-binary

```
python -m pip install psycopg2-binary
```

## Connect to Postgres via Python

```python
import psycopg2
conn = psycopg2.connect(
    database="my_db"
)

# close connection
conn.close()
```

## Running Queries with Python

Select many

```python
cursor = conn.cursor()

cursor.execute("SELECT * FROM people")
print(cursor.fetchall())

# close connection
cursor.close()
```

Select one

```python
cursor.execute("SELECT * FROM people WHERE id = %s", [24])
print(cursor.fetchone())
```

Insert

```python
cursor.execute("INSERT INTO people (name, age) VALUES (%s, %s)", ['Matt', 43])
conn.commit()
```

Delete

```python
cursor.execute("DELETE FROM people WHERE id = %s", [24]);
conn.commit()
```

Update

```python
cursor.execute("UPDATE people SET name = %s, age = %s WHERE id = %s", ['Matt', 43, 20])
conn.commit()
```

## SQLite Basics

Connect:

```python
import sqlite3
con = sqlite3.connect("mydb.db")

# close connection
con.close()
```

Create table

```python
cur = con.cursor()
cur.execute("CREATE TABLE people (name, age)")
```

Select Many

```python
res = cur.execute("SELECT * FROM people")
print(res.fetchall())
```

Select One

```python
res = cur.execute("SELECT * FROM people WHERE name = 'Matt'")
print(res.fetchone())
```

Insert

```python
cur.execute("INSERT INTO people (name, age) VALUES (?, ?)", ['Zagthorp', 543])
con.commit()
```

Delete

```python
cur.execute("DELETE FROM people WHERE name = ?", ['Bilbo'])
con.commit()
```

Update

```python
cur.execute("UPDATE people SET name = ? WHERE name = ?", ['Bilbo', 'Matthew'])
con.commit()
```

Check via `sqlite3` in the terminal

```
sqlite3 mydb.db
```

## Migrating data to a SQLite

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

mydb.csv:

```csv
1,matt,43
2,sally,34
3,zagthorp,999
```

read:

```python
import csv

with open('mydb.csv', newline='') as csvfile:
    people = csv.reader(csvfile, delimiter=',')
    for person in people:
        print(person)
```

wrte:

```python
import csv
with open('writedb.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow([1, 'matt', 43])
```

## Exporting data to CSV

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

with open('writedb.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    for person in people:
        writer.writerow(person)
```
