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

select
row_number()over(order by indepyear) as "No.",
name as "국가명",
case when indepyear<0 then concat("BC ",indepyear*-1)
else concat("AD ", indepyear)
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
and years = "2019";
-- order by sale_amt desc;

select
*
from box_office
where years = "2014" and (date_format(release_date, '%Y') between "2018" and "2019");

select
*
from box_office
where years = "2014" and year(release_date) between "2018" and "2019";

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

select
years as "제작년도",
movie_name as "영화명",
rep_country as "배포국가",
date_format(release_date, '%Y%m') as "개봉년월",
format(audience_num,0) as "관객수",
concat(round(sale_amt / 100000000), "억원") as "총매출"
from box_office
where year(release_date) between "2018" and "2019"
and audience_num > 10000000 and rep_country in ("한국", "미국")
order by sale_amt desc;



# 4-1
desc box_office;
select -- movie_name, release_date,
		-- release_date, 
        year(release_date),
        format(count(*),0) as Total_n,
        sum(case when quarter(release_date) in (1,2) then 1 else 0 end) as "상반기 개봉영화수",
        sum(case when quarter(release_date) in (3,4) then 1 else 0 end) as "하반기 개봉영화수" 
from box_office
where year(release_date) between 2004 and 2013
group by year(release_date) with rollup
order by 1;


# 4-2
select
year(release_date) as "년도",
format(count(*),0) as "년도별 개봉영화 수",
sum(case when date_format(release_date, '%w') = 0 then 1 else 0 end) as "일-개봉",
sum(case when date_format(release_date, '%w') = 1 then 1 else 0 end) as "월-개봉",
sum(case when date_format(release_date, '%w') = 2 then 1 else 0 end) as "화-개봉",
sum(case when date_format(release_date, '%w') = 3 then 1 else 0 end) as "수-개봉",
sum(case when date_format(release_date, '%w') = 4 then 1 else 0 end) as "목-개봉",
sum(case when date_format(release_date, '%w') = 5 then 1 else 0 end) as "금-개봉",
sum(case when date_format(release_date, '%w') = 6 then 1 else 0 end) as "토-개봉"
from box_office
where year(release_date) between 2004 and 2013
group by year(release_date) with rollup
order by 1;

# 5
-- use youDB;
select
distributor,
count(*) as "총개봉수-2016",
concat(format(round(sum(sale_amt) / 100000000),0), "억") as "매출-2016",
sum(case when quarter(release_date) = 1 then 1 else 0 end) as "Q1",
sum(case when quarter(release_date) = 2 then 1 else 0 end) as "Q2",
sum(case when quarter(release_date) = 3 then 1 else 0 end) as "Q3",
sum(case when quarter(release_date) = 4 then 1 else 0 end) as "Q4"
from box_office
where year(release_date) = "2016" and sale_amt > 2*pow(10,8)
group by distributor
having sum(sale_amt) div pow(10,8) > 100 and sum(sale_amt) div pow(10,8) < 1500
order by round(sum(sale_amt) / 100000000) desc;

# 6
select
(case when grouping (movie_type) = 1 then "총계" else movie_type end )as "영화유형",
concat(format(round(sum(sale_amt) / pow(10,8)),0),"억") as "매출"
from box_office
group by movie_type with rollup
order by sum(sale_amt) desc;

# 7
use world;
desc country;
select
continent,
sum(surfaceArea) as "면적",
sum(population) as "인구",
count(*) as "국가"
from country
group by continent
-- order by sum(surfaceArea) desc;
order by sum(population) desc;

# 8
select 
year(release_date) as "년도",
concat(format(sum(case when ranks between 1 and 20 then sale_amt end) / pow(10,8), 0), "억") as "1~20위 매출",
concat(format(sum(case when ranks >20 then sale_amt end) / pow(10,8), 0), "억") as "나머지 매출",
format(sum(case when ranks > 20 then 1 else 0 end),0) as "20위 이후 영화숫자"
from box_office
where year(release_date) between 2008 and 2018
group by year(release_date)
order by year(release_date);

# 9
select
year(release_date) as "년도",
format(sum(audience_num),0) as "총관객수",
format(sum(case when rep_country = "한국" then audience_num end),0) as "한국 관객",
format(sum(case when rep_country = "미국" then audience_num end),0) as "미국 관객",
format(sum(case when rep_country = "일본" then audience_num end),0) as "일본 관객",
format(sum(case when rep_country = "영국" then audience_num end),0) as "영국 관객",
format(sum(case when rep_country = "프랑스" then audience_num end),0) as "프랑스 관객",
format(sum(case when rep_country = "독일" then audience_num end),0) as "독일 관객"
from box_office
where year(release_date) between 2010 and 2019
group by year(release_date)
order by year(release_date) desc;

# 10
select
year(release_date) as "년도",
count(*) as "100만명 이상 영화수",
sum(case when rep_country = "한국" then 1 else 0 end) as "한국횟수",
sum(case when rep_country = "미국" then 1 else 0 end) as "미국횟수"
from box_office
where year(release_date) > 2014 and audience_num > 1000000
group by year(release_date)
order by year(release_date);


use world;
desc country;
select 



