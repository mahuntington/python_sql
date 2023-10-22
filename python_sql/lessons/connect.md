# Plan for Python + SQL

## Lessons

1. Install a Python virtual environment
1. Install psychopg2-binary
1. Connect to Postgres via Python
1. Running Queries with Python
1. Migrating data to a SQLite
1. Exporting data to CSV
1. Create an API with Flask
1. Create a web UI to customize automation

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
    database="supertest_lab"
)
```

## Running Queries with Python

```python
cursor = conn.cursor()
cursor.execute("SELECT * FROM people")
print(cursor.fetchall())
```

## Labs

1. create a terminal based customer relationship management tool
1. migrate the CRM from previous lab to simple web app with an API
