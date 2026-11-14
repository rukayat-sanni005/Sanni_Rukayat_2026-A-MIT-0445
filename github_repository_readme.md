# MIT 8103: Advanced Database Systems (Peak University Database)

**GitHub Repository URL:** <https://github.com/rukayat-sanni005/Sanni_Rukayat_30190655>

## 1. Selected Case Study Organisation: Peak University

In this portfolio, I model, implement, optimise, and scale the core data infrastructure for **Peak University**, a tertiary institution operating a centralized Student Result & Academic Management System.

* **Nature of the System:** Manages undergraduate and postgraduate student admissions, departmental hierarchies, semester course registrations, lecturer assignments, continuous assessment (CA) and examination grading, GPA calculation, and official academic transcript generation.

* **Database Users:** Database Administrators, Academic Registry Officers, Heads of Department (HODs), Lecturers, and Students.

* **Core Data & Key Operations:** Stores student profiles, departmental metadata, course catalogues, semester registrations, itemized grade histories, and audit logs. Key operations include course registration, atomic grade submission with automatic total and letter-grade computation, GPA/transcript retrieval, departmental performance reporting, and low-latency student portal lookups.

## 2. Repository Structure & Deliverables Guide

* **`/portfolio-1-database-design/`**
  Contains my 3NF relational schema SQL scripts (`departments`, `lecturers`, `students`, `courses`, `registrations`, `grades`), integrity constraints, sample datasets, and ER diagram screenshots.

* **`/portfolio-2-query-optimisation/`**
  Contains my analytical SQL queries (multi-table `JOIN` transcripts and departmental GPA aggregations), composite B-Tree index definitions, and `EXPLAIN` plan before-and-after execution screenshots.

* **`/portfolio-3-transactions-concurrency/`**
  Contains my ACID transaction scripts (`START TRANSACTION`, `COMMIT`, `ROLLBACK`), constraint violation tests, `REPEATABLE READ` isolation demonstrations, and execution output screenshots.

* **`/portfolio-4-nosql/`**
  Contains my MongoDB JSON transcript documents (`peak_university_nosql.student_transcripts`), single-read lookup queries, dynamic schema evolution examples, and MongoDB Compass screenshots.

* **`/portfolio-5-distributed-cloud/`**
  Contains my MongoDB Atlas cloud deployment documentation (`Cluster0` on AWS `eu-west-3`), 3-node Replica Set verification, compound shard key design, CAP theorem trade-off analysis, and Atlas dashboard screenshots.

## 3. Final Summary of Portfolio Activities (Portfolios 1–5)

### Portfolio 1: Database Design and Modelling

I designed a normalized relational database (`peak_university`) in Third Normal Form (3NF) to eliminate data redundancy and update anomalies. Six core tables (`departments`, `lecturers`, `students`, `courses`, `registrations`, and `grades`) enforce entity and referential integrity using `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, and `CHECK` constraints (such as bounding CA scores to `0–40` and examination scores to `0–60`).

### Portfolio 2: Query Processing and Optimisation

I executed and evaluated analytical SQL queries—including multi-table `INNER JOIN` student transcript reports and departmental GPA aggregations—using `EXPLAIN` execution plans. By adding targeted composite B-Tree indexes on foreign key and filter columns (`student_id`, `course_code`, `semester`), I eliminated full table scans (`type = ALL`), reduced examined rows, and accelerated query execution time.

### Portfolio 3: Transactions and Concurrency Control

To protect academic records during concurrent grade uploads, I implemented explicit ACID transaction blocks (`START TRANSACTION`, `COMMIT`, `ROLLBACK`). Valid grade submissions atomically updated student results and audit logs (`COMMIT`), whereas out-of-range score entries triggered constraint errors and full transaction reversal (`ROLLBACK`). Using row-level locking and `REPEATABLE READ` isolation, I prevented dirty reads and lost updates during simultaneous lecturer updates.

### Portfolio 4: NoSQL and Advanced Data Models

To eliminate costly multi-table `JOIN`s on the student portal, I re-architected Peak University's transcript model as a Document-Oriented NoSQL database (`peak_university_nosql.student_transcripts`) using MongoDB Atlas and MongoDB Compass. Each student document embeds department details and nested semester course arrays, enabling me to retrieve complete transcripts in a single read (`{ "_id": "STU-2024-001" }`) and demonstrate dynamic schema flexibility by appending `extracurricular_achievements` exclusively to `STU-2024-002`.

### Portfolio 5: Distributed and Cloud Database Exercise

I deployed the NoSQL database on MongoDB Atlas (`Cluster0`) in the AWS Paris (`eu-west-3`) region as a 3-node Replica Set (1 Primary node handling writes and 2 Secondary nodes replicating asynchronously via the oplog for automatic failover). To support horizontal scaling across campuses, I designed a compound shard key (`{ "department.department_id": 1, "_id": 1 }`) to distribute writes evenly while isolating departmental queries. Under the CAP Theorem, I configured grade writes to enforce strong consistency (`writeConcern: "majority"`), while student result reads use `secondaryPreferred` routing for high availability.

## 4. Individual Technical Reflection

Building the Peak University database across both relational (SQL) and document-oriented (NoSQL) paradigms showed me how workload requirements directly influence database architecture. Relational normalisation (3NF) and strict ACID transactions ensured data integrity during critical write operations, while MongoDB's embedded BSON documents eliminated complex joins and supported horizontal cloud scalability.

Key technical challenges I encountered included configuring MongoDB Atlas IP Access Lists for rotating mobile carrier networks and designing an effective compound shard key to prevent hot partitions while preserving departmental query locality. I resolved these through CIDR whitelisting and understanding TLS handshakes. Finally, maintaining 55 progressive Git commits across structured repository folders reinforced disciplined engineering and version control practices.

## 5. References & AI-Use Declaration

### References

1. Elmasri, R., & Navathe, S. B. (2021). *Fundamentals of Database Systems* (7th ed.). Pearson.

2. MongoDB, Inc. (2026). *MongoDB Manual: Replication, Sharding, and Data Modeling*. https://www.mongodb.com/docs/

3. MIVA Open University. (2026). *MIT 8103 Advanced Database Systems Course Guide & Continuous Assessment Specification*.

### AI-Use Declaration

* **AI Tool Used:** Google Gemini.

* **Purpose of Use:** I used Google Gemini as a technical learning and troubleshooting aid to verify SQL/MongoDB query syntax, diagnose MongoDB Atlas TLS/IP network access errors, and organize my technical documentation structure.

* **Verification & Ownership:** I independently executed, tested, and verified all database schemas, SQL scripts, JSON document structures, MongoDB queries, and cloud cluster configurations across local SQL tools, MongoDB Compass, and MongoDB Atlas, capturing all screenshots directly from live outputs.