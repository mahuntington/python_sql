# Creating an API with Flask

## Description

In this lesson, we'll create a web API using the Flask framework.  By the end of the lesson, it will be able to perform create, read, update, and delete actions on a specific model in your database.

## Creating a Virtual Development Environment

If this hasn't already been done yet, let's create a special development environment.  This will separate what we use for class from the rest of your system.  It also makes installing python packages easier

```zsh
python3 -m venv ~/my-env
```

You can put this in any location, but just remember what you called the directory and where you placed it for the next command.

Now that it's created, let's activate it:

```zsh
source ~/my-env/bin/activate
```

**NOTE:** you'll have to run `source ~/my-env/bin/activate` every time you create a new terminal window.  If you want, you can put this command in `~/.bash_profile` or `~/.zshenv` depending on whether you're using bash or zsh, respectively

Now the `python3` command has been replaced with `python`.  To see this in action, run the following:

```
python --version
```

You can have as many different virtual environments as you want, located wherever you want.  From here on out, whenever you install a Python package, it will be installed just for the virtual environment that has been activated, leaving the others alone.

Switching between virtual environments is as easy as running the `source` command above for the given virtual environment that you want to activate.

## Install Flask

Flask is a 3rd party package for Python.  It's designed to help developers quickly create web applications and web API's.  Let's install it for the virtual environment we just created.

```zsh
pip install Flask
```

## Initialize the Server File

Let's create a file for our API code:

```zsh
touch server.py
```

Inside that file, let's import `Flask`:

```python
from flask import Flask
```

Below that, let's create an "app" which basically will be a place that houses the routes we will create.  Each route is specific "location" from which a web browser can request or manipulate information.

```python
app = Flask('demo')
```

Lastly, create a testing route:

```python
@app.get("/")
def hello():
	return "hello world!"
```

The `@app.get("/")` is a decorator.  Anything that starts with `@` modifies the functionality of the subsequent function in some way.  In this case, this decorator tells flask which requests to run the `hello` function for.

This route will return the text "hello world!" when our server app receives a request that matches the following information:

- `.get` refers to the `GET` HTTP verb.  Each request that a browser or other client makes must specify a verb.  Each verb tells us what the route is trying to accomplish.  There are 4 main HTTP verbs that we'll use in this lesson.
	- GET: used for reading data
	- POST: used for creating data
	- DELETE: used for deleting data
	- PUT: used for updating data
- `"/"` refers to the path, or location, or model, that we are trying to act on

Using just the information given in `@app.get("/")`, we can determine that we're trying to read information from the very root of the application.

Let's start our server by running the following in the terminal:

```zsh
flask --app server.py run --debug
```

Now if you make a GET request to `http://127.0.0.1:5000` using Postman, you should see the text `hello world!`.  Note that if you make a change to the Python code and save, `flask` will automatically restart the server for us, thanks to the `--debug` flag we have in the command.

## Connect to Postgres

If you haven't already done so, let's install `psycopg2-binary`, which will allow us to control our Postgres database from our Python code.

```zsh
python -m pip install psycopg2-binary
```

Now in our `server.py` code, let's import it and have our app connect to the database:

```python
import psycopg2

connection = psycopg2.connect(
    database="my_db"
)
```

Finally, create a cursor, which is like a pointer to the database responsible for performing actions on it.

```python
import psycopg2.extras
cursor = connection.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
```

We want `psycopg2` to return lists of dictionaries, so we import `psycopog2.extras` and then change the kind of cursor using `cursor_factory = psycopg2.extras.RealDictCursor`.

## Create an Index Route

From here on out, it's just combination of Flask and what we already know about using Python with Postgres.  Delete the `@app.get("/")` route along with the `hello` route handler function.  Add in the following:

```python
@app.get("/people/")
def index():
    cursor.execute("SELECT * FROM people")
    return cursor.fetchall()
```

Now making a GET request to `http://127.0.0.1:5000/people` will give you a JSON representation of the `people` table.

## Create a Create Route

To create a Create route, we'll need to access the body of the request coming in.  Import `request` like so:

```python
from flask import Flask, request # add request
```

The body of our request will be formatted as JSON, so we'll access its values by using the `reques.json` dictionary.

```python
@app.post("/people/")
def create():
    cursor.execute("INSERT INTO people (name, age) VALUES (%s, %s)", [request.json["name"], request.json["age"]])
	connection.commit()
    return {
        "success":True
    }
```

Now make a POST request to `http://127.0.0.1:5000/people` using Postman.  Be sure to set the body of the request to something like the following:

```json
{
	"name":"matt",
	"age": 43
}
```

## Create a Delete Route

We can use a URL param `<id>` so that clients can make DELETE requests to something like `/people/1`.  Then the router handler function will be passed `id`, which we can use to specify in the SQL statement which row to delete.

```python
@app.delete("/people/<id>")
def delete(id):
    cursor.execute("DELETE FROM people WHERE id = %s", [id]);
	connection.commit()
    return {
        "success":True
    }
```

## Create an Update Route

Update is the most complex, but it's just a combination of what we know already:

```python
@app.put("/people/<id>")
def update(id):
    cursor.execute("UPDATE people SET name = %s, age = %s WHERE id = %s", [request.json["name"], request.json["age"], id])
	connection.commit()
    return {
        "success":True
    }
```

## CORS

Lastly, we'll need to install CORS so that we can access the API from other domains.  First install the package:

```zsh
pip install -U flask-cors
```

Now import it in the app:

```python
from flask_cors import CORS
```

and lastly, set it up:

```python
CORS(app)
```

If you add an `Origin` to the header of the request, you should see a corresponding `Access-Control-Allow-Origin` in the header of the response.

That's it!  You have a fully functioning CRUD API!