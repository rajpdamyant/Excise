-- MySQL dump 10.13  Distrib 5.1.54, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: samplemultitenant_dev
-- ------------------------------------------------------
-- Server version	5.1.54-1ubuntu4

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
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `executive_director_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `tenant_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK38A73C7DFF33AEEF` (`owner_id`),
  KEY `FK38A73C7DEF8EC19F` (`executive_director_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,3,4,'NTPC',2,1),(2,3,5,'HP',3,1);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_source`
--

DROP TABLE IF EXISTS `data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `data_source_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `sync_status` bit(1) NOT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_source`
--

LOCK TABLES `data_source` WRITE;
/*!40000 ALTER TABLE `data_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain_tenant_map`
--

DROP TABLE IF EXISTS `domain_tenant_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_tenant_map` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `domain_name` varchar(255) NOT NULL,
  `mapped_tenant_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain_tenant_map`
--

LOCK TABLES `domain_tenant_map` WRITE;
/*!40000 ALTER TABLE `domain_tenant_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain_tenant_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plant`
--

DROP TABLE IF EXISTS `plant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `company_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `plant_manager_id` bigint(20) DEFAULT NULL,
  `tenant_id` int(11) NOT NULL,
  `data_source_id` bigint(20) DEFAULT NULL,
  `data_source1_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65CDA6B115DDC43` (`company_id`),
  KEY `FK65CDA6B97E01209` (`plant_manager_id`),
  KEY `FK65CDA6BCF9627D8` (`data_source_id`),
  KEY `FK65CDA6BB71E6CA7` (`data_source1_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plant`
--

LOCK TABLES `plant` WRITE;
/*!40000 ALTER TABLE `plant` DISABLE KEYS */;
INSERT INTO `plant` VALUES (2,1,2,'HP-PLANT2',7,1,NULL,NULL),(3,1,1,'NTPC-PLANT1',8,1,NULL,NULL),(4,1,1,'NTPC-PLANT2',9,1,NULL,NULL);
/*!40000 ALTER TABLE `plant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_code`
--

DROP TABLE IF EXISTS `registration_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `token` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_code`
--

LOCK TABLES `registration_code` WRITE;
/*!40000 ALTER TABLE `registration_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `authority` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,0,'ROLE_SUPER_USER'),(2,0,'ROLE_ADMIN'),(3,0,'ROLE_USER'),(4,0,'ROLE_EXECUTIVE_DIRECTOR'),(5,0,'ROLE_COMPANY_OWNER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_data`
--

DROP TABLE IF EXISTS `test_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `channel_id` varchar(255) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `var_name1` double DEFAULT NULL,
  `var_name10` double DEFAULT NULL,
  `var_name11` double DEFAULT NULL,
  `var_name2` double DEFAULT NULL,
  `var_name3` double DEFAULT NULL,
  `var_name4` double DEFAULT NULL,
  `var_name5` double DEFAULT NULL,
  `var_name6` double DEFAULT NULL,
  `var_name7` double DEFAULT NULL,
  `var_name8` double DEFAULT NULL,
  `var_name9` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=862 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `account_expired` bit(1) NOT NULL,
  `account_locked` bit(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_expired` bit(1) NOT NULL,
  `user_tenant_id` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `plant_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `FK36EBCB115DDC43` (`company_id`),
  KEY `FK36EBCB6D8CC3C3` (`plant_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,2,'\0','\0','nikhils@damyant.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'damyant','com.damyant.User',NULL,NULL),(2,0,'\0','\0','ntpcowner@ntpc.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'ntpcowner','com.damyant.CompanyOwner',NULL,1),(3,0,'\0','\0','hpowner@hp.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'hpowner','com.damyant.CompanyOwner',NULL,2),(4,0,'\0','\0','ntpcexe1@ntpc.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'ntpcexecutive1','com.damyant.ExecutiveDirector',NULL,1),(5,0,'\0','\0','hpexe@hp.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'hpexecutive','com.damyant.ExecutiveDirector',NULL,2),(6,0,'\0','\0','hpmanager@hp.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'hpplantmanager1','com.damyant.PlantManager',1,NULL),(7,0,'\0','\0','hpmanager2@hp.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'hpplantmanager2','com.damyant.PlantManager',2,NULL),(8,0,'\0','\0','ntpcplant@ntpc.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'ntpcmanager-1','com.damyant.PlantManager',3,NULL),(9,0,'\0','\0','nts@vvvvdsv.com','','5aed14c5499622980fd786ccaf94bed09c9d631aea5c4821c632eaa1947e7acc','\0',1,'ntpcplantmanager-2','com.damyant.PlantManager',4,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `FK143BF46AEE223AF7` (`role_id`),
  KEY `FK143BF46A934CFED7` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1),(2,1),(2,6),(2,7),(2,8),(2,9),(3,1),(4,1),(4,4),(4,5),(5,1),(5,2),(5,3);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-09-30 18:27:34
