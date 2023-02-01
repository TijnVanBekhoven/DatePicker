USE master
DROP DATABASE IF EXISTS MeetingPlanner
CREATE DATABASE MeetingPlanner
GO
USE MeetingPlanner

CREATE TABLE [User] (
	Username nvarchar(50),
	Email nvarchar(320) NOT NULL UNIQUE,
	[Password] binary(64) NOT NULL,
	RedditPage nvarchar(100) DEFAULT 'https://www.reddit.com/r/memes/',

	CONSTRAINT PK_User PRIMARY KEY (Username),
);

CREATE TABLE Planner (
	ID varchar(8),
	[Name] nvarchar(50) NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	[Password] binary(64),
	DateOfCreation date DEFAULT GETDATE(),
	Creator nvarchar(50) NOT NULL,

	CONSTRAINT PK_Planner PRIMARY KEY (ID),
	CONSTRAINT CH_EndDate CHECK (EndDate >= StartDate),
	CONSTRAINT FK_Creator FOREIGN KEY (Creator) REFERENCES [User](Username)
);

CREATE TABLE Participates (
	Username nvarchar(50),
	PlannerID varchar(8),

	CONSTRAINT PK_Participates PRIMARY KEY (Username, PlannerID),
	CONSTRAINT FK_Participates_Username FOREIGN KEY (Username) REFERENCES [User](Username),
	CONSTRAINT FK_Participates_PlannerID FOREIGN KEY (PlannerID) REFERENCES Planner(ID)
);

CREATE TABLE Available (
	Username nvarchar(50),
	PlannerID varchar(8),
	[Date] date,
	Moment char(1) NOT NULL,

	CONSTRAINT PK_Available PRIMARY KEY (Username, PlannerID, [Date]),
	CONSTRAINT FK_Available_Username_PlannerID FOREIGN KEY (Username, PlannerID) REFERENCES Participates(Username, PlannerID),
	CONSTRAINT CH_Moment CHECK (Moment IN ('A', 'E', 'B')) -- A = Afternoon, E = Evening, B = Both afternoon and evening
);