USE RecommenDB;

#Extract GenreNames and GenreIds from Json in Movies Table
INSERT INTO Genres
SELECT DISTINCT -- Only returns unique GenreIds and GenreNames 
    JSON_EXTRACT(Genres, '$[0].id') AS GenreID,
    JSON_UNQUOTE(JSON_EXTRACT(Genres, '$[0].name')) AS GenreName
FROM Movies
WHERE JSON_EXTRACT(Genres, '$[0].id') IS NOT NULL;

# Extract all the ids as GenreId 
INSERT INTO Movie_has_Genre (MovieID, GenreID)
SELECT 
    MovieID, 
    GenreID
FROM 
    Movies
JOIN 
    JSON_TABLE(
        Genres, 
        '$[*]' 
        COLUMNS (
            GenreID INTEGER PATH '$.id'
        )
    ) AS Genres;
    
    
-- Quick check
SELECT
	mhg.GenreID
FROM movie_has_genre as mhg
WHERE mhg.MovieID = 1;