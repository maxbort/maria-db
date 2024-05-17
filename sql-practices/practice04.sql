-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재, 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?

select count(*)
from salaries
where salary> (select avg(salary)
	from salaries
	where to_date = '9999-01-01')
and to_date = '9999-01-01';

-- 문제2. (x)
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요.
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 

-- 문제3.
-- 현재, 자신의 부서 평균급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 

select a.emp_no, concat(a.first_name,' ', a.last_name), c.salary
from employees a, dept_emp b, salaries c, (select avg(a.salary) as avg_salary, dept_no
				from salaries a
				join dept_emp b on a.emp_no = b.emp_no
                where a.to_date = '9999-01-01'
                and b.to_date = '9999-01-01'
				group by b.dept_no) d
where a.emp_no = b.emp_no
and b.dept_no = d.dept_no
and c.emp_no = a.emp_no
and c.salary > d.avg_salary
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01';



-- 문제4.
-- 현재, 사원들의 사번, 이름, 자신의 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no, concat(a.first_name, ' ', a.last_name) as name,
		concat(d.first_name, ' ', d.last_name) as manage_name,
        e.dept_name
from employees a
join dept_emp b on a.emp_no = b.emp_no
join dept_manager c on b.dept_no = c.dept_no
join employees d on d.emp_no = c.emp_no
join departments e on c.dept_no = e.dept_no
where b.to_date = '9999-01-01'
and c.to_date = '9999-01-01';



    

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no, concat(a.first_name, ' ', a.last_name), b.title, e.salary
from employees a
join titles b on a.emp_no = b.emp_no
join dept_emp c on a.emp_no = c.emp_no
join departments d on c.dept_no = d.dept_no
join salaries e on a.emp_no = e.emp_no
where c.dept_no = (select b.dept_no
								from salaries a
                                join dept_emp b on a.emp_no = b.emp_no
                                where a.to_date = '9999-01-01'
                                and b.to_date = '9999-01-01'
                                group by dept_no
                                order by avg(a.salary) desc
                                limit 0, 1)
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and e.to_date = '9999-01-01'
order by e.salary desc;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
-- 영업 20000
select a.dept_name, b.avg_salary
from departments a
join (select avg(b.salary) as avg_salary, dept_no
from employees a
join salaries b on a.emp_no = b.emp_no
join dept_emp c on a.emp_no = c.emp_no
where c.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by c.dept_no
order by avg_salary desc
limit 0,1) b on a.dept_no = b.dept_no;



-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select a.title, b.avg_salary
from titles a
join (select avg(b.salary) as avg_salary, c.title
from employees a
join salaries b on a.emp_no = b.emp_no
join titles c on a.emp_no = c.emp_no
where c.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by c.title
order by avg_salary desc
limit 0,1) b on a.title = b.title
group by title;




-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저이름, 매니저연봉 순으로 출력합니다.

select c.dept_name as '부서명', concat(a.first_name, ' ', a.last_name) as '사원이름', d.salary as '연봉', 
			concat(e.first_name, ' ', e.last_name) as '매니저이름', f.salary as '매니저 연봉'
from employees a
join dept_emp b on a.emp_no = b.emp_no
join departments c on b.dept_no = c.dept_no
join salaries d on a.emp_no = d.emp_no
join dept_manager k on b.dept_no = k.dept_no
join employees e on k.emp_no = e.emp_no
join salaries f on e.emp_no = f.emp_no
where f.salary < d.salary
and b.to_date = '9999-01-01'
and d.to_date = '9999-01-01'
and k.to_date = '9999-01-01'
and f.to_date = '9999-01-01';



