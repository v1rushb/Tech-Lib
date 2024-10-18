-- Author Popularity using Aggregation: Rank authors by the borrowing frequency of their books.

WITH AuthorPopularity AS (
    SELECT author AS [Author], COUNT(*) as [Number Of Borrowings]
    FROM Books
    JOIN Loans ON Loans.book_id = Books.book_id
    GROUP BY author
)

SELECT DENSE_RANK() OVER(ORDER BY [Number Of Borrowings] DESC) AS [Author Rank], 
       [Author], [Number Of Borrowings]
FROM AuthorPopularity

GO