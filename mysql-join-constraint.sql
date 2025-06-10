-- Q-Join.. constraint..
-- 1
SELECT 
TABLE_NAME as '테이블명',
COLUMN_NAME as '컬럼명',
CONSTRAINT_NAME as '제약조건명',
if(REFERENCED_TABLE_NAME is null, 'PRIMARY KEY','FOREIGN KEY') as '제약조건 타입',
REFERENCED_TABLE_NAME as '참조테이블명',
REFERENCED_COLUMN_NAME as '참조컬럼명'
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'world';


-- 2
select C.name as '도시명', C.population as '도시인구', C.District as '지역명(도)', CL.language as '언어', CL.Percentage as '언어-사용비율', CO.name as '국가명', CO.Code as '국가코드', CO.Region as '국가위치', CO.Continent as '대륙명'
from city C
join country CO on C.population >= 5000000 and CO.continent in ('North America', 'Asia', 'Europe') and C.CountryCode=CO.Code
join countryLanguage CL on CL.Percentage >= 50 and CO.Code=CL.CountryCode
order by C.population desc;