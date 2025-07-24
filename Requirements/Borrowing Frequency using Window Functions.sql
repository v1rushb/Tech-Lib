-- Rank borrowers based on borrowing frequency.

WITH BorrowFrequency AS (
    SELECT borrower_id, COUNT(*) AS [Number Of Borrowings], first_name, last_name
    FROM Loans
    JOIN Borrowers ON Borrowers.borrower_id = Loans.borrower_id
    GROUP BY borrower_id, first_name, last_name
)

SELECT DENSE_RANK() OVER(ORDER BY [Number Of Borrowings] DESC) AS [Borrower Rank], [Number Of Borrowings], first_name AS [Borrower First Name], last_name AS [Borrower Last Name]
FROM BorrowFrequency