USE peak_university;

SELECT DATABASE();
SELECT
    students.first_name,
    students.last_name,
    courses.course_code,
    courses.course_title,
    grades.total_score
FROM students
INNER JOIN registrations
    ON students.student_id = registrations.student_id
INNER JOIN courses
    ON registrations.course_id = courses.course_id
INNER JOIN grades
    ON registrations.registration_id = grades.registration_id
WHERE registrations.academic_session = '2026/2027'
AND registrations.semester = 'First'
ORDER BY students.last_name;

EXPLAIN
SELECT
    students.first_name,
    students.last_name,
    courses.course_code,
    courses.course_title,
    grades.total_score
FROM students
INNER JOIN registrations
    ON students.student_id = registrations.student_id
INNER JOIN courses
    ON registrations.course_id = courses.course_id
INNER JOIN grades
    ON registrations.registration_id = grades.registration_id
WHERE registrations.academic_session = '2026/2027'
AND registrations.semester = 'First'
ORDER BY students.last_name;

CREATE INDEX idx_reg_session_semester
ON registrations (academic_session, semester);

SHOW INDEX FROM registrations;

EXPLAIN
SELECT
    students.first_name,
    students.last_name,
    courses.course_code,
    courses.course_title,
    grades.total_score
FROM students
INNER JOIN registrations
    ON students.student_id = registrations.student_id
INNER JOIN courses
    ON registrations.course_id = courses.course_id
INNER JOIN grades
    ON registrations.registration_id = grades.registration_id
WHERE registrations.academic_session = '2026/2027'
AND registrations.semester = 'First'
ORDER BY students.last_name;

