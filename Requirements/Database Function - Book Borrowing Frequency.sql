-- Database Function - Book Borrowing Frequency:
    -- Function Name: fn_BookBorrowingFrequency
    -- Purpose: Gauge the borrowing frequency of a book.
    -- Parameter: BookID
    -- Implementation: Count the number of times the book has been issued.
    -- Return: Borrowing count of the book.

CREATE OR ALTER FUNCTION fn_BookBorrowingFrequency (@BookID INT)
RETURNS INT
AS BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM Loans
        WHERE book_id = @BookID;
    )
END;

GO