def delete_project(user_mail):
    print("Delete Project")
    project_name = input("Enter Project Name you want to delete: ")

    f = open("../Projects.txt", 'r')
    lines = f.readlines()
    f.close()

    new_lines = []
    for line in lines:
        line = line.split(":")
        if not (line[0] == project_name and line[-1].strip('\n') == user_mail):
            line = ":".join(line) + '\n'
            new_lines.append(line)

    f = open("../Projects.txt", 'w')
    f.writelines(new_lines)
    f.close()
