-- analytical values as a single data set

USE sys;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'only_full_group_by',''));
USE MiniInsta;

SELECT AVG(P.PostsPerUser) FROM NumberOfPostsPerUser as P;

SELECT AVG(L.LikesPerPost) FROM NumberOfLikesPerPost as L;

DROP VIEW NumberOfPostsPerUser;

DROP VIEW NumberOfLikesPerPost;

CREATE VIEW NumberOfPostsPerUser AS
	SELECT count(*) as PostsPerUser, UserID FROM Post group by UserID;
    
CREATE VIEW NumberOfLikesPerPost AS
	SELECT count(*) as LikesPerPost, PostID FROM Liking group by PostID;

DELIMITER //

CREATE FUNCTION TotalUsers()
 returns int
 READS SQL DATA
 BEGIN
	RETURN IFNULL((SELECT count(*) FROM User), 0);
 END //

DELIMITER //
CREATE FUNCTION TotalPosts()
 returns int
 READS SQL DATA
 BEGIN
	RETURN IFNULL((SELECT count(*) FROM Post), 0);
 END //

SELECT 
 	TotalUsers() as TotalNumberOfUsers,
    TotalPosts() as TotalNumberOfPosts,
    AVG(NP.PostsPerUser) as AvgNumberOfPostsPerUser,
    MAX(NP.PostsPerUser) as MaxNumberOfPostsPerUser,
    AVG(L.LikesPerPost) as AvgNumberOfLikesPerPost,
    MAX(L.LikesPerPost) as MaxNumberOfLikesPerPost
FROM  NumberOfPostsPerUser as NP
INNER JOIN NumberOfLikesPerPost as L;

-- Top 10 Users with most posts

SELECT
	U.ID as UserID,
    U.Username,
    NP.PostsPerUser as NumberOfPosts
FROM User as U
INNER JOIN NumberOfPostsPerUser AS NP
ON NP.UserID = U.ID
ORDER BY NP.PostsPerUser DESC LIMIT 10;

SELECT * FROM NumberOfPostsPerUser;

-- Number of user registrations by date

SELECT 
	CONVERT(CreationTime, DATE) as Date,
    count(*)
FROM User
Group By Date;

-- User division by gender

SELECT
	G.Name as GenderName,
    Count(*)
FROM User as U
LEFT OUTER JOIN Gender as G
ON G.ID = U.GenderID
GROUP BY G.Name;
    
    
    
    

