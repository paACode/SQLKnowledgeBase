 USE RecommenDB;
 -- Create materialized view for 5 Star Ratings
CREATE TABLE Ratings5M AS
SELECT 
    r.UserID, 
    m.MovieID, 
    m.Title
FROM 
    Ratings as r
JOIN 
    Movies m ON r.MovieID = m.MovieID
WHERE 
    r.Rating = 5;
    
    
-- Run with materialized View
SELECT 
    MovieID, 
    COUNT(*) AS N5R
FROM 
    Ratings5m
WHERE 
    UserID IN (
        SELECT 
            UserID AS TargetGroup
        FROM 
            Ratings5m
        WHERE 
            MovieID = 1371
    )
GROUP BY 
    MovieID
ORDER BY 
    COUNT(*) DESC;
    
 -- Create materialized view with index
 CREATE TABLE Ratings5MI AS
SELECT 
    r.UserID, 
    m.MovieID, 
    m.Title
FROM 
    Ratings r
JOIN 
    Movies m ON r.MovieID = m.MovieID
WHERE 
    r.Rating = 5;

CREATE INDEX IX_MovieID ON Ratings5MI(MovieID);
CREATE INDEX IX_UserID ON Ratings5MI(UserID);
CREATE INDEX IX_UserID_MovieID ON Ratings5MI(UserID, MovieID);


-- Run with materialized View and index
EXPLAIN
SELECT 
    MovieID, 
    COUNT(*) AS N5R
FROM 
    Ratings5mi
WHERE 
    UserID IN (
        SELECT 
            UserID AS TargetGroup
        FROM 
            Ratings5mi
        WHERE 
            MovieID = 1371
    )
GROUP BY 
    MovieID
ORDER BY 
    COUNT(*) DESC;
    
-- Like is way faster because it can make use of index
SELECT MovieID,Title FROM Movies WHERE Title LIKE '%E.T.%'; -- 1097 


SELECT MovieID, Title, COUNT(*) AS N5R FROM Ratings5MI
WHERE UserID IN (
SELECT UserId AS TargetGroup FROM Ratings5MI
WHERE MovieID = 1097 ) GROUP BY MovieID, Title ORDER BY COUNT(*) DESC LIMIT 10;