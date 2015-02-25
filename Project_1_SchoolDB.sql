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

D. Conditions Table
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
('MacDonald', 'Ronald', 'Mac', '2002-04-01')

--#####--
DROP TABLE IF EXISTS HomeContact;

CREATE TABLE HomeContact
(LastName varchar,  FirstName varchar, NickName varchar, BirthDate date, StudentID serial);

INSERT INTO HomeContact
VALUES
('Kelly', 'Charlie', NULL, '2002-04-01'),

--#####--

DROP TABLE IF EXISTS Parents;

CREATE TABLE Parents
(LastName varchar,  FirstName varchar, Occupation varchar, PhoneNumber int);

INSERT INTO Parents
VALUES
('Reynolds', 'Frank', 5550104310),
('Kelly', 'Bonnie', 5550104310),