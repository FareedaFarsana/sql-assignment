1) Create a database login_system
CREATE DATABASE login_system;

2) Create Tables with following fields

	2.a)TableName:Users
			->userid int PK AI
			->username varchar(100) unique
			->password varchar(255) hashed password
			->email varchar(100) unique 
			->mobile bigint unique
			->roleid int FK references roles(rid)
			->createat

	CREATE TABLE Users(
		userid INT AUTO_INCREMENT PRIMARY KEY,
		username VARCHAR(100) UNIQUE NOT NULL,
		password VARCHAR(255) NOT NULL,
		email VARCHAR(100) UNIQUE NOT NULL,
		mobile BIGINT UNIQUE,
		roleid INT, FOREIGN KEY(roleid) REFERENCES Roles(roleid)	
	);
	
	2.b) TableName:Profile
			->profileid int AI PK
			->userid int FK references users(userid)
			->profileimage varchar(100) default 'no-image'
			->housename varchar(100)
			->place varchar(100)
			->city varchar(100)
			->pin int
			->dob date
			->linked_in_url text
			->github_url text
			->hobbies text
			->myself text
			->skillset text  

	CREATE TABLE Profile(
		profileid INT AUTO_INCREMENT PRIMARY KEY,
		userid INT,
		FOREIGN KEY(userid) REFERENCES users(userid),
		profileimage VARCHAR(100) DEFAULT 'no-image',
		housename VARCHAR(100),
		place VARCHAR(100),
		city VARCHAR(100),
		pin INT, 
		dob DATE, 
		linked_in_url TEXT, 
		github_url TEXT,
		hobbies TEXT,
		myself TEXT, 
		skillset TEXT
	);
	
	2.c)TableName:Roles 
			->roleid int PK AI
			->rolename varchar(100) unique
	
	CREATE TABLE Roles(
		roleid INT PRIMARY KEY AUTO_INCREMENT,
		rolename VARCHAR(100) UNIQUE NOT NULL
	);


