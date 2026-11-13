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