SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT registration_id, total_score FROM grades WHERE registration_id = 2;

SELECT registration_id, total_score FROM grades WHERE registration_id = 2;
COMMIT;

COMMIT;
SELECT registration_id, total_score FROM grades WHERE registration_id = 2;