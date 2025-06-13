 USE RecommenDB;

-- PW Policies already installed
SHOW VARIABLES LIKE 'validate_password.%';

#Create PW for Admin Localhost
ALTER USER admin@localhost IDENTIFIED BY 'HPgr_9$5';

# Create PW for USer gui
CREATE USER gui@localhost 
IDENTIFIED BY 'fl3SF1k_$';

-- See who has access to db
SELECT User, Host FROM mysql.user; 

GRANT ALL PRIVILEGES ON RecommenDB.* TO admin@localhost; -- allow reading, writing, deleting
GRANT SYSTEM_VARIABLES_ADMIN ON *.* TO admin@localhost; -- this is needed for backupp

SHOW GRANTS FOR admin@localhost;

 FLUSH PRIVILEGES
 
 
 -- Create a new DB for Visualizations --> login as root 
 
CREATE DATABASE Visualization;
CREATE OR REPLACE VIEW Visualization.Movies AS SELECT * FROM RecommenDB.Movies; # Copy Movies
CREATE OR REPLACE VIEW Visualization.rating_numbers AS SELECT * FROM RecommenDB.rating_numbers;
CREATE OR REPLACE VIEW Visualization.Ratings5MI AS SELECT * FROM RecommenDB.Ratings5MI;
GRANT SELECT ON Visualization.* TO gui@localhost;
FLUSH PRIVILEGES;