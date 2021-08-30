-- query that selects all the assignments a student has in their courses

SELECT 
	C.Name as CourseName, 
    A.Name as AssignmentName,
    A.Description,
    S.TimeSubmitted,
    S.Grade,
    T.TeacherFullName
FROM Course as C
INNER JOIN Assignment as A
ON A.CourseID = C.ID
INNER JOIN Submission as S
ON S.AssignmentID = A.ID
INNER JOIN Teaches
ON Teaches.CourseID = C.ID
INNER JOIN (
	SELECT
		CONCAT(FName, ' ', LName) as TeacherFullName,
        ID
	FROM Teacher
) as T
ON T.ID = Teaches.TeacherID
INNER JOIN Learning as L
ON L.CourseID = C.ID
INNER JOIN Student as St
ON L.StudentID = St.ID
WHERE St.Code = 'XHNV5770';

-- query that selects top 10 students based on their average submission grade for a given class

SET @CourseCode = 'CVI8837';

SELECT 
	S.StudentFullName,
    G.AvgGrade
FROM (
	SELECT
		CONCAT(FName, ' ', LName) as StudentFullName,
		Student.ID
	FROM Student
) as S
INNER JOIN (
	SELECT
		StudentID,
        AVG(GRADE) as AvgGrade
	FROM Submission
    WHERE AssignmentID in (
		SELECT A.ID as AssignmentID
        FROM Assignment as A
        INNER JOIN Course as C
        ON C.ID = A.CourseID
        WHERE C.Code = @CourseCode
    )
    GROUP BY StudentID
) as G
ON S.ID = G.StudentID
ORDER BY G.AvgGrade DESC LIMIT 10;

	