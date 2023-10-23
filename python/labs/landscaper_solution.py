import time

# // ==========================
# //       TOOL BOX & PLAYER OBJECTS
# // ==========================
# // toolbox
tools = [
   {
     "name": 'a starving team of students',
     "wage": 250,
     "cost": 500
   },
   {
    "name": 'a battery-powered lawnmower',
    "wage": 100,
    "cost": 250
  },
  {
    "name": 'an old-timey push lawnmower',
    "wage": 50,
    "cost": 35
  },
  {
    "name": 'scissors',
    "wage": 5,
    "cost": 5
  },
  {
    "name": 'teeth',
    "wage": 1,
    "cost": 0
  }
]
#
# //  player object
player = {
  "currentTool": tools.pop(),
  "bankAccount": 0
}

# # print(player["currentTool"]["name"])
# // ==========================
# //          START METHOD
# // ==========================
def startGame():
  print("Cut lawns, make money.")

  time.sleep(1)

  showStatus()

  time.sleep(1)

  askForAction()

#
# // ==========================
# //          GAME METHODS
# // ==========================
# // show current status
def showStatus():
  print("Current tool: " + player["currentTool"]["name"] + " // Currently in the bank: $" + str(player["bankAccount"]))

  time.sleep(1)


# // cutting the grass
def cutGrass():
  # // increase player's bank account
  player["bankAccount"] += player["currentTool"]["wage"]
  # // print player  of what happened
  print("Lets get to work! You cut the grass with " + player["currentTool"]["name"] + ' and made $' + str(player["currentTool"]["wage"]) + ' today!')

  time.sleep(1)
  # // check if win condition is met
  checkWin()


# // buying a tool
def buyTool():
  # // check if they can afford the tool or not
  if (player["bankAccount"] >= tools[len(tools) - 1]["cost"]):
    # // decrement their bank account by the next tool's cost
    player["bankAccount"] -= tools[len(tools) - 1]["cost"]
    # // set the player's tool to the next available tool
    player["currentTool"] = tools.pop()
    # // show status and call to action
    print("You just bought " + player["currentTool"]["name"] + " for $" + str(player["currentTool"]["cost"]))

    time.sleep(1)

    showStatus()
    askForAction()
  else:
    print("You cant afford " + tools[len(tools) - 1]["name"] + " yet! Keep working first!")

    time.sleep(1)

    askForAction()


# // asking for action
def askForAction():
  # // initilalize playerChoice
  playerChoice = ""
  # // ask for player input
  # // if more tools are still available
  if(len(tools) > 0):
    playerChoice = input("What do you want to do? Type either buy tool or cut grass: ").lower()

    time.sleep(1)

  else:
    print("No more tools left, just keep landscaping until you make $1000")
    playerChoice = input("Type cut grass: ").lower()

    time.sleep(1)


  # // move to next method depending on input
  if (playerChoice == "cut grass"):
    cutGrass()
  elif (playerChoice == "buy tool" and len(tools) > 0):
    buyTool()
  else:
    print("Option unavailable, please try again!")

    time.sleep(1)

    askForAction()



# // checking the win condition
def checkWin():
  # // if player meets win condition
  if(player["bankAccount"] >= 1000 and player["currentTool"]["name"] == "a starving team of students"):
    # // print that they won the game, game stops
    print("you won the game!")
  else:
    # // else, continue the game
    showStatus()
    askForAction()



# // ==========================
# //           START GAME ON LOAD
# // ==========================
startGame()
