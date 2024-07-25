use school;

-- 1. 학과의 학과 정원을 다음과 같이 출력하는 SQL문을 작성하시오.

select concat(department_name,'의 정원은 ', capacity,'명 입니다.') '학과별 정원' from tb_department;

-- 2. ‘국어국문학과’의 여학생 중에서 현재 휴학 중인 학생을 출력하는 SQL문을 작성하시오.

select s.student_name from tb_department d, tb_student s 
where d.department_no = s.department_no
and d.department_name = '국어국문학과'
and s.absence_yn = 'Y'
and substr(student_ssn,8, 1) = 2 || substr(student_ssn,8, 1) = 4;  -- 여성은 주민번호 뒷자리가 2 또는 4로 시작하므로

-- 3. 대학교의 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다. 총장의 이름을 출력하는 SQL문을 작성하시오.

select professor_name from tb_professor p
where p.department_no is null;

-- 4.  02학번 ‘전주’ 거주자들의 모임을 만들려고 한다. 휴학한 사람들을 제외한 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 SQL문을 작성하시오.

select student_no, student_name, student_ssn,student_address  from tb_student
where student_address like '%전주%'
and student_no like 'A2%'
and absence_yn = 'N'; 

-- 5. 영어영문학과(학과코드 002) 학생들의 학번과 이름,입학년도를 입학년도가 빠른순으로 출력하는 SQL문을 작성하시오.

select s.student_no, s.student_name, entrance_date from tb_department d inner join tb_student s
on d.department_no = s.department_no
where d.department_no = 002
order by entrance_date;

-- 6. 학과별 학생수를 구하여 ‘학과번호’, ‘학생수(명)’ 의 형태로 헤더를 만들어 출력하는 SQL문을 작성하시오.

select d.department_no as '학과번호', count(s.student_no) as '학생수(명)' from tb_department d inner join tb_student s
on d.department_no = s.department_no
group by d.department_no;

select s.department_no as '학과번호', count(s.student_no) as '학생수(명)' from  tb_student s
group by s.department_no;

-- 7. 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 2000년도 이전 학번에 해당되는 학생들의 학번과 이름을 출력하는 SQL문을 작성하시오.

select student_no, student_name from tb_student 
where student_no not like 'A%'; 

-- 8. 학번이 A517178인 한아름 학생의 학점을 활용하여 총 평점을 출력하는 SQL문을 작성하시오. 단, 출력헤더는 ‘평점’이라고 출력되고 점수는 반올림하여 소수점 이하 한 자리까지만 출력한다.

select s.student_no, s.student_name, round(avg(point),1) from tb_student s inner join tb_grade g inner join tb_class c on s.student_no = g.student_no and g.class_no = c.class_no
where s.student_no = 'A517178'
group by s.student_no, s.student_name; 

-- 9. 현재 법학과 교수중에서 가장 나이가 많은 사람부터 이름을 출력하시오. ( 법학과의 ‘학과코드’는 TB_DEPARTMENT인 학과테이블을참조한다.)

select professor_name, professor_ssn from tb_professor p inner join tb_department d 
	on p.department_no = d.department_no
	where department_name = '법학과'
    order by professor_ssn; 

-- 10. 과목별 교수 이름을 찾으려고 한다. 과목이름과 교수이름을 출력하는 조인(JOIN)문장을 작성하시오.

select c.class_name, p.professor_name from tb_class c 
	inner join tb_professor p 
	inner join tb_class_professor cp
	on cp.professor_no = p.professor_no
    and c.class_no = cp.class_no;
