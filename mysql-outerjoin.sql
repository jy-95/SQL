-- Q-Outer Join
-- 1
select continent, count(distinct country.name) as '국가수', count(city.name) as '도시수' from country left outer join city on country.code = city.countrycode group by continent
order by `국가수` desc;

-- 2
select continent, name from country left outer join countryLanguage on country.code = countryLanguage.countrycode where countryLanguage.Language is null;