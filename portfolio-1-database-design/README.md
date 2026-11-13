Peak University Relational Schema
1. Department
DEPARTMENTS (department_id, department_name, office_location)
Primary Key: department_id
Unique constraint: department_name
2. Students
STUDENTS (student_id, first_name, last_name, email, date_of_birth, department_id, admission_year, student_status)
Primary Key: student_id
Foreign Key: department_id references DEPARTMENTS
Unique constraint: email
3. Lecturers
LECTURERS (lecturer_id, first_name, last_name, email, department_id)
Primary Key: lecturer_id
Foreign Key: department_id references DEPARTMENTS
Unique constraint: email
4. Courses
COURSES (course_id, course_code, course_title, credit_units, department_id, lecturer_id)
Primary Key: course_id
Foreign Keys: department_id and lecturer_id
Unique constraint: course_code
Check constraint: credit units must be between 1 and 6.
5. Registrations
REGISTRATIONS (registration_id, student_id, course_id, academic_session, semester, registration_date, registration_status)
Primary Key: registration_id
Foreign Keys: student_id and course_id
Unique constraint: student, course, academic session and semester combination.
Check constraint: semester must be First or Second.
6. Grades
GRADES (grade_id, registration_id, ca_score, exam_score, total_score)
Primary Key: grade_id
Foreign Key: registration_id references REGISTRATIONS
Unique constraint: registration_id
Check constraints: CA must be between 0 and 40; examination must be between 0 and 60.
Generated column: total_score automatically calculates CA + examination score.


