-- Identify borrowers who've borrowed 2 or more books but haven't returned any using CTEs.

WITH BorrowedBooks AS (
    SELECT borrow_id, COUNT(*) AS nbooks
    FROM Loans
    WHERE date_borrowed IS NULL;
    GROUP BY borrow_id;
),
ActiveBorrowers (
    SELECT Borrower.borrow_id AS [Borrower ID], Borrower.first_name AS [Borrower First Name], Borrower.last_name AS [Borrower Last Name], BorrowedBooks.nbooks AS [Number Of Borrowed Books] 
    FROM BorrowedBooks
    JOIN Borrowers ON Borrowers.borrow_id = BorrowedBooks.borrower_id
    WHERE BorrowedBooks.nbooks >= 2
)

SELECT *
FROM ActiveBorrowers