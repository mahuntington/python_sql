import random
import requests
import psycopg2
import psycopg2.extras

connection = psycopg2.connect(
    dbname="test_db"
)

cursor = connection.cursor(cursor_factory = psycopg2.extras.RealDictCursor)

def retrieve_classes():
    response = requests.get('https://api.open5e.com/classes/?format=json')
    return response.json()["results"]

def show_classes(classes):
    print('Here are the possible classes:')
    for current_class in classes:
        print(' - ' + current_class["name"])

def save_data(player_id, chosen_class, chosen_subclass):
    cursor.execute("INSERT INTO characters (player_id, class, subclass) VALUES (%s, %s, %s)", [player_id, chosen_class, chosen_subclass])
    connection.commit()
    connection.close()
    print('saved!')

def lookup_player(username):
    cursor.execute('SELECT * FROM players WHERE username = %s', [username])
    return cursor.fetchone()

def process_username(username):
    found_player = lookup_player(username)
    if found_player is None:
        cursor.execute("INSERT INTO players (username) VALUES (%s)", [username])
        connection.commit()
        found_player = lookup_player(username)
    return found_player

def find_most_recent_character(player_id):
    cursor.execute("SELECT * FROM characters WHERE player_id = %s ORDER BY id DESC", [player_id])
    return cursor.fetchone()

print("Welcome adventurer!  Shall I help you choose a class?")
choice  = input('yes or no? ')
if choice == "yes":

    username = input("Perfect! What is you username? ")
    found_player = process_username(username)

    last_character = find_most_recent_character(found_player["id"])
    if last_character is None:
        print("You do not have any previously saved characters")
    else:
        print("Your last character was: " + last_character["class"] + " / " + last_character["subclass"])

    classes = retrieve_classes()
    show_classes(classes)

    answer = input('Roll to choose a new character? yes or no? ')
    while answer == 'yes':
        selected_class = random.choice(classes)
        print("Class: " + selected_class["name"])
        selected_archetype = random.choice(selected_class["archetypes"])
        print("Subclass: " + selected_archetype["name"])
        answer = input("Roll again? yes or no: ")
        if answer == 'no':
            save_data(found_player["id"], selected_class["name"], selected_archetype["name"])

print('Thanks for your time!')
