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
  PRIMARY KEY (`id`),
 KEY `index_movies_awards_on_award_id_and_movie_id_and_artist_id` (`award_id`,`movie_id`,`artist_id`),
  KEY `index_movies_awards_on_artist_id_and_award_id` (`artist_id`,`award_id`),
  KEY `index_movies_awards_on_movie_id_and_award_id` (`movie_id`,`award_id`),
  KEY `index_movies_awards_on_award_id` (`award_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
