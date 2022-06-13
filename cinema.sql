-- connexion au serveur MySQL

mysql -u root -p 

-- Afficher la liste des bases de données
SHOW databases;

-- Création de la  base de données
CREATE DATABASE  cinema_booking ;

-- Sélectionner la bbd à utiliser pour la création de table
USE cinema_booking ;



------------------------
-- Creation des tables--
------------------------


CREATE TABLE administrator
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_login VARCHAR(20) NOT NULL ,
    email VARCHAR(80) NOT NULL,
    password VARCHAR(60) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE managers
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_login VARCHAR(20) NOT NULL,
    email VARCHAR(80) NOT NULL,
    password VARCHAR(60) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(40) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE cinema_complex
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cinema_name VARCHAR(60) NOT NULL,
    cinema_phone VARCHAR(10),
    cinema_address VARCHAR(100),
    cinema_zipcode CHAR(5),
    cinema_city VARCHAR(30),
    number_of_rooms INT(6),
    id_administrator int(10) NOT NULL,
    id_managers int(10) NOT NULL,
    FOREIGN KEY(id_administrator) REFERENCES administrator(id),
    FOREIGN KEY(id_managers) REFERENCES managers(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE movierooms
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    number_of_seats int(5) NOT NULL,
    id_complex int(10) NOT NULL,
    FOREIGN KEY(id_complex) REFERENCES cinema_complex(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE movies
(
    id INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    movie_title VARCHAR(60) NOT NULL,
    movie_duration TIME NOT NULL,
    directed_by VARCHAR(100) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE projections 
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    projection_start DATETIME NOT NULL,
    id_movie_room INT(10) NOT NULL,
    id_manager INT(10) NOT NULL,
    id_movie INT(10) NOT NULL,
    FOREIGN KEY(id_movie_room) REFERENCES movierooms(id),
    FOREIGN KEY(id_manager) REFERENCES managers(id),
    FOREIGN KEY(id_movie) REFERENCES movies(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE prices_list
(
    id INT(4) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    prices_description VARCHAR(120) NOT NULL,
    prices DECIMAL(4,2) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE clients
(
    id INT(18) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_login VARCHAR(20),
    email VARCHAR(80),
    password VARCHAR(60),
    first_name VARCHAR(30),
    last_name VARCHAR(60),
    date_of_birth date NOT NULL,
    id_prices_list INT(4) NOT NULL,
    FOREIGN KEY(id_prices_list) REFERENCES prices_list(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


CREATE TABLE payments
(
    id INT(24) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    type_payment VARCHAR(30) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE bookings
(
    id CHAR(36) PRIMARY KEY NOT NULL,
    date_booking DATETIME NOT NULL,
    id_payment INT(24) NOT NULL,
    id_projection INT(10) NOT NULL,
    id_client INT(18) NOT NULL,
    id_movie_room INT(10) NOT NULL,
    FOREIGN KEY(id_payment) REFERENCES payments(id),
    FOREIGN KEY(id_projection) REFERENCES projections(id),
    FOREIGN KEY(id_client) REFERENCES clients(id),
    FOREIGN KEY(id_movie_room) REFERENCES movierooms(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


CREATE TABLE bookings
(
    id CHAR(36) PRIMARY KEY NOT NULL,
    date_booking DATETIME NOT NULL,
    id_payment INT(24) NOT NULL,
    id_projection INT(10) NOT NULL,
    id_client INT(18) NOT NULL,
    id_movie_room INT(10) NOT NULL,
    id_movie INT(12) NOT NULL,
    id_cinema_complex INT(10) NOT NULL,
    FOREIGN KEY(id_payment) REFERENCES payments(id),
    FOREIGN KEY(id_projection) REFERENCES projections(id),
    FOREIGN KEY(id_client) REFERENCES clients(id),
    FOREIGN KEY(id_movie_room) REFERENCES movierooms(id),
    FOREIGN KEY(id_movie) REFERENCES movies(id),
    FOREIGN KEY(id_cinema_complex) REFERENCES cinema_complex(id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;




--------------------------------------------------------------
--Insertions des scripts d'alimentation factices dans la BDD--
--------------------------------------------------------------


INSERT INTO administrator(user_login, email, password) 
VALUES ('1z5zeaf5', 'jerome@mail.com', '$2y$10$Ww2Q95rjnDGNC56ZVJQKdOwoRJgCf7J1AOGKSUT7rQUziuFb1p2AC');

INSERT INTO managers (user_login, email, password, first_name, last_name) 
VALUES 
('ze4ez5', 'paul@mail.com', '$2y$10$OGU4lK44wksDARlCQsEOD.FibZrlbIpwmDviBIlQiOxqUdn5OXGci', 'Paul', 'Durant'),
('5zg5z1', 'pierre@mail.com', '$2y$10$1s8Vjc9taJZu2POwKql2xeHmVpvXMvYISxUs/fD2Jq0skJ/EY7rHq', 'Pierre', 'Dupont'),
('gh787r', 'maurice@mail.com', '$2y$10$OGU4lK44wksDARlCQsEOD.FibZrlbIpwmDviBIlQiOxqUdn5OXGci', 'Maurice', 'Martin');

INSERT INTO cinema_complex (cinema_name, cinema_phone, cinema_address, cinema_zipcode, cinema_city, number_of_rooms, id_administrator, id_managers )  
VALUES 
( 'Grand Rex', '0238565854', '12, rue de la République', '45000', 'Orléans', '7', '1', '1' ),
( 'Moyen Rex', '0254125654', '1, place de la Mairie', '41000', 'Blois', '7', '1', '2' ),
( 'Ptit Rex', '0227852654', '22, rue de la Loire', '37000', 'Tours', '7', '1', '3' );

INSERT INTO movierooms (number_of_seats, id_complex)
VALUES 
('452', '1'), ('214', '1'), ('236', '1'), ('214', '2'), ('178', '2'), ('90', '3');


INSERT INTO movies (movie_title, movie_duration, directed_by) 
VALUES 
('Dune', '02:35:00', 'Denis Villeneuve'),
('Annette', '02:20:00', 'Leos Carax'),
('The Father', '01:38:00', 'Florian Zeller'),
('Le Dernier Duel', '02:32:00', 'Ridley Scott'),
('Titane', '01:48:00', 'Julia Ducourneau'),
('Last Night in Soho', '01:56:00', 'Edgar Wright');

INSERT INTO projections (projection_start, id_movie_room, id_manager, id_movie) 
VALUES
('2022-07-10 10:00:00', '2', '1', '2'),
('2022-07-10 10:00:00', '3', '1', '3'),
('2022-07-10 10:00:00', '4', '1', '4'),
('2022-07-10 10:00:00', '5', '1', '5'),
('2022-07-10 10:00:00', '6', '2', '1');

INSERT INTO prices_list(prices_description, prices) 
VALUES
('Plein Tarif', '9.20'),
('Étudiant', '7.60'),
('Moins de 14 ans', '5.90');

INSERT INTO clients (user_login, email, password, first_name, last_name, date_of_birth, id_prices_list) 
VALUES
( 'adupont', 'arthur.dupont@aol.com', '$2y$10$o3sIDPMYZ89uyQFOegRUxuce49v2EcLHf6z./OXFB4cg10h.fHZc6', 'Arthur', 'Martin', '1995-07-30', '1'),
( 'mpivert', 'momodu45@orange.fr', '$2y$10$RkKTjJ2iqS9nLjzemUl/qu89MIQ7MMsRizzxcR3hvwEbTc/7AvDqq', 'Maurice', 'Pivert', '1955-02-17', '1'),
( 'kfillio', 'katia.fifi@hotmail.com', '$2y$10$WakiGrUNZr/CA4LVZpus0e6Ejc3XR27Xp7wAY1aWWfg8p152FMzZ6', 'Katia', 'Fillio', '2001-10-06', '2'),
( 'mdialo', 'momodi@gmail.com', '$2y$10$KJpG.9kiYyNc2RzObqlTwu/UUjTT2Jyjw7y2Vap03nUF2KVJ7FWZq', 'Mamadou', 'Dialo', '1999-01-03', '3'),
( 'dlachaise', 'dylan.lachaise@hotmail.com', '$2y$10$/1kcML9ur4cOlwqpgshjauaG3d0pFWZtXFYdp7nbTneGnWRe6F0wG', 'Dylan', 'Lachaise', '2010-08-12','3'),
( 'nvebra', 'nina06@gmail.com', '$2y$10$zhXTDrE.pcXYuQOlLxPe0eFEzokDPnXOoeRcOlqWdkdRpV3GfrU76', 'Nina', 'Vebra', '2014-11-06','3');

INSERT INTO payments(type_payment) 
VALUES ('Sur place'), ('En ligne');


INSERT INTO bookings(id, date_booking, id_payment, id_projection, id_client, id_movie_room, id_movie, id_cinema_complex)
VALUES 
( UUID(),'2022-08-14 10:00:00', '1', '1', '1','4', '1', '1'),
( UUID(),'2022-08-15 10:00:00', '1', '2', '2','3', '1', '1'),
( UUID(),'2022-08-15 10:00:00', '2', '3', '3','2', '2', '2'),
( UUID(),'2022-08-16 16:00:00', '2', '4', '4','2', '3', '3');