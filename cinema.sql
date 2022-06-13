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
    id CHAR(36) PRIMARY KEY NOT NULL,
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

--CREATE TABLE bookings
(
    id CHAR(36) PRIMARY KEY NOT NULL,
    date_booking DATETIME NOT NULL,
    id_payment INT(24) NOT NULL,
    id_projection INT(10) NOT NULL,
    id_client CHAR(36) NOT NULL,
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
    id_client CHAR(36) NOT NULL,
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