This section of the portfolio focuses on writing practical queries for the `peak_university` portal, inspecting how MySQL executes them under the hood, and adding indexes to make data retrieval faster as the database grows.

1. Queries Implemented
Multi-table join queries were built connecting `students`, `registrations`, `courses`, and `grades` to pull complete student academic records—including student names, registered course codes, course titles, and final scores. Conditional logic (`CASE`) was also used to dynamically map numerical scores into letter grades.

2. Execution Plan Analysis (`EXPLAIN`)
Using MySQL's `EXPLAIN` command before optimising, the execution behavior of the query engine was examined when scanning tables:
* Primary key and unique constraints (`PRIMARY`, `uq_student_course_session`) enabled fast `eq_ref` and `ref` lookups when joining `registrations`, `courses`, and `grades`[cite: 12].
* However, queries filtering by academic session and semester without a supporting index required scanning broader sets of rows.

3. Indexing & Performance Enhancements
To improve filtering and join performance on registration records, a composite index was created on the `registrations` table:

```sql
CREATE INDEX idx_reg_session_semester ON registrations (academic_session, semester);
