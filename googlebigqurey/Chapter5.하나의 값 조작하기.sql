# data input
INSERT INTO `sql_recipe.mst_users`(user_id,register_date,register_device)
VALUES ("U001", "2016-08-26", 1)
  ,('U002', '2016-08-26', 2)
  ,('U003', '2016-08-27', 3) ;

INSERT INTO `sql_recipe.access_log` (stamp,referrer,url)
VALUES
    ('2016-08-26 12:02:00', 'http://www.other.com/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video/detail?id=001')
  , ('2016-08-26 12:02:01', 'http://www.other.net/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video#ref'          )
  , ('2016-08-26 12:02:01', 'https://www.other.com/'                               , 'http://www.example.com/book/detail?id=002' )
;


#code 5-1
SELECT
  user_id,
  CASE
    WHEN register_device = 1 THEN '데스크톱'
    WHEN register_device = 2 THEN '스마트폰'
    WHEN register_device = 3 THEN '애플리케이션'
  END AS device_name
FROM
  `sql_recipe.mst_users`

#result 5-1
  Row	user_id	device_name
  1	U002	스마트폰
  2	U001	데스크톱
  3	U003	애플리케이션

#code 5-2
SELECT stamp, host(referrer) AS referrer_host
FROM sql_recipe.access_log;
