-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: 195.251.249.131    Database: ismgroup21
-- ------------------------------------------------------
-- Server version	5.6.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `ACTIV_NAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIV_REGION` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIV_SEX` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIV_AGE` int(11) NOT NULL,
  `ACTIV_ACTIVITY_ID` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIV_IMAGE` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIV_PRICE` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIV_NUMBER_TICKETS` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ACTIV_ACTIVITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizer`
--

DROP TABLE IF EXISTS `organizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizer` (
  `ORG_COMPANY_NAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ORG_ID` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ORG_AFM` int(11) NOT NULL,
  `ORG_EMAIL` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ORG_TEL` int(11) NOT NULL,
  `ORG_NAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ORG_SURNNAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ORG_USERNAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ORG_PASSWORD` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizer`
--

LOCK TABLES `organizer` WRITE;
/*!40000 ALTER TABLE `organizer` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `USER_NAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `USER_SURNAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `USER_EMAIL` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `USER_USERNAME` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `USER_Password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`USER_USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-08 16:29:28
