-- MariaDB dump 10.19  Distrib 10.11.5-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	10.11.5-MariaDB-3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `gamesatin`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gamesatin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `gamesatin`;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `age_recommendation` varchar(50) DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES
(1,'God of War','Action','Embark on a journey as Kratos, a former Greek god seeking vengeance against the gods of Olympus. Hack and slash your way through epic battles and solve puzzles in this action-adventure masterpiece.','Mature',4.7,'assets/images/games/god_of_war.jpg'),
(2,'Elden Ring','Action RPG','Explore a vast open world filled with danger and mystery. Created by Hidetaka Miyazaki and George R. R. Martin, Elden Ring promises a dark fantasy adventure unlike any other.','Mature',4.9,'assets/images/games/elden_ring.jpg'),
(3,'Tekken 8','Fighting','Join the King of Iron Fist Tournament and compete against a diverse cast of fighters from around the world. Master martial arts moves and combos to become the ultimate champion.','Teen',4.6,'assets/images/games/tekken_8.jpg'),
(4,'Just Dance','Music','Get ready to groove to the hottest tracks and show off your dance moves in this fun-filled rhythm game. With a wide selection of songs and dance styles, Just Dance is perfect for players of all ages.','Everyone',4.8,'assets/images/games/just_dance.jpg'),
(5,'Diablo 4','Action RPG','Descend into the depths of hell and battle against demonic forces in this highly anticipated installment of the Diablo series. Customize your character, collect powerful loot, and save Sanctuary from the forces of evil.','Mature',4.7,'assets/images/games/diablo_4.jpg'),
(6,'Fortnite','Battle Royale','Drop into a colorful world and battle it out against 99 other players to be the last one standing. Build, fight, and survive to earn Victory Royales in this ever-evolving battle royale phenomenon.','Teen',4.5,'assets/images/games/fortnite.jpg'),
(7,'Minecraft','Sandbox','Explore infinite worlds and build anything you can imagine in this blocky sandbox game. Mine resources, craft tools, and embark on epic adventures with friends in multiplayer mode.','Everyone',4.9,'assets/images/games/minecraft.jpg'),
(8,'VALORANT','First-Person Shooter','Join a team of agents and engage in tactical gunplay in this competitive multiplayer shooter. Use unique abilities and strategic teamwork to outsmart and outshoot your opponents.','Teen',4.6,'assets/images/games/valorant.jpg');
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gamesatin_users`
--

DROP TABLE IF EXISTS `gamesatin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gamesatin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(128) NOT NULL,
  `favorite_game_genre` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `account_creation_date` timestamp NULL DEFAULT current_timestamp(),
  `is_admin` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gamesatin_users`
--

LOCK TABLES `gamesatin_users` WRITE;
/*!40000 ALTER TABLE `gamesatin_users` DISABLE KEYS */;
INSERT INTO `gamesatin_users` VALUES
(1,'admin','$2y$10$tQcW5eKQwlfoEIR9tBvNfuBpKMc42zwDmjRFr3sRJOIXEEvi5PYDC','Strategy','1980-05-12','2024-02-28 01:54:47',1),
(2,'andrea','$2y$10$6jWrkXNwYlTd7EpqN2.vOesFzCD.PUOgE/DyLJPuIYyA1NxUIEK.6','Adventure','1992-09-23','2024-02-28 01:54:47',1),
(3,'g4merZhito','$2y$10$loYbZEVpknYTBibxYgp8VOjMZChRGBZ5/zNTIT7D7hcNueKls/q.m','Racing','1990-07-15','2024-02-28 01:54:47',0),
(4,'andersonA','$2y$10$soohlP/HIKyeV9vH.URgOekBXAavkykaZtYX5jJlH1T5Qy5py930K','FPS','1991-02-20','2024-02-28 01:54:47',0),
(5,'anton1oL','$2y$10$bAFxkaNztUmA2n2E072cDOU64vN2.qoTrS9zq9I6FusYgKQipGw8m','MMORPG','1995-11-18','2024-02-28 01:54:47',0),
(6,'saraLOX','$2y$10$P4IvytGTmD/3Ta/a/QbQJ.KZmHfKY4GyxyqOidenicgl8hI3mRWx.','Simulation','1993-04-05','2024-02-28 01:54:47',0),
(7,'fredDao_','$2y$10$Nncwtyh6Dej/Grk2cY4KDOcNuar94x3VBv1/TyGwqHYrbTjWhRWZW','Puzzle','1994-08-20','2024-02-28 01:54:47',0),
(8,'rubenGamer','$2y$10$pnCuKseHyjmat61OpcrW1O5bjdyRtUZIwytJKMzwuql5T2za77Mcm','Platformer','1996-12-10','2024-02-28 01:54:47',0),
(9,'alina4','$2y$10$oYxIDFlCMaIhJXC.5T3pgOhJEep103e3av/fHfXcRjMyIeqWEpc0K','Strategy','1997-06-28','2024-02-28 01:54:47',0),
(10,'angieAsy','$2y$10$EjeT1KBc8GWfH3a/NKZNm./YnsJpPt0O/dstqqmLtnsTH.FSXIPjq','Adventure','1998-09-12','2024-02-28 01:54:47',0),
(11,'toooooonyi','$2y$10$mJZkB9r1LGk/GPRH7bM6WuVYyDqB3yrFRpjA0IYO.B0iEGKLHhdlu','Sports','2000-08-07','2024-02-28 01:54:47',0),
(12,'zonem1nd7atX','$2y$10$LBU76RdIe/0SKbsmAeaute1wMQ6AM/DeiZ58Znvy111rK2E9z7/cO','RPG','2002-01-25','2024-02-28 01:54:47',0),
(13,'amAT','$2y$10$eNEqufX5.L4oSxAZNXO9cuuL6CtY1BxSQr.7puHYGF274FEDKvmVq','Strategy','2005-10-03','2024-02-28 01:54:47',0);
/*!40000 ALTER TABLE `gamesatin_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-29 14:23:38
