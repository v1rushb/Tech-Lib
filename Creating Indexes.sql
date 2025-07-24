CREATE INDEX borrowers_index ON Borrowers(borrower_id, first_name, last_name)

CREATE INDEX books_index ON Books(book_id, genre, current_status)

CREATE INDEX loans_index ON Loans(loan_id, borrower_id, book_id)
