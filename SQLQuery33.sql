create TABLE appleStore_description_combined AS

SELECT * FROM appleStore_description1

UNION ALL

SELECT * FROM appleStore_description2

union all 

select * from appleStore_description3

union all 

SELECT * from appleStore_description4


                         ***Exploratory data analysis***
                         
SELECT COUNT(DISTINCT id) as UniqueAppIDs
FROM AppleStore

SELECT COUNT(DISTINCT id) as UniqueAppIDs
FROM appleStore_description_combined

-- check for any missing values in key fields--

SELECT COUNT(*) as MissingValues
FROM AppleStore
WHERE track_name is null or user_rating is null or prime_genre is null 


SELECT COUNT(*) as MissingValues
FROM appleStore_description_combined
WHERE app_desc is null

-- Find out the number of apps per genre-- 

SELECT prime_genre, COUNT(*) as NumApps
FROM AppleStore 
GROUP by prime_genre 
ORDER by NumApps DESC 

--get the overview of the apps rating 

SELECT min(user_rating) as MinRating,
       max(user_rating) as Maxrating,
       avg(user_rating) as Avgrating
FROM AppleStore       


-- Determine whether paid apps have higher rating than the free app

SELECT CASE
           WHEn price > 0 THEN 'paid'
           else 'free'
           END as App_type,
           avg(user_rating) as Avg_Rating
FROM AppleStore
GROUP by App_type

--check if app with more supported language have higher rating

SELECT CASE 
           WHEN lang_num < 10 then '<10 languages'
           WHEN lang_num BETWEEN 10 and 30 then '<10-30 languages'
           else '>30 languages'
      end as language_bucket,
      avg(user_rating) as Avg_Rating
From AppleStore
GROUP BY language_bucket
ORDER BY Avg_Rating DESC
      
--Check genere with low ratingsAppleStore

SELECT prime_genre,
       avg(user_rating) as Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating DESC
LIMIT 10 

--check if there is correlation between the lenght of the app desctiption and the user ratingAppleStore

SELECT case 
           WHEn length(b.app_desc) < 500 then 'short'
           WHEn length(b.app_desc)BETWEEN  500 and 1000  then 'medium'
           ELSE 'long'
       end as description_lenght_bucket,
       avg(a.user_rating) as average_rating

FROM
     AppleStore as A 
join 
     appleStore_description_combined as b 
on 
     a.id = b.id 
group by description_lenght_bucket
ORDER by average_rating DESC 
     
     