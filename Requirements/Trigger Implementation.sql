-- Design a trigger to log an entry into a separate AuditLog table whenever a book's status changes from 'Available' to 'Borrowed' or vice versa. The AuditLog should capture BookID, StatusChange, and ChangeDate.

CREATE TABLE BookStatusAuditLogs (
    book_id INT,
    status_change VARCHAR(50),
    change_date DATE
)

GO

CREATE OR ALTER TRIGGER BookStatusOnChangeTrigger
ON Books
AFTER UPDATE
AS BEGIN
    IF(UPDATE (current_status))
        BEGIN
            INSERT INTO BookStatusAuditLogs(book_id, status_change, change_date)
            SELECT inserted.book_id,
                   CONCAT('From ', deleted.current_status, ' to ', inserted.current_status) AS status_change,
                   GETDATE()
                   FROM deleted
                   JOIN inserted ON inserted.book_id = deleted.book_id
        END
END;

GO

-- Some Example

Update Books
SET current_status = "Available"
WHERE book_id = 2;

SELECT *
FROM BookStatusAuditLogs;