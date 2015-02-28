/*
IS607 Project 1

Group Members: James Hamski | james.hamski@spsmail.cuny.edu 

Create a database for a school.

The database is an enrollment roster for the school nurse. Its aim is to provide a central repository of key information 
about the students and their parents. If a child is ill the nurse can use it to track down their parents and see if the 
child has any medical issues that should be immediately addressed. Some of the students are siblings and some of the students
have the same last name but different parents because they're cousins. 

The students have strange medical conditions because they're characters in the TV series 
It's Always Sunny in Philidelphia (http://www.imdb.com/title/tt0472954/)

TABLE PLAN
A. "StudentInformation" - Student Information
- name, birth date

B. "HomeContact" - Home addresses & phone numbers

C. "Parents" - Parent's daytime contact information

D. AilmentsTable
- what to do for specific conditions

 */

DROP TABLE IF EXISTS StudentInformation;

CREATE TABLE StudentInformation
(LastName varchar,  FirstName varchar, NickName varchar, BirthDate date, StudentID serial);

INSERT INTO StudentInformation
VALUES
('Kelly', 'Charlie', NULL, '2002-04-01'),
('Reynolds', 'Dennis', NULL, '2002-04-01'),
('Reynolds', 'Deandra', 'Sweet Dee', '2002-04-01'),
('MacDonald', 'Ronald', 'Mac', '2002-04-01');

--##### Table Creation #####--
DROP TABLE IF EXISTS HomeContact;

CREATE TABLE HomeContact
(StudentID int, LastName varchar,  FirstName varchar, ParentLastName varchar, ParentFirstName varchar, Address varchar);

INSERT INTO HomeContact VALUES
('1','Kelly', 'Charlie', 'Kelly', 'Bonnie', '435 Franklin St. #2, Philidelphia'),
('2','Reynolds', 'Dennis', 'Reynolds', 'Frank', '2893 Forrest Road, Philidelphia'),
('3','Reynolds', 'Deandra', 'Reynolds', 'Frank', '2893 Forrest Road, Philidelphia'),
('4','MacDonald', 'Ronald', 'MacDonald', NULL, NULL);

--#####--

DROP TABLE IF EXISTS Parents;

CREATE TABLE Parents
(StudentID int, LastName varchar,  FirstName varchar, Occupation varchar, PhoneNumber varchar);

INSERT INTO Parents VALUES
('2', 'Reynolds', 'Frank', 'Manufacturing', '5550104310'),
('2','Reynolds', 'Barbara', NULL, '555079402'), 
('3', 'Reynolds', 'Frank', 'Manufacturing', '5550104310'),
('3','Reynolds', 'Barbara', NULL, '555079402'), 
('1','Kelly', 'Bonnie', 'Waitress', '5550104310'),
('4','MacDonald', NULL, NULL, NULL);

DROP TABLE IF EXISTS Ailments;

CREATE TABLE Ailments
(StudentID int, Ailment1 varchar, Notes varchar);

INSERT INTO Ailments VALUES
('1', 'ADHD', 'Do not let him have cheese or be around glue.'),
('2', NULL, NULL),
('3', 'scoliosis', 'Must wear back brace'),
('4', NULL, NULL);

 --##### Queries #####--
 SELECT * FROM StudentInformation;
 SELECT * FROM HomeContact;
 SELECT * FROM Parents;
 SELECT * FROM Ailments;

 -- Oh no, Sweet Dee showed up with a stomach ache. What's her actual name again?

 SELECT FirstName, LastName 
 FROM StudentInformation 
 WHERE NickName LIKE 'Sweet Dee';

 -- Great, better track down her parents 
SELECT *
FROM Parents
LEFT JOIN StudentInformation
ON StudentInformation.StudentID = Parents.StudentID
WHERE StudentInformation.LastName = 'Reynolds' AND StudentInformation.FirstName = 'Deandra';

 -- Charlie Kelly came in and is not looking too good. Does he live close enough that I can let him go home? 
 -- And what's his deal anyways?



 
