# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.1.19-MariaDB)
# Database: ffuf_library
# Generation Time: 2018-04-11 06:37:02 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table books
# ------------------------------------------------------------

DROP TABLE IF EXISTS `books`;

CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(500) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `section` varchar(100) NOT NULL,
  `is_available` varchar(3) NOT NULL DEFAULT 'Yes',
  `status` varchar(10) NOT NULL DEFAULT 'Active',
  `date_added` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `added_by` (`added_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`),
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;

INSERT INTO `books` (`id`, `title`, `author`, `genre`, `section`, `is_available`, `status`, `date_added`, `added_by`, `updated_at`, `updated_by`)
VALUES
	(1,'Wrong Turn','Bob','Horror,Thriller','Circulation','Yes','Active','2018-04-11 04:42:36',1,'2018-04-11 05:18:06',1),
	(2,'Murder on the Orient Express','Lady Lind','Thriller,Adventure','Fiction','No','Active','2018-04-11 04:44:26',1,'2018-04-11 05:16:26',1),
	(3,'Ang Panday','Coco Martin,Mars Ravelos','Action,Comedy,Adventure','Others','No','Inactive','2018-04-11 04:45:10',1,'2018-04-11 06:44:24',1),
	(4,'The Proposal','Aries,Racquel','Romance,Comedy','Fiction','Yes','Active','2018-04-11 05:18:21',1,NULL,NULL),
	(5,'klk','kl','klk','Circulation','No','Inactive','2018-04-11 06:45:00',1,'2018-04-11 06:45:04',1);

/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table borrowed_books
# ------------------------------------------------------------

DROP TABLE IF EXISTS `borrowed_books`;

CREATE TABLE `borrowed_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `borrower` varchar(255) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'Pending',
  `date_added` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `added_by` (`added_by`),
  KEY `updated_by` (`updated_by`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `borrowed_books_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`),
  CONSTRAINT `borrowed_books_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `borrowed_books_ibfk_3` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `borrowed_books` WRITE;
/*!40000 ALTER TABLE `borrowed_books` DISABLE KEYS */;

INSERT INTO `borrowed_books` (`id`, `book_id`, `borrower`, `status`, `date_added`, `added_by`, `updated_at`, `updated_by`)
VALUES
	(1,2,'Aries','Returned','2018-04-11 07:12:44',1,'2018-04-11 07:41:19',1),
	(2,4,'Aries','Returned','2018-04-11 07:41:12',1,'2018-04-11 07:41:20',1),
	(3,2,'Aries','Returned','2018-04-11 07:41:13',1,'2018-04-11 07:42:00',1),
	(4,2,'Racquel','Returned','2018-04-11 07:41:32',1,'2018-04-11 07:42:00',1),
	(5,4,'Racquel','Returned','2018-04-11 07:41:33',1,'2018-04-11 07:42:01',1),
	(6,1,'Racquel','Returned','2018-04-11 07:41:33',1,'2018-04-11 07:42:01',1),
	(7,2,'Ctian','Returned','2018-04-11 07:42:22',1,'2018-04-11 07:42:29',1),
	(8,4,'Ctian','Returned','2018-04-11 07:42:23',1,'2018-04-11 07:42:30',1),
	(9,1,'Ctian','Returned','2018-04-11 07:42:24',1,'2018-04-11 07:42:31',1),
	(10,2,'Cesar','Returned','2018-04-11 07:42:53',1,'2018-04-11 07:42:56',1),
	(11,4,'Cesar','Returned','2018-04-11 07:42:53',1,'2018-04-11 07:42:56',1),
	(12,1,'Cesar','Returned','2018-04-11 07:42:54',1,'2018-04-11 07:42:58',1),
	(13,2,'Sean','Returned','2018-04-11 07:43:08',1,'2018-04-11 07:48:18',1),
	(14,4,'Cesar','Returned','2018-04-11 07:43:12',1,'2018-04-11 07:48:19',1),
	(15,2,'Pete','Pending','2018-04-11 08:01:39',1,NULL,NULL);

/*!40000 ALTER TABLE `borrowed_books` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `last_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `password`, `name`, `last_login`, `created_at`, `updated_at`)
VALUES
	(1,'admin','$1$xH9JWb.d$XSizuBEAGJGV/9kxG2i4H0','Admin','2018-04-11 08:31:00','2015-12-25 10:35:16','2015-12-25 10:35:16');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users_authentication
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users_authentication`;

CREATE TABLE `users_authentication` (
  `id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users_authentication` WRITE;
/*!40000 ALTER TABLE `users_authentication` DISABLE KEYS */;

INSERT INTO `users_authentication` (`id`, `users_id`, `token`, `expired_at`, `created_at`, `updated_at`)
VALUES
	(0,1,'$1$zSdZ7ZjX$FBVijfic.7Ok0giAi3.ef/','2018-04-11 07:37:40','2018-04-11 01:37:40','2018-04-11 01:37:40'),
	(0,1,'$1$h/CsfPRY$bLF3/DbObIUFEZYrtvvfU.','2018-04-11 07:37:47','2018-04-11 01:37:47','2018-04-11 01:37:47'),
	(0,1,'$1$LicHwW56$GKbtewxzFT3GcykMyEX5F1','2018-04-11 07:46:58','2018-04-11 01:46:58','2018-04-11 01:46:58'),
	(0,1,'$1$O4Wb..DJ$QAiA3vH7tiESCDAewkMFZ/','2018-04-11 07:50:24','2018-04-11 01:50:24','2018-04-11 01:50:24'),
	(0,1,'$1$M8mMfwlb$cwajveDQZAvQQljg3akKP1','2018-04-11 07:51:40','2018-04-11 01:51:40','2018-04-11 01:51:40'),
	(0,1,'$1$PL8UBHa/$/j76XlhA/rtTD5iV6HBS70','2018-04-11 07:51:47','2018-04-11 01:51:47','2018-04-11 01:51:47'),
	(0,1,'$1$wrOegIAV$FsyrevCKVL/6b/E3KMvru/','2018-04-11 07:51:48','2018-04-11 01:51:48','2018-04-11 01:51:48'),
	(0,1,'$1$cti5zn0M$1et7jP9JSxTJ9GSzUo/jt1','2018-04-11 07:51:51','2018-04-11 01:51:51','2018-04-11 01:51:51'),
	(0,1,'$1$k/bDyXLy$TQTMrG1O4s1Zzr8i5Hj/8.','2018-04-11 15:16:49','2018-04-11 09:16:49','2018-04-11 09:16:49'),
	(0,1,'$1$vu6c00Bv$UbSoIPQ94PJCFKjI6JuGp1','2018-04-11 15:20:20','2018-04-11 09:20:20','2018-04-11 09:20:20'),
	(0,1,'$1$vMxYrH3h$nqT/kLftTO/JzKTM7PRtD0','2018-04-11 15:26:54','2018-04-11 09:26:54','2018-04-11 09:26:54'),
	(0,1,'$1$TuyDHbbn$JyjvXxtMpl7aktQAgXrDD1','2018-04-11 15:29:36','2018-04-11 09:29:36','2018-04-11 09:29:36'),
	(0,1,'$1$pZbOtnnh$7PqMat.N8VeCY0aFcdwcO/','2018-04-11 15:30:44','2018-04-11 09:30:44','2018-04-11 09:30:44'),
	(0,1,'$1$rC7fzafx$WgjQlnE6OyIL/qXywdqdR/','2018-04-11 15:31:09','2018-04-11 09:31:09','2018-04-11 09:31:09'),
	(0,1,'$1$l4.xk8ui$h0gITkBIYQ3R.ovyvyG3W1','2018-04-11 15:43:23','2018-04-11 09:43:23','2018-04-11 09:43:23'),
	(0,1,'$1$6OC5u7cj$xOdrWbJglabG2n5GMrDBf1','2018-04-11 15:50:22','2018-04-11 09:50:22','2018-04-11 09:50:22'),
	(0,1,'$1$xt6Lfkkh$1LoyQrgbJVSNqMsQns6fr.','2018-04-11 15:54:17','2018-04-11 09:54:17','2018-04-11 09:54:17'),
	(0,1,'$1$2ZAVNH.k$NZo/TXAdCuvacO6w4.uid0','2018-04-11 17:19:58','2018-04-11 09:54:35','2018-04-11 05:19:58'),
	(0,1,'$1$dtQiVLhW$nfQ0IabERPIPRZUcIMy080','2018-04-11 17:20:10','2018-04-11 11:20:08','2018-04-11 05:20:10'),
	(0,1,'$1$pZ3SQXwf$qJxLBIQWw8Cm6KxrmX9WA/','2018-04-11 20:24:44','2018-04-11 12:38:15','2018-04-11 08:24:44'),
	(0,1,'$1$5gHAnKU8$OB9Kl7SFgtvjtr/5zDF/j0','2018-04-11 20:30:47','2018-04-11 14:29:27','2018-04-11 08:30:47'),
	(0,1,'$1$Gy2xfVii$DCAy2UHE9nFW9ExA0p8av1','2018-04-11 20:33:09','2018-04-11 14:31:00','2018-04-11 08:33:09');

/*!40000 ALTER TABLE `users_authentication` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
