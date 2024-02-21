# Creating an API with Flask

## Description

In this lesson, we'll create a web API using the Flask framework.  By the end of the lesson, it will be able to perform create, read, update, and delete actions on a specific model in your database.
## Creating a Virtual Development Environment

Let's create a special development environment.  This will separate what we use for class from the rest of your system.  It also makes installing python packages easier

```zsh
python3 -m venv ~/my-env
```

You can put this in any location, but just remember what you called the directory and where you placed it for the next command.

Now that it's created, let's activate it:

```zsh
source ~/my-env/bin/activate
```

**NOTE:** you'll have to run `source ~/my-env/bin/activate` every time you create a new terminal window.  If you want, you can put this command in `~/.bash_profile` or `~/.zshenv` depending on whether you're using bash or zsh, respectively

Now the `python3` command has been replaced with `python`.  Too see this in action, run the following:

```
python --version
```

You can have as many different virtual environments as you want, located wherever you want.  From here on out, whenever you install a Python package, it will be installed just for the virtual environment that has been activated, leaving the others alone.

Switching between virtual environments is as easy as running the `source` command above for the given virtual environment that you want to activate.
## Install Flask

Flask is a 3rd party package for python.  It's designed to help developers quickly create web applications and web API's.  Let's install it for the virtual environment we just created.

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

Below that, let's create an "app" which basically be a place that houses the routes we create.

```python
app = Flask('demo')
```

Lastly, create a testing route:

```python
@app.get("/")
def hello():
	return "hello world!"
```

Let's start our server by running the following in the terminal:

```zsh
flask --app server.py run --debug
```

Now if you go to `http://127.0.0.1:5000` you should see the text `hello world!`.  Note that if you make a change to the Python code and save, `flask` will automatically restart the server for us, thanks to the `--debug` flag we have in the command.
## something
For this app, our model will be people, and we'll use the `people` table that we've already been working with.