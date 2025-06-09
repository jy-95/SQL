use world;
select
ct.countrycode,
cr.name,
district,
ct.name,
ct.population
from city ct, country cr
where ct.countrycode = cr.code
order by ct.countrycode;

select
name,
language,
isofficial,
percentage
from countrylanguage cl, country cr
where cl.countrycode = cr.code
order by name;

select
cr.name,
count(*) 
from city ct, country cr
where ct.countrycode = cr.code 
group by cr.name
having count(*) between 60 and 150
order by count(*) desc;

select 
country.name as '국가명', 
count(*) as '도시갯수' 
from city 
join country on city.countrycode 
in 
(select 
a.code as code 
from country a 
join city b 
on a.code = b.CountryCode 
group by a.code 
having count(*) between 60 and 150) 
and city.CountryCode = country.code 
group by country.name with rollup 
order by count(*) desc;
