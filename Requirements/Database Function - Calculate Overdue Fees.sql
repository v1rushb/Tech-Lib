-- Database Function - Calculate Overdue Fees:
    -- Function Name: fn_CalculateOverdueFees
    -- Purpose: Compute overdue fees for a given loan.
    -- Parameter: LoanID
    -- Implementation: Charge fees based on overdue days: $1/day for up to 30 days, $2/day after.
    -- Return: Overdue fee for the LoanID.

CREATE OR ALTER FUNCTION fn_CalculateOverdueDays (@LoanID INT)
RETURNS INT
AS BEGIN
    RETURN (
        SELECT DATEDIFF(DAY, due_date, GETDATE())
        FROM Loans
        WHERE loan_id = @LoanID
    )
END

GO

CREATE OR ALTER FUNCTION fn_CalculateOverdueFees (@LoanID INT)
RETURNS INT
AS BEGIN
    DECLARE @overdue_fees INT = 0;
    DECLARE @overdue_days INT;
    SET @overdue_days = dbo.fn_CalculateOverdueDays(@LoanID)

    if(@overdue_days <= 0)
        RETURN @overdue_fees;
    
    IF(@overdue_days <= 30)
        SET @overdue_fees = @overdue_days;
    IF(@overdue_days > 30)
        SET @overdue_fees = 2*@overdue_fees - 30;
    RETURN @overdue_fees
END

GO