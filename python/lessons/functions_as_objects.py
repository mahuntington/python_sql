############
# Step 1
############
# def greet():
#     print("Hello!")

# def henchman(action):
#     print('yes boss')
#     action()

# henchman(greet)

############
# Step 2
############
# def boss(choice):
#     def greet():
#         print("Hello")
    
#     def initimidate():
#         print("You're in trouble")
    
#     if choice == 1:
#         return greet
#     else:
#         return initimidate

# result = boss(2)
# print(result)
# result()

############
# Step 3
############
# def henchman_decorator(func):
#     def augment_func():
#         print('yes boss')
#         func()
#     return augment_func

# def greet():
#     print('hello')

# augmented_greet = henchman_decorator(greet)
# augmented_greet()

############
# Step 4
############
# def henchman_decorator(func):
#     def augment_func():
#         print('yes boss')
#         func()
#     return augment_func

# @henchman_decorator
# def greet():
#     print('hello')

# greet()


############
# Lambdas
############

# result = list(filter(lambda current_num: current_num > 5, [1,4, 5, 10, 15]))
# print(result)
# result = list(map(lambda current_num: current_num * 2, [1,2,3]))
# print(result)
