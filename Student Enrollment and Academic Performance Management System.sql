-- Students table
CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  course VARCHAR(50),
  enrollment_year INT
);

-- Modules table
CREATE TABLE modules (
  module_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  credits INT CHECK (credits BETWEEN 0 AND 60)
);

CREATE TABLE enrollments (
  enrollment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  module_id INT NOT NULL,
  grade VARCHAR(10),
  FOREIGN KEY (student_id) REFERENCES students(student_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (module_id) REFERENCES modules(module_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Insert students
INSERT INTO students (name, course, enrollment_year)
VALUES ('Alice Chan', 'Computer Science', 2022),
       ('Barry Cooper', 'Computer Science', 2023),
       ('Charlie Woodgate', 'Data Science', 2022),
       ('Daniel Johnson', 'Mathematics', 2021),
       ('Ethan Davids', 'Data Science', 2023);

-- Insert modules
INSERT INTO modules (title, credits)
VALUES ('Data Structures', 15),
       ('Machine Learning', 30),
       ('Business Intelligence', 15),
       ('Modelling Process', 30),
       ('Individual Project', 60),
       ('Big Data', 30);

-- Insert enrollments
INSERT INTO enrollments (student_id,module_id,grade) 
VALUES (1,1,'A'),
(1,2,'C'),
(2,5,'A'),
(2,3,'B'),
(3,3,'B'),
(3,4,'A'),
(4,6,'D'),
(5,1,'C'),
(5,3,'C');

--Exercise:
--list of all registered students in the system
select * from students;

--filters out and identifies recent Data Science students (enrolled from 2022 onwards)
select * from students where enrollment_year>=2022 and course ="Data Science";

-- displays a clean grade sheet for the post-2022 Data Science cohort
select DISTINCT s.student_id, s.enrollment_year, s.course, e.grade from students s
join enrollments e on s.student_id =e.student_id 
where enrollment_year>=2022 and course ="Data Science";

--convert letter grades into numeric quality points to calculate and compare the average GPA performance across different degree programs.
select DISTINCT s.course, AVG(case e.grade
when 'A' then 4
when 'B' then 3
when 'C' then 2
when 'D' then 1
else 0
end) from enrollments e 
join students s on s.student_id=e.student_id
group by s.course;



