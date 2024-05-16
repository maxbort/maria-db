--
-- subQuery
-- 조인으로 같은 결과를 낼 수 있다.
-- 데이터 양이 많으면 조인보다 좋은 성능
--

-- 1) select 절, insert into t1 values(...)
--
-- insert into board values(null, (select max(group_no) + 1 from board), ..., ..);

-- select (select 1+2 from dual) from dual;
-- select a.* from (select 1+2 from dual) a;

--
-- 2) from 절의 subquery
--
select now() as n, sysdate() as s, 3 + 1 as r from dual;

select * from (select now() as n, sysdate() as s, 3 + 1 as r from dual) a;

--
-- 3) where 절의 subquery
--

-- 예제) 현재, Fai Bale이 근무하는 부서에서 근무하는 다른 지구언의 사번, 이름을 출력
select a.emp_no, concat(first_name, ' ' , last_name),b.dept_no
from employees a
join dept_emp b on a.emp_no = b.emp_no
where dept_no = (select b.dept_no
		from employees a
        join dept_emp b on a.emp_no = b.emp_no
        where concat(first_name, ' ', last_name) = 'Fai Bale'
        and b.to_date = '9999-01-01')
	and b.to_date = '9999-01-01';

-- 3-1) 단일 행 연산자 : =, >, <, >=, <=, <>(!=), 
-- 실습문제 1
-- 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여를 출력 하세요.
select first_name, b.salary
from employees a
join salaries b on a.emp_no = b.emp_no
where b.to_date = '9999-01-01'
and b.salary < (select avg(salary)
				from salaries
                where to_date = '9999-01-01')
order by b.salary desc;

-- 실습문제 2
-- 현재, 직책별 평균 급여 중에 가장 작은 직책의 직책 이름과 그 평균 급여를 출력해 보세요.
-- 1. 직책별 평균 급여
-- 2. 직책별 가장 적은 평균 급여
-- 3. sol) 서브쿼리 사용해서 문제 해결
-- 집계함수 앞에는 다른 컬럼이 들어가선 안된다.
-- 테이블 전체를 묵시적으로 group by 대상으로 생각하고 집계 함수를 적용하므로
--  Select 절에는 집계 함수 외에는 다른 컬럼이 올 수가 없습니다.

-- 1) 
select avg(salary), title
from salaries a 
join employees b on a.emp_no = b.emp_no
join titles c on b.emp_no = c.emp_no
where a.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
group by c.title;

-- 2)
select min(avg_salary)
from (
	select avg(salary) as avg_salary,title
	from salaries b
	join titles c on b.emp_no = c.emp_no
	where b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
	group by c.title) as a;

-- 3)
select a.title, avg(salary)
from titles a
join salaries b on a.emp_no = b.emp_no
where a.to_date='9999-01-01'
and b.to_date = '9999-01-01'
group by a.title
having avg(salary) = (select min(avg_salary)
from (
		select avg(salary) as avg_salary,title
		from salaries b
		join titles c on b.emp_no = c.emp_no
		where b.to_date = '9999-01-01'
		and c.to_date = '9999-01-01'
		group by c.title) as a);




select title, avg(salary)
from (select min(salary), avg(salary), title
		from salaries a 
		join employees b on a.emp_no = b.emp_no
		join titles c on b.emp_no = c.emp_no
		group by c.title);
        
-- 4) sol2: top-k -> limit, 위에서부터 k개를 잘라낸다는 의미

select avg(salary), c.title
from salaries a 
join titles c on a.emp_no = c.emp_no
where a.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
group by c.title
order by avg(a.salary) asc
	limit 0, 1;
-- limit 인덱스 위치 부터 개수

-- 3-2) 복수행 연산자 : in, not in, (비교연산자)+any ex) =any , 비교연산자+all <all

-- any 사용법
-- 1. =any: in과 같음
-- 2. >any, >=any: 최솟값
-- 3. <any, <=any: 최댓값
-- 4. <>any, !=any: not in 과 같음.
-- all 사용법
-- 1. =all: (x)
-- 2. >all, a>=all: 최댓값
-- 3. <all, a<=all: 최솟값
-- 4. <>all, !=all

-- 실습문제 3
-- 현재 급여가 50000 이상인 직원의 이름과 급여를 출력하세요

-- sol1) join
select a.first_name, b.salary
from employees a
join salaries b on a.emp_no = b.emp_no
where b.salary > 50000
and b.to_date = '9999-01-01'
order by b.salary asc;

-- sol2) subquery: where(in)
select first_name, b.salary
from employees a
join salaries b on a.emp_no = b.emp_no
where (a.emp_no,b.salary) in(
	select emp_no, salary
		from salaries 
		where to_date = '9999-01-01'
		and salary > 50000)
order by b.salary asc;
        

-- sol3) subquery: where(=any)
select first_name, b.salary
from employees a
join salaries b on a.emp_no = b.emp_no
where (a.emp_no,b.salary) =any(
	select emp_no, salary
		from salaries 
		where to_date = '9999-01-01'
		and salary > 50000)
order by b.salary asc;

-- 실습문제 4
-- 현재 각 부서별로 최고 급여를 받고 있는 직원의 부서, 이름과 월급을 출력하세요.

-- sol1) where 사용, subquery(in)
select c.dept_name, a.first_name, b.salary
from employees a, salaries b, departments c, dept_emp d
where a.emp_no = b.emp_no
and d.emp_no = a.emp_no
and b.to_date = '9999-01-01'
and d.to_date = '9999-01-01'
and (b.salary,d.dept_no) in (
							select max(a.salary), b.dept_no
							from salaries a
							join dept_emp b on a.emp_no = b.emp_no
                            where a.to_date = '9999-01-01'
                            and b.to_date = '9999-01-01'
							group by b.dept_no);

                            

-- sol2) from 절 subquery(in) & join
select c.dept_name, a.first_name, d.salary
from employees a
join dept_emp b on a.emp_no = b.emp_no
join departments c on b.dept_no = c.dept_no
join salaries d on a.emp_no = d.emp_no
join (select max(a.salary) as max_salary, b.dept_no
							from salaries a
							join dept_emp b on a.emp_no = b.emp_no
                            where a.to_date = '9999-01-01'
                            and b.to_date = '9999-01-01'
							group by b.dept_no) e on b.dept_no = e.dept_no
where d.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
and d.salary = e.max_salary;