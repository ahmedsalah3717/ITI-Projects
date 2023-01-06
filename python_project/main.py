from python_project import Sign_up
from python_project import Login_Screen


def main_menu():
    while True:
        print("-------- Main Menu ----------")

        choice = int(input(""" Choose one of the options below : 
        1: Sign-Up
        2- LogIn
        3- Exit
        """))

        if choice == 1:
            Sign_up.sign_up_fun()
        elif choice == 2:
            Login_Screen.login_menu()
        elif choice == 3:
            exit()


print("Welcome to the main menu")
main_menu()
