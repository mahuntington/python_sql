# Python + SQL

## Lessons

1. Install a Python virtual environment
1. Install psychopg2-binary
1. Connect to Postgres via Python
1. Running Queries with Python
1. Migrating data to a SQLite
1. Exporting data to CSV

## Install a Python virtual environment

```
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

```ptyon
cursor.execute("SELECT * FROM people WHERE id = 12")
print(cursor.fetchone())
```

Insert

```python
cursor.execute("INSERT INTO people (name, age) VALUES (%s, %s)", ['Matt', 43])
conn.commit()
```

Delete

```python
cursor.execute("DELETE FROM people WHERE id = 12");
conn.commit()
```

Update

```python
cursor.execute("UPDATE people SET name = %s, age = %s WHERE id = %s", ['Matt', 43, 20])
conn.commit()
```
