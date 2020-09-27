-- How many unique businesses are represented in the database? Find out how many of them are currently open.

SELECT count(DISTINCT id) as "open businesses"
FROM yelp.businesses
WHERE is_open = 1
LIMIT 100000;

-- How many unique users are represented in the user table?

SELECT  count(distinct id) AS "Unique Users"
FROM yelp.users
limit 100000;

-- Which user has received the highest average stars?


SELECT average_stars, name 
FROM yelp.users
WHERE average_stars = 5


 

-- How many types of votes can a user send? List them
SELECT distinct vote_type
FROM yelp.users_votes
ORDER BY vote_type;

-- How many types of compliments can a user receive? List them.
SELECT DISTINCT compliment_type
FROM yelp.users_compliments
ORDER BY compliment_type;

-- Return the reviews which have received the greatest value for stars, the greatest number of useful votes and 
-- the greatest number of cool votes.
 -- Make sure that you are returning all relevant reviews if there is a tie.
 SELECT id, stars, useful, cool
FROM yelp.reviews
 ORDER BY stars DESC, cool DESC, useful DESC;
 
 
 
 
-- Which users have been "Yelping" the longest?
SELECT 
name, yelping_since
FROM 
yelp.users
WHERE
yelping_since=(SELECT
 MIN(yelping_since)
FROM
yelp.users);

SELECT name, yelping_since
FROM yelp.users
ORDER BY yelping_since

-- Which businesses have received the greatest value for stars? Sort these by the number of reviews, from highest to lowest.
 -- Return only open businesses.
SELECT id,stars,review_count, is_open
FROM yelp.businesses
WHERE is_open = 1
ORDER BY stars DESC, review_count DESC;


-- Return the user who has written the greatest number reviews.

SELECT  MAX(review_count), name
FROM yelp.users
GROUP BY name
ORDER BY MAX(review_count) DESC;

-- Return the number of open businesses in each Charlotte, NC neighborhood in the Yelp database. 
-- Sort from least number of businesses to greatest number of businesses

SELECT COUNT(name), neighborhood
FROM yelp.businesses 
WHERE is_open = 1
GROUP BY neighborhood 
ORDER BY COUNT(name) ;

-- Modify the previous query to return only neighborhoods with at least 100 businesses. Change the sorting to order the neighborhoods 
-- from greatest number of businesses to least number of businesses.

SELECT COUNT(name), neighborhood
FROM yelp.businesses 
WHERE is_open = 1
GROUP BY neighborhood 
HAVING COUNT(name) >= 100
ORDER BY COUNT(name) 

-- Return the neighborhood associated with the greatest number of reviews.
-- SELECT neighborhood, SUM(review_count)
-- FROM yelp.businesses
-- GROUP BY neighborhood;

-- Return the average star rating for the businesses in each neighborhood. How could you modify this query to return the 
-- average star rating for the entire neighborhood? Hint: this will involve a weighted average.
SELECT  neighborhood, AVG(stars)
FROM yelp.businesses
GROUP BY neighborhood;

SELECT  neighborhood, SUM(stars*review_count)/SUM(review_count)
FROM yelp.businesses
GROUP BY neighborhood;

-- Determine the average star rating given by the users who have written the greatest number of reviews. 
-- Return only the users name, average stars and review count
SELECT MAX(review_count) 
FROM yelp.users;
-- 11656.
SELECT review_count, name, average_stars 
FROM yelp.users                                                                                                                                                                                                                                                                                                 
WHERE review_count = 11656;

































