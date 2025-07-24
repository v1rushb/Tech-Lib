-- Stored Procedure - Add New Borrowers:
    -- Procedure Name: sp_AddNewBorrower
    -- Purpose: Streamline the process of adding a new borrower.
    -- Parameters: FirstName, LastName, Email, DateOfBirth, MembershipDate.
    -- Implementation: Check if an email exists; if not, add to Borrowers. If existing, return an error message.
    -- Return: The new BorrowerID or an error message.

CREATE Procedure sp_AddNewBorrower (@first_name NVARCHAR(50), @last_name NVARCHAR(50), @email NVARCHAR(80),
                                    @date_of_birth DATE, @membership_date DATE)
AS BEGIN
        IF (@email IN (SELECT email FROM Borrowers))
        BEGIN
            SELECT 'Email Already Exists.' AS [Error Message];
            RETURN;
        END;

        INSERT INTO Borrowers (first_name, last_name, email, date_of_birth, membership_date)
        VALUES (@first_name, @last_name, @email, @date_of_birth, @membership_date);

        SELECT borrower_id AS [New Borrower ID] 
        FROM Borrowers
        WHERE email = @email;
END;

GO

-- Some Example:
EXEC sp_AddNewBorrower 'Bashar', 'Herbawi', 'cs.bashar.herbawi@gmail.com', '20-Dec-2003', '3-Aug-2020'
