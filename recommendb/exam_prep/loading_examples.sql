USE RecommenDB;

# Add Column with Boolean Falue
ALTER TABLE details 
ADD COLUMN netflix_true BOOLEAN;

# Insert Data
INSERT INTO details (
	MovieId, Budget, Revenue, Duration, netflix_true
    )
VALUES (
	1, 1000000,2000, 66, TRUE
    );

# Update Data
UPDATE details
SET Budget = 123
WHERE MovieID = 1;

SELECT * FROM details;

 FROM movies
W