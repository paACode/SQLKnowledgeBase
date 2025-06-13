USE RecommenDB;
SET GLOBAL local_infile = true;

-- Load Movies
LOAD DATA LOCAL INFILE 'C:/Users/acker/Downloads/Movies_and_Ratings/movies.csv'
INTO TABLE Movies
FIELDS ENCLOSED BY '"' 
ESCAPED BY '\\'
IGNORE 1 LINES; -- Skip headers

SELECT COUNT(*) FROM Movies; -- 45463 movies(entities) loaded 


-- Drop FK and PK in Ratings to increase Loading Speed

ALTER TABLE Ratings DROP CONSTRAINT MovieID_FK; 
ALTER TABLE Ratings DROP PRIMARY KEY ;

-- Load ratings
LOAD DATA LOCAL INFILE 'C:/Users/acker/Downloads/Movies_and_Ratings/ratings.csv'
INTO TABLE Ratings
FIELDS TERMINATED BY ',' 
       ENCLOSED BY '"'
IGNORE 1 LINES
(UserID, MovieID, Rating, @Timestamp)   -- Map columns from the CSV, using a variable for timestamp
SET Timestamp = FROM_UNIXTIME(@Timestamp);  -- Convert UNIX timestamp to DATETIME format

# Recreate Primary Key
ALTER TABLE Ratings 
ADD CONSTRAINT PRIMARY KEY (MovieID, UserID);

# Delete Ratings from not existing MovieIDs
DELETE FROM Ratings
WHERE MovieID NOT IN (
    SELECT MovieID
    FROM Movies
);

#Recreate Foreign Key
ALTER TABLE Ratings
ADD CONSTRAINT MovieID_FK
FOREIGN KEY (MovieID)
REFERENCES Movies(MovieID);