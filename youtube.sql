
USE project2;

Select * from youtube_data;

-- Modifying table --

select * from youtube_data;

ALTER TABLE youtube_data
MODIFY COLUMN `rank` int not null;

ALTER TABLE youtube_data
MODIFY COLUMN `video views` text not null;



SET SQL_SAFE_UPDATES = 0;

update youtube_data
set `video views` = REPLACE(`video views`,',','');

ALTER TABLE youtube_data
MODIFY COLUMN `video views` bigint not null;

ALTER TABLE youtube_data
MODIFY COLUMN `video views` bigint not null;

-- Counting Dataset -- 

Select COUNT(`rank`) from youtube_data;

-- Oldest 5 channel -- 

SELECT `rank`, youtuber, started 
from  youtube_data
ORDER BY started ASC
LIMIT 5;

-- Latest 5 Channels--

SELECT `rank`, youtuber, started 
from  youtube_data
ORDER BY started DESC
LIMIT 5;

-- Channel with maximum subscriber ---

SELECT `rank`, youtuber, started, max(subscribers)
from  youtube_data
ORDER BY subscribers asc;

-- Top 5 subscribers with maxmum subscriber ---

SELECT `rank`, youtuber, started,subscribers
from  youtube_data
ORDER BY subscribers DESC
LIMIT 5;

-- Top 5 channels with maximum video views--

SELECT `rank`, youtuber, started,`video views`
from  youtube_data
ORDER BY `video views` DESC
LIMIT 5;

-- Youtube channels by category--

Select category, count(youtuber) as `Channel_count`
From youtube_data
GROUP BY category
ORDER BY COUNT(youtuber) DESC;

-- DESCRIBE TABLE--
DESCRIBE youtube_data;

-- Youtube channels by video views--

Select category, count(youtuber) as `Channel_count`, sum(`video views`)
From youtube_data
GROUP BY category
ORDER BY COUNT(youtuber) DESC;

-- Youtube channels by subscribers--

Select category, count(youtuber) as `Channel_count`, sum(`subscribers`) as 'subscribers'
From youtube_data
GROUP BY category
ORDER BY sum(`subscribers`) DESC;














