/*
  Just a basic db build for now
*/

CREATE DATABASE restApp;

USE restApp;

/* watch out for these lines - remove later */
drop table restaurants;
drop table diners;

CREATE TABLE restaurants (
  `restaurantID` int(100) NOT NULL AUTO_INCREMENT,
  `restaurantName` varchar(50) NOT NULL,
  `priceRange` int NOT NULL DEFAULT 1,
  `address` varchar(50) NOT NULL,
  `latitude` double NOT NULL DEFAULT 0,
  `longitude` double NOT NULL DEFAULT 0,
  `cuisine` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT now(),
  `available` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`restaurantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE diners (
  `customerId` int(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL UNIQUE,
  `name` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL UNIQUE,
  `reservationsMade` int(50) NOT NULL DEFAULT 0,
  PRIMARY KEY (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* test data */
insert into diners (username, name, email, reservationsMade) values ('armando', 'Armando', 'aaa@aaa.com', 12);
insert into diners (username, name, email, reservationsMade) values ('david', 'David', 'bbb@bbb.com', 34);
insert into diners (username, name, email, reservationsMade) values ('mai', 'Mai', 'ccc@ccc.com', 143);
insert into diners (username, name, email, reservationsMade) values ('eddie', 'Eddie', 'ddd@ddd.com', 4);

insert into restaurants (restaurantName, address, cuisine) values ('Zuni Cafe', '1658 Market St, San Francisco, CA', 'mediterranean');
insert into restaurants (restaurantName, address, cuisine, available) values ('Brenda\'s French Soul Food', '652 Polk St, San Francisco, CA', 'soul', 1);
insert into restaurants (restaurantName, address, cuisine, available) values ('Absinthe Brasserie and Bar', '398 Hayes St, San Francisco, CA', 'french', 1);

update restaurants set latitude=37.773646, longitude=-122.421573, priceRange = 3 where restaurantId=1;

update restaurants set latitude=37.782922, longitude=-122.418893 where restaurantId=2;

update restaurants set latitude=37.777048, longitude=-122.422912 where restaurantId=3;