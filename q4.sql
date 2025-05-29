select
	employee_id as eno,
	last_name || ', ' || first_name as ename,
	email || '@scit.master' as email,
	-- salary*12 as year_sal,
	to_char(salary * 12, '$999,999') as year_sal
 from employees
where salary*12 >=150000
/
