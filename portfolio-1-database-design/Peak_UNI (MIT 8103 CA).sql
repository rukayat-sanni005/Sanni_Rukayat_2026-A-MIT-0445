CREATE DATABASE peak_university;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    office_location VARCHAR(100)
) ENGINE=InnoDB;


CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE,
    department_id INT NOT NULL,
    admission_year YEAR NOT NULL,
    student_status VARCHAR(20) DEFAULT 'Active',

    CONSTRAINT fk_student_department
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
) ENGINE=InnoDB;


DESCRIBE students;
CREATE TABLE lecturers (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,

    CONSTRAINT fk_lecturer_department
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
) ENGINE=InnoDB;
SHOW TABLES;
DESCRIBE lecturers;

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_title VARCHAR(100) NOT NULL,
    credit_units INT NOT NULL,
    department_id INT NOT NULL,
    lecturer_id INT NOT NULL,

    CONSTRAINT chk_credit_units
    CHECK (credit_units BETWEEN 1 AND 6),

    CONSTRAINT fk_course_department
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id),

    CONSTRAINT fk_course_lecturer
    FOREIGN KEY (lecturer_id)
    REFERENCES lecturers(lecturer_id)
) ENGINE=InnoDB;

DESCRIBE courses;
CREATE TABLE registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    academic_session VARCHAR(9) NOT NULL,
    semester VARCHAR(10) NOT NULL,
    registration_date DATE DEFAULT (CURRENT_DATE),
    registration_status VARCHAR(20) DEFAULT 'Registered',

    CONSTRAINT chk_semester
    CHECK (semester IN ('First', 'Second')),

    CONSTRAINT uq_student_course_session
    UNIQUE (student_id, course_id, academic_session, semester),

    CONSTRAINT fk_registration_student
    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    CONSTRAINT fk_registration_course
    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
) ENGINE=InnoDB;


CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_id INT NOT NULL UNIQUE,
    ca_score DECIMAL(5,2) NOT NULL,
    exam_score DECIMAL(5,2) NOT NULL,

    total_score DECIMAL(6,2)
    GENERATED ALWAYS AS (ca_score + exam_score) STORED,

    CONSTRAINT chk_ca_score
    CHECK (ca_score BETWEEN 0 AND 40),

    CONSTRAINT chk_exam_score
    CHECK (exam_score BETWEEN 0 AND 60),

    CONSTRAINT fk_grade_registration
    FOREIGN KEY (registration_id)
    REFERENCES registrations(registration_id)
) ENGINE=InnoDB;
SHOW TABLES; 
DESCRIBE grades;

INSERT INTO departments (department_name, office_location)
VALUES
('Computer Science', 'Block A, First Floor'),
('Information Technology', 'Block B, Second Floor'),
('Mathematics', 'Block C, First Floor');

SELECT * FROM departments;

INSERT INTO lecturers
(first_name, last_name, email, department_id)
VALUES
('Adebayo', 'Olawale', 'adebayo@peakuniversity.edu', 1),
('Grace', 'Okafor', 'grace@peakuniversity.edu', 2),
('Daniel', 'Akinyemi', 'daniel@peakuniversity.edu', 3);

SELECT * FROM lecturers;
SELECT
    lecturers.lecturer_id,
    lecturers.first_name,
    lecturers.last_name,
    departments.department_name
FROM lecturers
INNER JOIN departments
ON lecturers.department_id = departments.department_id;

INSERT INTO students
(first_name, last_name, email, date_of_birth,
 department_id, admission_year)
VALUES
('Tunde', 'Adeyemi', 'tunde@peakuniversity.edu',
 '2002-04-15', 1, 2024),

('Amara', 'Okeke', 'amara@peakuniversity.edu',
 '2001-08-22', 2, 2024),

('David', 'Bello', 'david@peakuniversity.edu',
 '2003-01-10', 1, 2025),

('Fatima', 'Yusuf', 'fatima@peakuniversity.edu',
 '2002-11-05', 3, 2024),

('Chika', 'Nwosu', 'chika@peakuniversity.edu',
 '2001-06-18', 2, 2025),

('Samuel', 'James', 'samuel@peakuniversity.edu',
 '2003-09-12', 3, 2025);
 
 SELECT
    students.student_id,
    students.first_name,
    students.last_name,
    students.email,
    departments.department_name
FROM students
INNER JOIN departments
ON students.department_id = departments.department_id;

INSERT INTO courses
(course_code, course_title, credit_units, department_id, lecturer_id)
VALUES
('CSC 8101', 'Advanced Programming', 3, 1, 1),
('CSC 8102', 'Software Engineering', 3, 1, 1),
('MIT 8101', 'Information Technology Management', 3, 2, 2),
('MIT 8103', 'Advanced Database Systems', 3, 2, 2),
('MTH 8101', 'Advanced Mathematical Analysis', 3, 3, 3),
('MTH 8102', 'Statistical Computing', 2, 3, 3);

SELECT * FROM courses;

SELECT
    courses.course_code,
    courses.course_title,
    departments.department_name,
    lecturers.first_name,
    lecturers.last_name
FROM courses
INNER JOIN departments
ON courses.department_id = departments.department_id
INNER JOIN lecturers
ON courses.lecturer_id = lecturers.lecturer_id;

INSERT INTO registrations
(student_id, course_id, academic_session, semester)
VALUES
(1, 1, '2026/2027', 'First'),
(1, 2, '2026/2027', 'First'),

(2, 3, '2026/2027', 'First'),
(2, 4, '2026/2027', 'First'),

(3, 1, '2026/2027', 'First'),
(3, 2, '2026/2027', 'First'),

(4, 5, '2026/2027', 'First'),
(4, 6, '2026/2027', 'First'),

(5, 3, '2026/2027', 'First'),
(5, 4, '2026/2027', 'First'),

(6, 5, '2026/2027', 'First'),
(6, 6, '2026/2027', 'First');

SELECT * FROM registrations;

SELECT
    students.first_name,
    students.last_name,
    courses.course_code,
    courses.course_title,
    registrations.academic_session,
    registrations.semester
FROM registrations
INNER JOIN students
ON registrations.student_id = students.student_id
INNER JOIN courses
ON registrations.course_id = courses.course_id;

INSERT INTO grades
(registration_id, ca_score, exam_score)
VALUES
(1, 32, 48),
(2, 28, 51),
(3, 35, 50),
(4, 30, 55),
(5, 25, 42),
(6, 34, 49),
(7, 31, 52),
(8, 27, 45),
(9, 36, 54),
(10, 29, 50),
(11, 33, 48),
(12, 26, 44);

SHOW TABLES;

DESCRIBE grades;
SELECT * FROM grades;
SELECT
    students.first_name,
    students.last_name,
    courses.course_code,
    grades.total_score,
    CASE
        WHEN grades.total_score >= 70 THEN 'A'
        WHEN grades.total_score >= 60 THEN 'B'
        WHEN grades.total_score >= 50 THEN 'C'
        WHEN grades.total_score >= 45 THEN 'D'
        ELSE 'F'
    END AS grade_letter
FROM grades
INNER JOIN registrations
ON grades.registration_id = registrations.registration_id
INNER JOIN students
ON registrations.student_id = students.student_id
INNER JOIN courses
ON registrations.course_id = courses.course_id;