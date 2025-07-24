-- Overdue Analysis: List all books overdue by more than 30 days with their associated borrowers.

WITH OverDueBooks AS (
    SELECT book_id AS [Book ID], title AS [Book Title], author AS [Book Author], 
           due_date AS [Due Date],DATEDIFF(DAY, Loans.due_date, GETDATE()) AS [Overdue Days], borrower_id as [Borrower ID],
           first_name AS [Borrower First Name], last_name AS [Borrower Last Name]
    FROM Loans
    JOIN Books ON Books.book_id = Loans.book_id
    JOIN Borrowers ON Borrowers.borrower_id = Loans.borrower_id
    WHERE date_returned IS NULL;
)

SELECT *
FROM OverDueBooks
WHERE [Overdue Days] > 30
ORDER BY [Overdue Days] DESC;

GO