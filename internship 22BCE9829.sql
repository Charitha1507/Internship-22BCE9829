CREATE DATABASE ORG1; 
SHOW DATABASES; 
USE ORG1; 
 
CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
INSERT INTO Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
    (001, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
    (002, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
    (003, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
    (004, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
    (005, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
    (006, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
    (007, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
    (008, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');
    
    CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);

INSERT INTO Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
    (001, 5000, '2016-02-20 00:00:00'),
    (002, 3000, '2016-06-11 00:00:00'),
    (003, 4000, '2016-02-20 00:00:00'),
    (001, 4500, '2016-02-20 00:00:00'),
    (002, 3500, '2016-06-11 00:00:00');
    
    CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);

INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    (001, 'Manager', '2016-02-20 00:00:00'),
    (002, 'Executive', '2016-06-11 00:00:00'),
    (008, 'Executive', '2016-06-11 00:00:00'),
    (005, 'Manager', '2016-06-11 00:00:00'),
    (004, 'Asst. Manager', '2016-06-11 00:00:00'),
    (007, 'Executive', '2016-06-11 00:00:00'),
    (006, 'Lead', '2016-06-11 00:00:00'),
    (003, 'Lead', '2016-06-11 00:00:00');

SELECT *FROM Worker ORDER BY FIRST_NAME ASC;

SELECT *FROM Worker ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;

SELECT *FROM Worker WHERE FIRST_NAME IN ('Vipul', 'Satish');


SELECT *FROM Worker WHERE DEPARTMENT = 'Admin';

SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a%';

SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a';

SELECT * FROM Worker WHERE FIRST_NAME LIKE '_____h';

SELECT * FROM Worker WHERE SALARY BETWEEN 100000 AND 500000;

SELECT * FROM Worker WHERE JOINING_DATE BETWEEN '2014-02-01' AND '2014-02-28 23:59:59';

SELECT COUNT(*) AS Admin_Department_Count FROM Worker WHERE DEPARTMENT = 'Admin';

SELECT FIRST_NAME, LAST_NAME FROM Worker WHERE SALARY >= 50000 AND SALARY < 100000;

SELECT DEPARTMENT, COUNT(*) AS Worker_Count FROM Worker GROUP BY DEPARTMENT
ORDER BY Worker_Count DESC;

SELECT w.*FROM Worker w
JOIN Title t ON w.WORKER_ID = t.WORKER_REF_ID
WHERE t.WORKER_TITLE = 'Manager';

SELECT FIRST_NAME, LAST_NAME, COUNT(*)
FROM Worker
GROUP BY FIRST_NAME, LAST_NAME
HAVING COUNT(*) > 1;

SELECT * FROM Worker WHERE MOD(WORKER_ID, 2) = 1;

SELECT * FROM Worker WHERE MOD(WORKER_ID, 2) = 0;

CREATE TABLE Worker_Clone AS SELECT * FROM Worker;

SELECT *
FROM Worker
INNER JOIN Bonus ON Worker.WORKER_ID = Bonus.WORKER_REF_ID
INNER JOIN Title ON Worker.WORKER_ID = Title.WORKER_REF_ID;

SELECT Worker.*
FROM Worker
LEFT JOIN Bonus ON Worker.WORKER_ID = Bonus.WORKER_REF_ID
WHERE Bonus.WORKER_REF_ID IS NULL;


SELECT NOW() AS Current_DateTime;

SELECT *FROM Worker ORDER BY WORKER_ID LIMIT 10;

SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY DESC LIMIT 1 OFFSET 4;

SELECT DISTINCT SALARY 
FROM Worker w1
WHERE 4 = (
    SELECT COUNT(DISTINCT SALARY) 
    FROM Worker w2 
    WHERE w2.SALARY > w1.SALARY
);


SELECT MAX(SALARY) AS Second_Highest_Salary
FROM Worker
WHERE SALARY < (SELECT MAX(SALARY) FROM Worker);

SELECT *FROM Worker WHERE WORKER_ID = 1
UNION ALL
SELECT *FROM Worker WHERE WORKER_ID = 1;

SELECT *FROM WORKER WHERE WORKER_ID IN(SELECT WORKER_REF_ID FROM Bonus);

SELECT * FROM Worker ORDER BY WORKER_ID LIMIT (SELECT COUNT(*) FROM Worker) / 2;
 

SELECT DEPARTMENT FROM Worker GROUP BY DEPARTMENT HAVING COUNT(*) < 5;

SELECT DEPARTMENT, COUNT(*) AS Number_Of_Workers FROM Worker GROUP BY DEPARTMENT;

SELECT *FROM Worker ORDER BY WORKER_ID DESC LIMIT 1;

SELECT *FROM Worker ORDER BY WORKER_ID LIMIT 1;

SELECT *FROM Worker ORDER BY WORKER_ID DESC LIMIT 5;

SELECT DEPARTMENT, FIRST_NAME, LAST_NAME, SALARY
FROM Worker
WHERE (DEPARTMENT, SALARY) IN (
    SELECT DEPARTMENT, MAX(SALARY)
    FROM Worker
    GROUP BY DEPARTMENT);

SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY DESC LIMIT 3;

SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY ASC LIMIT 3;

SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY DESC LIMIT 1 OFFSET 4;

SELECT DEPARTMENT, SUM(SALARY) AS Total_Salary FROM Worker GROUP BY DEPARTMENT;

SELECT FIRST_NAME, LAST_NAME FROM Worker WHERE SALARY = (SELECT MAX(SALARY) FROM Worker);

