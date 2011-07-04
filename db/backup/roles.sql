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
(7,'Supporting Actress','cast','This is Supporting Actress'),
(8,'Guest Appearance','cast','This is Guest Appearance'),
(9,'Friendly Appearance','cast','This is Friendly Appearance'),
(10,'Artist','cast','This is Artist'),
(21,'Accounts Department','crew', 'This is Accounts Department'),
(22,'Action Co-ordinator','crew', 'This is Action Co-ordinator'),
(23,'Action Director','ProductionCrew', 'This is Action Director'),
(24,'Animators','crew', 'This is Animators'),
(25,'Art Director','ProductionCrew', 'This is Art Director'),
(26,'Assistant Action Director','crew', 'This is Assistant Action Director'),
(27,'Assistant Art Director','crew', 'This is Assistant Art Director'),
(28,'Assistant Choreographer','crew', 'This is Assistant Choreographer'),
(29,'Assistant Cinematographer','crew', 'This is Assistant Cinematographer'),
(30,'Assistant Costume Designer','crew', 'This is Assistant Costume Designer'),
(31,'Assistant Director','crew', 'This is Assistant Director'),
(32,'Assistant Editor','crew', 'This is Assistant Editor'),
(33,'Assistant Line Producer','crew', 'This is Assistant Line Producer'),
(34,'Assistant Make-Up Designer','crew', 'This is Assistant Make-Up Designer'),
(35,'Assistant Sound Designer','crew', 'This is Assistant Sound Designer'),
(36,'Associate Director','crew', 'This is Associate Director'),
(37,'Associate Producer','crew', 'This is Associate Producer'),
(38,'Associate Screenplay','crew', 'This is Associate Screenplay'),
(39,'Audiography','crew', 'This is Audiography'),
(40,'Background Sound','crew', 'This is Background Sound'),
(41,'Banner','ProductionCrew', 'This is Banner'),
(42,'Boom Operators','crew', 'This is Boom Operators'),
(43,'Camera Attendants','crew', 'This is Camera Attendants'),
(44,'Casting Director','crew', 'This is Casting Director'),
(45,'Censor','crew', 'This is Censor'),
(46,'Chartered Accountant','crew', 'This is Chartered Accountant'),
(47,'Chief Assistant Action Director','crew', 'This is Chief Assistant Action Director'),
(48,'Chief Assistant Choreographer','crew', 'This is Chief Assistant Choreographer'),
(49,'Chief Assistant Cinematographer','crew', 'This is Chief Assistant Cinematographer'),
(50,'Chief Assistant Director','crew', 'This is Chief Assistant Director'),
(51,'Chief Assistant Editor','crew', 'This is Chief Assistant Editor'),
(52,'Chief Assistant Sound Designer','crew', 'This is Chief Assistant Sound Designer'),
(53,'Chief Of Production','crew', 'This is Chief Of Production'),
(54,'Choreographer','ProductionCrew', 'This is Choreographer'),
(55,'Cinematographer','ProductionCrew', 'This is Cinematographer'),
(56,'Co-Producer','crew', 'This is Co-Producer'),
(57,'Colorist','crew', 'This is Colorist'),
(58,'Costume Coordinator','crew', 'This is Costume Coordinator'),
(59,'Costume Designer','crew', 'This is Costume Designer'),
(60,'Costumes','crew', 'This is Costumes'),
(61,'Crane Operators','crew', 'This is Crane Operators'),
(62,'Creative Director','crew', 'This is Creative Director'),
(63,'Creative Producer','crew', 'This is Creative Producer'),
(64,'Crew','crew', 'This is Crew'),
(65,'Dialogue Writer','ProductionCrew', 'This is Dialogue Writer'),
(66,'Dialogues','crew', 'This is Dialogues'),
(67,'Digital Intermediate','crew', 'This is Digital Intermediate'),
(68,'Director','ProductionCrew', 'This is Director'),
(69,'Director of Photography','crew', 'This is Director of Photography'),
(70,'Dressman','crew', 'This is Dressman'),
(71,'Dubbing and Foley Studio','crew', 'This is Dubbing and Foley Studio'),
(72,'Editor','ProductionCrew', 'This is Editor'),
(73,'Executive Producer','ProductionCrew', 'This is Executive Producer'),
(74,'Film Scanning Operator','crew', 'This is Film Scanning Operator'),
(75,'Film Scanning Supervisor','crew', 'This is Film Scanning Supervisor'),
(76,'First Assistant Cinematographer','crew', 'This is First Assistant Cinematographer'),
(77,'First Assistant Director','crew', 'This is First Assistant Director'),
(78,'Foley Artist','crew', 'This is Foley Artist'),
(79,'Fous Puller','crew', 'This is Fous Puller'),
(80,'Gaffer','crew', 'This is Gaffer'),
(81,'Hair Designer','crew', 'This is Hair Designer'),
(82,'Internet Campaign','crew', 'This is Internet Campaign'),
(83,'Jimmy Jib Operators','crew', 'This is Jimmy Jib Operators'),
(84,'Lab','crew', 'This is Lab'),
(85,'Legal Advisor','crew', 'This is Legal Advisor'),
(86,'Line Producer','crew', 'This is Line Producer'),
(87,'Lyricist','ProductionCrew', 'This is Lyricist'),
(88,'Make-up','crew', 'This is Make-up'),
(89,'Make-up Designer','crew', 'This is Make-up Designer'),
(90,'Marketing','crew', 'This is Marketing'),
(91,'Marketing and Promotions','crew', 'This is Marketing and Promotions'),
(92,'Media Relations','crew', 'This is Media Relations'),
(93,'Mixing Engineer','crew', 'This is Mixing Engineer'),
(94,'Modelers','crew', 'This is Modelers'),
(95,'Music Company','crew', 'This is Music Company'),
(96,'Music Director','ProductionCrew', 'This is Music Director'),
(97,'Music by','ProductionCrew', 'This is Music by'),
(98,'Negative Editor','crew', 'This is Negative Editor'),
(99,'On Air Promos','crew', 'This is On Air Promos'),
(100,'Playback Singer','ProductionCrew', 'This is Playback Singer'),
(101,'Presenter','crew', 'This is Presenter'),
(102,'Producer','ProductionCrew', 'This is Producer'),
(103,'Production Co-Ordinator','crew', 'This is Production Co-Ordinator'),
(104,'Production Controller','crew', 'This is Production Controller'),
(105,'Production Designer','crew', 'This is Production Designer'),
(106,'Production Executive','crew', 'This is Production Executive'),
(107,'Production Executives','crew', 'This is Production Executives'),
(108,'Production Manager','crew', 'This is Production Manager'),
(109,'Publicity Campaign','crew', 'This is Publicity Campaign'),
(110,'Publicity Consultant','crew', 'This is Publicity Consultant'),
(111,'Publicity Designer','crew', 'This is Publicity Designer'),
(112,'Publicity Printer','crew', 'This is Publicity Printer'),
(113,'Re-Recording Assistant','crew', 'This is Re-Recording Assistant'),
(114,'Re-Recording Engineer','crew', 'This is Re-Recording Engineer'),
(115,'Recording','crew', 'This is Recording'),
(116,'Recordist Mixer','crew', 'This is Recordist Mixer'),
(117,'Screenplay','crew', 'This is Screenplay'),
(118,'Screenplay Writer','ProductionCrew', 'This is Screenplay Writer'),
(119,'Script Consultant','crew', 'This is Script Consultant'),
(120,'Script Supervisor & Continuity','crew', 'This is Script Supervisor & Continuity'),
(121,'Second Assistant Cinematographer','crew', 'This is Second Assistant Cinematographer'),
(122,'Second Assistant Director','crew', 'This is Second Assistant Director'),
(123,'Singer','ProductionCrew', 'This is Singer'),
(124,'Song Director','ProductionCrew', 'This is Song Director'),
(125,'Song Recording Engineer','crew', 'This is Song Recording Engineer'),
(126,'Sound Attendants','crew', 'This is Sound Attendants'),
(127,'Sound Designer','crew', 'This is Sound Designer'),
(128,'Sound Post Production','crew', 'This is Sound Post Production'),
(129,'Special Appearance','crew', 'This is Special Appearance'),
(130,'Special Stills','crew', 'This is Special Stills'),
(131,'Steadicam Operators','crew', 'This is Steadicam Operators'),
(132,'Still Photographer','crew', 'This is Still Photographer'),
(133,'Story','crew', 'This is Story'),
(134,'Story Writer','ProductionCrew', 'This is Story Writer'),
(135,'Storyboard','crew', 'This is Storyboard'),
(136,'Supervising Producer','crew', 'This is Supervising Producer'),
(137,'Supporting Actress','crew', 'This is Supporting Actress'),
(138,'Sync Sound','crew', 'This is Sync Sound'),
(139,'Thrills','crew', 'This is Thrills'),
(140,'Visual Effects','crew', 'This is Visual Effects'),
(141,'Visual Effects Supervisor','crew', 'This is Visual Effects Supervisor'),
(142,'Website Design','crew', 'This is Website Design'),
(143,'Writer','crew', 'This is Writer');


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
