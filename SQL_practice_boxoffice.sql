select seq_no 연도, movie_name, years from box_office 
where years = 2004 or years = 2005;  -- or는 ||로 대체 가능 

select seq_no 연도, movie_name, years from box_office 
where years between 2004 and 2005;

select seq_no 연도, movie_name, years from box_office 
where years >= 2004 and years <= 2005;   -- and는 &&으로 대체 가능

select seq_no 연도, movie_name, years from box_office 
where movie_name like '천년_'; -- 천년 + 한글자 추가로 이루어진 데이터 찾기

 
select seq_no 연도, movie_name, years from box_office 
where movie_name like '%여우%' or movie_name like '%학%'; -- 여우 또는 학이라는 글자가 들어간 영화 출력

select seq_no 연도, movie_name, years, countries from box_office 
where movie_name like '%여우%' and years = 2007; -- 2007년에 제작된 영화중에 여우라는 단어가 들어간 영화 

-- - 2018년 개봉한 한국 영화 조회하기
select seq_no 연도, movie_name, years, countries from box_office 
where years = 2018 and countries = '한국';

-- - 2019년 개봉 영화 중 관객수가 500만 명 이상인 영화 조회하기
select seq_no 연도, movie_name, years, countries from box_office 
where years = 2019 and audience_num >= 5000000;

-- - 2019년 개봉 영화 중 관객수가 500만 명 이상이거나 매출액이 400억 원 이상인 영화 조회하기
EXPLAIN select a.seq_no, a.movie_name, a.years, a.countries from  
	(select * from box_office 
	where years = 2019) as a 
where a.audience_num >= 5000000 || a.sale_amt >= 40000000000;

CREATE INDEX idx_years_audience_sale ON box_office(years, audience_num, sale_amt);

EXPLAIN select seq_no, movie_name, years, countries from box_office 
where years = 2019 and (audience_num >= 5000000 || sale_amt >= 40000000000);

-- - 2012년에 제작됐지만, 2019년에 개봉된 영화를 조회하기.

select seq_no, movie_name, years, countries from box_office
where years = 2012 and year(release_date) = 2019;

-- - 위 데이터를 “특이사항”이라는 열 이름으로 출력하기.

select movie_name 특이사항 from box_office
where years = 2012 and year(release_date) = 2019;

-- 2019년 개봉하고 500만 명 이상의 관객을 동원한 매출액 기준 상위 5편의 영화만 조회

select seq_no, movie_name, years, countries, audience_num, sale_amt from box_office
where year(release_date) = 2019 and audience_num >= 5000000
order by sale_amt desc
limit 5;

-- 2019년 제작한 영화 중 관객수 1~10위 영화를 조회

select seq_no, movie_name, years, countries, audience_num from box_office
where years = 2019
order by audience_num desc 
limit 10; 

-- box_office 테이블에서 2019년 제작된 영화 중 영화 유형(movie_type 칼럼)이 장편이 아닌 영화를 순위(ranks)대로 조회.

select seq_no, movie_name, years, countries, audience_num, ranks from box_office
where years = 2019 and movie_type != '장편'
order by ranks;

select name, continent, region
from world.country
where population > 50000000
order by 1 desc
limit 10;


-- 실습.
# 1. box_office 테이블에서 2015년 이후 개봉한 영화 중 연도별로 2번 이상 
# 관객수 100만을 넘긴 영화의 감독과 해당 관객의 영화를 본 관객수를 
# 연도별, 감독별로 구하는 쿼리를 작성하세요.

select year(release_date), director, sum(audience_num) 
	from box_office
		where year(release_date) >= 2015 
        and audience_num >= 1000000
	group by director, year(release_date)
	having count(director) >= 2
	order by sum(audience_num) desc; 

# 2. 2019년 1분기(QUARTER 함수 사용) 개봉 영화 중 
# 매출액이 천만 원 이상인 영화의 
# 월별, 영화 유형별 매출액 소계를 구하는 쿼리

select month(release_date), movie_type, sum(sale_amt)
	from box_office
		where quarter(release_date) = 1 
		and years = 2019 
		and sale_amt >= 10000000
	group by 1,2;


/* 3. 2019년 개봉 영화 중 매출액이 천만 원 이상인 영화의 월별(MONTH), 영화 유형별 매출액 소계를 구하되
	7월 1일 전에 개봉한 영화이면 상반기,
	7월 1일 이후에 개봉한 영화이면 하반기라고 함께 출력하는 쿼리 */
    
select month(release_date),movie_type, sum(sale_amt), 
	case 
		when date_format(release_date, "%m-%d") < '07-01'then '상반기'
		when date_format(release_date, "%m-%d") > '07-01' then '하반기' 
        end as 분기
	from box_office
		where sale_amt >= 10000000 
        and year(release_date) = 2019
	group by 1,2,4
with rollup;


select month(release_date), movie_type, sum(sale_amt), 
	case when month(release_date) < 7 then '상반기'
    else '하반기' end as 분기
from box_office
where sale_amt >= 10000000 and year(release_date) = 2019
group by 1,2,4;


-- 4. 부제가 있는 영화 찾기 ':' 2015년 이후의 개봉영화 중에서 부제가 달려있는 영화의 개수 세어보기 

select count(movie_name) from box_office
where year(release_date) >= 2015 and movie_name like '%:%';

-- 4. 부제가 있는 영화 찾기 ':' 2015년 이후의 개봉영화 중에서 부제가 달려있는 영화의 개수 세어보기 

SELECT  YEAR(release_date), COUNT(*) as 합
FROM box_office
WHERE YEAR(release_date) >= 2015 AND movie_name LIKE "%:%"
GROUP BY YEAR(release_date)
ORDER BY 1;



/*  5. 감독이 두 명 이상이면 콤마(,)로 이어져 있습니다(예, ‘홍길동,김감독’). 감독이 1명이면 그대로, 
   두 명 이상이면 콤마 대신 ‘/’ 값으로 대체해(예, ‘홍길동/김감독’) 출력하는 쿼리를 작성해 보세요. */
   
select movie_name, replace(director, ',', '/') as 감독 from box_office;

SET @country_name = 'AGO';
SET @cn = 5;

select * from world.country
where population > 100000000
order by @cn asc;

PREPARE mySQL FROM 'SELECT code, name, continent, region, population
FROM world.country
 WHERE population > 100000000
 ORDER BY 1 ASC
 LIMIT ?';
EXECUTE mySQL USING @cn;