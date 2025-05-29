select * from(
select rownum as rank, id, full_name, job, hr$, num_yy_hired from
(
select employee_id as ID, first_name || ', ' || last_name as full_name, job_id as JOB, to_char(salary/160, '$999999') as HR$, trunc(months_between(sysdate, hire_date)/12) || ' years' as num_yy_hired from employees order by salary desc)
)
where rank BETWEEN 15 and 25