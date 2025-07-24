-- Identify the most popular genre for a given month.

CREATE PROCEDURE SP_TopGenreByMonth (@month INT)
AS BEGIN
    SELECT TOP 1 FIRST_VALUE(genre) OVER(ORDER BY [Number Of Borrowings] DESC) AS [Top Genre], [Number Of Borrowings]
    FROM (
        SELECT genre, COUNT(genre) AS [Number Of Borrowings]
        FROM Loans
        JOIN Books ON Books.book_id = Loans.book_id
        WHERE Month(date_borrowed) = @month
        Group By genre
    ) AS [Genre Frequency]
END