CREATE DATABASE IF NOT EXISTS CompanyXYYZ;
USE CompanyXYYZ;
CREATE TABLE employee (
	-- Datatypes
	employee_nr INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR (100),
    street VARCHAR (100) ,
    street_nr INT, -- Can be NULL, for example for farms "Windrosenhof"
    zipcode VARCHAR (4),
    -- Primary Key
    CONSTRAINT pk_employee_nr PRIMARY KEY (employee_nr)
);

CREATE TABLE project (
	-- Datatypes
	project_nr INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    -- Primary Key
    CONSTRAINT pk_project_nr PRIMARY KEY (project_nr)
);

create table involved(
	employee_nr INT NOT NULL,
    project_nr INT NOT NULL,
    percentage TINYINT, 
    CONSTRAINT fk_employee_nr FOREIGN KEY (employee_nr) REFERENCES employee(employee_nr),
    CONSTRAINT fk_project_nr FOREIGN KEY (project_nr) REFERENCES project(project_nr)
)
