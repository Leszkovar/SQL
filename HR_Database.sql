------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

-- Drop the tables in case they exist

DROP TABLE EMPLOYEES;
DROP TABLE JOB_HISTORY;
DROP TABLE JOBS;
DROP TABLE DEPARTMENTS;
DROP TABLE LOCATIONS;

-- Create the tables

CREATE TABLE EMPLOYEES (
                          EMP_ID CHAR(9) NOT NULL,
                          F_NAME VARCHAR(15) NOT NULL,
                          L_NAME VARCHAR(15) NOT NULL,
                          SSN CHAR(9),
                          B_DATE DATE,
                          SEX CHAR,
                          ADDRESS VARCHAR(30),
                          JOB_ID CHAR(9),
                          SALARY DECIMAL(10,2),
                          MANAGER_ID CHAR(9),
                          DEP_ID CHAR(9) NOT NULL,
                          PRIMARY KEY (EMP_ID)
                        );

CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL,
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID)
                          );

CREATE TABLE JOBS (
                    JOB_IDENT CHAR(9) NOT NULL,
                    JOB_TITLE VARCHAR(30) ,
                    MIN_SALARY DECIMAL(10,2),
                    MAX_SALARY DECIMAL(10,2),
                    PRIMARY KEY (JOB_IDENT)
                  );

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL,
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP)
                          );

CREATE TABLE LOCATIONS (
                          LOCT_ID CHAR(9) NOT NULL,
                          DEP_ID_LOC CHAR(9) NOT NULL,
                          PRIMARY KEY (LOCT_ID,DEP_ID_LOC)
                        );


SELECT * FROM EMPLOYEES;


-- Query 1-----
;
SELECT F_NAME, L_NAME 
FROM EMPLOYEES 
WHERE ADDRESS LIKE '%ELGIN, IL%';
;
--Query 2--
;
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE LIKE '197%';
;
--Query 3--
;
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE (SALARY BETWEEN 60000 AND 70000) AND DEP_ID = 5;
;
--Query 4--
;
SELECT F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID;
;
--Query 5--
;
SELECT F_NAME, L_NAME, DEP_ID 
FROM EMPLOYEES 
ORDER BY DEP_ID DESC, L_NAME DESC;
;
--Query 6--
;
SELECT D.DEP_NAME , E.F_NAME, E.L_NAME
FROM EMPLOYEES as E, DEPARTMENTS as D
WHERE E.DEP_ID = D.DEPT_ID_DEP
ORDER BY D.DEP_NAME, E.L_NAME DESC;
;
--Query 7--
;
SELECT DEP_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;
;
--Query 8,9--
;
SELECT DEP_ID, COUNT(*) as "NUM_EMPLOYEES", AVG(SALARY) as "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID;
;
--Query 10--
;
SELECT DEP_ID, COUNT(*) as "NUM_EMPLOYEES", AVG(SALARY) as "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY;
;
--Query 11--
;
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING COUNT(*) < 4
ORDER BY AVG_SALARY;
;
--Query 12--
;

--Exercise 1--
SELECT L_NAME, F_NAME, SALARY FROM EMPLOYEE WHERE SALARY < AVG(SALARY);

--Exercise 2--
SELECT EMP_ID, F_NAME, L_NAME, SALARY
FROM EMPLOYEES 
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

--Exercise 3--

SELECT EMP_ID, SALARY, MAX(SALARY) as MAX_SALARY from EMPLOYEES


SELECT EMP_ID, SALARY, (SELECT MAX(SALARY) FROM EMPLOYEES) as MAX_SALARY
FROM EMPLOYEES;


SELECT * FROM (SELECT EMP_ID, L_NAME, F_NAME, DEP_ID FROM EMPLOYEES) AS EMP4ALL;

SELECT * FROM EMPLOYEES WHERE JOB_ID IN (SELECT JOB_IDENT FROM JOBS);

SELECT * FROM EMPLOYEES WHERE JOB_ID in (SELECT JOB_IDENT FROM JOBS WHERE JOB_TITLE = 'Jr. Designer');

SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT  FROM JOBS WHERE JOB_IDENT IN (Select JOB_ID FROM EMPLOYEES WHERE SALARY > 70000);

SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT  FROM JOBS WHERE JOB_IDENT IN (SELECT JOB_ID FROM EMPLOYEES WHERE YEAR(B_DATE) > 1976);

SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT  FROM JOBS WHERE JOB_IDENT IN (SELECT JOB_ID FROM EMPLOYEES WHERE YEAR(B_DATE) > 1976 AND SEX = 'F');

SELECT * FROM EMPLOYEES, JOBS;

SELECT * FROM EMPLOYEES, JOBS WHERE EMPLOYEES.JOB_ID = JOBS. JOB_IDENT;

SELECT * FROM EMPLOYEES AS E, JOBS AS J WHERE E.JOB_ID = J.JOB_IDENT;

SELECT E.EMP_ID, E.L_NAME, E.F_NAME, J.JOB_TITLE FROM EMPLOYEES AS E, JOBS AS J WHERE E.JOB_ID = J.JOB_IDENT;

