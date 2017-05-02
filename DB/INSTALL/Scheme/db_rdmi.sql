-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: rdmi
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `accion`
--

DROP TABLE IF EXISTS `accion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accion` (
  `acc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acc_nombre` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `acc_url_accion` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `acc_tipo` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `acc_descripcion` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `acc_lang_file` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `acc_dir_imagen` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `acc_estado_activo` varchar(1) CHARACTER SET utf8 NOT NULL,
  `acc_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `acc_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `acc_estado_logico` varchar(1) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`acc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accion`
--

LOCK TABLES `accion` WRITE;
/*!40000 ALTER TABLE `accion` DISABLE KEYS */;
INSERT INTO `accion` VALUES (1,'Create','Create','General','Create','accion','glyphicon glyphicon-file','1','2012-09-20 02:21:35',NULL,'1'),(2,'Update','Update','General','Update','accion','glyphicon glyphicon-edit','1','2012-09-20 02:21:35',NULL,'1'),(3,'Delete','Delete','General','Delete','accion','glyphicon glyphicon-trash','1','2012-09-20 02:21:35',NULL,'1'),(4,'Save','Save','General','Save','accion','glyphicon glyphicon-floppy-disk','1','2012-09-20 02:21:35',NULL,'1'),(5,'Search','Search','General','Search','accion','glyphicon glyphicon-search','1','2012-09-20 02:21:35',NULL,'1'),(6,'Print','Print','General','Print','accion','glyphicon glyphicon-print','1','2012-09-20 02:21:35',NULL,'1'),(7,'Import','Import','General','Import','accion','glyphicon glyphicon-import','1','2012-09-20 02:21:35',NULL,'1'),(8,'Export','Export','General','Export','accion','glyphicon glyphicon-export','1','2012-09-20 02:21:35',NULL,'1'),(9,'Back','Back','General','Back','accion','glyphicon glyphicon-triangle-right','1','2012-09-20 02:21:35',NULL,'1'),(10,'Next','Next','General','Next','accion','glyphicon glyphicon-triangle-left','1','2012-09-20 02:21:35',NULL,'1'),(11,'Clear','Clear','General','Clear','accion','glyphicon glyphicon-leaf','1','2012-09-20 02:21:35',NULL,'1');
/*!40000 ALTER TABLE `accion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendar_cita`
--

DROP TABLE IF EXISTS `agendar_cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agendar_cita` (
  `acit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cprog_id` bigint(20) NOT NULL,
  `pac_id` bigint(20) NOT NULL,
  `acit_motivo` blob,
  `acit_est_log` varchar(1) DEFAULT NULL,
  `acit_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `acit_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`acit_id`,`pac_id`,`cprog_id`),
  KEY `fk_agendar_cita_cita_programada1` (`cprog_id`,`pac_id`),
  CONSTRAINT `fk_agendar_cita_cita_programada1` FOREIGN KEY (`cprog_id`, `pac_id`) REFERENCES `cita_programada` (`cprog_id`, `pac_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendar_cita`
--

LOCK TABLES `agendar_cita` WRITE;
/*!40000 ALTER TABLE `agendar_cita` DISABLE KEYS */;
/*!40000 ALTER TABLE `agendar_cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aplicacion`
--

DROP TABLE IF EXISTS `aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aplicacion` (
  `apl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apl_nombre` varchar(50) DEFAULT NULL,
  `apl_tipo` varchar(45) DEFAULT NULL,
  `apl_lang_file` varchar(100) DEFAULT NULL,
  `apl_est_log` varchar(1) DEFAULT NULL,
  `apl_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `apl_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`apl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicacion`
--

LOCK TABLES `aplicacion` WRITE;
/*!40000 ALTER TABLE `aplicacion` DISABLE KEYS */;
INSERT INTO `aplicacion` VALUES (1,'Repositorio Digital','1',NULL,'1','2016-03-03 00:19:43',NULL);
/*!40000 ALTER TABLE `aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canton`
--

DROP TABLE IF EXISTS `canton`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canton` (
  `can_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prov_id` bigint(20) NOT NULL,
  `can_nombre` varchar(150) DEFAULT NULL,
  `can_descripcion` varchar(150) DEFAULT NULL,
  `can_estado_activo` varchar(1) NOT NULL,
  `can_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `can_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `can_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`can_id`),
  KEY `prov_id` (`prov_id`),
  CONSTRAINT `canton_ibfk_1` FOREIGN KEY (`prov_id`) REFERENCES `provincia` (`prov_id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canton`
--

LOCK TABLES `canton` WRITE;
/*!40000 ALTER TABLE `canton` DISABLE KEYS */;
INSERT INTO `canton` VALUES (1,1,'Camilo Ponce Enríquez','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(2,1,'Chordeleg','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(3,1,'Cuenca','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(4,1,'El Pan','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(5,1,'Girón','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(6,1,'Guachapala','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(7,1,'Gualaceo','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(8,1,'Nabón','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(9,1,'Oña','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(10,1,'Paute','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(11,1,'Pucara','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(12,1,'San Fernando','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(13,1,'Santa Isabel','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(14,1,'Sevilla De Oro','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(15,1,'Sigsig','cantones Azuay','1','2012-08-29 10:00:00',NULL,'1'),(16,2,'Caluma','cantones Bolivar','1','2012-08-29 10:00:00',NULL,'1'),(17,2,'Chillanes','cantones Bolivar','1','2012-08-29 10:00:00',NULL,'1'),(18,2,'Chimbo','cantones Bolivar','1','2012-08-29 10:00:00',NULL,'1'),(19,2,'Echeandía','cantones Bolivar','1','2012-08-29 10:00:00',NULL,'1'),(20,2,'Guaranda','cantones Bolivar','1','2012-08-29 10:00:00',NULL,'1'),(21,2,'Las Naves','cantones Bolivar','1','2012-08-29 10:00:00',NULL,'1'),(22,2,'San Miguel','cantones Bolivar','1','2012-08-29 10:00:00',NULL,'1'),(23,3,'Azogues','cantones Cañar','1','2012-08-29 10:00:00',NULL,'1'),(24,3,'Biblián','cantones Cañar','1','2012-08-29 10:00:00',NULL,'1'),(25,3,'Cañar','cantones Cañar','1','2012-08-29 10:00:00',NULL,'1'),(26,3,'Déleg','cantones Cañar','1','2012-08-29 10:00:00',NULL,'1'),(27,3,'El Tambo','cantones Cañar','1','2012-08-29 10:00:00',NULL,'1'),(28,3,'La Troncal','cantones Cañar','1','2012-08-29 10:00:00',NULL,'1'),(29,3,'Suscal','cantones Cañar','1','2012-08-29 10:00:00',NULL,'1'),(30,4,'Bolívar','cantones Carchi','1','2012-08-29 10:00:00',NULL,'1'),(31,4,'Espejo','cantones Carchi','1','2012-08-29 10:00:00',NULL,'1'),(32,4,'Mira','cantones Carchi','1','2012-08-29 10:00:00',NULL,'1'),(33,4,'Montúfar','cantones Carchi','1','2012-08-29 10:00:00',NULL,'1'),(34,4,'San Pedro De Huaca','cantones Carchi','1','2012-08-29 10:00:00',NULL,'1'),(35,4,'Tulcán','cantones Carchi','1','2012-08-29 10:00:00',NULL,'1'),(36,5,'Alausi','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(37,5,'Chambo','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(38,5,'Chunchi','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(39,5,'Colta','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(40,5,'Cumandá','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(41,5,'Guamote','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(42,5,'Guano','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(43,5,'Pallatanga','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(44,5,'Penipe','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(45,5,'Riobamba','cantones Chimborazo','1','2012-08-29 10:00:00',NULL,'1'),(46,6,'La Maná','cantones Cotopaxi','1','2012-08-29 10:00:00',NULL,'1'),(47,6,'Latacunga','cantones Cotopaxi','1','2012-08-29 10:00:00',NULL,'1'),(48,6,'Pangua','cantones Cotopaxi','1','2012-08-29 10:00:00',NULL,'1'),(49,6,'Pujili','cantones Cotopaxi','1','2012-08-29 10:00:00',NULL,'1'),(50,6,'Salcedo','cantones Cotopaxi','1','2012-08-29 10:00:00',NULL,'1'),(51,6,'Saquisilí','cantones Cotopaxi','1','2012-08-29 10:00:00',NULL,'1'),(52,6,'Sigchos','cantones Cotopaxi','1','2012-08-29 10:00:00',NULL,'1'),(53,7,'Arenillas','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(54,7,'Atahualpa','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(55,7,'Balsas','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(56,7,'Chilla','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(57,7,'El Guabo','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(58,7,'Huaquillas','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(59,7,'Las Lajas','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(60,7,'Machala','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(61,7,'Marcabelí','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(62,7,'Pasaje','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(63,7,'Piñas','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(64,7,'Portovelo','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(65,7,'Santa Rosa','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(66,7,'Zaruma','cantones El Oro','1','2012-08-29 10:00:00',NULL,'1'),(67,8,'Atacames','cantones Esmeraldas','1','2012-08-29 10:00:00',NULL,'1'),(68,8,'Eloy Alfaro','cantones Esmeraldas','1','2012-08-29 10:00:00',NULL,'1'),(69,8,'Esmeraldas','cantones Esmeraldas','1','2012-08-29 10:00:00',NULL,'1'),(70,8,'Muisne','cantones Esmeraldas','1','2012-08-29 10:00:00',NULL,'1'),(71,8,'Quinindé','cantones Esmeraldas','1','2012-08-29 10:00:00',NULL,'1'),(72,8,'Rioverde','cantones Esmeraldas','1','2012-08-29 10:00:00',NULL,'1'),(73,8,'San Lorenzo','cantones Esmeraldas','1','2012-08-29 10:00:00',NULL,'1'),(74,9,'Isabela','cantones Galapagos','1','2012-08-29 10:00:00',NULL,'1'),(75,9,'San Cristóbal','cantones Galapagos','1','2012-08-29 10:00:00',NULL,'1'),(76,9,'Santa Cruz','cantones Galapagos','1','2012-08-29 10:00:00',NULL,'1'),(77,10,'Alfredo Baquerizo Moreno (Juján)','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(78,10,'Balao','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(79,10,'Balzar','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(80,10,'Colimes','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(81,10,'Coronel Marcelino Maridueña','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(82,10,'Daule','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(83,10,'Durán','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(84,10,'El Empalme','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(85,10,'El Triunfo','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(86,10,'General Antonio Elizalde','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(87,10,'Guayaquil','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(88,10,'Isidro Ayora','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(89,10,'Lomas De Sargentillo','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(90,10,'Milagro','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(91,10,'Naranjal','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(92,10,'Naranjito','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(93,10,'Nobol','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(94,10,'Palestina','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(95,10,'Pedro Carbo','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(96,10,'Playas','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(97,10,'Salitre (Urbina Jado)','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(98,10,'Samborondón','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(99,10,'San Jacinto De Yaguachi','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(100,10,'Santa Lucía','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(101,10,'Simón Bolívar','cantones Guayas','1','2012-08-29 10:00:00',NULL,'1'),(102,11,'Antonio Ante','cantones Imbabura','1','2012-08-29 10:00:00',NULL,'1'),(103,11,'Cotacachi','cantones Imbabura','1','2012-08-29 10:00:00',NULL,'1'),(104,11,'Ibarra','cantones Imbabura','1','2012-08-29 10:00:00',NULL,'1'),(105,11,'Otavalo','cantones Imbabura','1','2012-08-29 10:00:00',NULL,'1'),(106,11,'Pimampiro','cantones Imbabura','1','2012-08-29 10:00:00',NULL,'1'),(107,11,'San Miguel De Urcuquí','cantones Imbabura','1','2012-08-29 10:00:00',NULL,'1'),(108,12,'Calvas','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(109,12,'Catamayo','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(110,12,'Celica','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(111,12,'Chaguarpamba','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(112,12,'Espíndola','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(113,12,'Gonzanamá','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(114,12,'Loja','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(115,12,'Macará','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(116,12,'Olmedo','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(117,12,'Paltas','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(118,12,'Pindal','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(119,12,'Puyango','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(120,12,'Quilanga','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(121,12,'Saraguro','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(122,12,'Sozoranga','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(123,12,'Zapotillo','cantones Loja','1','2012-08-29 10:00:00',NULL,'1'),(124,13,'Baba','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(125,13,'Babahoyo','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(126,13,'Buena Fé','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(127,13,'Mocache','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(128,13,'Montalvo','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(129,13,'Palenque','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(130,13,'Puebloviejo','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(131,13,'Quevedo','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(132,13,'Quinsaloma','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(133,13,'Urdaneta','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(134,13,'Valencia','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(135,13,'Ventanas','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(136,13,'Vínces','cantones Los Rios','1','2012-08-29 10:00:00',NULL,'1'),(137,14,'24 De Mayo','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(138,14,'Bolívar','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(139,14,'Chone','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(140,14,'El Carmen','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(141,14,'Flavio Alfaro','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(142,14,'Jama','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(143,14,'Jaramijó','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(144,14,'Jipijapa','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(145,14,'Junín','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(146,14,'Manta','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(147,14,'Montecristi','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(148,14,'Olmedo','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(149,14,'Paján','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(150,14,'Pedernales','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(151,14,'Pichincha','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(152,14,'Portoviejo','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(153,14,'Puerto López','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(154,14,'Rocafuerte','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(155,14,'San Vicente','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(156,14,'Santa Ana','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(157,14,'Sucre','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(158,14,'Tosagua','cantones Manabi','1','2012-08-29 10:00:00',NULL,'1'),(159,15,'Gualaquiza','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(160,15,'Huamboya','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(161,15,'Limón Indanza','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(162,15,'Logroño','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(163,15,'Morona','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(164,15,'Pablo Sexto','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(165,15,'Palora','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(166,15,'San Juan Bosco','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(167,15,'Santiago','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(168,15,'Sucúa','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(169,15,'Taisha','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(170,15,'Tiwintza','cantones Morona Santiago','1','2012-08-29 10:00:00',NULL,'1'),(171,16,'Archidona','cantones Napo','1','2012-08-29 10:00:00',NULL,'1'),(172,16,'Carlos Julio Arosemena Tola','cantones Napo','1','2012-08-29 10:00:00',NULL,'1'),(173,16,'El Chaco','cantones Napo','1','2012-08-29 10:00:00',NULL,'1'),(174,16,'Quijos','cantones Napo','1','2012-08-29 10:00:00',NULL,'1'),(175,16,'Tena','cantones Napo','1','2012-08-29 10:00:00',NULL,'1'),(176,17,'Aguarico','cantones Orellana','1','2012-08-29 10:00:00',NULL,'1'),(177,17,'La Joya De Los Sachas','cantones Orellana','1','2012-08-29 10:00:00',NULL,'1'),(178,17,'Loreto','cantones Orellana','1','2012-08-29 10:00:00',NULL,'1'),(179,17,'Orellana','cantones Orellana','1','2012-08-29 10:00:00',NULL,'1'),(180,18,'Arajuno','cantones Pastaza','1','2012-08-29 10:00:00',NULL,'1'),(181,18,'Mera','cantones Pastaza','1','2012-08-29 10:00:00',NULL,'1'),(182,18,'Pastaza','cantones Pastaza','1','2012-08-29 10:00:00',NULL,'1'),(183,18,'Santa Clara','cantones Pastaza','1','2012-08-29 10:00:00',NULL,'1'),(184,19,'Cayambe','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(185,19,'Mejia','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(186,19,'Pedro Moncayo','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(187,19,'Pedro Vicente Maldonado','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(188,19,'Puerto Quito','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(189,19,'Quito','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(190,19,'Rumiñahui','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(191,19,'San Miguel De Los Bancos','cantones Pichincha','1','2012-08-29 10:00:00',NULL,'1'),(192,20,'La Libertad','cantones Santa Elena','1','2012-08-29 10:00:00',NULL,'1'),(193,20,'Salinas','cantones Santa Elena','1','2012-08-29 10:00:00',NULL,'1'),(194,20,'Santa Elena','cantones Santa Elena','1','2012-08-29 10:00:00',NULL,'1'),(195,21,'La Concordia','cantones Santo Domingo','1','2012-08-29 10:00:00',NULL,'1'),(196,21,'Santo Domingo','cantones Santo Domingo','1','2012-08-29 10:00:00',NULL,'1'),(197,22,'Cascales','cantones Sucumbios','1','2012-08-29 10:00:00',NULL,'1'),(198,22,'Cuyabeno','cantones Sucumbios','1','2012-08-29 10:00:00',NULL,'1'),(199,22,'Gonzalo Pizarro','cantones Sucumbios','1','2012-08-29 10:00:00',NULL,'1'),(200,22,'Lago Agrio','cantones Sucumbios','1','2012-08-29 10:00:00',NULL,'1'),(201,22,'Putumayo','cantones Sucumbios','1','2012-08-29 10:00:00',NULL,'1'),(202,22,'Shushufindi','cantones Sucumbios','1','2012-08-29 10:00:00',NULL,'1'),(203,22,'Sucumbíos','cantones Sucumbios','1','2012-08-29 10:00:00',NULL,'1'),(204,23,'Ambato','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(205,23,'Baños De Agua Santa','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(206,23,'Cevallos','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(207,23,'Mocha','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(208,23,'Patate','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(209,23,'Quero','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(210,23,'San Pedro De Pelileo','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(211,23,'Santiago De Píllaro','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(212,23,'Tisaleo','cantones Tungurahua','1','2012-08-29 10:00:00',NULL,'1'),(213,24,'Centinela Del Cóndor','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(214,24,'Chinchipe','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(215,24,'El Pangui','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(216,24,'Nangaritza','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(217,24,'Palanda','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(218,24,'Paquisha','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(219,24,'Yacuambi','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(220,24,'Yantzaza (Yanzatza)','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1'),(221,24,'Zamora','cantones Zamora Chinchipe','1','2012-08-29 10:00:00',NULL,'1');
/*!40000 ALTER TABLE `canton` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centro_atencion`
--

DROP TABLE IF EXISTS `centro_atencion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centro_atencion` (
  `cate_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_id` bigint(20) NOT NULL,
  `can_id` bigint(20) DEFAULT NULL,
  `cate_nombre` varchar(50) DEFAULT NULL,
  `cate_direccion` varchar(100) DEFAULT NULL,
  `cate_telefono` varchar(20) DEFAULT NULL,
  `cate_correo` varchar(60) DEFAULT NULL,
  `cate_hora_inicio` time DEFAULT NULL,
  `cate_hora_fin` time DEFAULT NULL,
  `cate_est_log` varchar(1) DEFAULT NULL,
  `cate_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cate_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`cate_id`),
  KEY `fk_centro_atencion_empresa1` (`emp_id`),
  CONSTRAINT `fk_centro_atencion_empresa1` FOREIGN KEY (`emp_id`) REFERENCES `empresa` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_atencion`
--

LOCK TABLES `centro_atencion` WRITE;
/*!40000 ALTER TABLE `centro_atencion` DISABLE KEYS */;
INSERT INTO `centro_atencion` VALUES (1,1,'Norte','Norte Ciudad','123456','norte@med.com','07:00:00','18:00:00','1','2016-07-22 10:54:31',NULL),(2,1,'Centro','Centro Ciudad','123457','centro@med.com','07:00:00','18:00:00','1','2016-07-22 10:54:31',NULL),(3,1,'Sur','Sur Ciudad','123458','sur@med.com','07:00:00','18:00:00','1','2016-07-22 10:54:31',NULL);
/*!40000 ALTER TABLE `centro_atencion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita_medica`
--

DROP TABLE IF EXISTS `cita_medica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cita_medica` (
  `cmde_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acit_id` bigint(20) NOT NULL,
  `pac_id` bigint(20) NOT NULL,
  `cprog_id` bigint(20) NOT NULL,
  `tcon_id` bigint(20) NOT NULL,
  `hora_id` bigint(20) NOT NULL,
  `hora_inicio` time NOT NULL,
  `fecha_cita` date NOT NULL,
  `cons_id` bigint(20) NOT NULL,
  `tur_numero` int(5) NOT NULL,
  `cmde_motivo` blob,
  `cmde_observacion` blob,
  `cmde_estado_asistencia` varchar(1) DEFAULT NULL,
  `cmde_est_log` varchar(1) DEFAULT NULL,
  `cmde_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cmde_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`cmde_id`,`acit_id`,`pac_id`,`cprog_id`,`tur_numero`,`hora_id`,`fecha_cita`,`cons_id`,`hora_inicio`),
  KEY `fk_cita_medica_agendar_cita1` (`acit_id`,`pac_id`,`cprog_id`),
  KEY `fk_cita_medica_horario1` (`hora_id`,`fecha_cita`,`cons_id`,`hora_inicio`),
  KEY `fk_cita_medica_001` (`tcon_id`),
  CONSTRAINT `fk_cita_medica_001` FOREIGN KEY (`tcon_id`) REFERENCES `tipo_consulta` (`tcon_id`),
  CONSTRAINT `fk_cita_medica_agendar_cita1` FOREIGN KEY (`acit_id`, `pac_id`, `cprog_id`) REFERENCES `agendar_cita` (`acit_id`, `pac_id`, `cprog_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cita_medica_horario1` FOREIGN KEY (`hora_id`, `fecha_cita`, `cons_id`, `hora_inicio`) REFERENCES `horario` (`hora_id`, `fecha_cita`, `cons_id`, `hora_inicio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita_medica`
--

LOCK TABLES `cita_medica` WRITE;
/*!40000 ALTER TABLE `cita_medica` DISABLE KEYS */;
/*!40000 ALTER TABLE `cita_medica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita_programada`
--

DROP TABLE IF EXISTS `cita_programada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cita_programada` (
  `cprog_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pac_id` bigint(20) NOT NULL,
  `emed_id` bigint(20) NOT NULL,
  `cprog_numero` int(10) DEFAULT NULL,
  `cprog_observacion` blob,
  `cprog_est_log` varchar(1) DEFAULT NULL,
  `cprog_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cprog_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`cprog_id`,`pac_id`),
  KEY `fk_cita_programada_paciente1` (`pac_id`),
  KEY `fk_cita_programada_especialidad_medico1` (`emed_id`),
  CONSTRAINT `fk_cita_programada_especialidad_medico1` FOREIGN KEY (`emed_id`) REFERENCES `especialidad_medico` (`emed_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cita_programada_paciente1` FOREIGN KEY (`pac_id`) REFERENCES `paciente` (`pac_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita_programada`
--

LOCK TABLES `cita_programada` WRITE;
/*!40000 ALTER TABLE `cita_programada` DISABLE KEYS */;
INSERT INTO `cita_programada` VALUES (1,1,1,0,'adaddsd','2','2016-08-17 03:23:45',NULL),(2,1,3,0,'documentod de datao inform','1','2016-08-17 03:28:25',NULL),(3,1,4,0,'sdses con la vida de lsd vida en donde la opciones estan datas perosor nose como actuar \npero tu no pueses','2','2016-08-17 05:25:11',NULL);
/*!40000 ALTER TABLE `cita_programada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultorio`
--

DROP TABLE IF EXISTS `consultorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultorio` (
  `cons_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cate_id` bigint(20) NOT NULL,
  `esp_id` bigint(20) NOT NULL,
  `ofi_id` bigint(20) NOT NULL,
  `cons_nombre` varchar(50) DEFAULT NULL,
  `cons_telefono` varchar(20) DEFAULT NULL,
  `cons_correo` varchar(60) DEFAULT NULL,
  `cons_hora_inicio` time DEFAULT NULL,
  `cons_hora_fin` time DEFAULT NULL,
  `cons_tiempo_consulta` time DEFAULT NULL,
  `cons_est_log` varchar(1) DEFAULT NULL,
  `cons_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cons_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`cons_id`),
  KEY `fk_consultorio_centro_atencion1` (`cate_id`),
  KEY `fk_consultorio_especialidad1` (`esp_id`),
  KEY `fk_consultorio_oficina1` (`ofi_id`),
  CONSTRAINT `fk_consultorio_centro_atencion1` FOREIGN KEY (`cate_id`) REFERENCES `centro_atencion` (`cate_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultorio_especialidad1` FOREIGN KEY (`esp_id`) REFERENCES `especialidad` (`esp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultorio_oficina1` FOREIGN KEY (`ofi_id`) REFERENCES `oficina` (`ofi_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultorio`
--

LOCK TABLES `consultorio` WRITE;
/*!40000 ALTER TABLE `consultorio` DISABLE KEYS */;
INSERT INTO `consultorio` VALUES (1,1,12,1,'Consultorio 1','1254541','con1@med.com','07:00:00','18:00:00','00:30:00','1','2016-07-22 11:05:15',NULL),(2,1,17,2,'Consultorio 2','1254543','con2@med.com','07:00:00','18:00:00','00:30:00','1','2016-07-22 11:05:15',NULL),(3,1,2,3,'Consultorio 3','5214119','con3@med.com','07:00:00','13:00:00','00:30:00','1','2016-07-22 11:05:15',NULL);
/*!40000 ALTER TABLE `consultorio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_persona`
--

DROP TABLE IF EXISTS `data_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_persona` (
  `dper_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `per_id` bigint(20) NOT NULL,
  `pai_id` bigint(20) DEFAULT NULL,
  `prov_id` bigint(20) DEFAULT NULL,
  `can_id` bigint(20) DEFAULT NULL,
  `dper_descripcion` varchar(100) DEFAULT NULL,
  `dper_direccion` varchar(100) DEFAULT NULL,
  `dper_telefono` varchar(20) DEFAULT NULL,
  `dper_celular` varchar(20) DEFAULT NULL,
  `dper_contacto` varchar(60) DEFAULT NULL,
  `dper_est_log` varchar(1) DEFAULT NULL,
  `dper_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dper_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dper_id`),
  KEY `fk_data_persona_persona` (`per_id`),
  CONSTRAINT `fk_data_persona_persona` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_persona`
--

LOCK TABLES `data_persona` WRITE;
/*!40000 ALTER TABLE `data_persona` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dicom`
--

DROP TABLE IF EXISTS `dicom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dicom` (
  `dic_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tdic_id` bigint(20) NOT NULL,
  `dic_size` decimal(10,2) DEFAULT NULL,
  `dic_ruta` varchar(80) DEFAULT NULL,
  `dic_est_log` varchar(1) DEFAULT NULL,
  `dic_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dic_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dic_id`),
  KEY `fk_dicom_tipo_dicom1` (`tdic_id`),
  CONSTRAINT `fk_dicom_tipo_dicom1` FOREIGN KEY (`tdic_id`) REFERENCES `tipo_dicom` (`tdic_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dicom`
--

LOCK TABLES `dicom` WRITE;
/*!40000 ALTER TABLE `dicom` DISABLE KEYS */;
/*!40000 ALTER TABLE `dicom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa` (
  `emp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_nombre` varchar(50) DEFAULT NULL,
  `emp_ruc` varchar(15) DEFAULT NULL,
  `emp_descripcion` varchar(100) DEFAULT NULL,
  `emp_direccion` varchar(100) DEFAULT NULL,
  `emp_telefono` varchar(20) DEFAULT NULL,
  `emp_est_log` varchar(1) DEFAULT NULL,
  `emp_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `emp_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'Medical','1310328405001','Imagenes Digitales',NULL,'Colon','1','2016-03-03 07:47:47',NULL);
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especialidad` (
  `esp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `esp_nombre` varchar(60) DEFAULT NULL,
  `esp_nivel` int(5) DEFAULT NULL,
  `esp_est_log` varchar(1) DEFAULT NULL,
  `esp_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `esp_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`esp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
INSERT INTO `especialidad` VALUES (1,'ANATOMÍA PATOLÓGICA',NULL,'1','2016-05-12 11:58:48',NULL),(2,'ANESTESIOLOGÍA',NULL,'1','2016-05-12 11:58:48',NULL),(3,'ALERGOLOGIA',NULL,'1','2016-05-12 11:58:48',NULL),(4,'CARDIOLOGÍA',NULL,'1','2016-05-12 11:58:48',NULL),(5,'CARDIOLOGO/ ECOGRAFISTA',NULL,'1','2016-05-12 11:58:48',NULL),(6,'CARDIOLOGÍA  HEMODINÁMICA',NULL,'1','2016-05-12 11:58:48',NULL),(7,'CARDIOLOGÍA INFANTIL',NULL,'1','2016-05-12 11:58:48',NULL),(8,'CIRUGÍA GENERAL LAPAROSCÓPICA',NULL,'1','2016-05-12 11:58:48',NULL),(9,'CIRUGIA GENERAL',NULL,'1','2016-05-12 11:58:48',NULL),(10,'CIRUGÍA ONCOLÓGICA',NULL,'1','2016-05-12 11:58:48',NULL),(11,'DERMATOLOGIA',NULL,'1','2016-05-12 11:58:48',NULL),(12,'ELECTROMIOGRAFÍA',NULL,'1','2016-05-12 11:58:48',NULL),(13,'ENDOSCOPÍA DIGESTIVA',NULL,'1','2016-05-12 11:58:48',NULL),(14,'GASTROENTEROLOGÍA',NULL,'1','2016-05-12 11:58:48',NULL),(15,'GINECOLOGIA',NULL,'1','2016-05-12 11:58:48',NULL),(16,'LABORATORIO CLÍNICO ',NULL,'1','2016-05-12 11:58:48',NULL),(17,'MAMOGRAFÍAS',NULL,'1','2016-05-12 11:58:48',NULL),(18,'ODONTOLOGÍA',NULL,'1','2016-05-12 11:58:49',NULL),(19,'OFTALMOLOGÍA',NULL,'1','2016-05-12 11:58:49',NULL),(20,'OTORRINOLARINGOLOGÍA',NULL,'1','2016-05-12 11:58:49',NULL),(21,'PEDIATRIA',NULL,'1','2016-05-12 11:58:49',NULL),(22,'REUMATOLOGÍA',NULL,'1','2016-05-12 11:58:49',NULL),(23,'UROLOGÍA',NULL,'1','2016-05-12 11:58:49',NULL);
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad_medico`
--

DROP TABLE IF EXISTS `especialidad_medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especialidad_medico` (
  `emed_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `esp_id` bigint(20) NOT NULL,
  `med_id` bigint(20) NOT NULL,
  `emed_nivel` int(5) DEFAULT NULL,
  `emed_est_log` varchar(1) DEFAULT NULL,
  `emed_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `emed_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`emed_id`),
  KEY `fk_especialidad_medico_especialidad1` (`esp_id`),
  KEY `fk_especialidad_medico_medico1` (`med_id`),
  CONSTRAINT `fk_especialidad_medico_especialidad1` FOREIGN KEY (`esp_id`) REFERENCES `especialidad` (`esp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_especialidad_medico_medico1` FOREIGN KEY (`med_id`) REFERENCES `medico` (`med_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidad_medico`
--

LOCK TABLES `especialidad_medico` WRITE;
/*!40000 ALTER TABLE `especialidad_medico` DISABLE KEYS */;
INSERT INTO `especialidad_medico` VALUES (1,2,1,5,'1','2016-07-22 10:30:22',NULL),(2,5,1,5,'1','2016-07-22 10:30:22',NULL),(3,12,1,5,'1','2016-07-22 10:30:22',NULL),(4,17,1,5,'1','2016-07-22 10:30:22',NULL);
/*!40000 ALTER TABLE `especialidad_medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventos` (
  `eve_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cmde_id` bigint(20) NOT NULL,
  `eve_usu_id` bigint(20) NOT NULL,
  `eve_nombre` varchar(50) DEFAULT NULL,
  `eve_observacion` text,
  `eve_fec_cre` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eve_fec_mod` timestamp NULL DEFAULT NULL,
  `eve_est_log` varchar(1) NOT NULL,
  PRIMARY KEY (`eve_id`),
  KEY `fk_eventos_cita_medica1` (`cmde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo` (
  `gru_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpas_id` bigint(20) NOT NULL,
  `gru_nombre` varchar(50) DEFAULT NULL,
  `gru_descripcion` varchar(200) DEFAULT NULL,
  `gru_estado_activo` varchar(1) NOT NULL,
  `gru_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gru_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `gru_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`gru_id`),
  KEY `tpas_id` (`tpas_id`),
  CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`tpas_id`) REFERENCES `tipo_password` (`tpas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_rol`
--

DROP TABLE IF EXISTS `grupo_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_rol` (
  `grol_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gru_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `usu_id` bigint(20) NOT NULL,
  `grol_estado_activo` varchar(1) NOT NULL,
  `grol_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `grol_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `grol_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`grol_id`),
  KEY `gru_id` (`gru_id`),
  KEY `rol_id` (`rol_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `grupo_rol_ibfk_1` FOREIGN KEY (`gru_id`) REFERENCES `grupo` (`gru_id`),
  CONSTRAINT `grupo_rol_ibfk_2` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`),
  CONSTRAINT `grupo_rol_ibfk_3` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_rol`
--

LOCK TABLES `grupo_rol` WRITE;
/*!40000 ALTER TABLE `grupo_rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horario` (
  `hora_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha_cita` date NOT NULL,
  `cons_id` bigint(20) NOT NULL,
  `med_id` bigint(20) NOT NULL,
  `hora_inicio` time NOT NULL DEFAULT '00:00:00',
  `hora_fin` time DEFAULT NULL,
  `hora_est_log` varchar(1) DEFAULT NULL,
  `hora_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `hora_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`hora_id`,`fecha_cita`,`cons_id`,`hora_inicio`),
  KEY `fk_horario_consultorio1` (`cons_id`),
  KEY `fk_horario_medico1` (`med_id`),
  CONSTRAINT `fk_horario_consultorio1` FOREIGN KEY (`cons_id`) REFERENCES `consultorio` (`cons_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_medico1` FOREIGN KEY (`med_id`) REFERENCES `medico` (`med_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` VALUES (28,'2016-08-27',3,1,'08:30:00','09:00:00','1','2016-08-03 01:51:43',NULL),(29,'2016-08-27',3,1,'10:00:00','10:30:00','1','2016-08-03 01:51:43',NULL),(30,'2016-08-27',3,1,'11:00:00','11:30:00','1','2016-08-03 01:51:43',NULL),(31,'2016-08-02',3,1,'08:00:00','08:30:00','0','2016-08-03 04:24:41',NULL),(32,'2016-08-02',3,1,'08:30:00','09:00:00','0','2016-08-03 04:24:41',NULL),(33,'2016-08-02',3,1,'09:30:00','10:00:00','0','2016-08-03 04:24:41',NULL),(34,'2016-08-02',3,1,'08:00:00','08:30:00','1','2016-08-03 05:13:04',NULL),(35,'2016-08-02',3,1,'08:30:00','09:00:00','1','2016-08-03 05:13:04',NULL),(36,'2016-08-02',3,1,'09:30:00','10:00:00','1','2016-08-03 05:13:04',NULL),(37,'2016-08-02',3,1,'10:30:00','11:00:00','1','2016-08-03 05:13:04',NULL),(38,'2016-08-02',3,1,'11:30:00','12:00:00','1','2016-08-03 05:13:04',NULL),(39,'2016-08-02',1,1,'07:30:00','08:00:00','1','2016-08-03 05:13:54',NULL),(40,'2016-08-02',1,1,'08:00:00','08:30:00','1','2016-08-03 05:13:54',NULL),(41,'2016-08-02',1,1,'08:30:00','09:00:00','1','2016-08-03 05:13:54',NULL),(42,'2016-08-02',1,1,'09:00:00','09:30:00','1','2016-08-03 05:13:54',NULL),(43,'2016-08-02',1,1,'09:30:00','10:00:00','1','2016-08-03 05:13:54',NULL),(44,'2016-08-02',1,1,'10:30:00','11:00:00','1','2016-08-03 05:13:54',NULL),(45,'2016-08-02',1,1,'11:00:00','11:30:00','1','2016-08-03 05:13:54',NULL),(46,'2016-08-02',1,1,'12:00:00','12:30:00','1','2016-08-03 05:13:54',NULL),(47,'2016-08-02',1,1,'15:00:00','15:30:00','1','2016-08-03 05:13:54',NULL),(48,'2016-08-02',1,1,'15:30:00','16:00:00','1','2016-08-03 05:13:54',NULL),(49,'2016-08-02',1,1,'16:00:00','16:30:00','1','2016-08-03 05:13:54',NULL),(50,'2016-08-02',1,1,'17:00:00','17:30:00','1','2016-08-03 05:13:54',NULL),(51,'2016-08-02',1,1,'17:30:00','18:00:00','1','2016-08-03 05:13:54',NULL),(52,'2016-08-15',3,1,'08:00:00','08:30:00','1','2016-08-16 04:27:15',NULL),(53,'2016-08-15',3,1,'09:00:00','09:30:00','1','2016-08-16 04:27:15',NULL),(54,'2016-08-15',3,1,'09:30:00','10:00:00','1','2016-08-16 04:27:15',NULL),(55,'2016-08-15',3,1,'10:00:00','10:30:00','1','2016-08-16 04:27:15',NULL),(56,'2016-08-15',3,1,'10:30:00','11:00:00','1','2016-08-16 04:27:15',NULL);
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagenes`
--

DROP TABLE IF EXISTS `imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagenes` (
  `ima_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eve_id` bigint(20) NOT NULL,
  `ima_titulo` varchar(60) DEFAULT NULL,
  `ima_nombre_archivo` varchar(60) DEFAULT NULL,
  `ima_extension_archivo` varchar(5) DEFAULT NULL,
  `ima_ruta_archivo` varchar(10) DEFAULT NULL,
  `ima_tamano` varchar(10) DEFAULT NULL,
  `ima_folio` varchar(20) DEFAULT NULL,
  `ima_observacion` text,
  `ima_fecha_publica` timestamp NULL DEFAULT NULL,
  `ima_fec_cre` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ima_fec_mod` timestamp NULL DEFAULT NULL,
  `ima_est_log` varchar(1) NOT NULL,
  PRIMARY KEY (`ima_id`),
  KEY `fk_imagenes_eventos1` (`eve_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagenes`
--

LOCK TABLES `imagenes` WRITE;
/*!40000 ALTER TABLE `imagenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usu_id` bigint(20) NOT NULL,
  `log_registro` bigint(20) NOT NULL,
  `log_accion` varchar(60) DEFAULT NULL,
  `log_table` varchar(60) DEFAULT NULL,
  `log_fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `fk_log_usuario1` (`usu_id`),
  CONSTRAINT `fk_log_usuario1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,1,3,'Insert -> hora_id->07:30:00','horario','2016-07-29 05:55:37'),(2,1,3,'Insert -> hora_id->09:00:00','horario','2016-07-29 05:55:37'),(3,1,3,'Insert -> hora_id->09:30:00','horario','2016-07-29 05:55:37'),(4,1,3,'Insert -> hora_id->11:00:00','horario','2016-07-29 05:55:37'),(5,1,3,'Insert -> hora_id->07:30:00','horario','2016-07-29 05:56:41'),(6,1,3,'Insert -> hora_id->09:00:00','horario','2016-07-29 05:56:41'),(7,1,3,'Insert -> hora_id->09:30:00','horario','2016-07-29 05:56:41'),(8,1,3,'Insert -> hora_id->11:00:00','horario','2016-07-29 05:56:41'),(9,1,9,'Insert -> hora_id->07:30:00','horario','2016-07-29 06:01:03'),(10,1,10,'Insert -> hora_id->09:00:00','horario','2016-07-29 06:01:03'),(11,1,11,'Insert -> hora_id->09:30:00','horario','2016-07-29 06:01:03'),(12,1,12,'Insert -> hora_id->11:00:00','horario','2016-07-29 06:01:03'),(13,1,13,'Insert -> hora_id->07:30:00','horario','2016-07-29 06:19:57'),(14,1,14,'Insert -> hora_id->09:00:00','horario','2016-07-29 06:19:57'),(15,1,15,'Insert -> hora_id->09:30:00','horario','2016-07-29 06:19:57'),(16,1,16,'Insert -> hora_id->11:00:00','horario','2016-07-29 06:19:57'),(17,1,17,'Insert -> hora_id->08:00:00','horario','2016-08-02 04:19:50'),(18,1,18,'Insert -> hora_id->09:30:00','horario','2016-08-02 04:19:50'),(19,1,19,'Insert -> hora_id->10:30:00','horario','2016-08-02 04:19:50'),(20,1,20,'Insert -> hora_id->09:00:00','horario','2016-08-02 04:38:22'),(21,1,21,'Insert -> hora_id->10:00:00','horario','2016-08-02 04:38:22'),(22,1,22,'Insert -> hora_id->11:00:00','horario','2016-08-02 04:38:22'),(23,1,23,'Insert -> hora_id->08:30:00','horario','2016-08-03 01:31:07'),(24,1,24,'Insert -> hora_id->09:30:00','horario','2016-08-03 01:31:07'),(25,1,25,'Insert -> hora_id->08:00:00','horario','2016-08-03 01:36:39'),(26,1,26,'Insert -> hora_id->09:00:00','horario','2016-08-03 01:36:39'),(27,1,27,'Insert -> hora_id->10:00:00','horario','2016-08-03 01:36:39'),(28,1,28,'Insert -> hora_id->08:30:00','horario','2016-08-03 01:51:43'),(29,1,29,'Insert -> hora_id->10:00:00','horario','2016-08-03 01:51:43'),(30,1,30,'Insert -> hora_id->11:00:00','horario','2016-08-03 01:51:43'),(31,1,31,'Insert -> hora_id->08:00:00','horario','2016-08-03 04:24:41'),(32,1,32,'Insert -> hora_id->08:30:00','horario','2016-08-03 04:24:41'),(33,1,33,'Insert -> hora_id->09:30:00','horario','2016-08-03 04:24:41'),(34,1,34,'Insert -> hora_id->08:00:00','horario','2016-08-03 05:13:04'),(35,1,35,'Insert -> hora_id->08:30:00','horario','2016-08-03 05:13:04'),(36,1,36,'Insert -> hora_id->09:30:00','horario','2016-08-03 05:13:04'),(37,1,37,'Insert -> hora_id->10:30:00','horario','2016-08-03 05:13:04'),(38,1,38,'Insert -> hora_id->11:30:00','horario','2016-08-03 05:13:04'),(39,1,39,'Insert -> hora_id->07:30:00','horario','2016-08-03 05:13:54'),(40,1,40,'Insert -> hora_id->08:00:00','horario','2016-08-03 05:13:54'),(41,1,41,'Insert -> hora_id->08:30:00','horario','2016-08-03 05:13:54'),(42,1,42,'Insert -> hora_id->09:00:00','horario','2016-08-03 05:13:54'),(43,1,43,'Insert -> hora_id->09:30:00','horario','2016-08-03 05:13:54'),(44,1,44,'Insert -> hora_id->10:30:00','horario','2016-08-03 05:13:54'),(45,1,45,'Insert -> hora_id->11:00:00','horario','2016-08-03 05:13:54'),(46,1,46,'Insert -> hora_id->12:00:00','horario','2016-08-03 05:13:54'),(47,1,47,'Insert -> hora_id->15:00:00','horario','2016-08-03 05:13:54'),(48,1,48,'Insert -> hora_id->15:30:00','horario','2016-08-03 05:13:54'),(49,1,49,'Insert -> hora_id->16:00:00','horario','2016-08-03 05:13:54'),(50,1,50,'Insert -> hora_id->17:00:00','horario','2016-08-03 05:13:54'),(51,1,51,'Insert -> hora_id->17:30:00','horario','2016-08-03 05:13:54'),(52,3,52,'Insert -> hora_id->08:00:00','horario','2016-08-16 04:27:15'),(53,3,53,'Insert -> hora_id->09:00:00','horario','2016-08-16 04:27:15'),(54,3,54,'Insert -> hora_id->09:30:00','horario','2016-08-16 04:27:15'),(55,3,55,'Insert -> hora_id->10:00:00','horario','2016-08-16 04:27:15'),(56,3,56,'Insert -> hora_id->10:30:00','horario','2016-08-16 04:27:15'),(57,3,1,'Insert -> cprog_id->1','cita_programada','2016-08-17 03:23:45'),(58,3,2,'Insert -> cprog_id->2','cita_programada','2016-08-17 03:28:25'),(59,3,3,'Insert -> cprog_id->3','cita_programada','2016-08-17 05:25:11');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico` (
  `med_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `per_id` bigint(20) NOT NULL,
  `med_colegiado` varchar(100) DEFAULT NULL,
  `med_registro` varchar(20) DEFAULT NULL,
  `med_est_log` varchar(1) DEFAULT NULL,
  `med_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `med_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`med_id`),
  KEY `fk_medico_persona1` (`per_id`),
  CONSTRAINT `fk_medico_persona1` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
/*!40000 ALTER TABLE `medico` DISABLE KEYS */;
INSERT INTO `medico` VALUES (1,3,'DATA','218121511','1','2016-07-22 10:30:22',NULL);
/*!40000 ALTER TABLE `medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico_atencion`
--

DROP TABLE IF EXISTS `medico_atencion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_atencion` (
  `mate_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `med_id` bigint(20) NOT NULL,
  `pac_id` bigint(20) NOT NULL,
  `mate_est_log` varchar(1) DEFAULT NULL,
  `mate_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `mate_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`mate_id`),
  KEY `fk_medico_atencion_medico1` (`med_id`),
  KEY `fk_medico_atencion_paciente1` (`pac_id`),
  CONSTRAINT `fk_medico_atencion_medico1` FOREIGN KEY (`med_id`) REFERENCES `medico` (`med_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_atencion_paciente1` FOREIGN KEY (`pac_id`) REFERENCES `paciente` (`pac_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico_atencion`
--

LOCK TABLES `medico_atencion` WRITE;
/*!40000 ALTER TABLE `medico_atencion` DISABLE KEYS */;
INSERT INTO `medico_atencion` VALUES (1,1,1,'1','0000-00-00 00:00:00',NULL);
/*!40000 ALTER TABLE `medico_atencion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico_empresa`
--

DROP TABLE IF EXISTS `medico_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_empresa` (
  `memp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `med_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  `memp_est_log` varchar(1) DEFAULT NULL,
  `memp_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `memp_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`memp_id`),
  KEY `fk_medico_empresa_medico1` (`med_id`),
  KEY `fk_medico_empresa_empresa1` (`emp_id`),
  CONSTRAINT `fk_medico_empresa_empresa1` FOREIGN KEY (`emp_id`) REFERENCES `empresa` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_empresa_medico1` FOREIGN KEY (`med_id`) REFERENCES `medico` (`med_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico_empresa`
--

LOCK TABLES `medico_empresa` WRITE;
/*!40000 ALTER TABLE `medico_empresa` DISABLE KEYS */;
INSERT INTO `medico_empresa` VALUES (1,1,1,'1','2016-07-22 10:30:22',NULL);
/*!40000 ALTER TABLE `medico_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulo` (
  `mod_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apl_id` bigint(20) NOT NULL,
  `mod_nombre` varchar(50) DEFAULT NULL,
  `mod_dir_imagen` varchar(100) DEFAULT NULL,
  `mod_url` varchar(100) DEFAULT NULL,
  `mod_orden` bigint(2) DEFAULT NULL,
  `mod_lang_file` varchar(60) DEFAULT NULL,
  `mod_estado_activo` varchar(1) NOT NULL,
  `mod_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `mod_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`mod_id`),
  KEY `fk_modulo_aplicacion1` (`apl_id`),
  CONSTRAINT `fk_modulo_aplicacion1` FOREIGN KEY (`apl_id`) REFERENCES `aplicacion` (`apl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulo`
--

LOCK TABLES `modulo` WRITE;
/*!40000 ALTER TABLE `modulo` DISABLE KEYS */;
INSERT INTO `modulo` VALUES (1,1,'Dashboard','fa fa-dashboard','site/index',1,'application','1','2012-08-26 11:47:23',NULL,'1'),(2,1,'My Account','glyphicon glyphicon-user','perfil/index',2,'menu','1','2012-08-26 11:47:23',NULL,'1'),(3,1,'My Forms','glyphicon glyphicon-list-alt','mceformulariotemp/index',3,'application','1','2012-08-26 11:47:23',NULL,'1'),(4,1,'Processes','glyphicon glyphicon-th-large','perfil/index',4,'application','1','2012-08-26 11:47:23',NULL,'1'),(5,1,'Images','glyphicon glyphicon-picture','site/index',5,'application','1','2016-03-18 10:09:10',NULL,'1'),(6,1,'Maintenance','glyphicon glyphicon-wrench','site/index',6,'application','1','2016-03-18 10:31:11',NULL,'1');
/*!40000 ALTER TABLE `modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objeto_modulo`
--

DROP TABLE IF EXISTS `objeto_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objeto_modulo` (
  `omod_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mod_id` bigint(20) NOT NULL,
  `omod_padre_id` bigint(20) DEFAULT NULL,
  `omod_nombre` varchar(50) DEFAULT NULL,
  `omod_tipo` varchar(60) DEFAULT NULL,
  `omod_tipo_boton` varchar(1) DEFAULT NULL,
  `omod_accion` varchar(50) DEFAULT NULL,
  `omod_function` varchar(100) DEFAULT NULL,
  `omod_dir_imagen` varchar(100) DEFAULT NULL,
  `omod_entidad` varchar(100) DEFAULT NULL,
  `omod_orden` bigint(2) DEFAULT NULL,
  `omod_estado_visible` int(1) DEFAULT NULL,
  `omod_lang_file` varchar(60) DEFAULT NULL,
  `omod_estado_activo` varchar(1) NOT NULL,
  `omod_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `omod_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `omod_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`omod_id`),
  KEY `fk_objeto_modulo_modulo1` (`mod_id`),
  KEY `fk_objeto_modulo_objeto_modulo1` (`omod_padre_id`),
  CONSTRAINT `fk_objeto_modulo_modulo1` FOREIGN KEY (`mod_id`) REFERENCES `modulo` (`mod_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_objeto_modulo_objeto_modulo1` FOREIGN KEY (`omod_padre_id`) REFERENCES `objeto_modulo` (`omod_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objeto_modulo`
--

LOCK TABLES `objeto_modulo` WRITE;
/*!40000 ALTER TABLE `objeto_modulo` DISABLE KEYS */;
INSERT INTO `objeto_modulo` VALUES (1,1,1,'Dashboard','P','0','Applications','','','site/index',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(2,2,1,'My Account','P','0','Applications','','','perfil/index',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(3,3,1,'My Forms','P','0','Applications','','','mceformulario/autorizar',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(4,4,1,'Processes','P','0','Applications','','','mceformulario/view',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(5,5,1,'Images','P','0','Applications','','','mceformulario/message',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(6,6,1,'Maintenance','P','0','Applications','','','mceformulario/deletemessage',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(7,2,2,'Profile','S','0','My Account','','','perfil/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),(8,2,2,'Save Profile','A','0','My Account','','','perfil/save',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),(9,2,2,'Change Password','S','0','Applications','','','perfil/password',2,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),(10,4,4,'Book Appointment','S','0','Applications','','','mceseguimiento/create',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(11,4,4,'Quote address','S','0','Applications','','','mceseguimiento/update',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(12,6,6,'Patient','S','0','Applications','','','paciente/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),(13,6,6,'Medico','S','0','Applications','','','medico/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),(14,6,6,'Admin Medico','S','0','My Forms','','','medico/adminmedico',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(15,6,6,'Admin Paciente','S','0','My Forms','','','mceformulariotemp/view',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(16,3,14,'Create Form','A','0','My Forms','','','mceformulariotemp/create',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(17,3,14,'Update Form','A','0','My Forms','','','mceformulariotemp/update',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(18,3,14,'Save Form','A','0','My Forms','','','mceformulariotemp/save',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(19,3,14,'Brand Use','A','0','My Forms','','','mceformulariotemp/usomarca',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(20,3,14,'Upload File','A','0','My Forms','','','mceformulariotemp/uploadfile',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(21,3,14,'Download File','A','0','My Forms','','','mceformulariotemp/download',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(22,3,14,'View Message','A','0','My Forms','','','mceformulariotemp/viewmessage',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(23,3,14,'Pdf Application','A','0','My Forms','','','mceformulariotemp/solicitudpdf',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(24,1,1,'Search Application','A','0','Applications','','','mceformulario/buscarpersonas',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(25,1,1,'Pdf Application Sol','A','0','Applications','','','mceformulario/solicitudpdf',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(26,4,26,'Profile','S','0','My Account','','','perfil/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),(27,4,26,'Save Profile','A','0','My Account','','','perfil/save',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1');
/*!40000 ALTER TABLE `objeto_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obmo_acci`
--

DROP TABLE IF EXISTS `obmo_acci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obmo_acci` (
  `oacc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `omod_id` bigint(20) NOT NULL,
  `acc_id` bigint(20) NOT NULL,
  `oacc_tipo_boton` varchar(1) DEFAULT NULL,
  `oacc_cont_accion` varchar(100) DEFAULT NULL,
  `oacc_function` varchar(100) DEFAULT NULL,
  `oacc_estado_activo` varchar(1) NOT NULL,
  `oacc_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oacc_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `oacc_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`oacc_id`),
  KEY `omod_id` (`omod_id`),
  KEY `acc_id` (`acc_id`),
  CONSTRAINT `obmo_acci_ibfk_1` FOREIGN KEY (`omod_id`) REFERENCES `objeto_modulo` (`omod_id`),
  CONSTRAINT `obmo_acci_ibfk_2` FOREIGN KEY (`acc_id`) REFERENCES `accion` (`acc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obmo_acci`
--

LOCK TABLES `obmo_acci` WRITE;
/*!40000 ALTER TABLE `obmo_acci` DISABLE KEYS */;
INSERT INTO `obmo_acci` VALUES (1,1,1,'5',NULL,'alert()','1','2014-06-12 12:43:33',NULL,'1');
/*!40000 ALTER TABLE `obmo_acci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oficina`
--

DROP TABLE IF EXISTS `oficina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oficina` (
  `ofi_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ofi_nombre` varchar(50) DEFAULT NULL,
  `ofi_est_log` varchar(1) DEFAULT NULL,
  `ofi_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ofi_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ofi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oficina`
--

LOCK TABLES `oficina` WRITE;
/*!40000 ALTER TABLE `oficina` DISABLE KEYS */;
INSERT INTO `oficina` VALUES (1,'N100','1','2016-07-22 10:45:40',NULL),(2,'N101','1','2016-07-22 10:46:14',NULL),(3,'N102','1','2016-07-22 10:46:14',NULL);
/*!40000 ALTER TABLE `oficina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `omodulo_rol`
--

DROP TABLE IF EXISTS `omodulo_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `omodulo_rol` (
  `omrol_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `omod_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `omrol_est_log` varchar(1) DEFAULT NULL,
  `omrol_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `omrol_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`omrol_id`),
  KEY `fk_omodulo_rol_objeto_modulo1` (`omod_id`),
  KEY `fk_omodulo_rol_rol1` (`rol_id`),
  CONSTRAINT `fk_omodulo_rol_objeto_modulo1` FOREIGN KEY (`omod_id`) REFERENCES `objeto_modulo` (`omod_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_omodulo_rol_rol1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `omodulo_rol`
--

LOCK TABLES `omodulo_rol` WRITE;
/*!40000 ALTER TABLE `omodulo_rol` DISABLE KEYS */;
INSERT INTO `omodulo_rol` VALUES (1,1,1,'1','2016-03-03 20:37:33',NULL),(2,2,1,'1','2016-03-18 14:41:00',NULL),(3,3,1,'1','2016-03-18 14:41:00',NULL),(4,4,1,'1','2016-03-18 15:03:29',NULL),(5,5,1,'1','2016-03-18 15:37:00',NULL),(6,6,1,'1','2016-03-18 15:37:00',NULL),(7,7,1,'1','2016-03-18 15:47:02',NULL),(8,8,1,'1','2016-03-18 15:47:02',NULL),(9,9,1,'1','2016-03-18 15:47:02',NULL),(10,10,1,'1','2016-03-18 15:47:02',NULL),(11,11,1,'1','2016-03-18 15:47:02',NULL),(12,12,1,'1','2016-03-18 15:47:02',NULL),(13,13,1,'1','2016-03-18 15:47:02',NULL),(14,14,1,'1','2016-07-22 11:38:34',NULL),(15,15,1,'1','2016-07-22 11:38:34',NULL),(16,13,3,'1','2016-08-03 06:20:37',NULL),(17,14,3,'1','2016-08-03 06:20:37',NULL);
/*!40000 ALTER TABLE `omodulo_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `pac_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `per_id` bigint(20) NOT NULL,
  `pac_fecha_ingreso` timestamp NULL DEFAULT NULL,
  `pac_est_log` varchar(1) DEFAULT NULL,
  `pac_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pac_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pac_id`),
  KEY `fk_paciente_persona1` (`per_id`),
  CONSTRAINT `fk_paciente_persona1` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES (1,4,NULL,'1','2016-07-22 10:35:30',NULL);
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `pai_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pai_nombre` varchar(50) DEFAULT NULL,
  `pai_descripcion` varchar(50) DEFAULT NULL,
  `pai_estado_activo` varchar(1) NOT NULL,
  `pai_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pai_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `pai_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`pai_id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'Afganistán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(2,'Albania',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(3,'Alemania',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(4,'Andorra',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(5,'Angola',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(6,'Anguila',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(7,'Antigua y Barbuda',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(8,'Antillas Neerlandesas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(9,'Antártida',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(10,'Arabia Saudí',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(11,'Argelia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(12,'Argentina',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(13,'Armenia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(14,'Aruba',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(15,'Australia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(16,'Austria',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(17,'Azerbaiyán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(18,'Bahamas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(19,'Bahréin',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(20,'Bangladesh',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(21,'Barbados',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(22,'Belice',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(23,'Benín',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(24,'Bermudas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(25,'Bielorrusia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(26,'Bolivia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(27,'Bosnia-Herzegovina',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(28,'Botsuana',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(29,'Brasil',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(30,'Brunéi',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(31,'Bulgaria',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(32,'Burkina Faso',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(33,'Burundi',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(34,'Bután',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(35,'Bélgica',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(36,'Cabo Verde',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(37,'Camboya',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(38,'Camerún',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(39,'Canadá',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(40,'Chad',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(41,'Chile',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(42,'China',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(43,'Chipre',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(44,'Ciudad del Vaticano',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(45,'Colombia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(46,'Comoras',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(47,'Congo',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(48,'Corea del Norte',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(49,'Corea del Sur',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(50,'Costa Rica',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(51,'Costa de Marfil',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(52,'Croacia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(53,'Cuba',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(54,'Dinamarca',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(55,'Dominica',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(56,'Ecuador',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(57,'Egipto',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(58,'El Salvador',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(59,'Emiratos Árabes Unidos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(60,'Eritrea',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(61,'Eslovaquia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(62,'Eslovenia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(63,'España',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(64,'Estados Unidos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(65,'Estonia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(66,'Etiopía',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(67,'Filipinas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(68,'Finlandia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(69,'Fiyi',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(70,'Francia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(71,'Gabón',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(72,'Gambia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(73,'Georgia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(74,'Ghana',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(75,'Gibraltar',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(76,'Granada',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(77,'Grecia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(78,'Groenlandia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(79,'Guadalupe',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(80,'Guam',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(81,'Guatemala',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(82,'Guayana Francesa',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(83,'Guernsey',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(84,'Guinea',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(85,'Guinea Ecuatorial',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(86,'Guinea-Bissau',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(87,'Guyana',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(88,'Haití',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(89,'Honduras',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(90,'Hungría',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(91,'India',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(92,'Indonesia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(93,'Iraq',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(94,'Irlanda',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(95,'Irán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(96,'Isla Bouvet',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(97,'Isla Christmas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(98,'Isla Niue',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(99,'Isla Norfolk',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(100,'Isla de Man',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(101,'Islandia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(102,'Islas Caimán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(103,'Islas Cocos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(104,'Islas Cook',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(105,'Islas Feroe',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(106,'Islas Georgia del Sur y Sandwich del Sur',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(107,'Islas Heard y McDonald',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(108,'Islas Malvinas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(109,'Islas Marianas del Norte',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(110,'Islas Marshall',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(111,'Islas Salomón',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(112,'Islas Turcas y Caicos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(113,'Islas Vírgenes Británicas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(114,'Islas Vírgenes de los Estados Unidos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(115,'Islas menores alejadas de los Estados Unidos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(116,'Islas Åland',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(117,'Israel',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(118,'Italia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(119,'Jamaica',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(120,'Japón',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(121,'Jersey',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(122,'Jordania',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(123,'Kazajistán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(124,'Kenia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(125,'Kirguistán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(126,'Kiribati',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(127,'Kuwait',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(128,'Laos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(129,'Lesoto',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(130,'Letonia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(131,'Liberia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(132,'Libia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(133,'Liechtenstein',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(134,'Lituania',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(135,'Luxemburgo',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(136,'Líbano',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(137,'Macedonia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(138,'Madagascar',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(139,'Malasia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(140,'Malaui',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(141,'Maldivas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(142,'Mali',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(143,'Malta',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(144,'Marruecos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(145,'Martinica',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(146,'Mauricio',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(147,'Mauritania',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(148,'Mayotte',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(149,'Micronesia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(150,'Moldavia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(151,'Mongolia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(152,'Montenegro',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(153,'Montserrat',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(154,'Mozambique',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(155,'Myanmar',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(156,'México',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(157,'Mónaco',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(158,'Namibia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(159,'Nauru',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(160,'Nepal',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(161,'Nicaragua',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(162,'Nigeria',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(163,'Noruega',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(164,'Nueva Caledonia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(165,'Nueva Zelanda',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(166,'Níger',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(167,'Omán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(168,'Pakistán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(169,'Palau',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(170,'Palestina',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(171,'Panamá',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(172,'Papúa Nueva Guinea',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(173,'Paraguay',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(174,'Países Bajos',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(175,'Perú',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(176,'Pitcairn',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(177,'Polinesia Francesa',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(178,'Polonia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(179,'Portugal',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(180,'Puerto Rico',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(181,'Qatar',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(182,'Región Administrativa Especial de Hong Kong de la ',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(183,'Región Administrativa Especial de Macao de la Repú',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(184,'Región desconocida o no válida',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(185,'Reino Unido',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(186,'República Centroafricana',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(187,'República Checa',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(188,'República Democrática del Congo',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(189,'República Dominicana',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(190,'Reunión',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(191,'Ruanda',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(192,'Rumanía',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(193,'Rusia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(194,'Samoa',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(195,'Samoa Americana',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(196,'San Bartolomé',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(197,'San Cristóbal y Nieves',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(198,'San Marino',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(199,'San Martín',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(200,'San Pedro y Miquelón',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(201,'San Vicente y las Granadinas',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(202,'Santa Elena',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(203,'Santa Lucía',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(204,'Santo Tomé y Príncipe',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(205,'Senegal',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(206,'Serbia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(207,'Serbia y Montenegro',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(208,'Seychelles',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(209,'Sierra Leona',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(210,'Singapur',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(211,'Siria',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(212,'Somalia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(213,'Sri Lanka',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(214,'Suazilandia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(215,'Sudáfrica',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(216,'Sudán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(217,'Suecia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(218,'Suiza',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(219,'Surinam',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(220,'Svalbard y Jan Mayen',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(221,'Sáhara Occidental',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(222,'Tailandia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(223,'Taiwán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(224,'Tanzania',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(225,'Tayikistán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(226,'Territorio Británico del Océano Índico',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(227,'Territorios Australes Franceses',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(228,'Timor Oriental',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(229,'Togo',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(230,'Tokelau',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(231,'Tonga',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(232,'Trinidad y Tobago',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(233,'Turkmenistán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(234,'Turquía',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(235,'Tuvalu',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(236,'Túnez',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(237,'Ucrania',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(238,'Uganda',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(239,'Uruguay',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(240,'Uzbekistán',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(241,'Vanuatu',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(242,'Venezuela',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(243,'Vietnam',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(244,'Wallis y Futuna',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(245,'Yemen',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(246,'Yibuti',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(247,'Zambia',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(248,'Zimbabue',NULL,'1','2012-08-30 06:02:59','0000-00-00 00:00:00','1');
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `per_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `per_ced_ruc` varchar(15) DEFAULT NULL,
  `per_nombre` varchar(100) DEFAULT NULL,
  `per_apellido` varchar(100) DEFAULT NULL,
  `per_genero` varchar(1) DEFAULT NULL,
  `per_fecha_nacimiento` date DEFAULT NULL,
  `per_estado_civil` varchar(1) DEFAULT NULL,
  `per_correo` varchar(100) DEFAULT NULL,
  `per_tipo_sangre` varchar(5) DEFAULT NULL,
  `per_foto` varchar(100) DEFAULT NULL,
  `per_estado_activo` varchar(1) NOT NULL,
  `per_est_log` varchar(1) DEFAULT NULL,
  `per_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `per_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`per_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'1310328404','Byron','Villacreses','M','1981-07-19','S','admin@hotmail.com','O+',NULL,'1','1','2016-07-29 05:48:30',NULL),(2,'1310328404','Byron','Villacreses','M','1981-07-19','S','byron_villacresesf@hotmail.com','O+',NULL,'1','1','2016-07-29 05:48:30',NULL),(3,'0102042397','JOSE','MEDICO','M','2016-07-14','C','byron_vilacresesf@hotmail.com','B-',NULL,'1','1','2016-07-29 05:48:30',NULL),(4,'1400302061','DORIS','PACIENTE','F','2016-07-29','S','byron_villacresesf@hotmail.com','O+',NULL,'1','1','2016-07-29 05:48:30',NULL);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincia` (
  `prov_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pai_id` bigint(20) NOT NULL,
  `prov_nombre` varchar(100) DEFAULT NULL,
  `prov_descripcion` varchar(100) DEFAULT NULL,
  `prov_estado_activo` varchar(1) NOT NULL,
  `prov_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prov_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `prov_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`prov_id`),
  KEY `pai_id` (`pai_id`),
  CONSTRAINT `provincia_ibfk_1` FOREIGN KEY (`pai_id`) REFERENCES `pais` (`pai_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES (1,56,'Azuay','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(2,56,'Bolívar','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(3,56,'Cañar','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(4,56,'Carchi','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(5,56,'Chimborazo','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(6,56,'Cotopaxi','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(7,56,'El Oro','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(8,56,'Esmeraldas','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(9,56,'Galápagos','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(10,56,'Guayas','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(11,56,'Imbabura','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(12,56,'Loja','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(13,56,'Los Ríos','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(14,56,'Manabí','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(15,56,'Morona Santiago','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(16,56,'Napo','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(17,56,'Orellana','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(18,56,'Pastaza','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(19,56,'Pichincha','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(20,56,'Santa Elena','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(21,56,'Santo Domingo de los Tsáchilas','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(22,56,'Sucumbíos','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(23,56,'Tungurahua','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(24,56,'Zamora Chinchipe','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1'),(25,56,'Todas','Provincias del Ecuador','1','2012-08-30 06:02:59','0000-00-00 00:00:00','1');
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultados`
--

DROP TABLE IF EXISTS `resultados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultados` (
  `resul_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eve_id` bigint(20) NOT NULL,
  `med_id` bigint(20) NOT NULL,
  `usu_id` bigint(20) DEFAULT NULL,
  `resul_observacion` text,
  `resul_fec_cre` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resul_fec_mod` timestamp NULL DEFAULT NULL,
  `resul_est_log` varchar(1) NOT NULL,
  PRIMARY KEY (`resul_id`),
  KEY `fk_resultados_eventos1` (`eve_id`),
  KEY `fk_resultados_medico1` (`med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultados`
--

LOCK TABLES `resultados` WRITE;
/*!40000 ALTER TABLE `resultados` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `rol_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(50) DEFAULT NULL,
  `rol_descripcion` varchar(45) DEFAULT NULL,
  `rol_estado_activo` varchar(1) NOT NULL,
  `rol_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rol_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `rol_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Administrador','Descripción','1','2012-09-03 20:00:00',NULL,'1'),(2,'Usuario','Descripción','1','2012-09-03 20:00:00',NULL,'1'),(3,'Medico','Descripción','1','2016-08-03 06:02:34',NULL,'1'),(4,'Paciente','Descripción','1','2016-08-03 06:02:34',NULL,'1');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` varchar(40) NOT NULL,
  `expire` bigint(20) DEFAULT NULL,
  `data` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES ('1s6a72a3lusj14g2unrm78s386',1470378361,'__flash|a:0:{}PB_module_id|i:1;PB_objmodule_id|i:1;JSLANG|a:0:{}PB_isuser|b:1;PB_username|s:23:\"byron_villa@hotmail.com\";PB_nombres|s:11:\"JOSE MEDICO\";PB_perid|i:3;PerId|i:3;PB_iduser|i:3;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"3\";__id|i:3;'),('3mgdi72cdecrp4tlf9og82uij1',1471416799,'__flash|a:0:{}PB_module_id|N;PB_objmodule_id|N;JSLANG|a:0:{}PB_isuser|b:1;PB_username|s:23:\"byron_villa@hotmail.com\";PB_nombres|s:11:\"JOSE MEDICO\";PB_perid|i:3;PerId|i:3;PB_iduser|i:3;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"3\";__id|i:3;'),('49tru94lba5d887hs8i4b2lor7',1470292378,'__flash|a:1:{s:18:\"loginFormSubmitted\";i:-1;}PB_module_id|N;PB_objmodule_id|N;JSLANG|a:0:{}loginFormSubmitted|b:1;PB_isuser|b:1;PB_username|s:23:\"byron_villa@hotmail.com\";PB_nombres|s:11:\"JOSE MEDICO\";PB_perid|i:3;PerId|i:3;PB_iduser|i:3;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"3\";__id|i:3;'),('515iemf42i0623gcrua4pgh8p6',1470209037,'__flash|a:0:{}PB_module_id|N;PB_objmodule_id|N;JSLANG|a:0:{}'),('5jvg99q53nli4npb477entctt4',1471327744,'__flash|a:0:{}PB_module_id|i:1;PB_objmodule_id|i:1;JSLANG|a:0:{}PB_isuser|b:1;PB_username|s:23:\"byron_villa@hotmail.com\";PB_nombres|s:11:\"JOSE MEDICO\";PB_perid|i:3;PerId|i:3;PB_iduser|i:3;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"3\";__id|i:3;'),('kinml6n6jrg9d17hl0deg0r2u4',1469776797,'__flash|a:0:{}PB_module_id|i:1;PB_objmodule_id|i:1;JSLANG|a:0:{}PB_isuser|b:1;PB_username|s:5:\"admin\";PB_nombres|s:17:\"Byron Villacreses\";PB_perid|i:1;PerId|i:1;PB_iduser|i:1;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"1\";__id|i:1;'),('qkqnk8qa17m44jjn8251v8jre0',1471324621,'__flash|a:0:{}PB_module_id|N;PB_objmodule_id|N;JSLANG|a:0:{}PB_isuser|b:1;PB_username|s:5:\"admin\";PB_nombres|s:17:\"Byron Villacreses\";PB_perid|i:1;PerId|i:1;PB_iduser|i:1;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"1\";__id|i:1;'),('uooq4u34gikatcm6v6t196s4s2',1471330803,'__flash|a:0:{}PB_module_id|i:1;PB_objmodule_id|i:1;JSLANG|a:0:{}PB_isuser|b:1;PB_username|s:23:\"byron_villa@hotmail.com\";PB_nombres|s:11:\"JOSE MEDICO\";PB_perid|i:3;PerId|i:3;PB_iduser|i:3;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"3\";__id|i:3;'),('v4qn4nd49sqiht7ft3sg4s67u4',1470116302,'__flash|a:0:{}PB_module_id|i:1;PB_objmodule_id|i:1;JSLANG|a:0:{}PB_isuser|b:1;PB_username|s:5:\"admin\";PB_nombres|s:17:\"Byron Villacreses\";PB_perid|i:1;PerId|i:1;PB_iduser|i:1;PB_yii_lang|s:2:\"es\";PB_yii_theme|s:8:\"adminLTE\";PB_client_ip|s:3:\"::1\";RolId|s:1:\"1\";__id|i:1;');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signos_vitales`
--

DROP TABLE IF EXISTS `signos_vitales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signos_vitales` (
  `svit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cmde_id` bigint(20) NOT NULL,
  `svit_peso` decimal(5,2) DEFAULT NULL,
  `svit_talla` decimal(5,2) DEFAULT NULL,
  `svit_temperatura` decimal(5,2) DEFAULT NULL,
  `svit_temperatura_axilar` decimal(5,2) DEFAULT NULL,
  `svit_presion_arteriar` decimal(5,2) DEFAULT NULL,
  `svit_frecuencia_respiratoria` decimal(5,2) DEFAULT NULL,
  `svit_frecuencia_cardiaca` decimal(5,2) DEFAULT NULL,
  `svit_observacion` blob,
  `svit_est_log` varchar(1) DEFAULT NULL,
  `svit_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `svit_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`svit_id`),
  KEY `fk_signos_vitales_cita_medica1` (`cmde_id`),
  CONSTRAINT `fk_signos_vitales_cita_medica1` FOREIGN KEY (`cmde_id`) REFERENCES `cita_medica` (`cmde_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signos_vitales`
--

LOCK TABLES `signos_vitales` WRITE;
/*!40000 ALTER TABLE `signos_vitales` DISABLE KEYS */;
/*!40000 ALTER TABLE `signos_vitales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_consulta`
--

DROP TABLE IF EXISTS `tipo_consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_consulta` (
  `tcon_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tcon_nombre` varchar(50) DEFAULT NULL,
  `tcon_fec_cre` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tcon_fec_mod` timestamp NULL DEFAULT NULL,
  `tcon_est_log` varchar(1) NOT NULL,
  PRIMARY KEY (`tcon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_consulta`
--

LOCK TABLES `tipo_consulta` WRITE;
/*!40000 ALTER TABLE `tipo_consulta` DISABLE KEYS */;
INSERT INTO `tipo_consulta` VALUES (1,'Consulta','2016-03-18 21:29:45',NULL,'1'),(2,'Imagenes','2016-03-18 21:29:45',NULL,'1');
/*!40000 ALTER TABLE `tipo_consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_dicom`
--

DROP TABLE IF EXISTS `tipo_dicom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_dicom` (
  `tdic_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tdic_nomenclatura` varchar(5) DEFAULT NULL,
  `tdic_detalle` varchar(100) DEFAULT NULL,
  `tdic_est_log` varchar(1) DEFAULT NULL,
  `tdic_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tdic_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`tdic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_dicom`
--

LOCK TABLES `tipo_dicom` WRITE;
/*!40000 ALTER TABLE `tipo_dicom` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_dicom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_password`
--

DROP TABLE IF EXISTS `tipo_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_password` (
  `tpas_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpas_tipo` varchar(50) DEFAULT NULL,
  `tpas_validacion` varchar(200) DEFAULT NULL,
  `tpas_descripcion` varchar(300) DEFAULT NULL,
  `tpas_estado_activo` varchar(1) NOT NULL,
  `tpas_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tpas_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `tpas_estado_logico` varchar(1) NOT NULL,
  PRIMARY KEY (`tpas_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_password`
--

LOCK TABLES `tipo_password` WRITE;
/*!40000 ALTER TABLE `tipo_password` DISABLE KEYS */;
INSERT INTO `tipo_password` VALUES (1,'Simples','/^(?=.*[a-z])(?=.*[A-Z]).{VAR,}$/','Las claves simples deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas).','1','2012-08-28 20:00:00','2012-08-28 20:00:00','1'),(2,'Semicomplejas','/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{VAR,}$/','Las claves semicomplejas deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas). ','1','2012-08-29 07:57:58','2012-08-29 07:57:58','1'),(3,'Complejas','/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\\,\\;#¿\\?\\}\\{\\]\\[\\-_¡!\\=&\\^:<>\\.\\+\\*\\/\\$\\(\\)]).{VAR,}$/','Las claves complejas deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas).\nSímbolos: @ ,  ; # ¿ ? }  {  ]  [ - _ ¡  ! = & ^ : < > . + * / ( )','1','2012-08-29 07:57:58','2012-08-29 07:57:58','1');
/*!40000 ALTER TABLE `tipo_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_passreset`
--

DROP TABLE IF EXISTS `user_passreset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_passreset` (
  `upas_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usu_id` bigint(20) NOT NULL,
  `upas_remote_ip_inactivo` varchar(20) DEFAULT NULL,
  `upas_remote_ip_activo` varchar(20) DEFAULT NULL,
  `upas_link` varchar(500) DEFAULT NULL,
  `upas_fecha_inicio` timestamp NULL DEFAULT NULL,
  `upas_fecha_fin` timestamp NULL DEFAULT NULL,
  `upas_estado_activo` varchar(1) DEFAULT NULL,
  `upas_fecha_creacion` timestamp NULL DEFAULT NULL,
  `upas_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `upas_estado_logico` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`upas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_passreset`
--

LOCK TABLES `user_passreset` WRITE;
/*!40000 ALTER TABLE `user_passreset` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_passreset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `usu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `per_id` bigint(20) NOT NULL,
  `usu_username` varchar(45) DEFAULT NULL,
  `usu_password` varchar(255) DEFAULT NULL,
  `usu_sha` varchar(255) DEFAULT NULL,
  `usu_session` varchar(255) DEFAULT NULL,
  `usu_last_login` timestamp NULL DEFAULT NULL,
  `usu_link_activo` text,
  `usu_estado_activo` varchar(1) NOT NULL,
  `usu_alias` varchar(60) DEFAULT NULL,
  `usu_est_log` varchar(1) DEFAULT NULL,
  `usu_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usu_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usu_id`),
  KEY `fk_usuario_persona1` (`per_id`),
  CONSTRAINT `fk_usuario_persona1` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,1,'admin','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-08-16 04:16:43',NULL,'1',NULL,'1','2016-03-10 23:00:00',NULL),(2,2,'byron_villacresesf@hotmail.com','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-08-03 06:23:26','','1',NULL,'1','2016-03-16 08:54:51','2016-03-16 08:54:51'),(3,3,'byron_villa@hotmail.com','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-08-17 01:24:38','','1',NULL,'1','2016-07-22 10:35:30','0000-00-00 00:00:00'),(4,4,'byronvillacreses@gmail.com','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-03-16 14:56:04','http://localhost/rdmi/site/activation?wg=KAhjvkvzHP77i6aO1d7VkvWkfGmYi6e','1',NULL,'1','2016-07-22 10:35:30',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_empresa`
--

DROP TABLE IF EXISTS `usuario_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_empresa` (
  `uemp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usu_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  `uemp_est_log` varchar(1) DEFAULT NULL,
  `uemp_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `uemp_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`uemp_id`),
  KEY `fk_usuario_rol_usuario1` (`usu_id`),
  KEY `fk_usuario_rol_rol1` (`rol_id`),
  KEY `fk_usuario_empresa_empresa1` (`emp_id`),
  CONSTRAINT `fk_usuario_empresa_empresa1` FOREIGN KEY (`emp_id`) REFERENCES `empresa` (`emp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_rol_rol1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_rol_usuario1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_empresa`
--

LOCK TABLES `usuario_empresa` WRITE;
/*!40000 ALTER TABLE `usuario_empresa` DISABLE KEYS */;
INSERT INTO `usuario_empresa` VALUES (1,1,1,1,'1','2016-03-03 07:50:58',NULL),(2,3,3,1,'1','2016-08-03 06:07:30',NULL),(3,4,4,1,'1','2016-08-03 06:07:30',NULL);
/*!40000 ALTER TABLE `usuario_empresa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-17 19:59:00
