-- Grace T Long Torales

-- question 1
SELECT location
FROM quarter
UNION
SELECT stateCode
FROM employer;

-- question 2
SELECT employer.companyName, employer.division, employer.stateCode, interview.salaryOffered
FROM (employer
JOIN interview
 ON (employer.companyName = interview.companyName
 AND employer.division = interview.division));
 
 -- question 3
 SELECT *
 FROM state
 WHERE state.stateCode
 NOT IN (
 SELECT stateCode
 FROM employer
 );
 
 -- question 4
 SELECT DISTINCT companyName, minhrsOffered
 FROM interview;
 
 -- question 5
 SELECT *
 FROM state
 WHERE(
    SUBSTRING(state.description, 4, 1) = "a" OR
    SUBSTRING(state.description, 4, 1) = "e" OR
    SUBSTRING(state.description, 4, 1) = "i" OR
    SUBSTRING(state.description, 4, 1) = "o" OR
    SUBSTRING(state.description, 4, 1) = "u"
);

-- question 6
SELECT quarter.qtrCode, quarter.location, state.description
FROM quarter
	LEFT JOIN state
    ON quarter.location = state.stateCode;
    
-- question 7
SELECT state.description, employer.companyName
FROM(
	state
    LEFT JOIN employer
    ON state.stateCode = employer.stateCode
);