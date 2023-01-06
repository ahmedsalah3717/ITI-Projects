from python_project import creation
from python_project import viewing
from python_project import editing
from python_project import deletion


def get_user(email, password):
    f = open("../logged_in_Users.txt", 'r')
    lines = f.readlines()
    f.close()
    found = False
    for line in lines:
        tmp = line.split(':')
        if tmp[2] == email and tmp[3] == password and tmp[5] == "True\n":
            found = True
            user = {"First_Name": tmp[0],
                    "Last_Name": tmp[1],
                    "Email": tmp[2],
                    "Password": tmp[3],
                    "Phone": tmp[4],
                    "Activated": tmp[5]}

    if found:
        return user
    return {}


def login():
    email = input("Email: ")
    password = input("Password: ")
    user = get_user(email, password)
    if user:
        print("Logged in Successfully!")
        return email
    else:
        print("Couldn't log in ")
        return 0


def login_menu():
    print("--------------- Log-In --------------------")
    user_mail = login()
    if user_mail:
        while True:
            # giving the user 6 options to choose from and when he presses a digit from 1 to 6 every digit matches a
            # function
            choice = int(input("""Choose one of the options below: 
                1- Create project
                2- View projects
                3- Edit project
                4- Delete project
                5- Exit
                """))

            if choice == 1:
                creation.create_project(user_mail)
            elif choice == 2:
                viewing.view_all_projects()
            elif choice == 3:
                editing.edit_project(user_mail)
            elif choice == 4:
                deletion.delete_project(user_mail)
            elif choice == 5:
                return 0
