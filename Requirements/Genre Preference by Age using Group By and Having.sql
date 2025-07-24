-- Genre Preference by Age using Group By and Having: Determine the preferred genre of different age groups of borrowers. (Groups are (0,10), (11,20), (21,30)…)

CREATE OR ALTER FUNCTION fn_BorrowerAge (@BorrowerID INT)
RETURN INT
AS BEGIN
    RETURN (
        SELECT DATEDIFF(YEAR, date_of_birth, GETDATE())
        FROM Borrowers
        WHERE borrower_id = @BorrowerID
    );
END;

GO

CREATE OR ALTER FUNCTION fn_SelectGenreByAgeRange (@min_range INT, @max_range INT)
RETURNS TABLE
AS 
RETURN (
    SELECT 
        Books.genre, 
        COUNT(*) AS [Number Of Borrowings for Genre]
    FROM 
        Loans
    JOIN 
        Books ON Books.book_id = Loans.book_id
    JOIN 
        Borrowers ON Borrowers.borrower_id = Loans.borrower_id
    WHERE 
        dbo.fn_BorrowerAge(Borrowers.borrower_id) BETWEEN @min_range AND @max_range
    GROUP BY 
        Books.genre
);

GO


GO

DECLARE age INT = 0;

CREATE TABLE #borrowings_by_age (
    age_group NVARCHAR(10),
    genre NVARCHAR(100)
)

while(@age <= 99)
BEGIN
    DECLARE @age_group NVARCHAR(10); -- (91-99)
    SET @age_group = CONCAT(@age, '-', @age+9);

    DECLARE @genre NVARCHAR(100);
    SET @genre = (
        SELECT TOP 1 genre
        FROM dbo.fn_SelectGenreByAgeRange(@age, @age+9);
    )

    INSERT INTO #borrowings_by_age (age_group, genre)
    VALUES (@age_group, @genre);

    SET @age = @age + 10;

END

SELECT *
FROM #borrowings_by_age