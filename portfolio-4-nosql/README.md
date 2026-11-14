NoSQL Document Modelling (`peak_university_nosql`)

This portfolio re-models the relational ``academic database`` into a document-orientated NoSQL architecture using MongoDB Atlas and MongoDB Compass. Instead of splitting student profiles, departments, enrolments, and grades across normalised tables, each student's complete academic transcript is stored as a self-contained JSON/BSON document inside the `student_transcripts` collection.

1. Relational vs. Document Model Comparison

| Feature | Relational SQL Model (Portfolios 1–3) | Document NoSQL Model (Portfolio 4) |
| :--- | :--- | :--- |
|Data Structure| Normalised tables (`students`, `departments`, `courses`, `enrollments`, `grades`) linked via foreign keys. | Single denormalised `student_transcripts` collection with embedded `department` objects and `academic_records` arrays. |
| Transcript Retrieva| Requires multi-table `INNER JOIN` queries across 4–5 tables. | Retrieved in one single read operation by `_id` (`{ "_id": "STU-2024-001" }`). |
| Schema Flexibility** | Rigid schema; adding a new attribute requires `ALTER TABLE` and leaves `NULL` values for other rows. | Dynamic schema; new fields can be added to individual documents on the fly without affecting existing records. |
|Consistency Trade-off| Strong ACID compliance across normalised tables. | High read performance and horizontal scalability; lecturer/course titles are embedded per semester snapshot. |


2. Document Schema Structure (`student_transcripts`)

```json
{
  "_id": "STU-2024-001",
  "student_id": 1,
  "full_name": "Tunde Adeyemi",
  "email": "tunde@peakuniversity.edu",
  "department": {
    "department_id": 1,
    "name": "Computer Science",
    "office": "Block A, First Floor"
  },
  "admission_year": 2024,
  "status": "Active",
  "academic_records": [
    {
      "session": "2026/2027",
      "semester": "First",
      "courses": [
        {
          "course_code": "CSC 8101",
          "course_title": "Advanced Programming",
          "credit_units": 3,
          "lecturer": "Adebayo Olawale",
          "ca_score": 32,
          "exam_score": 48,
          "total_score": 80,
          "grade": "A"
        }
      ]
    }
  ]
}

