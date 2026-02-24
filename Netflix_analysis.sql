CREATE TABLE netflix (
    show_id VARCHAR(10),
    type VARCHAR(10),         
    title varchar(150),
    director varchar(210),
	casts varchar(1000),
    country varchar(150),
	date_added varchar(50),
    release_year INT,
    rating VARCHAR(10),
	duration varchar(15),
	listed_in varchar(100),
	description varchar(250)
);

drop table  if exsits  netflix

select * from netflix 
limit 5




--Q) Which type of content is more on Netflix?

SELECT 
    type,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY type;

-- Q) What is the most common rating for Movies and TV Shows?

SELECT 
    type,
    rating,
    COUNT(*) AS rating_count
FROM netflix
GROUP BY type, rating
ORDER BY type, rating_count DESC;


--Q)  Which countries produce the most Netflix content?

SELECT 
    country,
    COUNT(*) AS no_of_content
FROM (
    SELECT TRIM(UNNEST(string_to_array(country, ','))) AS country
    FROM netflix
    WHERE country IS NOT NULL
) t
GROUP BY country
ORDER BY no_of_content DESC
LIMIT 5;





--Q) 👉 Which actors appear in the highest number of Netflix titles?
select 
	casts ,
	count(*) as total_film_acted
from (
	select TRIM(UNNEST(string_to_array(casts,','))) as casts
	from netflix
	where casts is not null 
	and 
	-- based on the need we can specify the condition here  
)t
group by casts
order by total_film_acted desc
limit 100


--Q)    “List all cast members along with the count of Movies and TV Shows they have appeared in, based on the Netflix dataset.”

select 
	casts,
	count(*) as total_acted,
	type
from (
	select trim(unnest(string_to_array(casts,',' ))) as casts, type
	from netflix
	where casts is  not null
)t
-- where casts = 'Takahiro Sakurai'
group by casts ,type
order by total_acted desc
limit 50

-- notes **- the where condition is written before group by clause  and can also be written in temp table (from ) if want to filter whie processing 
--**** outer group by is written when we need to filter after the temperory table is formed .



-- or---

SELECT 
    casts,
    COUNT(*) AS total_titles,

    COUNT(
	CASE
	WHEN type = 'Movie' THEN 1
	END) AS movies,
	
    COUNT(CASE  WHEN  type = 'TV Show' Then 1 end) as tv_shows

FROM (
    SELECT 
        TRIM(UNNEST(string_to_array(casts, ','))) AS casts,
        type
    FROM netflix
    WHERE casts IS NOT NULL
) t
GROUP BY casts
ORDER BY total_titles DESC
LIMIT 50;






-- 

