CREATE TABLE Books (
    book_id INT IDENTITY(1, 1) PRIMARY KEY,
    title NVARCHAR(50) NOT NULL,
    author NVARCHAR(50) NOT NULL,
    isbn NVARCHAR(13) NOT NULL UNIQUE,
    published_date DATE,
    genre NVARCHAR(50),
    shelf_location NVARCHAR(50),
    current_status NVARCHAR(10) NOT NULL,
)

GO


CREATE TABLE Borrowers (
    borrower_id INT IDENTITY(1, 1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(80) UNIQUE NOT NULL,
    date_of_birth DATE,
    date_returned DATE,
)
 
GO

CREATE TABLE Loans (
    loan_id INT IDENTITY(1, 1) PRIMARY KEY,
    book_id INT NOT NULL FOREIGN KEY REFERENCES Books(book_id),
    borrower_id INT NOT NULL FOREIGN KEY REFERENCES Borrowers(borrower_id),
    date_borrowed DATE,
    due_date DATE,
    date_returned DATE
)

GO