-- Drop and recreate the database and user
DROP DATABASE IF EXISTS movie_management;
CREATE DATABASE movie_management;
USE movie_management;


-- Tables creation
CREATE TABLE movie (
    movieID INT NOT NULL AUTO_INCREMENT,
    movieTitle VARCHAR(50) NOT NULL,
    movieDesc VARCHAR(150),
    movieReleaseDate DATE,
    movieRuntime INT,
    movieCertificate ENUM('N/A', 'PG', '12', '12A', '15', '15A', '16', '18'),
    movieRating DECIMAL(2, 1) CHECK (movieRating BETWEEN 1 AND 5),
    PRIMARY KEY (movieID),
    CHECK (movieRuntime > 25)
);



CREATE TABLE poster (
    posterID INT NOT NULL AUTO_INCREMENT,
    posterLink VARCHAR(200) DEFAULT 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg',
    p_movieID INT NOT NULL,
    PRIMARY KEY (posterID),
    FOREIGN KEY (p_movieID) REFERENCES movie (movieID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS trailer (
    trailerID INT NOT NULL AUTO_INCREMENT,
    trailerLength INT,
    trailerURL VARCHAR(150),
    trailerType INT,
    t_movieID INT NOT NULL,
    PRIMARY KEY (trailerID),
    FOREIGN KEY (t_movieID) REFERENCES movie (movieID) ON DELETE CASCADE
);

CREATE TABLE studio (
    studioID INT NOT NULL AUTO_INCREMENT,
    studioName VARCHAR(50) NOT NULL,
    studioAddress VARCHAR(200),
    PRIMARY KEY (studioID)
);

CREATE TABLE movie_studio (
    movie_studioID INT NOT NULL AUTO_INCREMENT,
    m_movieID INT NOT NULL,
    s_studioID INT NOT NULL,
    PRIMARY KEY (movie_studioID),
    FOREIGN KEY (m_movieID) REFERENCES movie (movieID) ON DELETE CASCADE,
    FOREIGN KEY (s_studioID) REFERENCES studio (studioID) ON DELETE CASCADE
);

CREATE TABLE genre (
    genreID INT NOT NULL AUTO_INCREMENT,
    genreType VARCHAR(25) NOT NULL,
    genreDesc VARCHAR(200),
    PRIMARY KEY (genreID)
);

CREATE TABLE movie_genre (
    movie_genreID INT NOT NULL AUTO_INCREMENT,
    m_movieID INT NOT NULL,
    g_genreID INT NOT NULL,
    PRIMARY KEY (movie_genreID),
    FOREIGN KEY (m_movieID) REFERENCES movie (movieID) ON DELETE CASCADE,
    FOREIGN KEY (g_genreID) REFERENCES genre (genreID) ON DELETE CASCADE
);

CREATE TABLE person (
    personID INT NOT NULL AUTO_INCREMENT,
    personFirstName VARCHAR(50) NOT NULL,
    personLastName VARCHAR(50),
    personNationality VARCHAR(50),
    personPicture VARCHAR(150) DEFAULT 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg',
    PRIMARY KEY (personID)
);

CREATE TABLE role (
    roleID INT NOT NULL AUTO_INCREMENT,
    roleDesc VARCHAR(25) NOT NULL,
    m_movieID INT NOT NULL,
    p_personID INT NOT NULL,
    PRIMARY KEY (roleID),
    FOREIGN KEY (m_movieID) REFERENCES movie (movieID) ON DELETE CASCADE,
    FOREIGN KEY (p_personID) REFERENCES person (personID) ON DELETE CASCADE
);

CREATE TABLE movie_person (
    id INT NOT NULL AUTO_INCREMENT,
    movie_id INT NOT NULL,
    person_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (movie_id) REFERENCES movie (movieID) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES person ( personID) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role (roleID) ON DELETE CASCADE
);


CREATE TABLE soundtrack (
    soundtrackID INT NOT NULL AUTO_INCREMENT,
    soundtrackName VARCHAR(100) NOT NULL,
    soundtrackSize INT,
    m_movieID INT NOT NULL,
    PRIMARY KEY (soundtrackID),
    FOREIGN KEY (m_movieID) REFERENCES movie (movieID) ON DELETE CASCADE
);

CREATE TABLE song (
    songID INT NOT NULL AUTO_INCREMENT,
    songName VARCHAR(100) NOT NULL,
    songLength INT,
    songURL VARCHAR(150),
    PRIMARY KEY (songID)
);

CREATE TABLE soundtrack_song (
    soundtrack_songID INT NOT NULL AUTO_INCREMENT,
    soundtrack_soundtrackID INT NOT NULL,
    song_songID INT NOT NULL,
    PRIMARY KEY (soundtrack_songID),
    FOREIGN KEY (soundtrack_soundtrackID) REFERENCES soundtrack (soundtrackID) ON DELETE CASCADE,
    FOREIGN KEY (song_songID) REFERENCES song (songID) ON DELETE CASCADE
);

CREATE TABLE artiste (
    artisteID INT NOT NULL AUTO_INCREMENT,
    artisteName VARCHAR(50) NOT NULL,
    artisteNationality VARCHAR(50),
    PRIMARY KEY (artisteID)
);

CREATE TABLE song_artiste (
    song_artisteID INT NOT NULL AUTO_INCREMENT,
    s_songID INT NOT NULL,
    a_artisteID INT NOT NULL,
    PRIMARY KEY (song_artisteID),
    FOREIGN KEY (s_songID) REFERENCES song (songID) ON DELETE CASCADE,
    FOREIGN KEY (a_artisteID) REFERENCES artiste (artisteID) ON DELETE CASCADE
);

CREATE TABLE band (
    bandID INT NOT NULL AUTO_INCREMENT,
    bandName VARCHAR(25) NOT NULL,
    PRIMARY KEY (bandID)
);

CREATE TABLE song_band (
    song_bandID INT NOT NULL AUTO_INCREMENT,
    song_songID INT NOT NULL,
    b_bandID INT NOT NULL,
    PRIMARY KEY (song_bandID),
    FOREIGN KEY (song_songID) REFERENCES song (songID) ON DELETE CASCADE,
    FOREIGN KEY (b_bandID) REFERENCES band (bandID) ON DELETE CASCADE
);

CREATE TABLE artiste_band (
    artiste_bandID INT NOT NULL AUTO_INCREMENT,
    bandRole VARCHAR(50),
    b_bandID INT NOT NULL,
    a_artisteID INT NOT NULL,
    PRIMARY KEY (artiste_bandID),
    FOREIGN KEY (a_artisteID) REFERENCES artiste (artisteID) ON DELETE CASCADE,
    FOREIGN KEY (b_bandID) REFERENCES band (bandID) ON DELETE CASCADE
);


-- Create app_user table
CREATE TABLE app_user (
    userID INT NOT NULL AUTO_INCREMENT,
    userName VARCHAR(50) NOT NULL,
    userEmail VARCHAR(100) NOT NULL UNIQUE,
    userPassword VARCHAR(100) NOT NULL,
    userRole ENUM('admin', 'reviewer', 'viewer') DEFAULT 'viewer', -- Defined possible roles
    userJoinDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    userStatus ENUM('active', 'inactive', 'banned') DEFAULT 'active', -- Defined possible statuses
    PRIMARY KEY (userID)
);

-- Create user_movie_rating table
CREATE TABLE user_movie_rating (
    user_movie_ratingID INT NOT NULL AUTO_INCREMENT,
    u_userID INT NOT NULL,
    m_movieID INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating > 0 AND rating <= 5),
    review VARCHAR(500),
    PRIMARY KEY (user_movie_ratingID),
    FOREIGN KEY (u_userID) REFERENCES app_user (userID) ON DELETE CASCADE,
    FOREIGN KEY (m_movieID) REFERENCES movie (movieID) ON DELETE CASCADE
);






/* movie inserts */
INSERT INTO movie (movieID, movieTitle, movieDesc, movieReleaseDate, movieRuntime, movieCertificate, movieRating)
VALUES 
(1, 'The Shawshank Redemption', 'Two imprisoned men bond over a number of years', '1994-10-14', 142, '18', 4.5),
(2, 'The Godfather', 'The aging patriarch of an organized crime dynasty transfers control to his son', '1972-03-24', 175, '18', 4.5),
(3, 'The Dark Knight', 'The menace known as the joker wreaks havoc on Gotham City', '2008-07-18', 152, '12', 4.5),
(4, 'American Psycho', 'A wealthy New York investment banking executive hides his alternate psychopathic ego', '2000-04-14', 102, '18', 4),
(5, 'Pulp Fiction', 'The lives of two mod hit men, a boxer, a gangsters wife are all inter twinned', '1994-10-14', 154, '18', 4),
(6, 'The Matrix', 'A hacker learns from mysterious rebels about the true nature of his reality', '1999-03-31', 136, '18', 4),
(7, 'Logan', 'In a near future, a weary Logan cares for an ailing professor x', '2017-03-03', 135, '18', 5),
(8, 'The Prestige', 'Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion', '2006-10-20', 135, '12', 5),
(9, 'Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to save the human race', '2014-11-07', 169, '12', 5),
(10, 'The Wolf of Wall Street', 'Based on the true story of Jordan Belfort', '2013-12-25', 180, '18', 4);

/* poster inserts */
INSERT INTO poster (posterID, posterLink, p_movieID)
VALUES 
(1, 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg', 1),
(2, 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg', 2),
(3, 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg', 3),
(4, 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjIyMTYwMTI0N15BMl5BanBnXkFtZTgwNTU2NTYxMTE@._V1_SX300.jpg', 4),
(5, 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTkxMTA5OTAzMl5BMl5BanBnXkFtZTgwNjA5MDc3NjE@._V1_SX300.jpg', 5),
(6, 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg', 6),
(7, 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjI1MjkzMjczMV5BMl5BanBnXkFtZTgwNDk4NjYyMTI@._V1_SX300.jpg', 7),
(8, 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjA4NDI0MTIxNF5BMl5BanBnXkFtZTYwNTM0MzY2._V1_SX300.jpg', 8),
(9, 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg', 9),
(10, 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_SX300.jpg', 10);




/* trailer inserts */
INSERT INTO trailer (trailerID, trailerLength, trailerURL, trailerType, t_movieID)
VALUES 
(1, 120, 'https://www.youtube.com/watch?v=6hB3S9bIaco', 2, 1),
(2, 150, 'https://www.youtube.com/watch?v=sY1S34973zA', 2, 2),
(3, 180, 'https://www.youtube.com/watch?v=EXeTwQWrcwY', 3, 3),
(4, 180, 'https://www.youtube.com/watch?v=2GIsExb5jJU', 3, 4),
(5, 150, 'https://www.youtube.com/watch?v=s7EdQ4FqbhY', 2, 5),
(6, 180, 'https://www.youtube.com/watch?v=m8e-FF8MsqU', 3, 6),
(7, 150, 'https://www.youtube.com/watch?v=DekuSxJgpbY', 2, 7),
(8, 180, 'https://www.youtube.com/watch?v=o4gHCmTQDVI', 3, 8),
(9, 180, 'https://www.youtube.com/watch?v=zSWdZVtXT7E', 3, 9),
(10, 150, 'https://www.youtube.com/watch?v=iszwuX1AK6A', 2, 10),
(11, 180, 'https://www.youtube.com/watch?v=vKQi3bBA1y8', 3, 6),
(12, 150, 'https://www.youtube.com/watch?v=pabEtIERlic', 2, 10),
(13, 180, 'https://www.youtube.com/watch?v=5DO-nDW43Ik', 3, 2),
(14, 150, 'https://www.youtube.com/watch?v=ewlwcEBTvcg', 2, 5),
(15, 150, 'https://www.youtube.com/watch?v=Div0iP65aZo&t=15s', 2, 7),
(16, 200, 'https://www.youtube.com/watch?v=RH3OxVFvTeg', 4, 7);

/* studio inserts */
INSERT INTO studio (studioID, studioName, studioAddress)
VALUES 
(1, 'Castle Rock Studios', 'America'),
(2, 'Paramount Pictures', 'America'),
(3, 'Warner Bros', 'America'),
(4, 'Lionsgate Studios', 'America'),
(5, 'Miramax Films', 'America'),
(6, 'Road Show Entertainment', 'Australia'),
(7, 'Marvel Studios', 'America');

/* movie-studio inserts */
INSERT INTO movie_studio (movie_studioID, m_movieID, s_studioID)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 3),
(7, 7, 6),
(8, 8, 7),
(9, 9, 3),
(10, 10, 3),
(11, 10, 2);

/* genre inserts */
INSERT IGNORE INTO genre (genreID, genreType, genreDesc) VALUES 
(1, 'Drama', 'Drama film is a genre that relies on the emotional and relational development of realistic characters'),
(2, 'Crime', 'Films that focus on crime'),
(3, 'Action', 'Action film is a genre in which the protagonist or protagonists end up in a series of challenges that typically include violence, extended fighting, physical feats, and frantic chases.'),
(4, 'Comic Book', 'Film adaptions from comic books and graphic novels'),
(5, 'Sci-Fi', 'Films of speculative fiction, typically dealing with imaginative concepts such as futuristic science and tech'),
(6, 'Mystery', 'Is a type of fiction in which a detective, or other professional, solves a crime or series of crimes'),
(7, 'Adventure', 'An adventure is an event or series of events that happens outside the course of the protagonist''s ordinary life, usually accompanied by danger, often by physical action.'),
(8, 'Comedy', 'Comedy is a genre of film in which the main emphasis is on humor.');

/* movie-genre inserts */
INSERT IGNORE INTO movie_genre ( movie_genreID,  m_movieID, g_genreID) VALUES  
(1, 1, 1), 
(2, 2, 2), 
(3, 3, 1),
 (4, 4, 2), 
 (5, 5, 3), 
 (6, 6, 4), 
 (7, 7, 2), 
 (8, 8, 1), 
 (9, 9, 1), 
 (10, 10, 2), 
 (11, 10, 1);

/* person inserts */
INSERT IGNORE INTO person (personID, personFirstName, personLastName, personNationality, personPicture)
VALUES 
(1, 'Morgan', 'Freeman', 'American', 'http://www.imdb.com/name/nm0000151/'),
(2, 'Tim', 'Robbins', 'American', 'http://www.imdb.com/name/nm0000613/'),
(3, 'Marlon', 'Brando', 'American', 'http://www.imdb.com/name/nm0000008/'),
(4, 'Al', 'Pacino', 'American', 'http://www.imdb.com/name/nm0000199/'),
(5, 'Christian', 'Bale', 'British', 'http://www.imdb.com/name/nm0283478/'),
(6, 'Hugh', 'Jackman', 'Australian', 'http://www.imdb.com/name/nm0413168/'),
(7, 'Leonardo', 'DiCaprio', 'American', 'http://www.imdb.com/name/nm0000138/'),
(8, 'Jack', 'Nicholson', 'American', 'http://www.imdb.com/name/nm0000197/'),
(9, 'Kate', 'Winslet', 'British', 'http://www.imdb.com/name/nm0000701/'),
(10, 'Matthew', 'McConaughey', 'American', 'http://www.imdb.com/name/nm0000190/'),
(11, 'Matthew', 'Fox', 'American', 'http://www.imdb.com/name/nm0004909/');

/* movie-person inserts */

INSERT IGNORE INTO movie_person (id, movie_id, person_id, role_id)
VALUES  
    (1, 1, 1, 1),
    (2, 1, 2, 2),
    (3, 2, 3, 1),
    (4, 2, 4, 2),
    (5, 3, 5, 1),
    (6, 3, 6, 2),
    (7, 4, 7, 1),
    (8, 4, 8, 2),
    (9, 5, 9, 1),
    (10, 5, 10, 2),
    (11, 6, 11, 1),
    (12, 7, 12, 2),
    (13, 8, 13, 1),
    (14, 8, 14, 2),
    (15, 9, 15, 1),
    (16, 10, 16, 2);
    
/* role inserts */
INSERT INTO role (roleID, roleDesc, m_movieID, p_personID)
VALUES 
-- The Shawshank Redemption roles
(1, 'lead actor', 1, 1),  -- Morgan Freeman
(2, 'co-actor', 1, 2),    -- Tim Robbins
-- The Godfather roles
(3, 'lead actor', 2, 3),  -- Marlon Brando
(4, 'co-actor', 2, 4),    -- Al Pacino
-- The Dark Knight roles
(5, 'lead actor', 3, 5),  -- Christian Bale

(6, 'director', 3, 6),
(7, 'writer', 3, 6),
(8, 'lead actor', 4, 7),
(9, 'co-actor', 4, 8),
(10, 'director', 4, 8);


/* soundtrack inserts */

INSERT IGNORE INTO soundtrack ( soundtrackID, soundtrackName, soundtrackSize, m_movieID) VALUES
(1, 'The Shawshank Redemption Soundtrack', 5, 1),
(2, 'The Godfather Soundtrack', 6, 2),
(3, 'The Dark Knight', 5, 3),
(4, 'American Psycho: Music from the Controversial movie picture', 10, 4),
(5, 'Music from the Motion Picture Pulp Fiction', 16, 5),
(6, 'The Matrix, Music, Music from the Motion Picture', 13, 6),
(7, 'Logan Music', 16, 7),
(8, 'The Prestige: Original Score', 17, 8),
(9, 'Interstellar Soundtrack', 16, 9),
(10, 'The Wolf Of Wall Street', 16, 10);



/* song inserts */
INSERT INTO song (songID, songName, songLength, songURL)
VALUES
(1, 'May', NULL, 'www.youtube.com/may'),
(2, 'Shawshank Prison', NULL, 'www.youtube.com/shawshankprison'),
(3, 'New Fish', NULL, 'www.youtube.com/newfish'),
(4, 'Rock Hammer', NULL, 'www.youtube.com/rockhammer'),
(5, 'An Inch of his life', NULL, 'www.youtube.com/aninchofhislife'),
(6, 'The Godfather Waltz', NULL, 'www.youtube.com/thewaltz'),
(7, 'I have but one heart', NULL, 'www.youtube.com/ihavebutoneheart'),
(8, 'The Pickup', NULL, 'www.youtube.com/thepickup'),
(9, 'Connies Wedding', NULL, 'www.youtube.com/connieswedding'),
(10, 'Miller Compilation', NULL, 'www.youtube.com/millercompilation'),
(11, 'Hip to be Square', NULL, 'www.youtube.com/hiptobesquare'),
(12, 'You Spin me Round', NULL, 'www.youtube.com/youspinmeround'),
(13, 'Jungle Boogie', NULL, 'www.youtube.com/jungleboogie'),
(14, 'Son of a Preacher Man', NULL, 'www.youtube.com/sonofapreacherman'),
(15, 'Girl, Youll be a Woman Soon', NULL, 'www.youtube.com/youllbeawomansoon'),
(16, 'Rock is Dead', NULL, 'www.youtube.com/rockisdead'),
(17, 'Mindfields', NULL, 'www.youtube.com/mindfields'),
(18, 'Du Hast', NULL, 'www.youtube.com/duhast'),
(19, 'Dragula', NULL, 'www.youtube.com/dragula'),
(20, 'Make it Bang', NULL, 'www.youtube.com/makeitbang'),
(21, 'I got a name', NULL, 'www.youtube.com/igotaname'),
(22, 'Are you watching closely', NULL, 'www.youtube.com/areyouwatching'),
(23, 'The light field', NULL, 'www.youtube.com/thelightfield'),
(24, 'Border Meets Sarah', NULL, 'www.youtube.com/bordermeetssarah'),
(25, 'No, not today', NULL, 'www.youtube.com/nonottoday'),
(26, 'Interstellar compilation', NULL, 'https://www.youtube.com/watch?v=iBfk37Fa3H0'),
(27, 'Bang Bang', NULL, 'www.youtube.com/bangbang'),
(28, 'Pretty Thing', NULL, 'www.youtube.com/prettything'),
(29, 'Smokestack Lightning', NULL, 'www.youtube.com/smokestack');

/* soundtrack-song inserts */
INSERT INTO soundtrack_song (soundtrack_soundtrackID, song_songID) VALUES
(1, 1),  -- Shawshank Redemption soundtrack songs
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),  -- Godfather soundtrack songs
(2, 7),
(2, 8),
(2, 9),
(3, 10), -- Dark Knight soundtrack songs
(4, 11), -- American Psycho soundtrack songs
(4, 12),
(5, 13), -- Pulp Fiction soundtrack songs
(5, 14),
(5, 15),
(6, 16), -- Matrix soundtrack songs
(6, 17),
(6, 18),
(6, 19),
(7, 20), -- Logan soundtrack songs
(7, 21),
(8, 22), -- Prestige soundtrack songs
(8, 23),
(8, 24),
(8, 25),
(9, 26), -- Interstellar soundtrack songs
(10, 27), -- Wolf of Wall Street soundtrack songs
(10, 28),
(10, 29);


/* artiste inserts */
INSERT IGNORE INTO artiste (artisteID, artisteName, artisteNationality) VALUES
(1, 'Thomas Newman', 'American'),
(2, 'Nino Rota', 'Italian'),
(3, 'Joe Bloggs', 'British'),
(4, 'Carmine Coppola', 'Italian'),
(5, 'Hans Zimmer', 'German'),
(6, 'Hughie Lewis', 'American'),
(7, 'Edsel Dope', 'American'),
(8, 'Acey Slade', 'American'),
(9, 'Racci Shay', 'American'),
(10, 'Virus', 'American'),
(11, 'John Hurley', 'American'),
(12, 'Neil Diamond', 'American'),
(13, 'Robert Bell', 'American'),
(14, 'Ronald Bell', 'American'),
(15, 'George Brown', 'American'),
(16, 'Lavell Evans', 'American'),
(17, 'Amir Bayyan', 'American'),
(18, 'Marilyn Manson', 'American'),
(19, 'Liam Howlett', 'British'),
(20, 'Keith Flint', 'British'),
(21, 'Maxim', 'British'),
(22, 'Till Lindemann', 'German'),
(23, 'Richard Z. Kruspe', 'German'),
(24, 'Paul Landers', 'German'),
(25, 'Christoph Schneider', NULL),
(26, 'Rob Zombie', NULL),
(27, 'Baauer', NULL),
(28, 'Jim Croce', NULL),
(29, 'David Julyan', 'American'),
(30, 'Joe Cuba', NULL),
(31, 'Bo Diddley', 'American'),
(32, 'Howlin Wolf', 'American');


/* song-artiste inserts */
INSERT IGNORE INTO song_artiste (song_artisteID, s_songID,  a_artisteID) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 2),
(7, 7, 3),
(8, 8, 2),
(9, 9, 4),
(10, 10, 5),
(11, 11, 6),
(12, 14, 11),
(13, 15, 12),
(14, 16, 18),
(15, 19, 26),
(16, 20, 27),
(17, 21, 28),
(18, 22, 29),
(19, 23, 29),
(20, 24, 29),
(21, 25, 29),
(22, 26, 5),
(23, 27, 30),
(24, 28, 31),
(25, 29, 32);


/* band inserts */
INSERT IGNORE INTO band ( bandID, bandName) VALUES
(1, 'Dope'),
(2, 'Kool and the Gang'),
(3, 'The Prodigy'),
(4, 'Rammstein');


/* song-band inserts */
INSERT IGNORE INTO song_band (song_bandID, song_songID, b_bandID) VALUES
(1, 12, 1),
(2, 13, 2),
(3, 17, 3),
(4, 18, 4);


/* artiste-band inserts */

INSERT IGNORE INTO artiste_band (artiste_bandID, bandRole, b_bandID, a_artisteID)
VALUES
    (1, 'lead vocals', 1, 7),
    (2, 'bass', 1, 8),
    (3, 'drums', 1, 9),
    (4, 'lead guitar', 1, 10),
    (5, 'bass', 2, 13),
    (6, 'saxophone', 2, 14),
    (7, 'drums', 2, 15),
    (8, 'lead vocals', 2, 16),
    (9, 'guitar', 2, 17),
    (10, 'Keyboards', 3, 19),
    (11, 'dancer', 3, 20),
    (12, 'MC', 3, 21),
    (14, 'lead vocals', 4, 22),
    (15, 'lead guitar', 4, 23),
    (16, 'bass', 4, 24),
    (17, 'drums', 4, 25);



-- Insert admin user
INSERT INTO app_user (userName, userEmail, userPassword, userRole)
VALUES 
('Admin', 'admin@akl.com', 'lajim1234', 'admin');

-- Insert reviewer users
INSERT INTO app_user (userName, userEmail, userPassword, userRole)
VALUES 
('Reviewer', 'asif.reviewer@example.com', 'password123', 'reviewer'),
('Rafi Critic', 'Rafi.critic@example.com', 'pass123', 'reviewer');

-- Insert viewer users
INSERT INTO app_user (userName, userEmail, userPassword)
VALUES 
('Alice Viewer', 'alice.viewer@example.com', 'viewerpass123'),
('Bob Watcher', 'bob.watcher@example.com', 'passw0rd'),
('Charlie FilmFan', 'charlie.filmfan@example.com', 'movielover789');

-- Insert users with different statuses
INSERT INTO app_user (userName, userEmail, userPassword, userStatus)
VALUES 
('Inactive User', 'inactive.user@example.com', 'inactivepass', 'inactive'),
('Banned User', 'banned.user@example.com', 'bannedpass', 'banned');

CREATE VIEW viewer_movies AS
SELECT movieID, title, description, releaseDate
FROM movies;


-- Grant admin full access
GRANT ALL PRIVILEGES ON movie_database.* TO 'admin_user'@'localhost';

-- Grant read-only access to viewers
GRANT SELECT ON movie_database.* TO 'viewer_user'@'localhost';

-- Grant insert, update, and select access to reviewers
GRANT SELECT, INSERT, UPDATE ON movie_database.* TO 'reviewer_user'@'localhost';


