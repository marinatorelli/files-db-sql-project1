DROP TABLE REGISTRATIONS CASCADE CONSTRAINTS;
DROP TABLE PROFILES CASCADE CONSTRAINTS;
DROP TABLE CONTRACTS CASCADE CONSTRAINTS;
DROP TABLE CLUBS CASCADE CONSTRAINTS;
DROP TABLE MEMBERSHIPS CASCADE CONSTRAINTS;
DROP TABLE OPINIONS CASCADE CONSTRAINTS;
DROP TABLE PROPOSEDFILMS CASCADE CONSTRAINTS;
DROP TABLE INVITATIONS CASCADE CONSTRAINTS;
DROP TABLE APPLICATIONS CASCADE CONSTRAINTS;
DROP TABLE FILMS CASCADE CONSTRAINTS;
DROP TABLE FILMKEYWORDS CASCADE CONSTRAINTS;
DROP TABLE FILMIMDBDATA CASCADE CONSTRAINTS;
DROP TABLE FILMGENRES CASCADE CONSTRAINTS;
DROP TABLE FILMCAST CASCADE CONSTRAINTS;
DROP TABLE FILMFACEBOOKINFO CASCADE CONSTRAINTS;


-- PARENT TABLES --
CREATE TABLE PROFILES(
first_name VARCHAR2(100), 
surname1 VARCHAR2(100),
surname2 VARCHAR2(100),
age NUMBER(3),
birth_date VARCHAR2(10),
user_ID VARCHAR2(9) NOT NULL,
phone_number VARCHAR2(10),
CONSTRAINT PK_PROFILES PRIMARY KEY(user_ID)
);

CREATE TABLE CLUBS(
club_name VARCHAR2(60) NOT NULL,
founder_username VARCHAR2(100) NOT NULL,
founding_date DATE NOT NULL,
founding_hour DATE NOT NULL,
privacy VARCHAR2(100),	
motto VARCHAR2(100),
num_events VARCHAR2(100),
ceased VARCHAR2(10) DEFAULT 'False',
CONSTRAINT PK_CLUBS PRIMARY KEY(club_name),
CONSTRAINT CK_CLUB CHECK (privacy IN ('Open' , 'Closed'))
);


CREATE TABLE FILMS(
title VARCHAR2(100) NOT NULL,
director VARCHAR2(100) NOT NULL,
duration VARCHAR2(100),
color VARCHAR2(100),
aspect_ratio VARCHAR2(100),
release_year NUMBER(4),
age_rating VARCHAR2(100),
country VARCHAR2(100),
language VARCHAR2(100),
budget VARCHAR2(100),
income VARCHAR2(100),
facesnumber_poster VARCHAR2(100),
CONSTRAINT PK_FILMS PRIMARY KEY(title, director)
);


-- PARENT/CHILD TABLES --
CREATE TABLE REGISTRATIONS(
username VARCHAR2(100) NOT NULL,
password VARCHAR2(100) NOT NULL, 
email VARCHAR2(100) NOT NULL,
user_ID VARCHAR2(9),
CONSTRAINT PK_REGISTRATIONS PRIMARY KEY(username),
CONSTRAINT FK_REGISTRATIONS FOREIGN KEY(user_ID) REFERENCES PROFILES,
CONSTRAINT CK_PASSWORD CHECK (LENGTHB(password)>7)
);


-- CHILD TABLES --
CREATE TABLE CONTRACTS(
contract_identifier VARCHAR2(16) NOT NULL,
user_ID VARCHAR2(10) NOT NULL,
contract_type VARCHAR2(50) NOT NULL,
postal_address VARCHAR2(100),
zip_code VARCHAR2(10),
town VARCHAR2(100),
country VARCHAR2(100),
phone_number VARCHAR2(10) NOT NULL,
start_date DATE NOT NULL,
end_date DATE,
CONSTRAINT PK_CONTRACTS PRIMARY KEY(contract_identifier),
CONSTRAINT FK_CONTRACTS FOREIGN KEY(user_ID) REFERENCES PROFILES
);

CREATE TABLE MEMBERSHIPS(
member_username VARCHAR2(100) NOT NULL,
club_name VARCHAR2(60) NOT NULL,
entry_date DATE NOT NULL,
CONSTRAINT PK_MEMBERSHIPS PRIMARY KEY(member_username, club_name, entry_date),
CONSTRAINT FK_MEMBERSHIPS FOREIGN KEY(club_name) REFERENCES CLUBS ON DELETE CASCADE
);
CREATE TABLE OPINIONS(
reviewer_username VARCHAR2(100) NOT NULL,
reviewer_club VARCHAR2(60) NOT NULL,
op_date DATE NOT NULL,
op_hour DATE NOT NULL,
score VARCHAR2(2),
commented_film VARCHAR2(100) NOT NULL,
commented_director VARCHAR2(100) NOT NULL,
comment_title VARCHAR2(100) NOT NULL,
comment_body VARCHAR2(1500) NOT NULL,
CONSTRAINT PK_OPINIONS PRIMARY KEY(reviewer_username, op_date, op_hour, commented_film),
CONSTRAINT FK_OPINIONS2 FOREIGN KEY(reviewer_club) REFERENCES CLUBS ON DELETE CASCADE,
CONSTRAINT FK_OPINIONS3 FOREIGN KEY(commented_film, commented_director) REFERENCES FILMS
);

CREATE TABLE PROPOSEDFILMS(
film_title VARCHAR2(100),
film_director VARCHAR2(100),
proposing_club VARCHAR2(60),
proposing_username VARCHAR2(100),
prop_date DATE,
prop_hour DATE,
CONSTRAINT PK_PROPOSEDFILMS PRIMARY KEY(film_title, film_director, proposing_club),
CONSTRAINT FK_PROPOSEDFILMS1 FOREIGN KEY(proposing_club) REFERENCES CLUBS ON DELETE CASCADE
);

CREATE TABLE APPLICATIONS(
club_name VARCHAR2(60),
username VARCHAR2(100),
app_date DATE,
app_hour DATE,	
accepted VARCHAR2(10),
message VARCHAR2(1000),
CONSTRAINT PK_APPLICATIONS PRIMARY KEY(club_name, username, app_date, app_hour),
CONSTRAINT FK_APPLICATIONS FOREIGN KEY(club_name) REFERENCES CLUBS
);

CREATE TABLE INVITATIONS(
club_name VARCHAR2(60),
username VARCHAR2(100),
inv_date DATE,
inv_hour DATE,
accepted VARCHAR2(10),
emmiter VARCHAR2(100),
CONSTRAINT PK_INVITATIONS PRIMARY KEY(club_name, username, inv_date, inv_hour),
CONSTRAINT FK_INVITATIONS FOREIGN KEY(club_name) REFERENCES CLUBS
);

CREATE TABLE HISTORY(
club_name VARCHAR2(60),
ceased_date DATE NOT NULL,
ceased_hour DATE NOT NULL,
CONSTRAINT PK_HISTORY PRIMARY KEY(club_name)
);

CREATE TABLE FILMKEYWORDS(
film_title VARCHAR2(100),
film_director VARCHAR2(100),
keyword1 VARCHAR2(50),
keyword2 VARCHAR2(50),
keyword3 VARCHAR2(50),
keyword4 VARCHAR2(50),
keyword5 VARCHAR2(50),
CONSTRAINT PK_FILMKEYWORDS PRIMARY KEY(film_title, film_director),
CONSTRAINT FK_FILMKEYWORDS FOREIGN KEY(film_title, film_director) REFERENCES FILMS
);

CREATE TABLE FILMIMDBDATA(
film_title VARCHAR2(100),
film_director VARCHAR2(100),
imdb_link VARCHAR2(100),
score VARCHAR2(100),
num_critics_reviews VARCHAR2(100),
num_users_reviews VARCHAR2(100),
num_voting_users VARCHAR2(100),
CONSTRAINT PK_FILMIMDBDATA PRIMARY KEY(film_title, film_director),
CONSTRAINT FK_FILMIMDBDATA FOREIGN KEY(film_title, film_director) REFERENCES FILMS
);

CREATE TABLE FILMGENRES(
film_title VARCHAR2(100),
film_director VARCHAR2(100),
genre1 VARCHAR2(30),
genre2 VARCHAR2(30),
genre3 VARCHAR2(30),
genre4 VARCHAR2(30),
genre5 VARCHAR2(30),
CONSTRAINT PK_FILMGENRES PRIMARY KEY(film_title, film_director),
CONSTRAINT FK_FILMGENRES FOREIGN KEY(film_title, film_director) REFERENCES FILMS
);

CREATE TABLE FILMCAST(
film_title VARCHAR2(100) NOT NULL,
film_director VARCHAR2(100) NOT NULL,
actor1_name VARCHAR2(100),
actor2_name VARCHAR2(100),
actor3_name VARCHAR2(100),
CONSTRAINT PK_FILMCAST PRIMARY KEY(film_title, film_director, actor1_name),
CONSTRAINT FK_FILMCAST FOREIGN KEY(film_title, film_director) REFERENCES FILMS
);

CREATE TABLE FILMFACEBOOKINFO(
film_title VARCHAR2(100),
film_director VARCHAR2(100),
film_likes VARCHAR2(100),
director_likes VARCHAR2(100),
actor1_likes VARCHAR2(100),
actor2_likes VARCHAR2(100),
actor3_likes VARCHAR2(100),
cast_likes VARCHAR2(100),
CONSTRAINT PK_FILMFACEBOOKINFO PRIMARY KEY(film_title, film_director),
CONSTRAINT FK_FILMFACEBOOKINFO FOREIGN KEY(film_title, film_director) REFERENCES FILMS
);
