# MIT 8103: Advanced Database Systems Portfolio — Peak University

**Student Name:** Rukayat Sanni  
**Course:** MIT 8103 – Advanced Database Systems (2026/2027 First Semester).
**Institution:** MIVA Open University – School of Postgraduate Studies.
**Case Study Organisation:** Peak University Student Result & Academic Management System.

---

## Case Study Overview: Peak University
**Peak University** is a tertiary academic institution managing student admissions, departmental administration, course registrations, continuous assessment (CA) and examination grading, GPA computation, and official academic transcript generation.
* **Primary Users:** Academic Registry/Administrators, Departmental Heads, Lecturers, and Students.
* **Core Data Entities:** Students, Departments, Lecturers, Courses, Semester Enrollments, Grades, and Academic Audit Logs.
* **Key Operations:** Course registration, atomic grade submission with automatic total/grade calculation, GPA/transcript retrieval, multi-criteria academic reporting, and high-availability cloud transcript lookup.

---

## Repository Structure

```text
advanced-database-portfolio/
├── portfolio-1-database-design/          # ER Diagram, 3NF Relational Schema, Keys & Constraints
├── portfolio-2-query-optimisation/       # Complex SQL Queries, EXPLAIN Execution Plans & Indexing
├── portfolio-3-transactions-concurrency/ # ACID Transactions (COMMIT/ROLLBACK), Isolation & Locking
├── portfolio-4-nosql/                    # MongoDB Atlas Document Modeling & Nested Array Queries
├── portfolio-5-distributed-cloud/        # Cloud Deployment, 3-Node Replica Set, Sharding & CAP Analysis
└── README.md                             # Portfolio Index & Case Study Overview
