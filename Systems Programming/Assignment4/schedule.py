import sqlite3
import os

databaseexisted = os.path.isfile('schedule.db')

dbcon = sqlite3.connect('schedule.db')

with dbcon:
    cursor = dbcon.cursor()


def courses_is_empty():
    cursor.execute("SELECT COUNT(*) FROM courses")
    count = cursor.fetchone()

    coursesnum = count[0]

    return coursesnum == 0


def check_available_students(courseid):
    cursor.execute("""SELECT * FROM courses  
                             WHERE id = ?""", (courseid,))

    course = cursor.fetchone()

    students_type = course[2]
    studentsnum_of_course = course[3]

    cursor.execute("""SELECT * FROM students  
                             WHERE grade = ?""", (students_type,))

    students = cursor.fetchone()
    students_count_grade = students[1]

    if students_count_grade >= studentsnum_of_course:
        return True

    else:
        return False


def decrease_students_num(students_type, decrease_num):
    cursor.execute("""UPDATE students                                    
                      SET count = count-?
                      WHERE grade = ?""", (decrease_num, students_type))


def assign_new_course(classid, iterationnum):
    cursor.execute("""SELECT *                           
                       FROM courses                 
                        WHERE class_id = ?""", (classid,))
    optional_courses_to_assign = cursor.fetchall()

    found = False
    for course in optional_courses_to_assign:
        if not found:
            if check_available_students(course[0]):  #course id is in cell 0
                found = True
                courseid = course[0]
                courselength = course[5]
                students_type = course[2]
                num_of_students = course[3]

                cursor.execute("""UPDATE classrooms                                    
                                   SET current_course_id = ? ,current_course_time_left = ?  
                                   WHERE id = ?""", (courseid, courselength, classid))

                decrease_students_num(students_type, num_of_students)    #deduced number of students

                cursor.execute("""SELECT * FROM classrooms                                      
                                   WHERE id = ?""", (classid,))

                print_course(cursor.fetchone(), 1, iterationnum)

    if not found:
        cursor.execute("""UPDATE classrooms                                    
                        SET current_course_id = ? ,current_course_time_left = ?  
                        WHERE id = ?""", (0, 0, classid))


def decrease_time(row):
    cursor.execute("""UPDATE classrooms                 
                   SET current_course_time_left = current_course_time_left-1      
                   WHERE id = ?""", (row[0],))   #row[0] => id


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


def print_table(list_of_tuples):
    for item in list_of_tuples:
        print(str(item))


def print_course(classroom, status, iterationnum):
    cursor.execute("""SELECT course_name FROM courses  
    WHERE id = ?""", (classroom[2],))

    course = cursor.fetchone()

    coursename = course[0]
    location = classroom[1]

    if status == 1:
        print("(" + str(iterationnum) + ") " + str(location) + ": " + str(coursename) + " is schedule to start")

    elif status == 2:
        print("(" + str(iterationnum) + ") " + str(location) + ": occupied by " + str(coursename))

    elif status == 3:
        print("(" + str(iterationnum) + ") " + str(location) + ": " + str(coursename) + " is done")


def remove(courseid):
    cursor.execute("""DELETE 
                      FROM courses
                      WHERE id = ?""", (courseid,))


def main():
    iterationnum = 0
    while (databaseexisted is True) and (not courses_is_empty()):
        cursor.execute("SELECT * FROM classrooms")
        classrooms = cursor.fetchall()
        for classroom in classrooms:

            currcourseid = classroom[2]
            currtimeleft = classroom[3]
            classroomid = classroom[0]

            if currtimeleft == 0:  # is free
                assign_new_course(classroomid, iterationnum)

            elif currtimeleft > 1:
                print_course(classroom, 2, iterationnum)
                decrease_time(classroom)

            elif currtimeleft == 1:  # going to finish now
                print_course(classroom, 3, iterationnum)
                cursor.execute("""SELECT * FROM courses  
                                         WHERE id = ?""", (currcourseid,))
                remove(currcourseid)
                assign_new_course(classroomid, iterationnum)

        iterationnum = iterationnum + 1
        print("courses")
        print_table(create_list_courses())
        print("classrooms")
        print_table(create_list_classrooms())
        print("students")
        print_table(create_list_students())

    dbcon.commit()


if __name__ == '__main__':
    main()
