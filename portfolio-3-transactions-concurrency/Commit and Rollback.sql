ROLLBACK;
USE peak_university;

-- Reset Tunde's registration_id = 1 score back to its original 32.00 and 48.00
UPDATE grades SET ca_score = 32.00, exam_score = 48.00 WHERE registration_id = 1;

-- Remove any leftover Second Semester test rows if they exist
DELETE FROM grades WHERE registration_id IN (
    SELECT registration_id FROM registrations WHERE academic_session = '2026/2027' AND semester = 'Second'
);
DELETE FROM registrations WHERE academic_session = '2026/2027' AND semester = 'Second';
COMMIT;

USE peak_university;

START TRANSACTION;

INSERT INTO registrations (student_id, course_id, academic_session, semester)
VALUES (1, 4, '2026/2027', 'Second');

SET @new_reg_id = LAST_INSERT_ID();

INSERT INTO grades (registration_id, ca_score, exam_score)
VALUES (@new_reg_id, 30.00, 52.00);

COMMIT;

-- Verify both records were saved permanently
SELECT * FROM grades WHERE registration_id = @new_reg_id;

USE peak_university;

START TRANSACTION;

-- Step 1: Valid registration insert for Student 2 (Amara)
INSERT INTO registrations (student_id, course_id, academic_session, semester)
VALUES (2, 1, '2026/2027', 'Second');

-- Step 2: Suppose validation catches an invalid CA score (> 40), so we abort:
ROLLBACK;

-- Proof of Rollback: Returns 0 rows (Amara's partial registration was undone)
SELECT * FROM registrations 
WHERE student_id = 2 AND academic_session = '2026/2027' AND semester = 'Second';