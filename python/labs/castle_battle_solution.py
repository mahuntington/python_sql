import random

class Player:
    def __init__(self, name):
        self.name = name
        self.hit_points = 15
        self.barracks = []

class Peon:
    def __init__(self, name, job):
        self.name = name
        self.job = job

player = Player('player')
computer = Player('computer')

def createPeon():
    user_choice = input("What should the peon's name be? ")
    player.barracks.append(Peon(user_choice, 'nothing'))

def printPeon(index, peon):
    print(str(index) + ": " + peon.name + " = " + peon.job)

def selectPeon():
    for index in range(0, len(player.barracks)):
        printPeon(index, player.barracks[index])
    user_choice = input("Select which peon (use list index)? ")
    chosen_peon = player.barracks[int(user_choice)]
    user_choice = input("What should the peon do?  attack or repair? ")
    chosen_peon.job = user_choice

def runPeon(peon):
    if peon.job == 'repair':
        print(peon.name + " repairs for 1")
        player.hit_points += 1
    elif peon.job == 'attack':
        print(peon.name + " attacks for 1")
        computer.hit_points -= 1

def runComputer():
    hit_points = random.randint(1,5)
    choice = random.randint(0,1)
    if(choice == 0):
        print('computer heals for ' + str(hit_points))
        computer.hit_points += hit_points
    else:
        print('computer attacks for ' + str(hit_points))
        player.hit_points -= hit_points

def evaluateGame():
    print('player: ' + str(player.hit_points))
    print('computer: ' + str(computer.hit_points))
    if computer.hit_points <= 0 and player.hit_points <= 0:
        print("it's a tie")
        return 'tie'
    elif computer.hit_points <= 0:
        print('you win!')
        return 'win'
    elif player.hit_points <= 0:
        print('you lose')
        return 'lose'
    else:
        return 'continue'

def startRound():
    user_choice = input("create or select a peon? ")
    if user_choice == 'create':
        createPeon()
    elif user_choice == 'select':
        selectPeon()

    for peon in player.barracks:
        runPeon(peon)

    runComputer()

    gameState = evaluateGame()

    if gameState == 'continue':
        startRound()

startRound()
