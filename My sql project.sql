
-- Project: Employee Attendance Management System


CREATE DATABASE IF NOT EXISTS employee_attendance;
USE employee_attendance;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    designation VARCHAR(50),
    joining_date DATE);
CREATE TABLE attendance 
(att_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    attendance_date DATE,
    login_time TIME,
    logout_time TIME,
    status ENUM('Present', 'Absent', 'Leave') DEFAULT 'Present',
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id));
CREATE TABLE admin
 (admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255));
INSERT INTO employees (first_name, last_name, department, designation, joining_date)
VALUES
('Ninad', 'Pawar', 'IT', 'Software Engineer', '2023-07-10'),
('Priya', 'Sharma', 'HR', 'HR Manager', '2022-03-15'),
('Ravi', 'Kumar', 'Finance', 'Accountant', '2021-09-01'),
('Sneha', 'Patil', 'IT', 'Tester', '2023-01-12');
INSERT INTO attendance (emp_id, attendance_date, login_time, logout_time, status)
VALUES
(1, '2025-10-20', '09:10:00', '17:30:00', 'Present'),
(1, '2025-10-21', '09:05:00', '17:40:00', 'Present'),
(2, '2025-10-20', NULL, NULL, 'Leave'),
(3, '2025-10-21', '09:30:00', '18:00:00', 'Present'),
(4, '2025-10-20', '09:15:00', '17:00:00', 'Present');
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    e.department,
    e.designation,
    a.attendance_date,
    a.login_time,
    a.logout_time,
    a.status
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
ORDER BY a.attendance_date;
SELECT 
    e.first_name,
    e.last_name,
    a.attendance_date,
    TIMEDIFF(a.logout_time, a.login_time) AS work_duration
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.status = 'Present';
SELECT 
    e.first_name,
    e.last_name,
    SUM(a.status = 'Present') AS total_present,
    SUM(a.status = 'Absent') AS total_absent,
    SUM(a.status = 'Leave') AS total_leave
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
GROUP BY e.emp_id;
SELECT 
    e.first_name,
    e.last_name,
    a.status
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.attendance_date = '2025-10-21';
SELECT emp_id, first_name, last_name, department, designation, joining_date
FROM employees;
INSERT INTO admin (username, password)
VALUES ('admin', 'admin123');
