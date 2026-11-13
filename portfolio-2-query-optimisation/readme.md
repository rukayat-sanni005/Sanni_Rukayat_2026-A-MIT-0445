This section of the portfolio demonstrates ACID property compliance, transaction control mechanisms, and concurrency management within the `peak_university` database portal.

Transaction Control (COMMIT and ROLLBACK)
To ensure data consistency during critical operations (such as student course registration or grade entries):
* **`COMMIT` Scenarios:** Executed transactions successfully write multiple related changes (like recording enrollments) simultaneously, ensuring atomicity.
`ROLLBACK` Scenarios:Tested transaction rollbacks to safely revert database states when invalid data or constraint violations occur, preventing partial or corrupted records from persisting.

Concurrency and Isolation Levels
To manage multiple users (such as students checking grades while lecturers input scores simultaneously):
* Transaction isolation levels (such as `READ COMMITTED`) was utilized to prevent concurrency anomalies like dirty reads, non-repeatable reads, and phantom reads.
