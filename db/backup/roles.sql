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
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `role_type` varchar(60) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `role_type`, `description`) VALUES 
(1,'Hero','cast','This is Hero'),
(2,'Heroine','cast','This is Heroine'),
(3,'Villain','cast','This is Villain'),
(4,'Vamp','cast','This is Vamp'),
(5,'Comedian','cast','This is Comedian'),
(6,'Supporting Actor','cast','This is Supporting Actor'),
(7,'Guest Appearance','cast','This is Guest Appearance'),
(8,'Producer','crew', 'This is Producer'),
(9,'Director','crew', 'This is Director'),
(10,'Writer','crew', 'This is Writer'),
(11,'Screenplay         ','crew', 'This is Screenplay   '),
(12,'Cinematographer','crew', 'This is Cinematographer'),
(13,'Director of Photography','crew', 'This is Director of Photography'),
(14,'Production Designer','crew', 'This is Production Designer'),
(15,'Art Director','crew', 'This is Art Director'),
(16,'Action Director','crew', 'This is Action Director'),
(17,'Editor','crew', 'This is Editor'),
(18,'Sound Designer','crew', 'This is Sound Designer'),
(19,'Costumes','crew', 'This is Costumes'),
(20,'Music Director','crew', 'This is Music Director'),
(21,'Lyricist','crew', 'This is Lyricist'),
(22,'Singer','crew', 'This is Singer'),
(23,'Choreographer','crew', 'This is Choreographer'),
(24,'Co-producer','crew', 'This is Co-producer'),
(25,'Associate Producer','crew', 'This is Associate Producer'),
(26,'Executive Producer','crew', 'This is Executive Producer'),
(27,'Associate Director','crew', 'This is Associate Director'),
(28,'Assistant Director','crew', 'This is Assistant Director'),
(29,'Story','crew', 'This is Story'),
(30,'Dialogues','crew', 'This is Dialogues'),
(31,'Chief Assistant Director','crew', 'This is Chief Assistant Director'),
(32,'Creative Producer','crew', 'This is Creative Producer'),
(33,'Line Producer','crew', 'This is Line Producer'),
(34,'Make-up','crew', 'This is Make-up'),
(35,'Thrills','crew', 'This is Thrills'),
(36,'Song Direction','crew', 'This is Song Direction'),
(37,'Visual Effects','crew', 'This is Visual Effects'),
(38,'Mixing Engineer','crew', 'This is Mixing Engineer'),
(39,'Production Co-Ordinator','crew', 'This is Production Co-Ordinator'),
(40,'Production Executive','crew', 'This is Production Executive'),
(41,'Production Manager','crew', 'This is Production Manager'),
(42,'Production Controller','crew', 'This is Production Controller'),
(43,'Costume Coordinator','crew', 'This is Costume Coordinator'),
(44,'Marketing','crew', 'This is Marketing'),
(45,'Publicity Campaign','crew', 'This is Publicity Campaign'),
(46,'Supporting Actress','cast','This is Supporting Actress');

/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-05-14 20:54:47
