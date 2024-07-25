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
select a.seq_no, a.movie_name, a.years, a.countries from 
	(select * from box_office 
	where years = 2019) as a
where a.audience_num >= 5000000 || a.sale_amt >= 40000000000;

select seq_no, movie_name, years, countries from box_office
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

