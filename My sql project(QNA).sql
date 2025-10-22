/* Employee attendance Question and Answers */
/* Q1. Display all employee details. */
SELECT emp_id, first_name, last_name, department, designation, joining_date
FROM employees;

/* Q2. Show all attendance records with employee details. */
SELECT 
    e.emp_id, e.first_name, e.last_name, e.department, e.designation,
    a.attendance_date, a.login_time, a.logout_time, a.status
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
ORDER BY a.attendance_date;

/* Q3. Display employees who were present on 2025-10-20. */
SELECT e.first_name, e.last_name, a.status
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.attendance_date = '2025-10-20' AND a.status = 'Present';

/* Q4. Calculate each employee’s total Present, Absent, and Leave days. */
SELECT 
    e.first_name, e.last_name,
    SUM(a.status = 'Present') AS total_present,
    SUM(a.status = 'Absent') AS total_absent,
    SUM(a.status = 'Leave') AS total_leave
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
GROUP BY e.emp_id;

/* Q5. Show how long each employee worked each day. */
SELECT 
    e.first_name, e.last_name, a.attendance_date,
    TIMEDIFF(a.logout_time, a.login_time) AS work_duration
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.status = 'Present';

/* Q6. Show employees who took Leave at least once. */
SELECT DISTINCT e.first_name, e.last_name
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.status = 'Leave';

/* Q7. Display attendance summary for 2025-10-21. */
SELECT e.first_name, e.last_name, a.status
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.attendance_date = '2025-10-21';

/* Q8. Show employees who joined after 2023-01-01. */
SELECT first_name, last_name, department, designation, joining_date
FROM employees
WHERE joining_date > '2023-01-01';

/* Q9. Find total employees in each department. */
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

/* Q10. Find employees in the IT department. */
SELECT first_name, last_name, designation
FROM employees
WHERE department = 'IT';

/* Q11. List employees who worked more than 8 hours. */
SELECT e.first_name, e.last_name, a.attendance_date,
TIMEDIFF(a.logout_time, a.login_time) AS work_duration
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE TIMEDIFF(a.logout_time, a.login_time) > '08:00:00';

/* Q12. Find employee(s) with the highest number of Present days. */
SELECT e.first_name, e.last_name, COUNT(a.status) AS total_present
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.status = 'Present'
GROUP BY e.emp_id
ORDER BY total_present DESC
LIMIT 1;

/* Q13. Display attendance records sorted by latest date first. */
SELECT e.first_name, e.last_name, a.attendance_date, a.status
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
ORDER BY a.attendance_date DESC;

/* Q14. Show employees who have no attendance records. */
SELECT e.first_name, e.last_name
FROM employees e
LEFT JOIN attendance a ON e.emp_id = a.emp_id
WHERE a.emp_id IS NULL;

/* Q15. Display admin usernames. */
SELECT username FROM admin;

/* Q16. Count total Leave requests. */
SELECT COUNT(*) AS total_leave_days
FROM attendance
WHERE status = 'Leave';

/* Q17. Find first and last attendance date per employee. */
SELECT 
    e.first_name, e.last_name,
    MIN(a.attendance_date) AS first_attendance,
    MAX(a.attendance_date) AS last_attendance
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
GROUP BY e.emp_id;

/* Q18. Show attendance where login time was after 9:15 AM. */
SELECT e.first_name, e.last_name, a.attendance_date, a.login_time
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.login_time > '09:15:00';

/* Q19. Find average working hours per employee. */
SELECT 
    e.first_name, e.last_name,
    SEC_TO_TIME(AVG(TIME_TO_SEC(TIMEDIFF(a.logout_time, a.login_time)))) AS avg_work_time
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.status = 'Present'
GROUP BY e.emp_id;

/* Q20. Display employees who were Absent at least once. */
SELECT DISTINCT e.first_name, e.last_name
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.status = 'Absent';

