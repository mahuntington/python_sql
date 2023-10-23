import random

words = ['day', 'night', 'football', 'monday', 'saturday', 'hockey']
chosen_word = words[random.randint(0,5)]
num_guesses = 15

print(chosen_word)

choices = []
won = False
while(num_guesses > 0 and won != True):
    guess = input('guess a letter: ')
    choices.append(guess)

    all_letters_guessed = True
    for character in chosen_word:
        found = False
        for choice in choices:
            if choice == character:
                found = True
        if found == True:
            print(character)
        else:
            print('_')
            all_letters_guessed = False

    if all_letters_guessed == True:
        won = True
    num_guesses -= 1
    print(num_guesses)

if all_letters_guessed == False:
    print('you lose')
else:
    print('you won')
