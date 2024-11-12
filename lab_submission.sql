-- (i) A Procedure called PROC_LAB5
-- retrieving the top five highest paid employees in the company
DELIMITER $$
CREATE PROCEDURE PROC_LAB5()
BEGIN
  SELECT 
    e.employeeNumber AS 'Employee ID',
    e.firstName AS 'First Name',
    e.lastName AS 'Last Name',
    e.jobTitle AS 'Job Title',
    o.city AS 'Office City',
    o.country AS 'Office Country',
    es.employees_salary_amount AS 'Salary'
  FROM 
    employees e
    JOIN offices o ON e.officeCode = o.officeCode
    JOIN employees_salary es ON e.employeeNumber = es.employeeNumber
  ORDER BY 
    es.employees_salary_amount DESC
  LIMIT 5;
END$$
DELIMITER ;


-- (ii) A Function called FUNC_LAB5
-- calculating the average salary of employees in a specific office

DELIMITER $$
CREATE FUNCTION FUNC_LAB5(officeCode INT) RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE avgSalary DOUBLE;
    SELECT COALESCE(AVG(es.employees_salary_amount), 0) INTO avgSalary
    FROM employees_salary es
    JOIN employees e ON es.employeeNumber = e.employeeNumber
    WHERE e.officeCode = officeCode;
    RETURN avgSalary;
END$$
DELIMITER ;

-- (iii) A View called VIEW_LAB5
-- summary of top five paid workers in the office code 8

CREATE OR REPLACE VIEW VIEW_LAB5 AS
SELECT 
  e.employeeNumber AS 'Employee ID',
  e.firstName AS 'First Name',
  e.lastName AS 'Last Name',
  e.jobTitle AS 'Job Title',
  o.officeCode AS 'Office Code',
  o.city AS 'Office City',
  es.employees_salary_amount AS 'Salary'
FROM
  employees e
  JOIN offices o ON e.officeCode = o.officeCode
  JOIN employees_salary es ON e.employeeNumber = es.employeeNumber
WHERE 
  o.officeCode = 8
ORDER BY
   es.employees_salary_amount DESC
LIMIT 5;
    




SELECT
     offices.city AS 'Office Location (City)',
     offices.country AS 'Office Location (Country)',
     offices.territory AS 'Office Location (Territory)',
     offices.officeCode AS 'Office Code',
     FUNC_LAB6(offices.officeCode) AS 'Average Salary'
    
     FROM
    offices;