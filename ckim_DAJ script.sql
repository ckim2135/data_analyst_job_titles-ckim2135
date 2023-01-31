SELECT *
FROM data_analyst_jobs
ORDER BY location DESC;

-- 1.	How many rows are in the data_analyst_jobs table?
-- 1793

SELECT COUNT(title)
FROM data_analyst_jobs;

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
-- ExxonMobil

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
-- TN 21, KY 6, Total 27

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location= 'TN';

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'KY';

-- 4.	How many postings in Tennessee have a star rating above 4?
-- 3 job postings in TN have a star rating > 4

SELECT COUNT (star_rating)
FROM data_analyst_jobs
WHERE star_rating > 4
	AND location = 'TN';


-- 5.	How many postings in the dataset have a review count between 500 and 1000?
-- 151 job postings for companies with between 500 and 1000 reviews

SELECT COUNT (review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;


-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
-- Nebraska
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE location IS NOT NULL
GROUP BY location
ORDER BY AVG(star_rating) DESC;

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?
-- 881

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

-- 8.	How many unique job titles are there for California companies?
-- 230

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

-- 9.	Determine which companies have more than 5000 reviews across all locations. How many companies have more than 5000 reviews? What is the star rating of each company?
-- 40 companies have > 5000 reviews

SELECT COUNT(DISTINCT company)
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL;

SELECT DISTINCT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY company, star_rating
ORDER BY AVG(star_rating) DESC;


-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
-- Kaiser Permanente has the highest star rating, 4.1999

SELECT DISTINCT company, star_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company, star_rating
ORDER BY star_rating DESC
LIMIT 1;

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 1669; 774
-- 1669 job titles contain 'analyst', 774 unique job titles contain 'analyst'

SELECT title
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
-- 4 titles do not include 'analyst' or 'analytics'. These job titles all include 'Tableau'

SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%'
	AND title NOT ILIKE '%analytics%';

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
-- - Disregard any postings where the domain is NULL. 
-- - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
-- - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
-- Top 4: Internet and Software (62), Banks and Financial Services (61), Consulting and Business Services (57), Health Care (52)

SELECT domain, COUNT(title)
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
	AND domain IS NOT NULL
	AND days_since_posting > 21
GROUP BY domain
ORDER BY COUNT(title) DESC;

SELECT domain, COUNT(title)
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
	AND domain IS NOT NULL
	AND days_since_posting > 21
GROUP BY domain
ORDER BY COUNT(title) DESC
LIMIT 4;
