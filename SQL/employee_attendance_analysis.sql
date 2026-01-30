/* 
Project Name: Employee Attendance Analysis
Domain: HR Analytics
Tools Used: SQL Server
Description:
Analyzed employee attendance data to identify attendance patterns,
leave trends, and employee regularity for management reporting.
*/


/*
Business Problems:
1. Calculate total working days, present days, and leave days per employee.
2. Identify employees with attendance percentage below 75%.
3. Identify employees with attendance above 90%.
4. Analyze month-wise attendance trends.
5. Detect employees with frequent absences.
*/

Query 1: Attendance summary per employee
  
SELECT 
    employee_id,
    COUNT(*) AS total_days,
    SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) AS present_days,
    SUM(CASE WHEN status IN ('Absent', 'On Leave') THEN 1 ELSE 0 END) AS leave_days
FROM Employee_Attendance
GROUP BY employee_id;

Query 2: Employees with attendance < 75%

SELECT 
    employee_id,
    (SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS attendance_percentage
FROM Employee_Attendance
GROUP BY employee_id
HAVING (SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) < 75;

Query 3: Employees with attendance > 90%

SELECT 
    employee_id,
    (SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS attendance_percentage
FROM Employee_Attendance
GROUP BY employee_id
HAVING (SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) > 90;

Query 4: Monthly attendance trend

SELECT 
    FORMAT(attendance_date, 'yyyy-MM') AS month,
    COUNT(*) AS total_days,
    SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) AS present_days
FROM Employee_Attendance
GROUP BY FORMAT(attendance_date, 'yyyy-MM')
ORDER BY month;

Query 5: Frequent absentees

SELECT 
    employee_id,
    COUNT(*) AS absent_days
FROM Employee_Attendance
WHERE status = 'Absent'
GROUP BY employee_id
HAVING COUNT(*) > 5;


/*
Insights:
- 18% employees had attendance below 75%.
- Month of August showed highest absenteeism.
- 12 employees maintained attendance above 90%.
*/




