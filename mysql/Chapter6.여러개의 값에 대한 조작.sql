use sql_recipe;
# CODE 6-1
SELECT user_id, CONCAT(pref_name,' ',city_name) AS pref_city
FROM mst_user_location;

#U001	서울특별시강서구
#U002	경기도수원시장안구
#U003	제주특별자치도서귀포시

# CODE 6-2
SELECT year, q1, q2,
	CASE
		WHEN q1 < q2 THEN '+'
        WHEN q1 = q2 THEN ' '
        ELSE '-'
	END AS judge_q1_q2
    , q2 - q1 AS diff_q2_q1
    , SIGN(q2 - q1) AS sign_q2_q1
FROM quarterly_sales
order by year;

#2015	82000	83000	+	1000	1
#2016	85000	85000	 	0	0
#2017	92000	81000	-	-11000	-1

## SIGN()은 변수값의 부호를 검정해준다.

# CODE 6-3
SELECT
	year, greatest(q1,q2,q3,q4) AS greatest_sales, least(q1,q2,q3,q4) AS least_sales
FROM quarterly_sales
ORDER BY year;

#2015	83000	78000
#2016	85000	80000
#2017		


# CODE 6-4
SELECT 
	year, (q1+q2+q3+q4)/4 AS average
FROM quarterly_sales
ORDER BY year;

#2015	81500.0000
#2016	82750.0000
#2017	

# CODE 6-5
SELECT 
	year, (coalesce(q1,0)+coalesce(q2,0)+coalesce(q3,0)+coalesce(q4,0))/4 AS average
FROM quarterly_sales
ORDER BY year;

#2015	81500.0000
#2016	82750.0000
#2017	43250.0000

# CODE 6-6 
SELECT 
	year, (coalesce(q1,0)+coalesce(q2,0)+coalesce(q3,0)+coalesce(q4,0))/(sign(coalesce(q1,0))+sign(coalesce(q2,0))+sign(coalesce(q3,0))+sign(coalesce(q4,0))) AS average
FROM quarterly_sales
ORDER BY year;

#2015	81500.0000
#2016	82750.0000
#2017	86500.0000

# CODE 6-7

SELECT dt, ad_id, clicks/impressions AS ctr
FROM advertising_stats
WHERE dt = '2017-04-01'
ORDER BY dt, ad_id;


#2017-04-01	001	0.0300
#2017-04-01	002	0.0100
#2017-04-01	003	0.0200

# CODE 6-8
SELECT dt, ad_id,
	CASE
		WHEN impressions > 0 THEN 100.0 * clicks / impressions
	END AS ctr_as_percent_by_case
    ,100.0 * clicks / NULLIF(impressions,0) AS ctr_as_precent_by_null
FROM advertising_stats
ORDER BY dt, ad_id;
        
#2017-04-01	001	3.00000	3.00000
#2017-04-01	002	1.00000	1.00000
#2017-04-01	003	2.00000	2.00000
#2017-04-02	001		
#2017-04-02	002	1.07692	1.07692
#2017-04-02	003	2.41935	2.41935

# CODE 6-9
SELECT abs(x1 - x2) AS abs, sqrt(power(x1 -x2, 2)) AS rms
FROM location_1d;

#5	5
#5	5
#6	6
#0	0
#1	1

#CODE 6-10
SELECT sqrt(power(x1-x2,2) + power(y1-y2,2)) as dist
FROM location_2d;

#2.8284271247461903
#3.605551275463989
#3.605551275463989

#CODE 6-11
SELECT 
	user_id, 
	timestamp(register_stamp) AS register_stamp,
    timestampadd(hour, 1, timestamp(register_stamp)) AS after_1_hour,
    timestampadd(minute,-30,timestamp(register_stamp)) AS before_30_minute,
    date(timestamp(register_stamp)) AS register_date,
    date_add(date(timestamp(register_stamp)), interval 1 day) AS after_1_day,
    date_sub(date(timestamp(register_stamp)), interval 1 month) AS before_1_month
FROM mst_users_with_birthday;

#U001	2016-02-28 10:00:00.000000	2016-02-28 11:00:00.000000	2016-02-28 09:30:00.000000	2016-02-28	2016-02-29	2016-01-28
#U002	2016-02-29 10:00:00.000000	2016-02-29 11:00:00.000000	2016-02-29 09:30:00.000000	2016-02-29	2016-03-01	2016-01-29
#U003	2016-03-01 10:00:00.000000	2016-03-01 11:00:00.000000	2016-03-01 09:30:00.000000	2016-03-01	2016-03-02	2016-02-01

#CODE 6-12
SELECT user_id, current_date() AS today, date(register_stamp) AS register_date, datediff(current_date(), date(register_stamp)) AS diff_days
FROM mst_users_with_birthday;

#U001	2018-07-06	2016-02-28	859
#U002	2018-07-06	2016-02-29	858
#U003	2018-07-06	2016-03-01	857

#CODE 6-13




