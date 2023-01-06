def view_all_projects():
    f = open("../Projects.txt", 'r')
    lines = f.readlines()
    f.close()

    print("-------------- All Projects ----------------")
    counter = 1
    for line in lines:
        if line == '\n':
            break
        line = line.split(":")
        # concatenating the counter value to the string
        print("Project %d" % counter)
        # appending a string to another string with value
        print("Project Title: %s" % line[0])
        print("Project Description: %s" % line[1])
        print("Total Target: %s" % line[2])
        print("Start Date: %s" % line[3])
        print("End Date: %s" % line[4])
        print("Project Owner: %s" % line[5])
        print("____________________________________________________________")
        counter += 1

        # printing all the prjects created
def view_user_projects(user_mail):
    f = open("../Projects.txt", 'r')
    lines = f.readlines()
    f.close()
    print("These are the projects that exist: ")
    counter = 1
    for line in lines:
        line = line.split(":")
        if line[-1] == user_mail:
            print("Project %d" % counter)
            print("Project Title: %s" % line[0])
            print("Project Description: %s" % line[1])
            print("Total Target: %s" % line[2])
            print("Start Date: %s" % line[3])
            print("End Date: %s" % line[4])
            print("Project Owner: %s" % line[5])
            print("____________________________________________________________")
            counter += 1
