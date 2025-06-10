USE CompanyXYYZ;
SET GLOBAL local_infile = true;

LOAD DATA LOCAL INFILE 'C:/Users/acker/Documents/sql_workspace/SQLKnowledgeBase/raw_data/employee.csv'
INTO TABLE employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(employee_nr, first_name, last_name, street, street_nr, zipcode);

LOAD DATA LOCAL INFILE 'C:/Users/acker/Documents/sql_workspace/SQLKnowledgeBase/raw_data/project.csv'
INTO TABLE project
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(project_nr, name);

LOAD DATA LOCAL INFILE 'C:/Users/acker/Documents/sql_workspace/SQLKnowledgeBase/raw_data/involved.csv'
INTO TABLE involved
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(employee_nr, project_nr, percentage);
