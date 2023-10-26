from flask import Flask, request 
from flask_cors import CORS

import sqlite3

app = Flask('demo')
CORS(app)

@app.get("/people/")
def index():
    connection = sqlite3.connect("mydb.db")
    cursor = connection.cursor()
    result = cursor.execute("SELECT * FROM people")
    return result.fetchall()

@app.post("/people/")
def create():
    connection = sqlite3.connect("mydb.db")
    cursor = connection.cursor()
    cursor.execute("INSERT INTO people (name, age) VALUES (?, ?)", [request.json["name"], int(request.json["age"])])
    connection.commit()
    return {
        "success":True
    }

@app.delete("/people/<id>")
def delete(id):
    connection = sqlite3.connect("mydb.db")
    cursor = connection.cursor()
    cursor.execute("DELETE FROM people WHERE id = ?", [id])
    connection.commit()
    return {
        "success":True
    }

@app.put("/people/<id>")
def update(id):
    connection = sqlite3.connect("mydb.db")
    cursor = connection.cursor()
    cursor.execute("UPDATE people SET name = ?, age = ? WHERE id = ?", [request.json["name"], request.json["age"],id])
    connection.commit()
    return {
        "success":True
    }

