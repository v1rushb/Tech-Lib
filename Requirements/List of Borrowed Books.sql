-- Retrieve all books borrowed by a specific borrower, including those currently unreturned.

SELECT Books.book_id AS [Book ID], Books.title AS [Book Title], Books.author AS [Book Author], Books.current_status AS [Book Status] AS [Book Status], Borrowers.borrower_id [Borrower ID], Borrowers.first_name AS [Borrower Fist Name], Borrowers.last_name AS [Borrower Last Name], date_borrowed [Date Borrowed]
FROM Loans
JOIN Books ON Loans.book_id = Books.book_id
JOIN Borrowers ON Loans.borrower_id = Borrowers.borrower_id
