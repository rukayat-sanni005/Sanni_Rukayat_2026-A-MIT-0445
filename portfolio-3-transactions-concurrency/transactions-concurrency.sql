START TRANSACTION;

-- Registering a student for a course
INSERT INTO registrations (student_id, course_code, academic_session, semester) 
VALUES (1, 'CSC 8101', '2026/2027', 'First');

-- If everything looks good, save the changes permanently
COMMIT;

START TRANSACTION;

-- Attempting an operation that violates a rule or needs to be aborted
INSERT INTO registrations (student_id, course_code, academic_session, semester) 
VALUES (9999, 'MIT 8103', '2026/2027', 'First'); -- Assuming student_id 9999 doesn't exist (foreign key error)

-- If an error or condition occurs, undo the changes
ROLLBACK;

-- Setting isolation level to prevent dirty reads during concurrent transactions
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;
SELECT * FROM grades WHERE student_id = 1;
COMMIT;