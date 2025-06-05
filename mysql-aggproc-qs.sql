-- 1
select CountryCode as '국가코드', count(*) as '도시수' from city group by countrycode with rollup order by count(*) desc limit 15;

-- 2
select CountryCode,  sum(case when population > 2000000 then 1 else 0 end) as 'num of city' from city group by countrycode having `num of city` >= 4 order by `num of city` desc;

-- 3

select count(*) as '총국가수', sum(case when indepYear is null then 1 else 0 end) as '독립년도가 없는 국가', sum(case when indepYear is not null then 1 else 0 end) as '독립년도가 있는 국가' from country;

-- 4

select year(release_date) as '년도', format(count(*),0) as '년도별 봉영화 수', format(sum(case when quarter(release_date) in (1,2) then 1 else 0 end),0) as '상반기 개봉영화수',
 format(sum(case when quarter(release_date) in (3,4) then 1 else 0 end),0) as '상반기 개봉영화수' from box_office
where year(release_date) between 2004 and 2013 group by year(release_date) with rollup order by year(release_date);

-- 5
select
distributor as '배급사', 
count(*) as '총개봉수-2016', 
concat(format(round(sum(sale_amt)/pow(10,8),0),0),'억') as '매출-2016', 
sum(case when quarter(release_date) = 1 then 1 else 0 end) as Q1,
sum(case when quarter(release_date) = 2 then 1 else 0 end) as Q2,
sum(case when quarter(release_date) = 3 then 1 else 0 end) as Q3,
sum(case when quarter(release_date) = 4 then 1 else 0 end) as Q4
from box_office
where year(release_date) = 2016 and sale_amt >= 200000000
group by distributor
having sum(sale_amt) between 10000000000 and 150000000000
order by sum(sale_amt) desc;


-- 6
select if(grouping(movie_type)=0,movie_type,'총계') as '영화유형', concat(format(round((sum(sale_amt)/pow(10,8)),0),0),'억') as '매출' from box_office group by movie_type with rollup order by sum(sale_amt) desc;


-- 7
select continent ,sum(surfaceArea) as totalSurfaceArea from country group by continent order by totalSurfaceArea desc limit 1;
select continent ,sum(population) as totalPopulation from country group by continent order by totalPopulation desc limit 1;
select continent ,count(*) as totalNations from country group by continent order by totalNations desc limit 1;
select continent ,sum(population) as totalPopulation from country group by continent order by totalPopulation limit 1;

-- 8

select year(release_date) as '년도', 
concat(format(truncate(sum(case when ranks <= 20 then sale_amt else 0 end)/pow(10,8),0),0),'억') as '1~20위 매출',
concat(format(truncate(sum(case when ranks > 20 then sale_amt else 0 end)/pow(10,8),0),0),'억') as '나머지 매출',
format(sum(case when ranks > 20 then 1 else 0 end),0) as '20위 이상 영화숫자'
from box_office
where year(release_date) between 2008 and 2018
group by year(release_date)
order by year(release_date);


-- 9
select year(release_date) as '년도', sum(audience_num) as '총 관객수',
format(sum(case when rep_country='한국' then audience_num else 0 end),0) as '한국관객',
format(sum(case when rep_country='미국' then audience_num else 0 end),0) as '미국관객',
format(sum(case when rep_country='일본' then audience_num else 0 end),0) as '일본관객',
format(sum(case when rep_country='영국' then audience_num else 0 end),0) as '영국관객',
format(sum(case when rep_country='프랑스' then audience_num else 0 end),0) as '프랑스관객',
format(sum(case when rep_country='독일' then audience_num else 0 end),0) as '독일관객'
from box_office
where year(release_date) between 2010 and 2019
group by year(release_date)
order by year(release_date) desc;

-- 10
select year(release_date) as '년도',
count(*) as '100만명 이상 영화수',
sum(case when rep_country='한국' then 1 else 0 end) as '한국횟수',
sum(case when rep_country='미국' then 1 else 0 end) as '미국횟수'
from box_office
where audience_num >= 1000000 and year(release_date) >= 2015
group by year(release_date)
order by year(release_date);