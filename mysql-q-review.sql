-- q-review

-- 1
select ROW_NUMBER() OVER (ORDER BY POPULATION DESC) as "No.", Code as "국가코드", concat(Name, ' <', Continent, '>') as "국가 <대륙>", Region as "대륙내 지역", format(population,0) as "인구" from country where population between 40000000 and 60000000;

-- 2
select ROW_NUMBER() OVER (ORDER BY INDEPYEAR) as "No.", name as "국가명", case when IndepYear < 0 then concat("BC ", IndepYear*-1) when IndepYear >= 0 then concat("AD ", IndepYear) end as "개국년도" from country where IndepYear is not null limit 10;

-- 3
select ROW_NUMBER() OVER (ORDER BY AUDIENCE_NUM DESC) as "No.", years as "제작년도", movie_name as "영화제목", date_format(release_date, "%Y-%b-%e") as "개봉일",
concat(format(audience_num, 0), "명") as "관객수", concat(round(sale_amt/100000000, 0), '억') as "총매출"
from box_office
where year(release_date)=2019 and ((audience_num between 3000000 and 7000000) or (sale_amt between 18000000000 and 50000000000));

-- 4
select * from box_office
where years=2014 and year(release_date) between 2018 and 2019;
 
-- 5
select distinct movie_name as "영화", date_format(release_date, "%Y%m") as "개봉년월", replace(director, ',','/') as "감독그룹"
from box_office
where (year(release_date), month(release_date))=(2017,11) and director like '%,%' and movie_name like '%:%';

-- 6
select years as "제작년도", movie_name as "영화명", countries, date_format(release_date, "%Y%m") as "개봉년월", format(audience_num,0) as "관객수", concat(round(sale_amt/100000000, 0), '억원') as "매출" from box_office
where audience_num > 10000000 and (year(release_date) between 2018 and 2019) order by audience_num desc;