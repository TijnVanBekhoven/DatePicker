USE master
DROP DATABASE IF EXISTS MeetingPlanner
CREATE DATABASE MeetingPlanner
GO
USE MeetingPlanner

CREATE TABLE [User] (
	Username nvarchar(50) PRIMARY KEY,
	Email nvarchar(254) NOT NULL,
	[Password] nvarchar(64) NOT NULL
);

CREATE TABLE Planner (
	ID nvarchar(8) PRIMARY KEY,
	Name nvarchar(50) NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	[Password] nvarchar(64),

	CONSTRAINT CHK_EndDate CHECK (EndDate >= StartDate)
);

CREATE TABLE Owns (
	Username nvarchar(50) NOT NULL,
	PlannerID nvarchar(8) NOT NULL,
	CreationDate date NOT NULL DEFAULT GETDATE(),

	CONSTRAINT PK_Owns PRIMARY KEY (Username, PlannerID),
	CONSTRAINT FK_Owns_Username FOREIGN KEY (Username) REFERENCES [User](Username) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Owns_PlannerID FOREIGN KEY (PlannerID) REFERENCES Planner(ID) ON DELETE CASCADE
);

CREATE TABLE Participates (
	Username nvarchar(50) NOT NULL,
	PlannerID nvarchar(8) NOT NULL,

	CONSTRAINT PK_Participates PRIMARY KEY (Username, PlannerID),
	CONSTRAINT FK_Participates_Username FOREIGN KEY (Username) REFERENCES [User](Username) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Participates_PlannerID FOREIGN KEY (PlannerID) REFERENCES Planner(ID) ON DELETE CASCADE
);

CREATE TABLE AvailableDates (
	Username nvarchar(50) NOT NULL,
	PlannerID nvarchar(8) NOT NULL,
	[Date] date NOT NULL,
	Available bit NOT NULL,

	CONSTRAINT PK_AvailableDates PRIMARY KEY (Username, PlannerID, [Date]),
	CONSTRAINT FK_AvailableDates_Username FOREIGN KEY (Username, PlannerID) REFERENCES Participates(Username, PlannerID)  ON UPDATE CASCADE ON DELETE CASCADE
);