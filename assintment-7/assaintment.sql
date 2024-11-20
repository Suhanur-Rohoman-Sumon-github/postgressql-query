-- Active: 1731631300076@@127.0.0.1@5432@university_db@public



 CREATE TABLE students (
	student_id serial PRIMARY KEY,
	student_name VARCHAR ( 50 ) UNIQUE NOT NULL,
	age INTEGER NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL,
	frontend_mark INTEGER NOT NULL,
    backend_mark INTEGER ,
    status VARCHAR (50)  
);

DROP TABLE students;
DROP TABLE enrollment;


 CREATE TABLE courses (
	course_id serial PRIMARY KEY,
	course_name VARCHAR ( 50 ) UNIQUE NOT NULL,
	credits INTEGER NOT NULL
);
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);



INSERT INTO students ( student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
( 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
( 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
( 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
( 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
( 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
( 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

SELECT * FROM students ;

INSERT INTO courses (course_id, course_name, credits)
VALUES 
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);

SELECT * FROM courses

INSERT INTO enrollment (enrollment_id, student_id, course_id)
VALUES 
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);

SELECT * FROM enrollment

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Sumon', 25, 'sumonsuhanurrohoman@gmail.com', 55, 60, NULL);

SELECT student_name
FROM students as s
JOIN enrollment as  e ON s.student_id = e.student_id
JOIN courses as c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js'; 



UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);


DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM enrollment
);

SELECT student_name
FROM students
LIMIT 2 OFFSET 2;



SELECT c.course_name, COUNT(e.student_id) AS num_students
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;



SELECT AVG(age) AS average_age
FROM students;


SELECT student_name
FROM students
WHERE email LIKE '%example.com%';


