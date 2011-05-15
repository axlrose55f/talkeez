-- MySQL dump 10.13  Distrib 5.1.56, for apple-darwin10.3.0 (i386)
--
-- Host: localhost    Database: talkeez
-- ------------------------------------------------------
-- Server version	5.1.56

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
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` (`id`, `name`, `description`) VALUES 
(1,'Action','This is Action'),
(2,'Adult','This is Adult'),
(3,'Adventure','This is Adventure'),
(4,'Animation','This is Animation'),
(5,'Biography','This is Biography'),
(6,'Children','This is Children'),
(7,'Comedy','This is Comedy'),
(8,'Crime','This is Crime'),
(9,'Documentary','This is Documentary'),
(10,'Drama','This is Drama'),
(11,'Family','This is Family'),
(12,'Fantasy','This is Fantasy'),
(13,'Film-Noir','This is Film-Noir'),
(14,'Foreign','This is Foreign'),
(15,'Game','This is Game'),
(16,'Health','This is Health'),
(17,'History','This is History'),
(18,'Horror','This is Horror'),
(19,'Music','This is Music'),
(20,'Musical','This is Musical'),
(21,'Mystery','This is Mystery'),
(22,'Mythological','This is Mythological'),
(23,'News','This is News'),
(24,'Patriotic','This is Patriotic'),
(25,'Period','This is Period'),
(26,'Reality-TV','This is Reality-TV'),
(27,'Romance','This is Romance'),
(28,'Sci-Fi','This is Sci-Fi'),
(29,'Social','This is Social'),
(30,'Special','This is Special'),
(31,'Sports','This is Sports'),
(32,'Sports','This is Sports'),
(33,'Talk','This is Talk'),
(34,'Thriller','This is Thriller'),
(35,'War','This is War'),
(36,'Western','This is Western');

/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-05-14 21:01:46
