CREATE DATABASE IF NOT EXISTS RecommenDB;

USE RecommenDB;

-- 1 Movie -> Many Ratings
-- 1 User --> Many Movies
-- 1 Rating --> 1 Movie 

CREATE TABLE Movies (
    MovieID INTEGER PRIMARY KEY,
    Title TEXT,
    Release_date DATE,
    Budget INTEGER,
    Genres JSON
);

CREATE TABLE Ratings (
    UserID     INTEGER,
    MovieID    INTEGER,
    Rating     INTEGER,
    Timestamp  DATETIME,
    PRIMARY KEY (MovieID, UserID), -- This is a compound key 
    CONSTRAINT MovieID_FK
        FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

CREATE TABLE Genres ( 
	GenreID INTEGER PRIMARY KEY, 
	Name TEXT
) ;

CREATE TABLE Movie_has_Genre (
    MovieID  INTEGER,
    GenreID  INTEGER,
    PRIMARY KEY (MovieID, GenreID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);


CREATE TABLE Details (
    DetailsID INTEGER PRIMARY KEY AUTO_INCREMENT,
    MovieID INTEGER UNIQUE,
    Budget DECIMAL(15,2),
    Revenue DECIMAL(15,2),
    Duration INT,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);