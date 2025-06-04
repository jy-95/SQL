use world;
desc country;

select
row_number()over(order by population desc) as "No.",
code as "국가코드",
concat(name, " <", continent, ">") as "국가<대륙>",
region as "대륙내 지역",
format(population, 0) as "인구"
from country
where population between 40000000 and 60000000
order by population desc;

select
row_number()over(order by indepyear) as "No.",
name as "국가명",
case when indepyear like "-%" then concat("BC ",substr(indepyear,2))
	 else concat("AD ", substr(indepyear,1))
     end as "개국년도"
from country
where indepyear is not null
limit 10;

use youDB;
desc box_office;

select
row_number() over(order by sale_amt desc) as "No.",
years as "년도",
movie_name as "영화제목",
date_format(release_date, '%Y-%M-%d')  as "개봉일",
concat(format(audience_num,0), "명") as "관객수",
concat(round(sale_amt / 100000000), "억") as "총매출"
from box_office
where (audience_num between 3000000 and 7000000 
or sale_amt between 18000000000 and 50000000000)
and years = "2019"
order by sale_amt desc;

select
*
from box_office
where years = "2014" and (date_format(release_date, '%Y') between "2018" and "2019");

select
distinct movie_name as "영화",
date_format(release_date, '%Y%m') as "개봉년월",
replace(director, ",", "/") as "감독그룹"
from box_office
where date_format(release_date, '%Y-%m') = '2017-11' 
and director like "%,%"
and movie_name like "%:%";

select
years as "제작년도",
movie_name as "영화명",
rep_country as "배포국가",
date_format(release_date, '%Y%m') as "개봉년월",
format(audience_num,0) as "관객수",
concat(round(sale_amt / 100000000), "억원") as "총매출"
from box_office
where (date_format(release_date, '%Y') between "2018" and "2019")
and audience_num > 10000000 and rep_country in ("한국", "미국")
order by sale_amt desc;