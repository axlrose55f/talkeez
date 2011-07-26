--
-- Table structure for table  `movies_genres`
--

DROP TABLE IF EXISTS `movies_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `active` TINYINT(1) DEFAULT 1, 
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_movies_genres_on_movie_id_and_genre_id` (`movie_id`,`genre_id`),
  KEY `index_movies_genres_on_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `movies_awards`
--

DROP TABLE IF EXISTS `movies_awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies_awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT, 
  `award_id` int(11) NOT NULL,
  `movie_id` int(11),
  `artist_id` int(11) ,
   `year` date DEFAULT '1900-01-01',
  `location` varchar(255) DEFAULT NULL,
  `active` TINYINT(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_movies_awards_on_award_id_and_movie_id_and_artist_id` (`award_id`,`movie_id`,`artist_id`),
  KEY `index_movies_awards_on_artist_id_and_award_id` (`artist_id`,`award_id`),
  KEY `index_movies_awards_on_movie_id_and_award_id` (`movie_id`,`award_id`),
  KEY `index_movies_awards_on_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Add id to movies_genres table 
--

ALTER TABLE movies add column `active` TINYINT(1) DEFAULT 1 after `rating`;

ALTER TABLE artists add column `active` TINYINT(1) DEFAULT 1 after `rating`;

ALTER TABLE movies_artists_roles add column `active` TINYINT(1) DEFAULT 1 after `role_id`;

ALTER TABLE users add column `active` TINYINT(1) DEFAULT 1 after `password_salt`;

ALTER TABLE videos add column `active` TINYINT(1) DEFAULT 1 after `description`;

ALTER TABLE movies ADD INDEX `index_movies_active` (id, active);

ALTER TABLE artists ADD INDEX `index_artists_active` (id, active);

-- update movie_artist_roles unique, drop 