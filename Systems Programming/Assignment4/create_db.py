
import sqlite3
import os
import atexit
import sys

dbexist = os.path.isfile('schedule.db')

dbcon = sqlite3.connect('schedule.db')

with dbcon:
    cursor = dbcon.cursor()


def main(args):
        if not dbexist:
            create_tables()
            insert_data(args)
        print("courses")
        print_table(create_list_courses())
        print("classrooms")
        print_table(create_list_classrooms())
        print("students")
        print_table(create_list_students())

        dbcon.commit()
        dbcon.close()


def create_tables():
    cursor.execute(""" CREATE TABLE courses(id INTEGER PRIMARY KEY,
                                                          course_name TEXT NOT NULL,
                                                          student TEXT NOT NULL,
                                                          number_of_students INTEGER NOT NULL,
                                                          class_id INTEGER REFERENCES classrooms(id),
                                                          course_length INTEGER NOT NULL)                 
                               """)

    cursor.execute(""" CREATE TABLE students(grade TEXT PRIMARY KEY,
                                                        count INTEGER NOT NULL)                 
                              """)

    cursor.execute(""" CREATE TABLE classrooms(id INTEGER PRIMARY KEY,
                                                           location TEXT NOT NULL,
                                                           current_course_id INTEGER NOT NULL,
                                                           current_course_time_left INTEGER NOT NULL)                 
                              """)


def insert_data(args):
    inputfilename = args[1]
    with open(inputfilename) as inputfile:
        for line in inputfile:
            splittedline = line.split(",")

            for i in range(len(splittedline)):
                splittedline[i] = splittedline[i].strip(' ')

            if line[0] == 'S':
                insert_student(splittedline)
            elif line[0] == 'C':
                insert_course(splittedline)
            elif line[0] == 'R':
                insert_room(splittedline)


def insert_student(splittedline):
    grade = splittedline[1]

    count = splittedline[2]
    count = count.split("\n")
    count = count[0]

    cursor.execute("INSERT INTO students VALUES(?, ?)", (grade, count))


def insert_room(splittedline):
    idclassroom = splittedline[1]

    location = splittedline[2]
    location = location.split("\n")
    location = location[0]

    cursor.execute("INSERT INTO classrooms VALUES(?, ?, ?, ?)", (idclassroom, location, 0, 0))


def insert_course(splittedline):
    idcourse = splittedline[1]

    namecourse = splittedline[2]

    typestudent = splittedline[3]

    numofstudents = splittedline[4]

    idclassroom = splittedline[5]

    courselength = splittedline[6]
    courselength = courselength.split("\n")
    courselength = courselength[0]

    cursor.execute("INSERT INTO courses VALUES(?, ?, ?, ?, ?, ?)",
                   (idcourse, namecourse, typestudent, numofstudents, idclassroom, courselength))


def print_table(list_of_tuples):
    for item in list_of_tuples:
        print(str(item))


def create_list_courses():
    cursor.execute("""SELECT * FROM courses""")
    rows = cursor.fetchall()
    courses = []

    for row in rows:
        course = (row[0], row[1], row[2], row[3], row[4], row[5])
        courses.append(course)

    return courses


def create_list_classrooms():
    cursor.execute("""SELECT * FROM classrooms""")
    rows = cursor.fetchall()
    classrooms = []

    for row in rows:
        classroom = (row[0], row[1], row[2], row[3])
        classrooms.append(classroom)

    return classrooms


def create_list_students():
    cursor.execute("""SELECT * FROM students""")
    rows = cursor.fetchall()
    students = []

    for row in rows:
        student = (row[0], row[1])
        students.append(student)

    return students


if __name__ == '__main__':
    main(sys.argv)
