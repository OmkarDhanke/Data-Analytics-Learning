USE Miniproject;

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    ReleaseYear INT,
    Genre VARCHAR(50),
    Director VARCHAR(100)
);

INSERT INTO Movies (MovieID, Title, ReleaseYear, Genre, Director) VALUES
((1, 'The Matrix', 1999, 'Sci-Fi', 'Wachowski'),
(2, 'Inception', 2010, 'Sci-Fi', 'Nolan'),
(3, 'Parasite', 2019, 'Drama', 'Bong Joon-ho'),
(4, 'Interstellar', 2014, 'Sci-Fi', 'Nolan'),
(5, 'The Dark Knight', 2008, 'Action', 'Nolan'),
(6, 'Pulp Fiction', 1994, 'Crime', 'Tarantino'),
(7, 'Titanic', 1997, 'Romance', 'Cameron'),
(8, 'Avatar', 2009, 'Sci-Fi', 'Cameron'),
(9, 'Joker', 2019, 'Drama', 'Phillips'),
(10, 'Whiplash', 2014, 'Drama', 'Chazelle'));


CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    MovieID INT,
    UserID INT,
    Rating INT,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

INSERT INTO Ratings (RatingID, MovieID, UserID, Rating) VALUES
((1, 1, 101, 5),
(2, 1, 102, 4),
(3, 2, 103, 5),
(4, 5, 104, 5),
(5, 3, 105, 4),
(6, 7, 106, 3),
(7, 8, 107, 4),
(8, 9, 108, 5),
(9, 10, 109, 5),
(10, 6, 110, 4),
(11, 1, 111, 5),
(12, 2, 112, 4),
(13, 3, 113, 5),
(14, 4, 114, 4),
(15, 5, 115, 5),
(16, 6, 116, 3),
(17, 7, 117, 4),
(18, 8, 118, 5),
(19, 9, 119, 4),
(20, 10, 120, 5));


-- Q1: How many movies were released each year?
SELECT ReleaseYear,COUNT(*) as CountOfMovie 
FROM Movies
GROUP BY ReleaseYear;

-- Q2: List all movies released after 2010, showing Title and ReleaseYear.
SELECT Title, ReleaseYear 
from Movies
where ReleaseYear > 2010;

-- Q3: Find the average rating of each movie.
SELECT m.Title, round(avg(r.rating),2) as Rating from movies as m
LEFT JOIN ratings as r
on m.MovieID = r.MovieID
GROUP BY Title;

-- Q4: Which movie has the highest average rating?
SELECT m.Title, round(avg(r.rating),2) as AVG_Rating from movies as m
LEFT JOIN ratings as r
on m.MovieID = r.MovieID
GROUP BY r.MovieID,m.Title
ORDER BY AVG_Rating DESC LIMIT 1;

-- Q5: Find all movies that have more than 2 ratings.
SELECT m.Title , COUNT(r.Rating) as Rating from movies as m
INNER JOIN ratings as r
on m.MovieID = r.MovieID 
GROUP BY m.Title 
HAVING Rating > 2
ORDER BY Rating DESC;
     
-- Q6: Get the top 5 movies by average rating, but only if they have at least 2 ratings.
SELECT m.Title , ROUND(AVG(r.rating),2) as Avrage_Rating , COUNT(r.rating) as Count_rating from Movies as m
INNER JOIN  ratings as r
on m.MovieID = r.MovieID 
GROUP BY m.Title 
HAVING Count_rating >= 2
ORDER BY Count_rating DESC LIMIT 5;

-- Q7: Which director has the highest average movie rating across all their films?
SELECT m.Director , round(AVG(r.rating),2)as Highest_Rating from Movies as m
INNER JOIN ratings as r
on m.MovieID = r.MovieID 
WHERE m.Director is NOT NULL
GROUP BY m.Director
ORDER BY Highest_Rating DESC;

-- Q8: For each genre, what is the average rating?
SELECT M.Genre, round(avg(R.Rating)) as Avrage_Rating from Movies as m
INNER JOIN ratings as r
on m.MovieID = r.MovieID 
GROUP BY M.Genre
ORDER BY Avrage_Rating DESC;

-- Q9: Categorize movies into quality bands using CASE: Excellent (avg ≥ 4.5), Good (avg 3.5–4.4), Average (<3.5)
    
-- Q10: Which year had the highest average rating across all movies released in that year?
SELECT M.ReleaseYear , round(avg(r.rating),2)  as AVG_rating from movies as m
INNER JOIN ratings as r
on m.MovieID = r.MovieID 
GROUP BY M.ReleaseYear 
ORDER BY AVG_rating DESC LIMIT 1;
