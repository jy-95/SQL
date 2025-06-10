select 
E.employee_id as 사원번호, 
E.first_name as 사원명, 
E.job_id as 직무ID, 
to_char(E.salary*12,'$999,999,999') as 연봉, 
D.department_name as 부서명,
L.city as 도시,
c.country_name as 국가,
r.region_name as 대륙
from employees E
JOIN  departments D on E.first_name in ('Susan', 'Pat', 'Adam') and E.department_id = d.department_id
JOIN locations L on d.location_id = l.location_id
JOIN countries C on l.country_id = c.country_id
JOIN regions R on c.region_id = r.region_id;

select * from employees where department_id is null;

select department_name from departments D where department_id not in (
    select distinct department_id from employees where department_id is not null
);

select * from employees E
left outer join departments D on e.department_id = D.department_id;

select * from employees E
full outer join departments D on e.department_id = D.department_id;


select sum(case when cnt>0 then 1 else 0 end) as "부서가 있는 도시 수(O)", sum(case when cnt=0 then 1 else 0 end) as "부서가 없는 도시 수(X)" from (
select L.location_id, sum(case when D.department_id is not null then 1 else 0 end) as cnt
from locations L
left outer join departments D on L.location_id = d.location_id
group by L.location_id);

select '사번 ' || E.employee_id || '번 직원의 성명은 ' || E.first_name || ' ' || E.last_name || ' 이고, 해당직원의 직속 관리자는 ' || decode(E.manager_id, null, '본인', M.first_name || ' ' || M.last_name) as "Manager" 
from employees E
join employees M on E.manager_id = M.employee_id;
