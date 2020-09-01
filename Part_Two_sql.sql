use zoo_lab


SELECT 
FROM zoo_lab.animals
LIMIT 1;

SELECT *
FROM zoo_lab.animal_stats
LIMIT 1;

SELECT scientific_name, length(scientific_name)
FROM species
ORDER BY scientific_name DESC;

-- Which animal has the longest individual_name? Shortest?
-- Each individual animal's given name is stored in the animals table.
-- HINT: there can be such a thing as too short of a name.
SELECT individual_name, length(individual_name)
FROM animals
ORDER BY length(individual_name) DESC;


SELECT individual_name, length(individual_name)
FROM animals
ORDER BY length(individual_name);

SELECT individual_name, start_date
FROM animals
ORDER BY start_date DESC;
SELECT start_date
FROM animals
ORDER BY start_date;

SELECT individual_name, species.id,start_date
FROM animals
JOIN species
ON species.id=animals.species_id
WHERE start_date = '2015-08-08';

SELECT scientific_name, species.id,start_date
FROM animals
JOIN species
ON species.id=animals.species_id
WHERE start_date = '2015-08-08';

How many are there of each species?
Your answer should report by the common_name of each species, but it may help to start with 
counting the number of animals per species_id.  (10pts)
SELECT COUNT(species_id), common_name
FROM animals
INNER JOIN species
ON animals.species_id= species.id
GROUP BY common_name;

-- As of today, what's the average tenancy (length of stay) at the zoo?
-- HINTS:
-- DATEDIFF(date2, date1) returns number of days of date2 - date1
-- IFNULL(exp1, exp2) returns exp2 if exp1 is null
-- CURDATE() returns the current date of the running MySQL session

SELECT species_id, DATEDIFF(IFNULL(end_date,CURDATE()), start_date)Average_Tenancy_Days
FROM animals

-- Using the animal stats table, tell me the average weight for each individual animal, across all of that 
-- animal's weigh-ins
-- The zoo director is not exactly sure what this would reveal, but wants you to go for it. She adds, "oh, 
-- and I'm not that great with the metric system. Can you report weight in pounds?"
-- Measured weights are in animal_stats table.
-- HINT:

-- ROUND(x, d) 
-- rounds the number x to the nearest d decimal points
-- floor(x)
-- rounds DOWN to the nearest integer
-- % 
-- modulo, returns remainder
(20pts)

SELECT ROUND(AVG(weight)*0.00220462,2) AVG_weight, animal_id, individual_name
FROM animal_stats
INNER JOIN animals
ON animal_stats.animal_id = animals.id
GROUP BY animal_id,individual_name
ORDER BY animal_id;

Which animals have been here since December 01, 2014 or earlier?
HINT: "been here" implies still here

SELECT individual_name, start_date, end_date
FROM animals
WHERE start_date <= '2014-01-01' and end_date IS NULL;

Of the animals who have been here since 11-23-2015, which grew the most, by percentage weight, 
between 12-01-2014 and 11-23-2015, a period where we implemented a new feeding schedule.
HINTS:
use the ids from the last query
assume no gaps in data
use hardcoded earliest and latest dates

(20pts)
SELECT ((old_weight - new_weight)/old_weight)*100 percent_weight, animal_id
FROM
(SELECT old_weight,new_weight,old_wt.animal_id
FROM 
(SELECT  weight old_weight, animal_id
FROM animal_stats
WHERE cal_date = '2014-12-01'
GROUP BY animal_id, weight) old_wt
JOIN 
(SELECT  weight new_weight, animal_id
FROM animal_stats
WHERE cal_date = '2015-11-23'
GROUP BY animal_id, weight) new_wt
ON old_wt.animal_id = new_wt.animal_id) newest_wt
ORDER BY percent_weight DESC;

