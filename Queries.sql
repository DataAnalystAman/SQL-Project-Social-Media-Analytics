use socialMedia;
select * from users;
select * from post;

select * from post p
where p.location = "mumbai";

delete from post where post_id is null;

select * from post p
where p.location != "mumbai";

select * from post p
where p.location in ("mumbai", "pune", "jaipur", "Delhi", "Kolkata");

select * from users
order by user_id desc;


-- ------------------------ string functions ------------------------
select * from users;

select * from users where bio like "%Bollywood%";  -- users whose bio is related to bollywood

select u.username, u.user_id from users u
where u.username like "bolly%";  --  username and id of users whoes username starts with "bolly"

select u.user_id, substring(u.profile_photo_url, 23) as Photo_profile_number
from users u;


select u.user_id, u.username, length(u.username) as username_length
from users u
order by username_length desc;

select u.user_id, u.username, length(u.username) as username_length
from users u
order by 3 desc;  -- refers to 3rd coloum


-- views in date time as a string (concat, type casting to timestamp or view created)
select concat(p.date,'        ', p.time) from photos p; 
select timestamp(concat(p.date,' ', p.time)) from photos p;

create or replace view photos_times as 
select p.photo_id,p.post_id,p.size, timestamp(concat(p.date,' ', p.time)) as create_time from photos p;

select * from photos_times;

-- ---------------------------- numeric functions -----------------------------
select * from post;
select * from post_likes;

select user_id, count(user_id) as Number_of_post_likes
from post_likes pl
group by pl.user_id;

select * from users
where mod(user_id, 2) = 0; -- will return multiple of 2 or else 0 (even number)

select * from users
where mod(user_id, 2) = 1; -- will return odd numbers 


-- -------------------- Date and Time Functions ---------------------
select * from photos_times;

select post_id,create_time from photos_times 
where create_time >=  timestamp("2023-01-01")
and create_time <  timestamp("2023-02-01");  -- photos created in jan using >= and <

select post_id,create_time from photos_times 
where create_time  between timestamp("2023-01-01") and timestamp("2023-02-01"); -- photos created in jan using between

 select sysdate(); -- 2024-04-14 18:03:52
select post_id,create_time from photos_times 
where create_time <= sysdate();

select post_id,create_time from photos_times 
where create_time <= date_sub(sysdate(), interval 14 month)
order by 2 desc;

-- ----------------------- Aggregate Functions ----------------
select max(create_time) from photos_times;

select min(create_time) from photos_times;

-- ------------------------Window Functions-------------------------

-- -----------------------Control Flow Functions------------------
select * from post;

select user_id, post_id, location,
row_number() over (order by location desc) as location_number
from post order by location;

select user_id, post_id, location,
row_number() over (order by post_id asc) as post_id_number
from post 
where mod(post_id, 2) = 0
order by post_id;

select user_id, post_id,
rank() over (order by user_id) as ranking
from post_likes;  -- 1,1,1,4,4,6......

select user_id, post_id,
dense_rank() over (order by post_id) as dens_ranking
from post_likes;  -- 1,1,1,2,2,3......

select user_id, post_id,
ntile(4) over (order by post_id) as quaterile
from post_likes;  -- divide in 4 section

-- ----------------------------------- User Defined Functions --------------------
select * from videos;

select *, case size
when 1 then "small"
when 2 then "small"
when 3 then "small"
when 4 then "medium"
when 5 then "medium"
else "large"
end as video_size
from videos;

select *, case
when size <= 3 then "Small"
when size in (4,5) then "Medium"
when size >= 6 then "Large"
end as video_size
from videos;

-- --------------------------- joins -----------------------------
select * from users;
select * from post;
select * from comments;

-- find of users names , userid, emails who make videos size 3
select u.user_id, u.username, u.email, v.size
from users u
join
post p on u.user_id = p.user_id
join
videos v on p.user_id = v.video_id
where v.size >= 3
order by v.size desc;

-- post which has more then 5 comments
select * from post p
join 
(select post_id, count(*) as cn from comments
group by post_id) cmt 
on p.post_id = cmt.post_id
where cmt.cn >= 5;

-- ----------------------------- Subqueries ----------------------
select * from users;
select * from post;

-- post of users with bolly username
select user_id from users u
where u.username like "bolly%" ;

select * from post p
where p.user_id in (7,12,23,32,44,49) ;

select * from post p
where p.user_id in 
(select user_id from users u
where u.username like "bolly%");

-- ----------------------Common Table Expressions(CTE)------------------------
with bolly as
(select user_id from users u
where u.username like "bolly%")
select * from bolly;

with bolly as
(select user_id from users u
where u.username like "bolly%")
select * from post p
join bolly on p.user_id = bolly.user_id  -- CTE with join



