-- Design a stored procedure that retrieves all borrowers who have overdue books.
--  Store these borrowers in a temporary table,
--  then join this temp table with the Loans table to list out the specific overdue books for each borrower.

DROP TABLE IF EXISTS #borrowers_with_overdue_books;

GO

CREATE OR ALTER PROCEDURE sp_OverdueBorrowings
AS BEGIN
    CREATE TABLE #borrowers_with_overdue_books (
        borrower_id INT,
        first_name NVARCHAR(50),
        last_name NVARCHAR(50)
    );

    INSERT INTO #borrowers_with_overdue_books(borrower_id, first_name, last_name)
        SELECT DISTINCT Borrowers.borrower_id, first_name, last_name
        FROM Loans
        JOIN Borrowers ON Borrowers.borrower_id = Loans.borrower_id
        WHERE Loans.date_returned IS NULL AND Loans.due_date < GETDATE()

    SELECT Loans.borrower_id AS [Borrower ID], first_name AS [Borrower First Name],
        last_name AS [Borrower Last Name], book_id AS [Book ID],
        due_date AS [Due Date], date_borrowed AS [Borrow Date]
    FROM #borrowers_with_overdue_books
    JOIN Loans ON Loans.borrower_id = #borrowers_with_overdue_books.borrower_id
    WHERE date_returned IS NULL AND due_date < GETDATE();
END;

GO

EXEC sp_OverdueBorrowings

GO