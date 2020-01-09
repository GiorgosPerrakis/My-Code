CREATE TABLE `users_2018_ex3_8110111` (
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




INSERT INTO `users_2018_ex3_8110111` VALUES ('jdoe','John','Doe','jdoe@example.com','1111'),('joken','Jim','Oken','joken@somewhere.gr','1111'),('msmith','Mary','Smith','msmith@example.com','1111');