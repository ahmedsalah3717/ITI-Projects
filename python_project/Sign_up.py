import re


def confirmation(correct_password):
    confirmed_password = input("Confirm Password: ")
    if confirmed_password == correct_password:
        return True
    return False


def full_name_reg(full_name):
    if full_name:
        name = input("Last Name: ")
    else:
        name = input("First Name: ")

    if name.replace(" ", "").isalpha():
        return name
    else:
        print("In-valid name!")
        return 0


def email_address_reg():
    email_regex = re.compile(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")
    email_address = input("Enter your email: ")
    if email_regex.search(email_address):
        return email_address
    else:
        print("Wrong Email!")
        print("ex: ahmedsalah3535@gmail.com")
        return 0


# email_address_reg()
def registeration_password():
    reg_password = input("Password: ")
    valid = True

    if 6 > len(reg_password) > 20:
        print("your password should be between 8 and 20 characters")
        valid = False
    pass_regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
    if not re.fullmatch(pass_regex, reg_password):
        print("your password must contain the following: ")
        print("At least one uppercase English letter.\n"
              "At least one lowercase English letter.\n"
              "At least one digit.\n"
              "At least one special character.")
        valid = False

    if valid:
        if confirmation(reg_password):
            return reg_password
        else:
            print("Passwords do not match!")
            return 0
    return 0


# registeration_password()
def validate_phone():
    mobile_phone = input("Mobile Phone: ")
    mobile_regex = re.compile(r"^020?[10,11,12]\d{8}")
    if mobile_regex.search(mobile_phone):
        return mobile_phone
    else:
        print("Wrong phone number! ")
        return 0


# Meta data
def add_user(**kwargs):
    f = open("../logged_in_Users.txt", 'a')
    f.write(":".join([kwargs["First_Name"],
                      kwargs["Last_Name"],
                      kwargs["Email"],
                      kwargs["Password"],
                      kwargs["Phone"],
                      str(kwargs["Activated"])]))
    f.write('\n')
    f.close()


# adding the newly created user with credentials to the logged_in_Users.txt file (appending to the metadata)
def create_user():
    first_name = full_name_reg(0)
    if first_name:
        last_name = full_name_reg(1)
        if last_name:
            email = email_address_reg()
            if email:
                password = registeration_password()
                if password:
                    phone = validate_phone()
                    if phone:
                        new_user = {"First_Name": first_name,
                                    "Last_Name": last_name,
                                    "Email": email,
                                    "Password": password,
                                    "Phone": phone,
                                    "Activated": True}
                        return new_user
    return False


def sign_up_fun():
    user_data = create_user()
    if user_data:
        add_user(**user_data)
        print(user_data)
        print("Registration Succeeded!")
    else:
        print("Registration Failed!")
