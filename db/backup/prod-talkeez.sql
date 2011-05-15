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
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  `year` date DEFAULT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `music_director_id` int(11) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `lyricist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_albums_movies` (`movie_id`),
  KEY `fk_albums_genres` (`genre_id`),
  KEY `fk_albums_music_dir` (`music_director_id`),
  KEY `fk_albums_lyricist` (`lyricist_id`),
  CONSTRAINT `fk_albums_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
  CONSTRAINT `fk_albums_lyricist` FOREIGN KEY (`lyricist_id`) REFERENCES `artists` (`id`),
  CONSTRAINT `fk_albums_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `fk_albums_music_dir` FOREIGN KEY (`music_director_id`) REFERENCES `artists` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,'Test Album','','',NULL,NULL,NULL,1,NULL),(2,'Test Album','','','2002-02-02',NULL,NULL,1,NULL),(3,'Maine Pyaar Kiya','Test','',NULL,1,NULL,2,NULL);
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums_genres`
--

DROP TABLE IF EXISTS `albums_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums_genres` (
  `album_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  KEY `index_albums_genres_on_album_id_and_genre_id` (`album_id`,`genre_id`),
  KEY `index_albums_genres_on_genre_id` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums_genres`
--

LOCK TABLES `albums_genres` WRITE;
/*!40000 ALTER TABLE `albums_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `albums_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `biography` text,
  `image_url` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `birth_place` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `birth_name` varchar(255) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `education` varchar(255) DEFAULT NULL,
  `star_sign` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'Amitabh Bachchan','Amitabh Bachchan , born Amitabh Harivansh Bachchan on 11 October 1942), is an Indian film actor and producer. He first gained popularity in the early 1970s as the \"angry young man\" of Hindi cinema, and has since become one of the most prominent figures in the history of Indian cinema.[1][2]\r\nBachchan has won numerous major awards in his career, including four National Film Awards, three of which are in the Best Actor category, and fourteen Filmfare Awards. He is the most-nominated performer in any major acting category at Filmfare, with 36 nominations overall. In addition to acting, Bachchan has worked as a playback singer, film producer and television presenter, and was an elected member of the Indian Parliament from 1984 to 1987.',NULL,'1942-10-11','Allahabad','India','Amitabh Harivansh Bachchan',74,NULL,'','','','','amitab.jpg','image/jpeg',8226,'2011-05-14 22:37:43'),(2,'Tusshar Kapoor','Tusshar Kapoor is the son of Veteran Bollywood actor, Jeetendra and Shobha Kapoor. He is the brother of Indian Soap Opera Queen, Ekta Kapoor. He studied at the University of Michigan and graduated with a MBA from the Stephen M. Ross School of Business.\r\n\r\n',NULL,'1976-11-20','Mumbai','India','',65,0,'Single','MBA','Scorpio','',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `image_updated_at` datetime DEFAULT NULL,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
INSERT INTO `awards` VALUES (1,'FilmFare','This is filmfare award',NULL,NULL,NULL,NULL),(2,'Cini Awards','This is Cini awards',NULL,NULL,NULL,NULL),(3,'Oscar','Oh yeah the oscars',NULL,NULL,NULL,NULL),(4,'IFA','Indian Filma awards',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Action','This is Action'),(2,'Adult','This is Adult'),(3,'Adventure','This is Adventure'),(4,'Animation','This is Animation'),(5,'Biography','This is Biography'),(6,'Children','This is Children'),(7,'Comedy','This is Comedy'),(8,'Crime','This is Crime'),(9,'Documentary','This is Documentary'),(10,'Drama','This is Drama'),(11,'Family','This is Family'),(12,'Fantasy','This is Fantasy'),(13,'Film-Noir','This is Film-Noir'),(14,'Foreign','This is Foreign'),(15,'Game','This is Game'),(16,'Health','This is Health'),(17,'History','This is History'),(18,'Horror','This is Horror'),(19,'Music','This is Music'),(20,'Musical','This is Musical'),(21,'Mystery','This is Mystery'),(22,'Mythological','This is Mythological'),(23,'News','This is News'),(24,'Patriotic','This is Patriotic'),(25,'Period','This is Period'),(26,'Reality-TV','This is Reality-TV'),(27,'Romance','This is Romance'),(28,'Sci-Fi','This is Sci-Fi'),(29,'Social','This is Social'),(30,'Special','This is Special'),(31,'Sports','This is Sports'),(32,'Sports','This is Sports'),(33,'Talk','This is Talk'),(34,'Thriller','This is Thriller'),(35,'War','This is War'),(36,'Western','This is Western');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moods`
--

DROP TABLE IF EXISTS `moods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moods`
--

LOCK TABLES `moods` WRITE;
/*!40000 ALTER TABLE `moods` DISABLE KEYS */;
/*!40000 ALTER TABLE `moods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `studio` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `certification` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `keywords` text,
  `description` text,
  `aspect_ratio` varchar(255) DEFAULT NULL,
  `year` date DEFAULT '1900-01-01',
  `run_time` int(11) DEFAULT '0',
  `rating` int(11) DEFAULT '1',
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Don','us','Hindi','fox','bw','pg','/images/Data/Movies/Don_28Cover29.jpg',NULL,'Don - The Chase Begins Again, directed by Farhan Akhtar, is a remake of the blockbuster 1978 film, Don. The film was released in India on October 20, 2006 and it was also simultaneously released internationally. It received a very good response worldwide, and collected over Rs. 30 crores in India in its first week itself. The script of the previous film was written by Akhtar\'s father, Javed Akhtar and Salim Khan (father of Salman Khan).\r\n\r\nThe film stars Shahrukh Khan, Priyanka Chopra, Arjun Rampal, Ishaa Koppikar and Kareena Kapoor in a guest appearance. Eighty percent of the movie was shot in Malaysia, and was filmed around the tropical Langkawi island as well as the Petronas Twin Towers and the Jalan Masjid India area, which is the \'little India\' of Kuala Lumpur. Akshay Kumar was offered for the role of Jasjit but he rejected saying he might have accepted if he was offered the part of Don.[1] Shahrukh Khan and Priyanka Chopra underwent special martial arts training for their roles in the movie.\r\n\r\nThe film was selected to be screened at the Berlin Film Festival.[2] Critical reaction was mixed, with Variety stating that the film \"could have been much better.\"[3]','2:3','2002-01-01',2,2,'Don_28Cover29.jpg','image/jpeg',24965,'2011-01-28 09:17:08'),(2,'Paheli','India','Hindi','UTV','Color','pg','/images/Data/Movies/Paheli.jpg',NULL,'Paheli (English: Riddle) is a Bollywood movie, released in India on June 24, 2005, directed by Amol Palekar and produced by Gauri Khan, Sanjiv Chawla and Shahrukh Khan, who also plays the male lead. Paheli is based on the short story written by Vijayadan Detha and tells the story of a wife (Rani Mukerji) who is left by her husband (Shahrukh Khan) and visited by a ghost, disguised as her husband, who is in love with her and takes her husband\'s place.','2:3','2007-10-10',120,4,'Paheli.jpg','image/jpeg',49385,'2011-01-28 09:18:10'),(3,'Rock On','India','Hindi','UTV','Color',NULL,'/images/Data/Movies/RockOn.png',NULL,'This is a decent movie. Has lot of interesting aspect. I don\'t have much to write about.',NULL,'2008-01-10',126,2,'RockOn.png',NULL,NULL,NULL),(4,'Sholay','India','','NR','',NULL,NULL,NULL,'This is Sholay',NULL,'1976-01-01',0,4,'sholay.jpg','image/jpeg',7275,'2011-05-14 22:34:12'),(5,'Shor in the City','India','Hindi','Balaji Motion Pictures','Color',NULL,NULL,NULL,'SHOR IN THE CITY is a thriller which revolves around three stories in the midst of the noise and grunge of Mumbai. The three stories run concurrently - the characters are not connected with each other and don\'t cross paths. It has the gangster backdrop and the thriller quotient that keeps audiences on the edge. ',NULL,'2011-04-28',108,4,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies_artists_roles`
--

DROP TABLE IF EXISTS `movies_artists_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies_artists_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_movies_artists_roles_on_movie_id_and_artist_id_and_role_id` (`movie_id`,`artist_id`,`role_id`),
  KEY `index_movies_artists_roles_on_artist_id_and_role_id` (`artist_id`,`role_id`),
  KEY `index_movies_artists_roles_on_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies_artists_roles`
--

LOCK TABLES `movies_artists_roles` WRITE;
/*!40000 ALTER TABLE `movies_artists_roles` DISABLE KEYS */;
INSERT INTO `movies_artists_roles` VALUES (1,1,1,1),(3,2,1,1),(5,2,2,3),(6,2,4,3),(7,4,1,1),(8,5,2,3);
/*!40000 ALTER TABLE `movies_artists_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies_awards`
--

DROP TABLE IF EXISTS `movies_awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies_awards` (
  `movie_id` int(11) NOT NULL,
  `award_id` int(11) NOT NULL,
  KEY `index_movies_awards_on_movie_id_and_award_id` (`movie_id`,`award_id`),
  KEY `index_movies_awards_on_award_id` (`award_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies_awards`
--

LOCK TABLES `movies_awards` WRITE;
/*!40000 ALTER TABLE `movies_awards` DISABLE KEYS */;
INSERT INTO `movies_awards` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `movies_awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies_genres`
--

DROP TABLE IF EXISTS `movies_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies_genres` (
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  KEY `index_movies_genres_on_movie_id_and_genre_id` (`movie_id`,`genre_id`),
  KEY `index_movies_genres_on_genre_id` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies_genres`
--

LOCK TABLES `movies_genres` WRITE;
/*!40000 ALTER TABLE `movies_genres` DISABLE KEYS */;
INSERT INTO `movies_genres` VALUES (1,1),(1,34),(2,5),(3,5),(5,7);
/*!40000 ALTER TABLE `movies_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies_themes`
--

DROP TABLE IF EXISTS `movies_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies_themes` (
  `movie_id` int(11) NOT NULL,
  `theme_id` int(11) NOT NULL,
  KEY `index_movies_themes_on_movie_id_and_theme_id` (`movie_id`,`theme_id`),
  KEY `index_movies_themes_on_theme_id` (`theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies_themes`
--

LOCK TABLES `movies_themes` WRITE;
/*!40000 ALTER TABLE `movies_themes` DISABLE KEYS */;
/*!40000 ALTER TABLE `movies_themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open_id_authentication_associations`
--

DROP TABLE IF EXISTS `open_id_authentication_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open_id_authentication_associations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issued` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `assoc_type` varchar(255) DEFAULT NULL,
  `server_url` blob,
  `secret` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_id_authentication_associations`
--

LOCK TABLES `open_id_authentication_associations` WRITE;
/*!40000 ALTER TABLE `open_id_authentication_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `open_id_authentication_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open_id_authentication_nonces`
--

DROP TABLE IF EXISTS `open_id_authentication_nonces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open_id_authentication_nonces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL,
  `server_url` varchar(255) DEFAULT NULL,
  `salt` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_id_authentication_nonces`
--

LOCK TABLES `open_id_authentication_nonces` WRITE;
/*!40000 ALTER TABLE `open_id_authentication_nonces` DISABLE KEYS */;
/*!40000 ALTER TABLE `open_id_authentication_nonces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ragas`
--

DROP TABLE IF EXISTS `ragas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ragas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ragas`
--

LOCK TABLES `ragas` WRITE;
/*!40000 ALTER TABLE `ragas` DISABLE KEYS */;
INSERT INTO `ragas` VALUES (1,'Malhar','Raga malhar'),(2,'Khamaj','raga khamaj');
/*!40000 ALTER TABLE `ragas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `rateable_type` varchar(15) NOT NULL DEFAULT '',
  `rateable_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_ratings_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `cast_type` varchar(60) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Hero','cast','Hero'),(2,'Heroien','cast','Heroien'),(3,'Director','cast',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20080925065459'),('20080926031023'),('20080927214228'),('20080927214609'),('20081023232217'),('20081024000128'),('20081024004608'),('20081024004618'),('20081024004736'),('20081024004759'),('20081024004819'),('20081024041935'),('20081026054543'),('20081026105924'),('20081026105937'),('20081026110057'),('20081105093934'),('20081123050129');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `themes`
--

LOCK TABLES `themes` WRITE;
/*!40000 ALTER TABLE `themes` DISABLE KEYS */;
/*!40000 ALTER TABLE `themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `lyrics` text,
  `chords` text,
  `lenght` int(11) DEFAULT NULL,
  `album_id` int(11) DEFAULT NULL,
  `track_number` int(11) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `raga_id` int(11) DEFAULT NULL,
  `mood_id` int(11) DEFAULT NULL,
  `lyricist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tracks_albums` (`album_id`),
  KEY `fk_tracks_lyricist` (`lyricist_id`),
  KEY `fk_tracks_genre` (`genre_id`),
  KEY `fk_tracks_raga` (`raga_id`),
  KEY `fk_tracks_mood` (`mood_id`),
  CONSTRAINT `fk_tracks_albums` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`),
  CONSTRAINT `fk_tracks_genre` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
  CONSTRAINT `fk_tracks_lyricist` FOREIGN KEY (`lyricist_id`) REFERENCES `artists` (`id`),
  CONSTRAINT `fk_tracks_mood` FOREIGN KEY (`mood_id`) REFERENCES `moods` (`id`),
  CONSTRAINT `fk_tracks_raga` FOREIGN KEY (`raga_id`) REFERENCES `ragas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracks`
--

LOCK TABLES `tracks` WRITE;
/*!40000 ALTER TABLE `tracks` DISABLE KEYS */;
INSERT INTO `tracks` VALUES (3,'Pichle Saat Dinon Mein','Some more lyrics for this song Pichle Saat Dinon Mein','Some chords for this song',3,2,2,'',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trivias`
--

DROP TABLE IF EXISTS `trivias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trivias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `fk_trivias_movies` (`movie_id`),
  CONSTRAINT `fk_trivias_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trivias`
--

LOCK TABLES `trivias` WRITE;
/*!40000 ALTER TABLE `trivias` DISABLE KEYS */;
/*!40000 ALTER TABLE `trivias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `crypted_password` varchar(255) DEFAULT NULL,
  `password_salt` varchar(255) DEFAULT NULL,
  `persistence_token` varchar(255) NOT NULL,
  `single_access_token` varchar(255) NOT NULL,
  `perishable_token` varchar(255) NOT NULL,
  `openid_identifier` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_openid_identifier` (`openid_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-05-15  9:47:44
