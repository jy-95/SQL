use world;
desc city;

select count(*) as "총레코드개수",
		count(IndepYear) as nn_레코드개수, -- count 안에 컬럼명을 넣을 시 null값 제외
        count(distinct indepyear) as unique_컬럼값개수
from country;

select
countrycode as "국가코드",
count(name) as "도시수" 
from city
group by CountryCode with rollup
order by count(name) desc
limit 15;

select 
CountryCode,
count(name) as "num of city"
from city
where Population > 2000000
group by CountryCode
having count(name) >= 4
order by count(name) desc;

select
count(*) as "총국가수",
count(*)-count(IndepYear) as "독립년도가 없는 국가",
count(indepyear) as "독립년도가 있는 국가"
from country;

select
sum(case ifnull(indepyear, 0) when 0 then 1 else 0 end) as null_n_total
from country;

select
sum(if(indepyear is null,1, 0)) as null_n_total2
from country;

