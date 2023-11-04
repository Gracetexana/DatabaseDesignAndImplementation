USE jobs;

-- question 22
SELECT e.companyName AS "Company Name", i.interviewDate AS "Interview Date"
FROM employer e
LEFT JOIN interview i
ON e.companyName = i.companyName AND e.division = i.division
WHERE e.companyName LIKE "__ch%" OR e.companyName LIKE "__me%"
ORDER BY e.companyName DESC, i.interviewDate DESC;

-- question 23
SELECT companyName AS companyname, AVG(salaryOffered) AS "Average Salary"
FROM interview
GROUP BY companyName
HAVING AVG(salaryOffered) > 21.25;

-- question 24
INSERT INTO quarter (qtrCode, minSal, minHrs)
VALUES (22217, 22.15, 35);

-- question 25
CREATE TABLE travel(
	travelID INT UNSIGNED AUTO_INCREMENT,
    interviewID INT UNSIGNED NOT NULL,
    departLoc CHAR(3) DEFAULT "ROC",
    departDate DATE NOT NULL,
    bookedThrough VARCHAR(50),
    price DECIMAL(6, 2) NOT NULL,
    paid ENUM("y", "n") NOT NULL,
    CONSTRAINT travel_pk PRIMARY KEY (travelID), 
    CONSTRAINT travel_interviewID_fk FOREIGN KEY (interviewID)
		REFERENCES interview (interviewID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);