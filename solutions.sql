-- ### Order
-- 1. Find all subjects sorted by subject
SELECT * FROM subjects;

-- 2. Find all subjects sorted by location
SELECT * FROM subjects ORDER BY location;

-- ### Where
-- 3. Find the book "Little Women"
SELECT * FROM books WHERE title = 'Little Women';
id 190 title Little Women author_id 16 subject_id 6
-- 4. Find all books containing the word "Python"
SELECT * FROM books WHERE title like '%Python%';
Programming Python author_id 7805 subject_id 4
Learning Python author_id 7805 subject_id 4
-- 5. Find all subjects with the location "Main St" sort them by subject
SELECT * FROM subjects WHERE location = 'Main St';
Drama, Entertainment, Romance, Science Fiction

-- ### Joins

-- 6. Find all books about Computers and list ONLY the book titles
SELECT * FROM subjects WHERE subject = 'Computers';
SELECT title FROM books WHERE subject_id = 4;

Programming Python
Learning Python
Perl Cookbook
Practical PostegreSQL

-- 7. Find all books and display a result table with ONLY the following columns
-- 	* Book title
-- SELECT title FROM books;
-- 	* Author's first name
-- SELECT authors.first_name FROM books INNER JOIN authors ON books.author_id = authors.id;
-- 	* Author's last name
-- SELECT authors.last_name FROM books INNER JOIN authors ON books.author_id = authors.id;
-- 	* Book subject
-- SELECT subjects.subject FROM books INNER JOIN subjects ON books.subject_id = subjects.id;
SELECT books.title, authors.first_name, authors.last_name, subjects.subject FROM books INNER JOIN authors ON books.author_id = author.id
INNER JOIN subjects ON books.subject_id = subjects.id;
-- 8. Find all books that are listed in the stock table
-- 	* Sort them by retail price (most expensive first)
-- 	* Display ONLY: title and price
SELECT books.title, stock.retail FROM books INNER JOIN stock ON books.subject_id = stock.stock;
SELECT books.title, stock.retail ORDER BY retail DESC;
-- 9. Find the book "Dune" and display ONLY the following columns
-- 	* Book title
-- 	* ISBN number
-- 	* Publisher name
-- 	* Retail price
SELECT books.title, publishers.name, editions.isbn, stock.retail FROM books JOIN editions ON books.id = editions.book_id
JOIN publishers
ON editions.publisher_id = publishers.id
JOIN stock
ON editions.isbn = stock.isbn
WHERE books.title = 'Dune';
-- 10. Find all shipments sorted by ship date display a result table with ONLY the following columns:
-- 	* Customer first name
-- 	* Customer last name
-- 	* ship date
-- 	* book title
SELECT books.title, shipments.ship_date, customers.first_name, customers.last_name FROM customers INNER JOIN shipments ON customers.id = shipments.customer_id
JOIN editions
ON editions.isbn = shipments.isbn
JOIN books
ON books.id = editions.book_id;

-- ### Grouping and Counting

-- 11. Get the COUNT of all books
SELECT COUNT (*) FROM books;

-- 12. Get the COUNT of all Locations
SELECT COUNT (location) FROM subjects;
-- 13. Get the COUNT of each unique location in the subjects table. Display the count and the location name. (hint: requires GROUP BY).
SELECT COUNT (location) FROM subjects GROUP BY location;
-- 14. List all books. Display the book_id, title, and a count of how many editions each book has. (hint: requires GROUP BY and JOIN)
SELECT books.title, books.id,
COUNT (*) FROM books 
INNER JOIN editions
ON books.id = editions.book_id 
GROUP BY book_id, books.id;