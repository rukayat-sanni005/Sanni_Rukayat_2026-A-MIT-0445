# Distributed and Cloud Database Architecture (`peak_university`)

## Overview
This portfolio demonstrates the cloud deployment and distributed database architecture for **Peak University**, hosted on **MongoDB Atlas** (`Cluster0`, AWS `eu-west-3` Paris region, MongoDB v8.0.37)[cite: 2, 16]. It examines how replication, horizontal sharding, high availability, and consistency models support university-wide academic operations during peak registration and exam result periods.

---

## 1. Cloud Deployment & High Availability (3-Node Replica Set)
`Cluster0` is deployed as a **3-node Replica Set** across AWS availability zones[cite: 2]:
* **1 Primary Node:** Receives all write operations (`insert`, `update`, `delete`) such as course registrations and lecturer grade submissions, and logs them to the **oplog** (operations log).
* **2 Secondary Nodes:** Asynchronously replicate the oplog from the Primary node in real time to maintain identical copies of `peak_university_nosql.student_transcripts`[cite: 11].
* **Automatic Failover:** If the Primary node becomes unavailable due to hardware failure or network partition, the remaining Secondary nodes hold an automated election and promote a new Primary within seconds—ensuring uninterrupted access to student portals.

### Cloud Deployment Evidence
*(Place your Atlas Cluster / Replica Set screenshot inside `portfolio-5-distributed-cloud/` and update the filename below if needed)*
![MongoDB Atlas 3-Node Replica Set Deployment](atlas-cluster-replication.png)

---

## 2. Horizontal Scaling & Sharding Strategy
As Peak University scales across multiple campuses, faculties, and multi-year alumni cohorts, a single server's storage and write throughput become bottlenecks. Horizontal **Sharding** partitions `student_transcripts` across multiple shard clusters[cite: 11, 16]:
* **Chosen Shard Key:** `{ "department.department_id": 1, "_id": 1 }` (Compound Hashed/Ranged Shard Key).
* **Why This Shard Key Works:**
  * **High Cardinality & Even Distribution:** Combining `department_id` with unique student ID (`_id`, e.g., `STU-2024-001`) prevents "hot shards" (jumbo chunks) where all writes hit one server[cite: 11].
  * **Targeted Queries (Query Isolation):** Departmental queries (e.g., Computer Science HOD generating semester broadsheets) route directly to the specific shard holding that department rather than broadcasting across all shards.

---

CAP Theorem & Consistency vs. Availability Trade-Offs


Under the **CAP Theorem** (Consistency, Availability, Partition Tolerance), a distributed cloud database must tolerate network partitions (**P**) and balance **Consistency (C)** vs. **Availability (A)**

| Peak University Workload | Consistency / Availability Strategy | Configuration & Justification |
| :--- | :--- | :--- |
| **Grade Entry & Fee/Registration Updates** | **Strong Consistency (CP)** | `writeConcern: "majority"` and `readConcern: "majority"` ensure a grade or course registration is committed to at least 2 of the 3 replica nodes before confirming success, preventing lost grades during failover. |
| **Student Transcript & Result Viewing** | **High Availability & Read Scaling (AP)** | `readPreference: "secondaryPreferred"` routes heavy read traffic during result release days to the Secondary nodes, offloading the Primary node while keeping data within milliseconds of real time. |

---

## 4. Security & Network Isolation in the Cloud
* **Encryption in Transit & at Rest:** All client connections from MongoDB Compass and application drivers enforce **TLS/SSL encryption**, while storage volumes on AWS are encrypted at rest.
* **Role-Based Access Control (RBAC) & IP Access Lists:** Database access is restricted to authenticated database users (`readWrite` scoped roles) and whitelisted network CIDR ranges via Atlas Network Access.

