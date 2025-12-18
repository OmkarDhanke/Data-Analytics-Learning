-- 1. Create the Main Table (Books)
-- Note: We initially create it WITHOUT a Primary Key to practice adding one.
CREATE TABLE Books (
    BookID INT,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    PublishedYear INT,
    ISBN VARCHAR(20),
    Price DECIMAL(10,2)
);

-- 2. Create a Borrowers Table
CREATE TABLE Borrowers (
    BorrowerID INT AUTO_INCREMENT PRIMARY KEY , -- Clustered Index created automatically
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50)
);

###################################### Practice ######################################
-- Creating when creating the table
CREATE TABLE emp(
	emp_id int AUTO_INCREMENT PRIMARY key ,
    emp_name VARCHAR(50)
);

-- Adding Primary Key 
ALTER TABLE books
add PRIMARY KEY (BookID);

-- DROPing the PRIMARY KEY
ALTER TABLE Books
DROP PRIMARY KEY;

-- Order By ASC/DESC
CREATE INDEX sec_index
on Books (ISBN DESC);

-- Multiple Index
CREATE INDEX idx_Country_score
on Customer (Cuntry,Score);

###################################### Practice ######################################
-- Q1: (Clustered Index) The 'Books' table currently has no Primary Key.
--     Add a PRIMARY KEY to the 'BookID' column. 
--     (This automatically creates the Clustered Index in InnoDB).
ALTER TABLE books
ADD PRIMARY KEY (BookID);

-- Q2: (Secondary Index) Library users frequently search for books by 'Title'.
--     Create a standard Secondary Index named 'idx_title' on the 'Title' column.
CREATE INDEX idx_title
on Books (Title);

-- Q3: (Unique Index) The 'ISBN' number for a book must be unique (no two books can share it).
--     Create a UNIQUE INDEX named 'idx_isbn' on the 'ISBN' column.
--     (Note: This enforces uniqueness AND speeds up lookups).

CREATE UNIQUE INDEX idx_isbn
on Books(ISBN);

-- Q4: (Composite Index) Users often filter books by 'Genre' AND 'PublishedYear' together 
--     (e.g., "Show me Fantasy books from 1997").
--     Create a Composite Index named 'idx_genre_year' on these two columns.ALTER

CREATE INDEX idx_genre_year
on Books (Genre,PublishedYear);

-- Q5: (Leftmost Prefix Rule) You just created the index on (Genre, PublishedYear).
--     Write a query that searches for books by 'Genre' only.
--     Does this query utilize the index you created in Q4? (Write "Yes/No" as a comment).

SELECT * FROM Books
WHERE Genre IN ('Classic','Romance');
-- Yes

-- Q6: (Leftmost Prefix Rule) Using that same index (Genre, PublishedYear).
--     Write a query that searches for books by 'PublishedYear' only.
--     Does this query utilize the index from Q4? (Write "Yes/No" as a comment).

SELECT * FROM indexdb.Books
WHERE PublishedYear = 1951;
-- NO

-- Q7: (Dropping Indexes) We decided searching by Title is not useful anymore.
--     Write the command to DROP the 'idx_title' index from the Books table.

 DROP INDEX idx_title on Books;

-- Q8: (Composite Sorting) We want to show the most recent books first.
--     Create an index named 'idx_author_year_desc' on 'Author' and 'PublishedYear'.
--     However, sort 'PublishedYear' in DESCENDING order (MySQL 8.0+ syntax).

CREATE INDEX idx_author_year_desc
ON books (Author,PublishedYear DESC);

-- Q9: (Clustered Index Management) We made a mistake. We want to remove the Primary Key from 'Books'.
--     Write the command to drop the Primary Key.
ALTER TABLE books
DROP PRIMARY KEY;

-- Q10: (Performance Logic) The 'Borrowers' table has a 'City' column.
--      If we have 1,000,000 users but only 3 distinct cities (New York, LA, Chicago),
--      is it a good idea to create an index on 'City'? 
--      (Write a comment explaining why or why not. Hint: "Cardinality").

-- No Its not a good idea it is not practical tto create the idex just for the tree Cities ;
