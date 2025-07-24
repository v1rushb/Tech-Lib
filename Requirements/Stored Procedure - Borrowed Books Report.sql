-- Stored Procedure - Borrowed Books Report:
    -- Procedure Name: sp_BorrowedBooksReport
    -- Purpose: Generate a report of books borrowed within a specified date range.
    -- Parameters: StartDate, EndDate
    -- Implementation: Retrieve all books borrowed within the given range, with details like borrower name and borrowing date.
    -- Return: Tabulated report of borrowed books.

CREATE OR ALTER PROCEDURE sp_BorrowedBooksReport (@StartDate DATE, @EndDate DATE)
AS BEGIN
    SELECT book_id AS [Book ID], title AS [Book Title], author AS [Book Author], date_borrowed AS [Borrow Date],
           borrower_id AS [Borrower ID], first_name AS [Borrower First Name], last_name AS [Borrower Last Name]  
    FROM Loans
    JOIN Books ON Books.book_id = Loans.book_id
    JOIN Borrowers ON Borrowers.borrower_id = Loans.borrower_id
    WHERE date_borrowed BETWEEN @StartDate AND @EndDate
    ORDER BY [Borrow Date];
END;

GO