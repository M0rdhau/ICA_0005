-- Front Page
SELECT 
	P.ID as PostID,
    U.Username,
    P.CreationTime,
    PM.MediaFileUrl,
    PM.MediaTypeID,
    L.NumLikes
FROM Post AS P
LEFT OUTER JOIN User AS U
ON P.UserID = U.ID
RIGHT OUTER JOIN PostMedia as PM
ON PM.PostID = P.ID
LEFT OUTER JOIN
(
	SELECT 
		PostID,
        Count(*) as NumLikes
	FROM Liking
    GROUP BY PostID
) AS L 
ON L.PostID = P.ID
WHERE U.Username = 'jcardon0';

-- Profile page, Header

SELECT U.ID as UserID,
	U.Username,
    U.Website,
    U.Bio,
    U.ProfileImageUrl,
    P.NumberOfPosts,
    Followers.NumberOfFollowers,
    Followed.NumberOfFollowedUsers
FROM User AS U
LEFT OUTER JOIN
(
	SELECT UserID, Count(*) as NumberOfPosts
    FROM Post
    GROUP BY UserID
) as P on P.UserID = U.ID
LEFT OUTER JOIN
(
	SELECT FolloweeUserID, Count(*) as NumberOfFollowers
    FROM Following
    GROUP BY FolloweeUserID
) as Followers on Followers.FolloweeUserID = U.ID
LEFT OUTER JOIN
(
	SELECT FollowerUserID, Count(*) as NumberOfFollowedUsers
    FROM Following
    GROUP BY FollowerUserID
) as Followed on Followed.FollowerUserID = U.ID
WHERE U.Username = 'jcardon0';


-- Profile Page, Posts

SELECT P.ID as PostID,
	P.LocationName,
    MT.Name as MediaType,
    PM.MediaFileUrl
FROM Post as P
LEFT OUTER JOIN PostMedia as PM
ON PM.PostID = P.ID
LEFT OUTER JOIN MediaType as MT
ON MT.ID = PM.MediaTypeID
INNER JOIN User as U
ON U.ID = P.UserID
WHERE U.Username = 'jcardon0'
GROUP BY P.ID;


-- Post Details page, main query
    
SELECT
	P.ID as PostID,
    U.Username,
    U.ProfileImageUrl,
    P.LocationName,
    P.Location,
    L.NumberOfLikes
FROM Post as P
INNER JOIN User as U
ON P.UserId = U.ID
LEFT OUTER JOIN
(
	SELECT PostID, COUNT(*) as NumberOfLikes
    FROM Liking GROUP BY PostID
) as L ON L.PostID = P.ID
WHERE U.Username = 'jcardon0';

-- Media files, in their natural order

SELECT
	PM.ID AS PostMediaID,
    PM.MediaTypeID,
    PM.MediaFileUrl
FROM PostMedia AS PM
INNER JOIN Post AS P
ON P.ID = PM.PostID
LEFT OUTER JOIN User AS U
ON U.ID = P.UserID
WHERE U.Username = 'jcardon0';

-- Comments in chronological order

SELECT C.ID, C.Comment, C.CreationTime
FROM Comment as C
INNER JOIN Post AS P
ON P.ID = C.PostID
LEFT OUTER JOIN User AS U
ON U.ID = P.UserID
WHERE U.Username = 'jcardon0';
    
    