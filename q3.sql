select 
	department_id as DNO,
	first_name as fname,
	job_id as job,
	salary*12*1300 as year_sal,
	commission_pct
from employees
where commission_pct is not null
order by 5, YEAR_SAL desc 
/
