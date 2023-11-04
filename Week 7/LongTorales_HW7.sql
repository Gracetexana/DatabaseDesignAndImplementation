-- question 1
SELECT CONCAT(city, ", ", stateCode) AS Location, COUNT(*) AS Count
FROM publisher
GROUP BY city, stateCode
ORDER BY COUNT(*) ASC;

-- question 2
SELECT b.title AS title, COUNT(r.rating) AS "Total Ratings", MIN(r.rating) AS Low, 
	MAX(r.rating) AS High, ROUND(AVG(r.rating), 2) AS Average
FROM book b
LEFT JOIN bookreview r ON b.isbn = r.isbn
GROUP BY b.title
ORDER BY COUNT(r.rating) DESC;

-- question 3
SELECT p.name AS "Publisher Name", COUNT(*) AS "Book Count"
FROM publisher p
INNER JOIN book b ON p.publisherID = b.publisherID
GROUP BY p.name
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC;

-- question 4
SELECT title, LENGTH(title) AS Length, 
	SUBSTRING(title, INSTR(title, "bill") + 4, LENGTH(title)) AS "After Bill"
FROM book
WHERE title LIKE "%bill%";

-- question 5
SELECT DISTINCT title
FROM book b
RIGHT JOIN ownersbook ob ON b.isbn = ob.isbn;