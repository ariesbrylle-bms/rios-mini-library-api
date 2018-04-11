/*

SQLyog Ultimate v8.55 
MySQL - 5.5.27 : Database - rios_library

*********************************************************************

*/



/*!40101 SET NAMES utf8 */;



/*!40101 SET SQL_MODE=''*/;



/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*Table structure for table `books` */



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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;



/*Data for the table `books` */



insert  into `books`(`id`,`title`,`author`,`genre`,`section`,`is_available`,`status`,`date_added`,`added_by`,`updated_at`,`updated_by`) values (1,'Wrong Turn','Bob','Horror,Thriller','Circulation','Yes','Active','2018-04-11 04:42:36',1,'2018-04-11 05:18:06',1),(2,'Murder on the Orient Express','Lady Lind','Thriller,Adventure','Fiction','Yes','Active','2018-04-11 04:44:26',1,'2018-04-11 11:13:11',1),(3,'Ang Panday','Coco Martin,Mars Ravelos','Action,Comedy,Adventure','Others','No','Inactive','2018-04-11 04:45:10',1,'2018-04-11 06:44:24',1),(4,'The Proposal','Aries,Racquel','Romance,Comedy','Fiction','Yes','Active','2018-04-11 05:18:21',1,NULL,NULL),(5,'klk','kl','klk','Circulation','No','Inactive','2018-04-11 06:45:00',1,'2018-04-11 06:45:04',1),(6,'klkl','l;l',';l;','Others','No','Inactive','2018-04-11 11:01:15',1,'2018-04-11 11:12:00',1),(7,'The Proposal','Aries,Racquel','Romance,Comedy','Fiction','Yes','Active','2018-04-11 11:04:14',1,NULL,NULL),(8,'lkl','klklk','lklkl','Fiction','No','Inactive','2018-04-11 11:11:41',1,'2018-04-11 11:12:05',1),(9,'lklk','klklkl','klklk','Children\'s Section','No','Inactive','2018-04-11 11:11:51',1,'2018-04-11 11:12:09',1),(10,'kjk','jkjk','jkjk','Others','No','Inactive','2018-04-11 11:13:18',1,'2018-04-11 11:13:24',1);



/*Table structure for table `borrowed_books` */



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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;



/*Data for the table `borrowed_books` */



insert  into `borrowed_books`(`id`,`book_id`,`borrower`,`status`,`date_added`,`added_by`,`updated_at`,`updated_by`) values (1,2,'Aries','Returned','2018-04-11 07:12:44',1,'2018-04-11 07:41:19',1),(2,4,'Aries','Returned','2018-04-11 07:41:12',1,'2018-04-11 07:41:20',1),(3,2,'Aries','Returned','2018-04-11 07:41:13',1,'2018-04-11 07:42:00',1),(4,2,'Racquel','Returned','2018-04-11 07:41:32',1,'2018-04-11 07:42:00',1),(5,4,'Racquel','Returned','2018-04-11 07:41:33',1,'2018-04-11 07:42:01',1),(6,1,'Racquel','Returned','2018-04-11 07:41:33',1,'2018-04-11 07:42:01',1),(7,2,'Ctian','Returned','2018-04-11 07:42:22',1,'2018-04-11 07:42:29',1),(8,4,'Ctian','Returned','2018-04-11 07:42:23',1,'2018-04-11 07:42:30',1),(9,1,'Ctian','Returned','2018-04-11 07:42:24',1,'2018-04-11 07:42:31',1),(10,2,'Cesar','Returned','2018-04-11 07:42:53',1,'2018-04-11 07:42:56',1),(11,4,'Cesar','Returned','2018-04-11 07:42:53',1,'2018-04-11 07:42:56',1),(12,1,'Cesar','Returned','2018-04-11 07:42:54',1,'2018-04-11 07:42:58',1),(13,2,'Sean','Returned','2018-04-11 07:43:08',1,'2018-04-11 07:48:18',1),(14,4,'Cesar','Returned','2018-04-11 07:43:12',1,'2018-04-11 07:48:19',1),(15,2,'Pete','Returned','2018-04-11 08:01:39',1,'2018-04-11 07:48:19',1),(16,2,'Aries','Returned','2018-04-11 11:13:31',1,'2018-04-11 11:13:39',1);



/*Table structure for table `users` */



DROP TABLE IF EXISTS `users`;



CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;



/*Data for the table `users` */



insert  into `users`(`id`,`username`,`password`,`name`,`last_login`,`created_at`,`updated_at`) values (1,'admin','$1$xH9JWb.d$XSizuBEAGJGV/9kxG2i4H0','Admin','2018-04-11 11:01:05','2015-12-25 10:35:16','2015-12-25 10:35:16');



/*Table structure for table `users_authentication` */



DROP TABLE IF EXISTS `users_authentication`;



CREATE TABLE `users_authentication` (
  `id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*Data for the table `users_authentication` */



insert  into `users_authentication`(`id`,`users_id`,`token`,`expired_at`,`created_at`,`updated_at`) values (0,1,'$1$5g/.oE3.$ovKk3JvQCETxD1.BozjOz0','2018-04-11 22:57:43','2018-04-11 10:57:43','2018-04-11 10:57:43'),(0,1,'$1$nu0.kl/.$r2ohUI2rlyeLKN3ksC85c1','2018-04-11 23:00:44','2018-04-11 10:59:05','2018-04-11 11:00:44'),(0,1,'$1$jC5.wC2.$0NRIBQr72KWoqVvS1OZpY1','2018-04-11 23:13:41','2018-04-11 11:01:05','2018-04-11 11:13:41');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

