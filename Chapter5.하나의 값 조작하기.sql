#code 5-1
SELECT user_id, CASE WHEN register_device = 1 THEN '테스크톱'
				WHEN register_device = 2 THEN '스마트폰'
                WHEN register_device = 3 THEN '애플리케이션'
                END AS device_name
                FROM sql_recipe.mst_users;
                
#U001	테스크톱
#U002	스마트폰
#U003	애플리케이션            


#code 5-2                
SELECT stamp, SUBSTRING_INDEX(SUBSTRING_INDEX(referrer, '/', 3),'/',-1) AS referrer_host
FROM sql_recipe.access_log;

#2016-08-26 12:02:00	www.other.com
#2016-08-26 12:02:01	www.other.net
#2016-08-26 12:02:01	www.other.com


#code 5-3
SELECT stamp, url, SUBSTRING_INDEX(replace(url, SUBSTRING_INDEX(url, '/', 3), ''),'#',1) AS path, right(replace(url, substring_index(url, '?id=', 1), ''),3) AS id
FROM sql_recipe.access_log;

#2016-08-26 12:02:00	http://www.example.com/video/detail?id=001	/video/detail?id=001	001
#2016-08-26 12:02:01	http://www.example.com/video#ref	/video	
#2016-08-26 12:02:01	http://www.example.com/book/detail?id=002	/book/detail?id=002	002

#code 5-4
SELECT stamp, url, substring_index(substring_index(replace(url, concat(SUBSTRING_INDEX(url,'/',3),'/'),''),'/',1), '#', 1) AS path1, replace(substring_index(replace(url, substring_index(url,'/',4),''),'?',1),'/','') AS path2
FROM sql_recipe.access_log;

#2016-08-26 12:02:00	http://www.example.com/video/detail?id=001	video	detail
#2016-08-26 12:02:01	http://www.example.com/video#ref	video	
#2016-08-26 12:02:01	http://www.example.com/book/detail?id=002	book	detail


#code 5-5
SELECT current_date() as dt, current_timestamp() as stamp;

# 2018-06-12	2018-06-12 17:41:16

#code 5-6
SELECT date('2016-01-01') as dt, timestamp('2016-01-01 12:00') AS stamp;

# 2016-01-01	2016-01-01 12:00:00


#code 5-7
SELECT stamp,
extract(YEAR from stamp) AS YEAR,
extract(MONTH from stamp) AS MONTH,
extract(DAY from stamp) AS DAY,
extract(HOUR from stamp) AS HOUR
FROM (SELECT current_timestamp() AS stamp) AS t; 

#2018-06-12 17:19:50	2018	6	12	17


#code 5-8
SELECT stamp, substr(stamp, 1,4) AS year, substr(stamp, 6,2) AS month, substr(stamp, 9,2) AS day, substr(stamp, 12,2) AS hour, substr(stamp, 1, 7) AS y_month
FROM (SELECT CAST('2016-01-01 12:00:00' AS character) AS stamp) AS t;

# 2016-01-01 12:00:00	2016	01	01	12	2016-01



#code 5-9
SELECT purchase_id, amount, coupon, amount - coupon AS discount_amout1, amount - coalesce(coupon,0) AS discount_amout2
FROM sql_recipe.purchase_log_with_coupon;

#10001	3280			    3280
#10002	4650	500	4150	4150
#10003	3870			    3870




