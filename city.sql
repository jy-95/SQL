use world;

select
concat_ws(':' ,'KOREA', name) as 'R.O.K'
from city
where countrycode = 'jpn';

select ceil(5.146);
select floor(5.146);

desc city;
select length('jwc정');

select format(population, 0),
population from city
order by 2 desc;

select concat(name, countrycode) as c_name,
instr(concat(name,countrycode), 'usa')as 'instr()'
from city
where countrycode = 'usa';

select locate('db' , 'rdbs are mariadb&mysql', 1);
select position('db' in 'rdbs are mariadb&mysql');