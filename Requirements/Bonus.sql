-- Weekly peak days: The library is planning to employ a new part-time worker. This worker will work 3 days weekly in the library. From the data you have, determine the most 3 days in the week that have the most share of the loans and display the result of each day as a percentage of all loans. Sort the results from the highest percentage to the lowest percentage. (eg. 25.18% of the loans happen on Monday...)

DECLARE @tbl_size INT = (
    SELECT COUNT(*)
    FROM Loans
    WHERE date_borrowed IS NOT NULL
)

SELECT TOP 3 DATENAME(WEEKDAY, date_borrowed) AS [Weekday],
             (CAST(COUNT(*) AS FLOAT) / @tbl_size) * 100 AS [Loan Precentage]
FROM Loans
GROUP BY DATENAME(WEEKDAY, date_borrowed)
ORDER BY [Loan Precentage]