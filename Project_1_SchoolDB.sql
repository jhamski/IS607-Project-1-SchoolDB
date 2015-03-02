/*
IS607 Project 1

Group Members: James Hamski | james.hamski@spsmail.cuny.edu 

This database is for an elementary school. The elementary school's purpose is to provide an instructional environment
where kids can learn social skills and basic academic skills like reading, writing, and arithmetic. 

The database is an enrollment roster used by the school nurse. Its aim is to provide a central repository of key information 
about the students and their parents. If a child is ill the nurse can use it to track down their parents and see if the 
child has any medical issues that should be immediately addressed. Some of the students are siblings and some of the students
have the same last name but different parents because they're cousins. 

The students have strange medical conditions because they're based on characters in the TV series 
It's Always Sunny in Philadelphia (http://www.imdb.com/title/tt0472954/)

TABLE PLAN
A. "Students" - Student Information
- name, birth date

B. "HomeContact" - Home addresses & phone numbers

C. "Parents" - Parent's daytime contact information

D. AilmentsTable
- what to do for specific conditions

 */

DROP TABLE IF EXISTS Students CASCADE;

CREATE TABLE Students
(LastName varchar,  FirstName varchar, NickName varchar, BirthDate date, StudentID serial PRIMARY KEY);

-- It is important to use a unique StudentID as the primary key. When I first began building out the DB
-- design I used last names. But for common last names like "Smith" or if you're like me and a bunch of cousins
-- attended the same school, it introduces ambiguity when trying to attach a student to a parent or any other information.

INSERT INTO Students
VALUES
('Kelly', 'Charlie', NULL, '2002-04-01'),
('Reynolds', 'Dennis', NULL, '2002-04-01'),
('Reynolds', 'Deandra', 'Sweet Dee', '2002-04-01'),
('MacDonald', 'Ronald', 'Mac', '2002-04-01');

--##### Table Creation #####--
DROP TABLE IF EXISTS HomeContact;

CREATE TABLE HomeContact
(StudentID int REFERENCES Students (StudentID) ON DELETE CASCADE, LastName varchar, FirstName varchar, Address varchar);

INSERT INTO HomeContact VALUES
('1', 'Kelly', 'Bonnie', '435 Franklin St. #2, Philadelphia'),
('2', 'Reynolds', 'Frank', '2893 Forrest Road, Philadelphia'),
('3', 'Reynolds', 'Frank', '2893 Forrest Road, Philadelphia'),
('4',  'MacDonald', 'Mrs.', NULL);

--#####--

DROP TABLE IF EXISTS Parents;

CREATE TABLE Parents
(StudentID int REFERENCES Students (StudentID) ON DELETE CASCADE, LastName varchar,  FirstName varchar, Occupation varchar, PhoneNumber varchar);

INSERT INTO Parents VALUES
('2', 'Reynolds', 'Frank', 'Manufacturing', '5550104310'),
('2','Reynolds', 'Barbara', NULL, '555079402'), 
('3', 'Reynolds', 'Frank', 'Manufacturing', '5550104310'),
('3','Reynolds', 'Barbara', NULL, '555079402'), 
('1','Kelly', 'Bonnie', 'Waitress', '5550104310'),
('4','MacDonald', 'Mrs.', NULL, NULL);

DROP TABLE IF EXISTS Ailments;

CREATE TABLE Ailments
(StudentID int REFERENCES Students (StudentID) ON DELETE CASCADE, Ailment1 varchar, Notes varchar);

INSERT INTO Ailments VALUES
('1', 'ADHD', 'Do not let him have cheese or be around glue.'),
('1', 'Allergies', ' Allergic to peanuts'), 
('2', NULL, NULL),
('3', 'scoliosis', 'Must wear back brace'),
('4', NULL, NULL);

 --##### Queries #####--
 
 -- Oh no, Sweet Dee showed up with a stomach ache. What's her actual name again?

 SELECT FirstName, LastName 
 FROM Students
 WHERE NickName LIKE 'Sweet Dee';

 -- Great, better track down her parents 
 -- The tables Students and Parents have a many to many relationship
SELECT *
FROM Parents
LEFT JOIN Students
ON Students.StudentID = Parents.StudentID
WHERE Students.LastName = 'Reynolds' AND Students.FirstName = 'Deandra';

-- What is wrong with Charlie, anyways? 
-- The tables Students and Ailments have a one to many relationship
SELECT * 
FROM Ailments
WHERE StudentId = 1;

-- Oh no, Mac dropped out of school. Now we have to delete him from the database, using a cascading delete.

DELETE 
FROM Students
WHERE Nickname LIKE 'Mac';

SELECT * FROM HomeContact;
-- Mac is deleted from all tables

-- Sometimes a child has medication they are prescribed and the school nurse needs to look up more information on it. 
-- So, let's load in the National Drug Code Directory from http://www.fda.gov/Drugs/InformationOnDrugs/ucm142438.htm

DROP TABLE IF EXISTS DrugDirectory;

CREATE TABLE DrugDirectory
(PRODUCTID varchar, PRODUCTNDC varchar, PRODUCTTYPENAME varchar, PROPRIETARYNAME varchar, PROPRIETARYNAMESUFFIX varchar, NONPROPRIETARYNAME varchar, 
DOSAGEFORMNAME varchar, ROUTENAME varchar, STARTMARKETINGDATE varchar, ENDMARKETINGDATE varchar, MARKETINGCATEGORYNAME varchar, APPLICATIONNUMBER varchar, 
LABELERNAME varchar, SUBSTANCENAME varchar, ACTIVE_NUMERATOR_STRENGTH varchar, ACTIVE_INGRED_UNIT varchar, PHARM_CLASSES varchar, DEASCHEDULE varchar);

COPY DrugDirectory FROM '/Users/Shared/drugdirectory.csv' DELIMITERS ',' CSV;

-- How many drugs are in this thing?

SELECT COUNT(*) FROM DrugDirectory;

/*
Short requirement for extending functionality.

Problem: 
Some of the students need to have medication administered during the school day. The Nurse has requested
a form she can enter after each time she gives out medication to ensure the proper timing and dosage.

Aim of this requirement: 
Update the user interface to include a form that accepts the parameters (1) student first and last name
(2) medication serial number entered via barcode scanner (3) dosage given entered manually (3) date/time of disbursement. 

Architecture:
- The student name can be queried from the Students table and will bring up the StudentID as well. 
- The barcode scanner will use off-the-shelf technology to return a 12-digit serial number to the database form,
displaying the name of the medication. It will cross-reference this with a new table showing what medication the 
student takes, ensuring that the wrong medication isn't given to a student. All data will be entered into the 
medication disbursment database. 
- The nurse will be able to manually enter the dosage given. 
- The date and time of entry is recorded.

Acceptance Criteria: 
The school nurse can bring up the student's name and ID from a UI, scan the barcode on a medication bottle, then
and enter the dosage given. The records are timestamped with the day/time of entry and stored in a database
for later reference. 

 */
