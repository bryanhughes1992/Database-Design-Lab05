/* QUESTION #1 
 * Get a list of all books, including the author's names 
 * (duplicate books are okay, if the book has multiple authors). */

SELECT 
	title AS `Book`, 
	genre AS `Genre`, 
	first_name AS `Author First Name`, 
	last_name AS `Author Last Name`
FROM books b
	JOIN authorship a
		ON b.book_id = a.book_id
	JOIN authors 
		ON authors.author_id = a.author_id;
    
/* QUESTION #2 
 * Get a list of all books withdrawn by people with the initials 'B.W.'. 
 * Show a column for the first name, last name, initials, and the title of the book. */
	
SELECT 
	b.title AS "Book Withdrawn",
	m.first_name AS "Member First Name",
	m.last_name AS "Member Last Name",
	SUBSTRING(m.first_name, 1, 1) AS "First Name Initial",
	SUBSTRING(m.last_name, 1, 1) AS "Last Name Initial"
FROM books b
	JOIN withdrawals w
		ON b.book_id = w.book_id
	JOIN members m 
		ON m.member_id = w.member_id
WHERE m.first_name 
	LIKE 'B%' 
AND m.last_name 
	LIKE 'W%';

/* QUESTION #3
 * Get the number of books written by each American author. 
 * Include the first and last names of the author. 
 * Note that America might be represented in the 'country' column in more than one way. */

SELECT 
	COUNT(*) AS "Number of Books", 
	a2.first_name, 
	a2.last_name 
FROM books b
	JOIN authorship a
		ON b.book_id = a.book_id
	JOIN authors a2
		ON a.author_id = a2.author_id
	WHERE a2.country
		LIKE "U%S%"
	GROUP BY a.author_id;
	
/* QUESTION #4
 * For any book withdrawn in October, 
 * get the member's first name, last name, the withdrawal date and the book's title.
 * Try getting the month from a date using the scalar function MONTH() */

SELECT 
	m.first_name AS "Member First Name",
	m.last_name AS "Member Last Name",
	w.withdrawal_date AS "Withdrawal Date",
	b2.title AS "Book Title"
	FROM withdrawals w
	JOIN members m 
		ON w.member_id = m.member_id
	JOIN books b2 
		ON b2.book_id = w.book_id 
	WHERE MONTH(w.withdrawal_date) = 10;

/* QUESTION 5
 * Get a list of people who have overdue books (the return date is greater than the due date). */
SELECT 
	m2.first_name AS "First-Name",
	m2.last_name AS "Last-Name"
FROM withdrawals w
	JOIN members m2
		ON w.member_id = m2.member_id
WHERE w.return_date > w.due_date;

/* QUESTION #6 
 * Get a list of all authors, and the books they wrote. 
 * Include authors multiple times if they wrote multiple books. 
 * Also include authors who don't have any books in the database. */

SELECT
	a2.first_name AS "Author's First Name",
	a2.last_name AS "Author's Last Name",
	b.title AS "Title"
FROM authors a2
	JOIN authorship a3 
		ON a2.author_id = a3.author_id
	JOIN books b
		ON b.book_id = a3.book_id;
		
/* QUESTION #7
 * Get a list of members who've never withdrawn a book. 
 * Hint: outer joins return rows with null values if there is no match between the tables. */
SELECT 
	m.first_name AS "Member First Name",
	m.last_name AS "Member Last Name"
FROM withdrawals w 
	RIGHT JOIN members m
		ON w.member_id = m.member_id
WHERE w.withdrawal_id IS NULL;

/* QUESTION #8 
 * Rewrite the above query as the opposite join 
 * (if you used a left join, rewrite it as a right join; if you used a right join, rewrite it as a left join). 
 * The results table should contain the same data. */

SELECT DISTINCT 
	m.first_name AS "Member First Name",
	m.last_name AS "Member Last Name"
FROM withdrawals w 
	LEFT JOIN members m
		ON w.member_id = m.member_id;
	
/* QUESTION #9
 * Cross join books and authors. Isn't that ridiculous?*/
SELECT *
	FROM books b 
		CROSS JOIN authors a;
	
/* QUESTION #10
 * Get a list of all members who have the same first name as other members. 
 * Sort it by first name so you can verify the data. */
	
SELECT 
	m.first_name AS "First Name",
	COUNT(*) AS Repitition
FROM members m
GROUP BY m.first_name
HAVING COUNT(*) > 1;


		

	
    
    