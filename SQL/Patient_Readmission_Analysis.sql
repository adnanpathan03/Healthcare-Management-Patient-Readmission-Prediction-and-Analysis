-- Calculate the total number of patient encounters
SELECT COUNT(*) AS total_encounters FROM project.diabetic_data;

-- Identify the top 10 most frequent diagnoses
SELECT diag_1 AS diagnosis, COUNT(*) AS frequency
FROM project.diabetic_data
GROUP BY diag_1
ORDER BY frequency DESC
LIMIT 10;

-- Calculate the average length of hospital stay for each admission type
SELECT admission_type_id, AVG(time_in_hospital) AS avg_length_of_stay
FROM project.diabetic_data
GROUP BY admission_type_id;

-- Determine the number of readmitted patients and the percentage of total encounters that they represent
SELECT COUNT(*) AS readmitted_count, 
       ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM project.diabetic_data), 2) AS percentage
FROM project.diabetic_data
WHERE readmitted != 'NO';

-- identify the age distribution of patients
SELECT age, COUNT(*) AS patient_count
FROM project.diabetic_data
GROUP BY age
ORDER BY age;

-- Identify the most common procedures performed during patient encounters
SELECT medical_specialty, COUNT(*) AS procedure_count
FROM project.diabetic_data
WHERE medical_specialty IS NOT NULL
GROUP BY medical_specialty
ORDER BY procedure_count DESC
LIMIT 5;
-- Calculate the average number of medications prescribed for patients in each age group.
SELECT age, AVG(num_medications) AS avg_medications
FROM project.diabetic_data
GROUP BY age
ORDER BY age;

-- Identify the distribution of readmission rates across different payer codes.
SELECT payer_code, 
       SUM(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) AS readmitted_count,
       COUNT(*) AS total_encounters,
       ROUND((SUM(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS readmission_rate
FROM project.diabetic_data
GROUP BY payer_code
ORDER BY readmission_rate DESC;
