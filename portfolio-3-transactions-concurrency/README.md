This section demonstrates ACID transaction management, pessimistic concurrency control (row-level locking), and transaction isolation levels within the Peak University (`peak_university`) Student Result Portal database. In an academic portal, course registrations and student grade entries are mission-critical operations. Partial writes (such as registering a student without recording valid assessment records) or concurrent updates by multiple lecturers/administrators can corrupt academic transcripts. Using MySQL's InnoDB storage engine, these exercises verify how transactions preserve data integrity under normal execution, failure recovery, and simultaneous multi-user access. 

 Implementation & Test Analysis 

1. Atomic Persistence (`COMMIT`)
What was tested:Registering Student 1 (Tunde Adeyemi) for `MIT 8103` and inserting his grades (`ca_score = 30.00`, `exam_score = 52.00`) inside a single transaction.
Outcome (Transaction-concurrency 1 .png): Both inserts succeeded together after `COMMIT`, saving `grade_id = 13` with an automatically calculated `total_score = 82.00`.

2. Failure Recovery (`ROLLBACK`)
What was tested: Inserting a registration for Student 2 (Amara Okeke) and then running `ROLLBACK` to simulate aborting an invalid grade entry.
Outcome (Transaction-concurrency 2 .png):`ROLLBACK` completely undid the registration insert. Querying `registrations` afterward returned `0 rows`, proving no partial data was saved.

3. Concurrency Locking (`SELECT ... FOR UPDATE`)
What was tested:Two sessions trying to edit `registration_id = 1` at the same time. Session 1 locked the row with `FOR UPDATE` while Session 2 tried to run an `UPDATE`.
Outcome: MySQL blocked Session 2 from overwriting the locked row until the 50-second wait limit expired (`Error Code: 1205: Lock wait timeout exceeded`). This prevents lost updates when two users edit the same grade simultaneously.

4. Isolation Level (`REPEATABLE READ`)
What was tested:Session 1 read `registration_id = 2` (`total_score = 79.00`) inside a `REPEATABLE READ` transaction while Session 2 updated and committed a new score (`83.00`) in the background.
Outcome (Transaction-concurrency 3.png): Session 1 continued to read `79.00` across repeated queries inside its open transaction, proving that InnoDB snapshot isolation prevents mid-report data changes (non-repeatable reads).

