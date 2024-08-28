use master 
go
alter database gym_fitness set single_user with rollback immediate

drop database if exists gym_fitness
go
create database gym_fitness
go
use gym_fitness
CREATE TABLE PhysicalLevel (
    level_id INT IDENTITY(1,1) PRIMARY KEY,
    level_name NVARCHAR(MAX)
);

CREATE TABLE Goal ( 
    goal_id INT IDENTITY(1,1) PRIMARY KEY,
    goal_name NVARCHAR(MAX)
);

CREATE TABLE UserAccount (
    user_id VARCHAR(255) PRIMARY KEY,
    user_fullname NVARCHAR(MAX),
    user_email VARCHAR(MAX),
    user_phone VARCHAR(20)
);

CREATE TABLE UserInfor (
	info_id INT IDENTITY(1,1) PRIMARY KEY,
    gender NVARCHAR(10),
    weight DECIMAL(5,2),
    height DECIMAL(5,2),
    age INT,
    DoB DATE,
	user_image nvarchar(max),
    user_id VARCHAR(255),
	goal_id INT,
    level_id INT,
    FOREIGN KEY (goal_id) REFERENCES Goal(goal_id),
    FOREIGN KEY (level_id) REFERENCES PhysicalLevel(level_id),
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE Article (
    article_id INT IDENTITY(1,1) PRIMARY KEY,
	created_at DATETIME DEFAULT GETDATE(),
    article_title NVARCHAR(MAX),
    article_content NVARCHAR(MAX),
    article_thumbnail NVARCHAR(MAX)
);

CREATE TABLE FavoriteArticle (
    article_id INT,
    user_id VARCHAR(255),
    PRIMARY KEY (article_id, user_id),
    FOREIGN KEY (article_id) REFERENCES Article(article_id),
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE Workout (
    workout_id INT IDENTITY(1,1) PRIMARY KEY,
    workout_name NVARCHAR(MAX),
    workout_calories DECIMAL(10,2),
    workout_thumbnail NVARCHAR(MAX),
    level_id INT,
    FOREIGN KEY (level_id) REFERENCES PhysicalLevel(level_id)
);

CREATE TABLE Excersise (
    excersise_id INT IDENTITY(1,1) PRIMARY KEY,
    excersise_name NVARCHAR(MAX),
	excersise_description NVARCHAR(MAX),
    excersise_duration INT,
    excersise_rep INT,
    excersise_video NVARCHAR(MAX),
    workout_id INT,
    FOREIGN KEY (workout_id) REFERENCES Workout(workout_id)
);

CREATE TABLE FavoriteWorkout (
    workout_id INT,
    user_id VARCHAR(255),
    PRIMARY KEY (workout_id, user_id),
    FOREIGN KEY (workout_id) REFERENCES Workout(workout_id),
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE ProgressTracking (
    progress_id INT IDENTITY(1,1) PRIMARY KEY,
    datetime_tracking DATETIME,
    user_id VARCHAR(255) not null,
    workout_id INT not null,
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id),
    FOREIGN KEY (workout_id) REFERENCES Workout(workout_id)
);


CREATE TABLE Notifications(
	noti_id INT IDENTITY(1,1) PRIMARY KEY,
	noti_type VARCHAR(8),
	noti_title NVARCHAR(MAX),
	noti_content NVARCHAR(MAX),
	user_id VARCHAR(255) not null,
	FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
)

CREATE TABLE Challenge (
    challenge_id INT IDENTITY(1,1) PRIMARY KEY,
    result NVARCHAR(10),
    workout_id INT not null,
    FOREIGN KEY (workout_id) REFERENCES Workout(workout_id)
);

CREATE TABLE ForumPost (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    post_title NVARCHAR(MAX),
    post_content NVARCHAR(MAX),
    user_id VARCHAR(255) not null,
    created_at DATETIME DEFAULT GETDATE(),
    view_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE PostLike (
    post_id INT not null,
    user_id VARCHAR(255) not null,
    PRIMARY KEY (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES ForumPost(post_id),
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE PostComment (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT not null,
    user_id VARCHAR(255) not null,
    comment_content NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES ForumPost(post_id),
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE PostView (
    post_id INT,
    user_id VARCHAR(255),
    view_date DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES ForumPost(post_id),
    FOREIGN KEY (user_id) REFERENCES UserAccount(user_id)
);

CREATE TABLE Routine
(
	routine_id INT IDENTITY(1,1) PRIMARY KEY,
	round_name INT,
	user_id VARCHAR(255) not null,
	excersise_id INT not null,
	FOREIGN KEY (user_id) REFERENCES UserAccount(user_id),
	FOREIGN KEY (excersise_id) REFERENCES Excersise(excersise_id)
)

INSERT PhysicalLevel(level_name) values ('Beginner'), ('Intermediate'), ('Advance')
INSERT Goal(goal_name) values ('Lose weight'), ('Gain weight'), ('Muscle mass gain'), ('Shape body'), ('Others')