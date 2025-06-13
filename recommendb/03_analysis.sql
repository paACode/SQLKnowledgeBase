USE RecommenDB;
SELECT 
	UserID, 
    MovieID,
    Rating
FROM Ratings
WHERE Rating = 5;

-- Join without Join Command " Comma Notation" 
SELECT 
	UserID, 
	Movies.MovieID,
	Title 
FROM Ratings, Movies
WHERE Ratings.MovieID = Movies.MovieID 
AND Rating = 5;

# Real Join does actually the same 
SELECT 
    UserID, 
    Movies.MovieID, 
    Title
FROM 
    Ratings
JOIN 
    Movies ON Ratings.MovieID = Movies.MovieID
WHERE 
    Rating = 5;
    
-- Create a 5 Star Rating View
CREATE OR REPLACE VIEW Ratings5 AS
SELECT 
    r.UserID, 
    m.MovieID, 
    m.Title
FROM 
    Ratings r, 
    Movies m
WHERE 
    r.Rating = 5 
    AND r.MovieID = m.MovieID;
    
-- Get similiar results to Harry
SELECT * FROM Movies WHERE Title LIKE '%Harry%';


-- 
SELECT 
    MovieID, 
    Title, 
    COUNT(*) AS N5R -- Found that many entries with MovieID = 1371
FROM 
    Ratings5
WHERE 
    MovieID = 1371;
    
    
SELECT 
    MovieID, 
    Title, 
    COUNT(*) AS N5R
FROM 
    Ratings5
GROUP BY 
    MovieID
ORDER BY N5R DESC;


SELECT  -- inout target group that gave 1371 a 5star , they also gave a 5 star to the following 10 movies with count
    MovieID, 
    Title, 
    COUNT(*) AS N5R
FROM 
    Ratings5
WHERE 
    UserID IN ( -- get all user ids that gave the movie 1371 a 5 star rating
        SELECT 
            UserID 
        FROM 
            Ratings5
        WHERE 
            MovieID = 1371
    )
GROUP BY 
    MovieID, Title
ORDER BY 
    COUNT(*) DESC
LIMIT 10;