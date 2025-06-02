use world;

select 
lpad(round(rand()*1000), 3, 0) as '난수 3자리';

select 
concat_ws(' : ', countrycode, district, name) as '\'한미일\'에서 인구 top10 도시명',
concat(format(population,0), '명') as '인구'
from city
where countrycode in ('kor', 'usa', 'jpn')
order by population desc
limit 10; 

select 
city_info,
left(city_info,3) as '국가코드',
substring_index(city_info, ' ', -1) as '인구'
from t_city;

select
now() as '특정날짜',
last_day(now()) as '특정날짜의 마지막일',
dayname(last_day(now())) as '요일',
date_format(last_day(now()), '%W') as '요일'; 


