-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: inu_calc_envios
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

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
-- Table structure for table `direcciones`
--

DROP TABLE IF EXISTS `direcciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direcciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) unsigned NOT NULL,
  `id_pais` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `id_parroquia` int(11) NOT NULL,
  `calle` varchar(254) NOT NULL,
  `referencia` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_pais` (`id_pais`),
  KEY `id_estado` (`id_estado`),
  KEY `id_municipio` (`id_municipio`),
  KEY `id_parroquia` (`id_parroquia`),
  CONSTRAINT `direcciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `direcciones_ibfk_2` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `direcciones_ibfk_3` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `direcciones_ibfk_4` FOREIGN KEY (`id_municipio`) REFERENCES `municipios` (`id_municipio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `direcciones_ibfk_5` FOREIGN KEY (`id_parroquia`) REFERENCES `parroquias` (`id_parroquia`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direcciones`
--

LOCK TABLES `direcciones` WRITE;
/*!40000 ALTER TABLE `direcciones` DISABLE KEYS */;
INSERT INTO `direcciones` VALUES (18,44,1,24,1,20,'Esq. Guayabal a Sordo','Edif. Amanecer'),(19,45,1,24,1,11,'Esq. Desamparados a Te??idero','Edif. HM'),(20,46,1,20,1,1,'asd','ads'),(21,47,1,11,1,2,'Calle Ekisde','Casa Ekisde'),(22,48,1,24,1,12,'Ekisde','Ekisde'),(23,49,1,24,1,17,'Calle Ekisde','Casa Ekisde'),(24,50,1,24,1,2,'IDK','IDK'),(25,51,1,24,1,11,'Av Urdaneta','IDK'),(26,52,1,19,1,1,'asd','asd'),(27,53,1,24,1,11,'Esq. Desamparados a Te??idero','Edif. HM'),(28,54,1,24,1,1,'IDK','IDK'),(29,55,1,1,1,1,'ekisde','ekisde');
/*!40000 ALTER TABLE `direcciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envios`
--

DROP TABLE IF EXISTS `envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `envios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) unsigned NOT NULL,
  `id_estatus` int(10) unsigned NOT NULL DEFAULT 1,
  `id_transporte` int(10) unsigned NOT NULL,
  `id_origen` int(10) unsigned NOT NULL,
  `id_destino` int(10) unsigned NOT NULL,
  `peso` float NOT NULL,
  `ancho` float NOT NULL,
  `alto` float NOT NULL,
  `largo` float NOT NULL,
  `precio` float NOT NULL,
  `nota_adicional` varchar(254) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_recepcion` date NOT NULL,
  `fecha_entrega` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_estatus` (`id_estatus`),
  KEY `envios_FK_1` (`id_origen`),
  KEY `envios_FK_2` (`id_destino`),
  KEY `envios_FK` (`id_transporte`),
  CONSTRAINT `envios_FK` FOREIGN KEY (`id_transporte`) REFERENCES `transportes` (`id`),
  CONSTRAINT `envios_FK_1` FOREIGN KEY (`id_origen`) REFERENCES `ubicaciones` (`id`),
  CONSTRAINT `envios_FK_2` FOREIGN KEY (`id_destino`) REFERENCES `ubicaciones` (`id`),
  CONSTRAINT `envios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `envios_ibfk_3` FOREIGN KEY (`id_estatus`) REFERENCES `estatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envios`
--

LOCK TABLES `envios` WRITE;
/*!40000 ALTER TABLE `envios` DISABLE KEYS */;
INSERT INTO `envios` VALUES (1,45,1,2,1,3,200,20,20,20,0.468068,'','2022-04-29 01:42:17','2022-04-30',NULL);
/*!40000 ALTER TABLE `envios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(250) NOT NULL,
  `iso_3166-2` varchar(4) NOT NULL,
  `id_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_estado`),
  KEY `fk_pais` (`id_pais`),
  CONSTRAINT `fk_pais` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'Amazonas','VE-X',1),(2,'Anzo??tegui','VE-B',1),(3,'Apure','VE-C',1),(4,'Aragua','VE-D',1),(5,'Barinas','VE-E',1),(6,'Bol??var','VE-F',1),(7,'Carabobo','VE-G',1),(8,'Cojedes','VE-H',1),(9,'Delta Amacuro','VE-Y',1),(10,'Falc??n','VE-I',1),(11,'Gu??rico','VE-J',1),(12,'Lara','VE-K',1),(13,'M??rida','VE-L',1),(14,'Miranda','VE-M',1),(15,'Monagas','VE-N',1),(16,'Nueva Esparta','VE-O',1),(17,'Portuguesa','VE-P',1),(18,'Sucre','VE-R',1),(19,'T??chira','VE-S',1),(20,'Trujillo','VE-T',1),(21,'La Guaira','VE-W',1),(22,'Yaracuy','VE-U',1),(23,'Zulia','VE-V',1),(24,'Distrito Capital','VE-A',1),(25,'Dependencias Federales','VE-Z',1);
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatus`
--

DROP TABLE IF EXISTS `estatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estatus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `estatus` varchar(50) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus`
--

LOCK TABLES `estatus` WRITE;
/*!40000 ALTER TABLE `estatus` DISABLE KEYS */;
INSERT INTO `estatus` VALUES (1,'Pendiente de revisi??n','2022-04-27 18:18:25'),(2,'En espera de transporte','2022-04-27 18:18:26'),(3,'En camino','2022-04-27 18:18:26'),(4,'Entregado','2022-04-27 18:18:26');
/*!40000 ALTER TABLE `estatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipios`
--

DROP TABLE IF EXISTS `municipios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `municipios` (
  `id_municipio` int(11) NOT NULL AUTO_INCREMENT,
  `id_estado` int(11) NOT NULL,
  `municipio` varchar(100) NOT NULL,
  PRIMARY KEY (`id_municipio`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id_estado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipios`
--

LOCK TABLES `municipios` WRITE;
/*!40000 ALTER TABLE `municipios` DISABLE KEYS */;
INSERT INTO `municipios` VALUES (1,1,'Alto Orinoco'),(2,1,'Atabapo'),(3,1,'Atures'),(4,1,'Autana'),(5,1,'Manapiare'),(6,1,'Maroa'),(7,1,'R??o Negro'),(8,2,'Anaco'),(9,2,'Aragua'),(10,2,'Manuel Ezequiel Bruzual'),(11,2,'Diego Bautista Urbaneja'),(12,2,'Fernando Pe??alver'),(13,2,'Francisco Del Carmen Carvajal'),(14,2,'General Sir Arthur McGregor'),(15,2,'Guanta'),(16,2,'Independencia'),(17,2,'Jos?? Gregorio Monagas'),(18,2,'Juan Antonio Sotillo'),(19,2,'Juan Manuel Cajigal'),(20,2,'Libertad'),(21,2,'Francisco de Miranda'),(22,2,'Pedro Mar??a Freites'),(23,2,'P??ritu'),(24,2,'San Jos?? de Guanipa'),(25,2,'San Juan de Capistrano'),(26,2,'Santa Ana'),(27,2,'Sim??n Bol??var'),(28,2,'Sim??n Rodr??guez'),(29,3,'Achaguas'),(30,3,'Biruaca'),(31,3,'Mu????z'),(32,3,'P??ez'),(33,3,'Pedro Camejo'),(34,3,'R??mulo Gallegos'),(35,3,'San Fernando'),(36,4,'Atanasio Girardot'),(37,4,'Bol??var'),(38,4,'Camatagua'),(39,4,'Francisco Linares Alc??ntara'),(40,4,'Jos?? ??ngel Lamas'),(41,4,'Jos?? F??lix Ribas'),(42,4,'Jos?? Rafael Revenga'),(43,4,'Libertador'),(44,4,'Mario Brice??o Iragorry'),(45,4,'Ocumare de la Costa de Oro'),(46,4,'San Casimiro'),(47,4,'San Sebasti??n'),(48,4,'Santiago Mari??o'),(49,4,'Santos Michelena'),(50,4,'Sucre'),(51,4,'Tovar'),(52,4,'Urdaneta'),(53,4,'Zamora'),(54,5,'Alberto Arvelo Torrealba'),(55,5,'Andr??s Eloy Blanco'),(56,5,'Antonio Jos?? de Sucre'),(57,5,'Arismendi'),(58,5,'Barinas'),(59,5,'Bol??var'),(60,5,'Cruz Paredes'),(61,5,'Ezequiel Zamora'),(62,5,'Obispos'),(63,5,'Pedraza'),(64,5,'Rojas'),(65,5,'Sosa'),(66,6,'Caron??'),(67,6,'Cede??o'),(68,6,'El Callao'),(69,6,'Gran Sabana'),(70,6,'Heres'),(71,6,'Piar'),(72,6,'Angostura (Ra??l Leoni)'),(73,6,'Roscio'),(74,6,'Sifontes'),(75,6,'Sucre'),(76,6,'Padre Pedro Chien'),(77,7,'Bejuma'),(78,7,'Carlos Arvelo'),(79,7,'Diego Ibarra'),(80,7,'Guacara'),(81,7,'Juan Jos?? Mora'),(82,7,'Libertador'),(83,7,'Los Guayos'),(84,7,'Miranda'),(85,7,'Montalb??n'),(86,7,'Naguanagua'),(87,7,'Puerto Cabello'),(88,7,'San Diego'),(89,7,'San Joaqu??n'),(90,7,'Valencia'),(91,8,'Anzo??tegui'),(92,8,'Tinaquillo'),(93,8,'Girardot'),(94,8,'Lima Blanco'),(95,8,'Pao de San Juan Bautista'),(96,8,'Ricaurte'),(97,8,'R??mulo Gallegos'),(98,8,'San Carlos'),(99,8,'Tinaco'),(100,9,'Antonio D??az'),(101,9,'Casacoima'),(102,9,'Pedernales'),(103,9,'Tucupita'),(104,10,'Acosta'),(105,10,'Bol??var'),(106,10,'Buchivacoa'),(107,10,'Cacique Manaure'),(108,10,'Carirubana'),(109,10,'Colina'),(110,10,'Dabajuro'),(111,10,'Democracia'),(112,10,'Falc??n'),(113,10,'Federaci??n'),(114,10,'Jacura'),(115,10,'Jos?? Laurencio Silva'),(116,10,'Los Taques'),(117,10,'Mauroa'),(118,10,'Miranda'),(119,10,'Monse??or Iturriza'),(120,10,'Palmasola'),(121,10,'Petit'),(122,10,'P??ritu'),(123,10,'San Francisco'),(124,10,'Sucre'),(125,10,'Toc??pero'),(126,10,'Uni??n'),(127,10,'Urumaco'),(128,10,'Zamora'),(129,11,'Camagu??n'),(130,11,'Chaguaramas'),(131,11,'El Socorro'),(132,11,'Jos?? F??lix Ribas'),(133,11,'Jos?? Tadeo Monagas'),(134,11,'Juan Germ??n Roscio'),(135,11,'Juli??n Mellado'),(136,11,'Las Mercedes'),(137,11,'Leonardo Infante'),(138,11,'Pedro Zaraza'),(139,11,'Ort??z'),(140,11,'San Ger??nimo de Guayabal'),(141,11,'San Jos?? de Guaribe'),(142,11,'Santa Mar??a de Ipire'),(143,11,'Sebasti??n Francisco de Miranda'),(144,12,'Andr??s Eloy Blanco'),(145,12,'Crespo'),(146,12,'Iribarren'),(147,12,'Jim??nez'),(148,12,'Mor??n'),(149,12,'Palavecino'),(150,12,'Sim??n Planas'),(151,12,'Torres'),(152,12,'Urdaneta'),(179,13,'Alberto Adriani'),(180,13,'Andr??s Bello'),(181,13,'Antonio Pinto Salinas'),(182,13,'Aricagua'),(183,13,'Arzobispo Chac??n'),(184,13,'Campo El??as'),(185,13,'Caracciolo Parra Olmedo'),(186,13,'Cardenal Quintero'),(187,13,'Guaraque'),(188,13,'Julio C??sar Salas'),(189,13,'Justo Brice??o'),(190,13,'Libertador'),(191,13,'Miranda'),(192,13,'Obispo Ramos de Lora'),(193,13,'Padre Noguera'),(194,13,'Pueblo Llano'),(195,13,'Rangel'),(196,13,'Rivas D??vila'),(197,13,'Santos Marquina'),(198,13,'Sucre'),(199,13,'Tovar'),(200,13,'Tulio Febres Cordero'),(201,13,'Zea'),(223,14,'Acevedo'),(224,14,'Andr??s Bello'),(225,14,'Baruta'),(226,14,'Bri??n'),(227,14,'Buroz'),(228,14,'Carrizal'),(229,14,'Chacao'),(230,14,'Crist??bal Rojas'),(231,14,'El Hatillo'),(232,14,'Guaicaipuro'),(233,14,'Independencia'),(234,14,'Lander'),(235,14,'Los Salias'),(236,14,'P??ez'),(237,14,'Paz Castillo'),(238,14,'Pedro Gual'),(239,14,'Plaza'),(240,14,'Sim??n Bol??var'),(241,14,'Sucre'),(242,14,'Urdaneta'),(243,14,'Zamora'),(258,15,'Acosta'),(259,15,'Aguasay'),(260,15,'Bol??var'),(261,15,'Caripe'),(262,15,'Cede??o'),(263,15,'Ezequiel Zamora'),(264,15,'Libertador'),(265,15,'Matur??n'),(266,15,'Piar'),(267,15,'Punceres'),(268,15,'Santa B??rbara'),(269,15,'Sotillo'),(270,15,'Uracoa'),(271,16,'Antol??n del Campo'),(272,16,'Arismendi'),(273,16,'Garc??a'),(274,16,'G??mez'),(275,16,'Maneiro'),(276,16,'Marcano'),(277,16,'Mari??o'),(278,16,'Pen??nsula de Macanao'),(279,16,'Tubores'),(280,16,'Villalba'),(281,16,'D??az'),(282,17,'Agua Blanca'),(283,17,'Araure'),(284,17,'Esteller'),(285,17,'Guanare'),(286,17,'Guanarito'),(287,17,'Monse??or Jos?? Vicente de Unda'),(288,17,'Ospino'),(289,17,'P??ez'),(290,17,'Papel??n'),(291,17,'San Genaro de Bocono??to'),(292,17,'San Rafael de Onoto'),(293,17,'Santa Rosal??a'),(294,17,'Sucre'),(295,17,'Tur??n'),(296,18,'Andr??s Eloy Blanco'),(297,18,'Andr??s Mata'),(298,18,'Arismendi'),(299,18,'Ben??tez'),(300,18,'Berm??dez'),(301,18,'Bol??var'),(302,18,'Cajigal'),(303,18,'Cruz Salmer??n Acosta'),(304,18,'Libertador'),(305,18,'Mari??o'),(306,18,'Mej??a'),(307,18,'Montes'),(308,18,'Ribero'),(309,18,'Sucre'),(310,18,'Vald??z'),(341,19,'Andr??s Bello'),(342,19,'Antonio R??mulo Costa'),(343,19,'Ayacucho'),(344,19,'Bol??var'),(345,19,'C??rdenas'),(346,19,'C??rdoba'),(347,19,'Fern??ndez Feo'),(348,19,'Francisco de Miranda'),(349,19,'Garc??a de Hevia'),(350,19,'Gu??simos'),(351,19,'Independencia'),(352,19,'J??uregui'),(353,19,'Jos?? Mar??a Vargas'),(354,19,'Jun??n'),(355,19,'Libertad'),(356,19,'Libertador'),(357,19,'Lobatera'),(358,19,'Michelena'),(359,19,'Panamericano'),(360,19,'Pedro Mar??a Ure??a'),(361,19,'Rafael Urdaneta'),(362,19,'Samuel Dar??o Maldonado'),(363,19,'San Crist??bal'),(364,19,'Seboruco'),(365,19,'Sim??n Rodr??guez'),(366,19,'Sucre'),(367,19,'Torbes'),(368,19,'Uribante'),(369,19,'San Judas Tadeo'),(370,20,'Andr??s Bello'),(371,20,'Bocon??'),(372,20,'Bol??var'),(373,20,'Candelaria'),(374,20,'Carache'),(375,20,'Escuque'),(376,20,'Jos?? Felipe M??rquez Ca??izalez'),(377,20,'Juan Vicente Campos El??as'),(378,20,'La Ceiba'),(379,20,'Miranda'),(380,20,'Monte Carmelo'),(381,20,'Motat??n'),(382,20,'Pamp??n'),(383,20,'Pampanito'),(384,20,'Rafael Rangel'),(385,20,'San Rafael de Carvajal'),(386,20,'Sucre'),(387,20,'Trujillo'),(388,20,'Urdaneta'),(389,20,'Valera'),(390,21,'Vargas'),(391,22,'Ar??stides Bastidas'),(392,22,'Bol??var'),(407,22,'Bruzual'),(408,22,'Cocorote'),(409,22,'Independencia'),(410,22,'Jos?? Antonio P??ez'),(411,22,'La Trinidad'),(412,22,'Manuel Monge'),(413,22,'Nirgua'),(414,22,'Pe??a'),(415,22,'San Felipe'),(416,22,'Sucre'),(417,22,'Urachiche'),(418,22,'Jos?? Joaqu??n Veroes'),(441,23,'Almirante Padilla'),(442,23,'Baralt'),(443,23,'Cabimas'),(444,23,'Catatumbo'),(445,23,'Col??n'),(446,23,'Francisco Javier Pulgar'),(447,23,'P??ez'),(448,23,'Jes??s Enrique Losada'),(449,23,'Jes??s Mar??a Sempr??n'),(450,23,'La Ca??ada de Urdaneta'),(451,23,'Lagunillas'),(452,23,'Machiques de Perij??'),(453,23,'Mara'),(454,23,'Maracaibo'),(455,23,'Miranda'),(456,23,'Rosario de Perij??'),(457,23,'San Francisco'),(458,23,'Santa Rita'),(459,23,'Sim??n Bol??var'),(460,23,'Sucre'),(461,23,'Valmore Rodr??guez'),(462,24,'Libertador');
/*!40000 ALTER TABLE `municipios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(250) NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` VALUES (1,'Venezuela');
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parroquias`
--

DROP TABLE IF EXISTS `parroquias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parroquias` (
  `id_parroquia` int(11) NOT NULL AUTO_INCREMENT,
  `id_municipio` int(11) NOT NULL,
  `parroquia` varchar(250) NOT NULL,
  PRIMARY KEY (`id_parroquia`),
  KEY `id_municipio` (`id_municipio`),
  CONSTRAINT `parroquias_ibfk_1` FOREIGN KEY (`id_municipio`) REFERENCES `municipios` (`id_municipio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1139 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parroquias`
--

LOCK TABLES `parroquias` WRITE;
/*!40000 ALTER TABLE `parroquias` DISABLE KEYS */;
INSERT INTO `parroquias` VALUES (1,1,'Alto Orinoco'),(2,1,'Huachamacare Acana??a'),(3,1,'Marawaka Toky Shamana??a'),(4,1,'Mavaka Mavaka'),(5,1,'Sierra Parima Parimab??'),(6,2,'Ucata Laja Lisa'),(7,2,'Yapacana Macuruco'),(8,2,'Caname Guarinuma'),(9,3,'Fernando Gir??n Tovar'),(10,3,'Luis Alberto G??mez'),(11,3,'Pahue??a Lim??n de Parhue??a'),(12,3,'Platanillal Platanillal'),(13,4,'Samariapo'),(14,4,'Sipapo'),(15,4,'Munduapo'),(16,4,'Guayapo'),(17,5,'Alto Ventuari'),(18,5,'Medio Ventuari'),(19,5,'Bajo Ventuari'),(20,6,'Victorino'),(21,6,'Comunidad'),(22,7,'Casiquiare'),(23,7,'Cocuy'),(24,7,'San Carlos de R??o Negro'),(25,7,'Solano'),(26,8,'Anaco'),(27,8,'San Joaqu??n'),(28,9,'Cachipo'),(29,9,'Aragua de Barcelona'),(30,11,'Lecher??a'),(31,11,'El Morro'),(32,12,'Puerto P??ritu'),(33,12,'San Miguel'),(34,12,'Sucre'),(35,13,'Valle de Guanape'),(36,13,'Santa B??rbara'),(37,14,'El Chaparro'),(38,14,'Tom??s Alfaro'),(39,14,'Calatrava'),(40,15,'Guanta'),(41,15,'Chorrer??n'),(42,16,'Mamo'),(43,16,'Soledad'),(44,17,'Mapire'),(45,17,'Piar'),(46,17,'Santa Clara'),(47,17,'San Diego de Cabrutica'),(48,17,'Uverito'),(49,17,'Zuata'),(50,18,'Puerto La Cruz'),(51,18,'Pozuelos'),(52,19,'Onoto'),(53,19,'San Pablo'),(54,20,'San Mateo'),(55,20,'El Carito'),(56,20,'Santa In??s'),(57,20,'La Romere??a'),(58,21,'Atapirire'),(59,21,'Boca del Pao'),(60,21,'El Pao'),(61,21,'Pariagu??n'),(62,22,'Cantaura'),(63,22,'Libertador'),(64,22,'Santa Rosa'),(65,22,'Urica'),(66,23,'P??ritu'),(67,23,'San Francisco'),(68,24,'San Jos?? de Guanipa'),(69,25,'Boca de Uchire'),(70,25,'Boca de Ch??vez'),(71,26,'Pueblo Nuevo'),(72,26,'Santa Ana'),(73,27,'Bergant??n'),(74,27,'Caigua'),(75,27,'El Carmen'),(76,27,'El Pilar'),(77,27,'Naricual'),(78,27,'San Crsit??bal'),(79,28,'Edmundo Barrios'),(80,28,'Miguel Otero Silva'),(81,29,'Achaguas'),(82,29,'Apurito'),(83,29,'El Yagual'),(84,29,'Guachara'),(85,29,'Mucuritas'),(86,29,'Queseras del medio'),(87,30,'Biruaca'),(88,31,'Bruzual'),(89,31,'Mantecal'),(90,31,'Quintero'),(91,31,'Rinc??n Hondo'),(92,31,'San Vicente'),(93,32,'Guasdualito'),(94,32,'Aramendi'),(95,32,'El Amparo'),(96,32,'San Camilo'),(97,32,'Urdaneta'),(98,33,'San Juan de Payara'),(99,33,'Codazzi'),(100,33,'Cunaviche'),(101,34,'Elorza'),(102,34,'La Trinidad'),(103,35,'San Fernando'),(104,35,'El Recreo'),(105,35,'Pe??alver'),(106,35,'San Rafael de Atamaica'),(107,36,'Pedro Jos?? Ovalles'),(108,36,'Joaqu??n Crespo'),(109,36,'Jos?? Casanova Godoy'),(110,36,'Madre Mar??a de San Jos??'),(111,36,'Andr??s Eloy Blanco'),(112,36,'Los Tacarigua'),(113,36,'Las Delicias'),(114,36,'Choron??'),(115,37,'Bol??var'),(116,38,'Camatagua'),(117,38,'Carmen de Cura'),(118,39,'Santa Rita'),(119,39,'Francisco de Miranda'),(120,39,'Mose??or Feliciano Gonz??lez'),(121,40,'Santa Cruz'),(122,41,'Jos?? F??lix Ribas'),(123,41,'Castor Nieves R??os'),(124,41,'Las Guacamayas'),(125,41,'Pao de Z??rate'),(126,41,'Zuata'),(127,42,'Jos?? Rafael Revenga'),(128,43,'Palo Negro'),(129,43,'San Mart??n de Porres'),(130,44,'El Lim??n'),(131,44,'Ca??a de Az??car'),(132,45,'Ocumare de la Costa'),(133,46,'San Casimiro'),(134,46,'G??iripa'),(135,46,'Ollas de Caramacate'),(136,46,'Valle Mor??n'),(137,47,'San Sebast??an'),(138,48,'Turmero'),(139,48,'Arevalo Aponte'),(140,48,'Chuao'),(141,48,'Sam??n de G??ere'),(142,48,'Alfredo Pacheco Miranda'),(143,49,'Santos Michelena'),(144,49,'Tiara'),(145,50,'Cagua'),(146,50,'Bella Vista'),(147,51,'Tovar'),(148,52,'Urdaneta'),(149,52,'Las Pe??itas'),(150,52,'San Francisco de Cara'),(151,52,'Taguay'),(152,53,'Zamora'),(153,53,'Magdaleno'),(154,53,'San Francisco de As??s'),(155,53,'Valles de Tucutunemo'),(156,53,'Augusto Mijares'),(157,54,'Sabaneta'),(158,54,'Juan Antonio Rodr??guez Dom??nguez'),(159,55,'El Cant??n'),(160,55,'Santa Cruz de Guacas'),(161,55,'Puerto Vivas'),(162,56,'Ticoporo'),(163,56,'Nicol??s Pulido'),(164,56,'Andr??s Bello'),(165,57,'Arismendi'),(166,57,'Guadarrama'),(167,57,'La Uni??n'),(168,57,'San Antonio'),(169,58,'Barinas'),(170,58,'Alberto Arvelo Larriva'),(171,58,'San Silvestre'),(172,58,'Santa In??s'),(173,58,'Santa Luc??a'),(174,58,'Torumos'),(175,58,'El Carmen'),(176,58,'R??mulo Betancourt'),(177,58,'Coraz??n de Jes??s'),(178,58,'Ram??n Ignacio M??ndez'),(179,58,'Alto Barinas'),(180,58,'Manuel Palacio Fajardo'),(181,58,'Juan Antonio Rodr??guez Dom??nguez'),(182,58,'Dominga Ortiz de P??ez'),(183,59,'Barinitas'),(184,59,'Altamira de C??ceres'),(185,59,'Calderas'),(186,60,'Barrancas'),(187,60,'El Socorro'),(188,60,'Mazparrito'),(189,61,'Santa B??rbara'),(190,61,'Pedro Brice??o M??ndez'),(191,61,'Ram??n Ignacio M??ndez'),(192,61,'Jos?? Ignacio del Pumar'),(193,62,'Obispos'),(194,62,'Guasimitos'),(195,62,'El Real'),(196,62,'La Luz'),(197,63,'Ciudad Bol??via'),(198,63,'Jos?? Ignacio Brice??o'),(199,63,'Jos?? F??lix Ribas'),(200,63,'P??ez'),(201,64,'Libertad'),(202,64,'Dolores'),(203,64,'Santa Rosa'),(204,64,'Palacio Fajardo'),(205,65,'Ciudad de Nutrias'),(206,65,'El Regalo'),(207,65,'Puerto Nutrias'),(208,65,'Santa Catalina'),(209,66,'Cachamay'),(210,66,'Chirica'),(211,66,'Dalla Costa'),(212,66,'Once de Abril'),(213,66,'Sim??n Bol??var'),(214,66,'Unare'),(215,66,'Universidad'),(216,66,'Vista al Sol'),(217,66,'Pozo Verde'),(218,66,'Yocoima'),(219,66,'5 de Julio'),(220,67,'Cede??o'),(221,67,'Altagracia'),(222,67,'Ascensi??n Farreras'),(223,67,'Guaniamo'),(224,67,'La Urbana'),(225,67,'Pijiguaos'),(226,68,'El Callao'),(227,69,'Gran Sabana'),(228,69,'Ikabar??'),(229,70,'Catedral'),(230,70,'Zea'),(231,70,'Orinoco'),(232,70,'Jos?? Antonio P??ez'),(233,70,'Marhuanta'),(234,70,'Agua Salada'),(235,70,'Vista Hermosa'),(236,70,'La Sabanita'),(237,70,'Panapana'),(238,71,'Andr??s Eloy Blanco'),(239,71,'Pedro Cova'),(240,72,'Ra??l Leoni'),(241,72,'Barceloneta'),(242,72,'Santa B??rbara'),(243,72,'San Francisco'),(244,73,'Roscio'),(245,73,'Sal??m'),(246,74,'Sifontes'),(247,74,'Dalla Costa'),(248,74,'San Isidro'),(249,75,'Sucre'),(250,75,'Aripao'),(251,75,'Guarataro'),(252,75,'Las Majadas'),(253,75,'Moitaco'),(254,76,'Padre Pedro Chien'),(255,76,'R??o Grande'),(256,77,'Bejuma'),(257,77,'Canoabo'),(258,77,'Sim??n Bol??var'),(259,78,'G??ig??e'),(260,78,'Carabobo'),(261,78,'Tacarigua'),(262,79,'Mariara'),(263,79,'Aguas Calientes'),(264,80,'Ciudad Alianza'),(265,80,'Guacara'),(266,80,'Yagua'),(267,81,'Mor??n'),(268,81,'Yagua'),(269,82,'Tocuyito'),(270,82,'Independencia'),(271,83,'Los Guayos'),(272,84,'Miranda'),(273,85,'Montalb??n'),(274,86,'Naguanagua'),(275,87,'Bartolom?? Sal??m'),(276,87,'Democracia'),(277,87,'Fraternidad'),(278,87,'Goaigoaza'),(279,87,'Juan Jos?? Flores'),(280,87,'Uni??n'),(281,87,'Borburata'),(282,87,'Patanemo'),(283,88,'San Diego'),(284,89,'San Joaqu??n'),(285,90,'Candelaria'),(286,90,'Catedral'),(287,90,'El Socorro'),(288,90,'Miguel Pe??a'),(289,90,'Rafael Urdaneta'),(290,90,'San Blas'),(291,90,'San Jos??'),(292,90,'Santa Rosa'),(293,90,'Negro Primero'),(294,91,'Cojedes'),(295,91,'Juan de Mata Su??rez'),(296,92,'Tinaquillo'),(297,93,'El Ba??l'),(298,93,'Sucre'),(299,94,'La Aguadita'),(300,94,'Macapo'),(301,95,'El Pao'),(302,96,'El Amparo'),(303,96,'Libertad de Cojedes'),(304,97,'R??mulo Gallegos'),(305,98,'San Carlos de Austria'),(306,98,'Juan ??ngel Bravo'),(307,98,'Manuel Manrique'),(308,99,'General en Jefe Jos?? Laurencio Silva'),(309,100,'Curiapo'),(310,100,'Almirante Luis Bri??n'),(311,100,'Francisco Aniceto Lugo'),(312,100,'Manuel Renaud'),(313,100,'Padre Barral'),(314,100,'Santos de Abelgas'),(315,101,'Imataca'),(316,101,'Cinco de Julio'),(317,101,'Juan Bautista Arismendi'),(318,101,'Manuel Piar'),(319,101,'R??mulo Gallegos'),(320,102,'Pedernales'),(321,102,'Luis Beltr??n Prieto Figueroa'),(322,103,'San Jos?? (Delta Amacuro)'),(323,103,'Jos?? Vidal Marcano'),(324,103,'Juan Mill??n'),(325,103,'Leonardo Ru??z Pineda'),(326,103,'Mariscal Antonio Jos?? de Sucre'),(327,103,'Monse??or Argimiro Garc??a'),(328,103,'San Rafael (Delta Amacuro)'),(329,103,'Virgen del Valle'),(330,10,'Clarines'),(331,10,'Guanape'),(332,10,'Sabana de Uchire'),(333,104,'Capadare'),(334,104,'La Pastora'),(335,104,'Libertador'),(336,104,'San Juan de los Cayos'),(337,105,'Aracua'),(338,105,'La Pe??a'),(339,105,'San Luis'),(340,106,'Bariro'),(341,106,'Boroj??'),(342,106,'Capat??rida'),(343,106,'Guajiro'),(344,106,'Seque'),(345,106,'Zaz??rida'),(346,106,'Valle de Eroa'),(347,107,'Cacique Manaure'),(348,108,'Norte'),(349,108,'Carirubana'),(350,108,'Santa Ana'),(351,108,'Urbana Punta Card??n'),(352,109,'La Vela de Coro'),(353,109,'Acurigua'),(354,109,'Guaibacoa'),(355,109,'Las Calderas'),(356,109,'Macoruca'),(357,110,'Dabajuro'),(358,111,'Agua Clara'),(359,111,'Avaria'),(360,111,'Pedregal'),(361,111,'Piedra Grande'),(362,111,'Purureche'),(363,112,'Adaure'),(364,112,'Ad??cora'),(365,112,'Baraived'),(366,112,'Buena Vista'),(367,112,'Jadacaquiva'),(368,112,'El V??nculo'),(369,112,'El Hato'),(370,112,'Moruy'),(371,112,'Pueblo Nuevo'),(372,113,'Agua Larga'),(373,113,'El Pauj??'),(374,113,'Independencia'),(375,113,'Maparar??'),(376,114,'Agua Linda'),(377,114,'Araurima'),(378,114,'Jacura'),(379,115,'Tucacas'),(380,115,'Boca de Aroa'),(381,116,'Los Taques'),(382,116,'Judibana'),(383,117,'Mene de Mauroa'),(384,117,'San F??lix'),(385,117,'Casigua'),(386,118,'Guzm??n Guillermo'),(387,118,'Mitare'),(388,118,'R??o Seco'),(389,118,'Sabaneta'),(390,118,'San Antonio'),(391,118,'San Gabriel'),(392,118,'Santa Ana'),(393,119,'Boca del Tocuyo'),(394,119,'Chichiriviche'),(395,119,'Tocuyo de la Costa'),(396,120,'Palmasola'),(397,121,'Cabure'),(398,121,'Colina'),(399,121,'Curimagua'),(400,122,'San Jos?? de la Costa'),(401,122,'P??ritu'),(402,123,'San Francisco'),(403,124,'Sucre'),(404,124,'Pecaya'),(405,125,'Toc??pero'),(406,126,'El Charal'),(407,126,'Las Vegas del Tuy'),(408,126,'Santa Cruz de Bucaral'),(409,127,'Bruzual'),(410,127,'Urumaco'),(411,128,'Puerto Cumarebo'),(412,128,'La Ci??naga'),(413,128,'La Soledad'),(414,128,'Pueblo Cumarebo'),(415,128,'Zaz??rida'),(416,113,'Churuguara'),(417,129,'Camagu??n'),(418,129,'Puerto Miranda'),(419,129,'Uverito'),(420,130,'Chaguaramas'),(421,131,'El Socorro'),(422,132,'Tucupido'),(423,132,'San Rafael de Laya'),(424,133,'Altagracia de Orituco'),(425,133,'San Rafael de Orituco'),(426,133,'San Francisco Javier de Lezama'),(427,133,'Paso Real de Macaira'),(428,133,'Carlos Soublette'),(429,133,'San Francisco de Macaira'),(430,133,'Libertad de Orituco'),(431,134,'Cantaclaro'),(432,134,'San Juan de los Morros'),(433,134,'Parapara'),(434,135,'El Sombrero'),(435,135,'Sosa'),(436,136,'Las Mercedes'),(437,136,'Cabruta'),(438,136,'Santa Rita de Manapire'),(439,137,'Valle de la Pascua'),(440,137,'Espino'),(441,138,'San Jos?? de Unare'),(442,138,'Zaraza'),(443,139,'San Jos?? de Tiznados'),(444,139,'San Francisco de Tiznados'),(445,139,'San Lorenzo de Tiznados'),(446,139,'Ortiz'),(447,140,'Guayabal'),(448,140,'Cazorla'),(449,141,'San Jos?? de Guaribe'),(450,141,'Uveral'),(451,142,'Santa Mar??a de Ipire'),(452,142,'Altamira'),(453,143,'El Calvario'),(454,143,'El Rastro'),(455,143,'Guardatinajas'),(456,143,'Capital Urbana Calabozo'),(457,144,'Quebrada Honda de Guache'),(458,144,'P??o Tamayo'),(459,144,'Yacamb??'),(460,145,'Fr??itez'),(461,145,'Jos?? Mar??a Blanco'),(462,146,'Catedral'),(463,146,'Concepci??n'),(464,146,'El Cuj??'),(465,146,'Juan de Villegas'),(466,146,'Santa Rosa'),(467,146,'Tamaca'),(468,146,'Uni??n'),(469,146,'Aguedo Felipe Alvarado'),(470,146,'Buena Vista'),(471,146,'Ju??rez'),(472,147,'Juan Bautista Rodr??guez'),(473,147,'Cuara'),(474,147,'Diego de Lozada'),(475,147,'Para??so de San Jos??'),(476,147,'San Miguel'),(477,147,'Tintorero'),(478,147,'Jos?? Bernardo Dorante'),(479,147,'Coronel Mariano Peraza '),(480,148,'Bol??var'),(481,148,'Anzo??tegui'),(482,148,'Guarico'),(483,148,'Hilario Luna y Luna'),(484,148,'Humocaro Alto'),(485,148,'Humocaro Bajo'),(486,148,'La Candelaria'),(487,148,'Mor??n'),(488,149,'Cabudare'),(489,149,'Jos?? Gregorio Bastidas'),(490,149,'Agua Viva'),(491,150,'Sarare'),(492,150,'Bur??a'),(493,150,'Gustavo Vegas Le??n'),(494,151,'Trinidad Samuel'),(495,151,'Antonio D??az'),(496,151,'Camacaro'),(497,151,'Casta??eda'),(498,151,'Cecilio Zubillaga'),(499,151,'Chiquinquir??'),(500,151,'El Blanco'),(501,151,'Espinoza de los Monteros'),(502,151,'Lara'),(503,151,'Las Mercedes'),(504,151,'Manuel Morillo'),(505,151,'Monta??a Verde'),(506,151,'Montes de Oca'),(507,151,'Torres'),(508,151,'Heriberto Arroyo'),(509,151,'Reyes Vargas'),(510,151,'Altagracia'),(511,152,'Siquisique'),(512,152,'Moroturo'),(513,152,'San Miguel'),(514,152,'Xaguas'),(515,179,'Presidente Betancourt'),(516,179,'Presidente P??ez'),(517,179,'Presidente R??mulo Gallegos'),(518,179,'Gabriel Pic??n Gonz??lez'),(519,179,'H??ctor Amable Mora'),(520,179,'Jos?? Nucete Sardi'),(521,179,'Pulido M??ndez'),(522,180,'La Azulita'),(523,181,'Santa Cruz de Mora'),(524,181,'Mesa Bol??var'),(525,181,'Mesa de Las Palmas'),(526,182,'Aricagua'),(527,182,'San Antonio'),(528,183,'Canagua'),(529,183,'Capur??'),(530,183,'Chacant??'),(531,183,'El Molino'),(532,183,'Guaimaral'),(533,183,'Mucutuy'),(534,183,'Mucuchach??'),(535,184,'Fern??ndez Pe??a'),(536,184,'Matriz'),(537,184,'Montalb??n'),(538,184,'Acequias'),(539,184,'Jaj??'),(540,184,'La Mesa'),(541,184,'San Jos?? del Sur'),(542,185,'Tucan??'),(543,185,'Florencio Ram??rez'),(544,186,'Santo Domingo'),(545,186,'Las Piedras'),(546,187,'Guaraque'),(547,187,'Mesa de Quintero'),(548,187,'R??o Negro'),(549,188,'Arapuey'),(550,188,'Palmira'),(551,189,'San Crist??bal de Torondoy'),(552,189,'Torondoy'),(553,190,'Antonio Spinetti Dini'),(554,190,'Arias'),(555,190,'Caracciolo Parra P??rez'),(556,190,'Domingo Pe??a'),(557,190,'El Llano'),(558,190,'Gonzalo Pic??n Febres'),(559,190,'Jacinto Plaza'),(560,190,'Juan Rodr??guez Su??rez'),(561,190,'Lasso de la Vega'),(562,190,'Mariano Pic??n Salas'),(563,190,'Milla'),(564,190,'Osuna Rodr??guez'),(565,190,'Sagrario'),(566,190,'El Morro'),(567,190,'Los Nevados'),(568,191,'Andr??s Eloy Blanco'),(569,191,'La Venta'),(570,191,'Pi??ango'),(571,191,'Timotes'),(572,192,'Eloy Paredes'),(573,192,'San Rafael de Alc??zar'),(574,192,'Santa Elena de Arenales'),(575,193,'Santa Mar??a de Caparo'),(576,194,'Pueblo Llano'),(577,195,'Cacute'),(578,195,'La Toma'),(579,195,'Mucuch??es'),(580,195,'Mucurub??'),(581,195,'San Rafael'),(582,196,'Ger??nimo Maldonado'),(583,196,'Bailadores'),(584,197,'Tabay'),(585,198,'Chiguar??'),(586,198,'Est??nquez'),(587,198,'Lagunillas'),(588,198,'La Trampa'),(589,198,'Pueblo Nuevo del Sur'),(590,198,'San Juan'),(591,199,'El Amparo'),(592,199,'El Llano'),(593,199,'San Francisco'),(594,199,'Tovar'),(595,200,'Independencia'),(596,200,'Mar??a de la Concepci??n Palacios Blanco'),(597,200,'Nueva Bolivia'),(598,200,'Santa Apolonia'),(599,201,'Ca??o El Tigre'),(600,201,'Zea'),(601,223,'Arag??ita'),(602,223,'Ar??valo Gonz??lez'),(603,223,'Capaya'),(604,223,'Caucagua'),(605,223,'Panaquire'),(606,223,'Ribas'),(607,223,'El Caf??'),(608,223,'Marizapa'),(609,224,'Cumbo'),(610,224,'San Jos?? de Barlovento'),(611,225,'El Cafetal'),(612,225,'Las Minas'),(613,225,'Nuestra Se??ora del Rosario'),(614,226,'Higuerote'),(615,226,'Curiepe'),(616,226,'Tacarigua de Bri??n'),(617,227,'Mamporal'),(618,228,'Carrizal'),(619,229,'Chacao'),(620,230,'Charallave'),(621,230,'Las Brisas'),(622,231,'El Hatillo'),(623,232,'Altagracia de la Monta??a'),(624,232,'Cecilio Acosta'),(625,232,'Los Teques'),(626,232,'El Jarillo'),(627,232,'San Pedro'),(628,232,'T??cata'),(629,232,'Paracotos'),(630,233,'Cartanal'),(631,233,'Santa Teresa del Tuy'),(632,234,'La Democracia'),(633,234,'Ocumare del Tuy'),(634,234,'Santa B??rbara'),(635,235,'San Antonio de los Altos'),(636,236,'R??o Chico'),(637,236,'El Guapo'),(638,236,'Tacarigua de la Laguna'),(639,236,'Paparo'),(640,236,'San Fernando del Guapo'),(641,237,'Santa Luc??a del Tuy'),(642,238,'C??pira'),(643,238,'Machurucuto'),(644,239,'Guarenas'),(645,240,'San Antonio de Yare'),(646,240,'San Francisco de Yare'),(647,241,'Leoncio Mart??nez'),(648,241,'Petare'),(649,241,'Caucag??ita'),(650,241,'Filas de Mariche'),(651,241,'La Dolorita'),(652,242,'C??a'),(653,242,'Nueva C??a'),(654,243,'Guatire'),(655,243,'Bol??var'),(656,258,'San Antonio de Matur??n'),(657,258,'San Francisco de Matur??n'),(658,259,'Aguasay'),(659,260,'Caripito'),(660,261,'El Gu??charo'),(661,261,'La Guanota'),(662,261,'Sabana de Piedra'),(663,261,'San Agust??n'),(664,261,'Teresen'),(665,261,'Caripe'),(666,262,'Areo'),(667,262,'Capital Cede??o'),(668,262,'San F??lix de Cantalicio'),(669,262,'Viento Fresco'),(670,263,'El Tejero'),(671,263,'Punta de Mata'),(672,264,'Chaguaramas'),(673,264,'Las Alhuacas'),(674,264,'Tabasca'),(675,264,'Temblador'),(676,265,'Alto de los Godos'),(677,265,'Boquer??n'),(678,265,'Las Cocuizas'),(679,265,'La Cruz'),(680,265,'San Sim??n'),(681,265,'El Corozo'),(682,265,'El Furrial'),(683,265,'Jusep??n'),(684,265,'La Pica'),(685,265,'San Vicente'),(686,266,'Aparicio'),(687,266,'Aragua de Matur??n'),(688,266,'Chaguamal'),(689,266,'El Pinto'),(690,266,'Guanaguana'),(691,266,'La Toscana'),(692,266,'Taguaya'),(693,267,'Cachipo'),(694,267,'Quiriquire'),(695,268,'Santa B??rbara'),(696,269,'Barrancas'),(697,269,'Los Barrancos de Fajardo'),(698,270,'Uracoa'),(699,271,'Antol??n del Campo'),(700,272,'Arismendi'),(701,273,'Garc??a'),(702,273,'Francisco Fajardo'),(703,274,'Bol??var'),(704,274,'Guevara'),(705,274,'Matasiete'),(706,274,'Santa Ana'),(707,274,'Sucre'),(708,275,'Aguirre'),(709,275,'Maneiro'),(710,276,'Adri??n'),(711,276,'Juan Griego'),(712,276,'Yaguaraparo'),(713,277,'Porlamar'),(714,278,'San Francisco de Macanao'),(715,278,'Boca de R??o'),(716,279,'Tubores'),(717,279,'Los Baleales'),(718,280,'Vicente Fuentes'),(719,280,'Villalba'),(720,281,'San Juan Bautista'),(721,281,'Zabala'),(722,283,'Capital Araure'),(723,283,'R??o Acarigua'),(724,284,'Capital Esteller'),(725,284,'Uveral'),(726,285,'Guanare'),(727,285,'C??rdoba'),(728,285,'San Jos?? de la Monta??a'),(729,285,'San Juan de Guanaguanare'),(730,285,'Virgen de la Coromoto'),(731,286,'Guanarito'),(732,286,'Trinidad de la Capilla'),(733,286,'Divina Pastora'),(734,287,'Monse??or Jos?? Vicente de Unda'),(735,287,'Pe??a Blanca'),(736,288,'Capital Ospino'),(737,288,'Aparici??n'),(738,288,'La Estaci??n'),(739,289,'P??ez'),(740,289,'Payara'),(741,289,'Pimpinela'),(742,289,'Ram??n Peraza'),(743,290,'Papel??n'),(744,290,'Ca??o Delgadito'),(745,291,'San Genaro de Boconoito'),(746,291,'Antol??n Tovar'),(747,292,'San Rafael de Onoto'),(748,292,'Santa Fe'),(749,292,'Thermo Morles'),(750,293,'Santa Rosal??a'),(751,293,'Florida'),(752,294,'Sucre'),(753,294,'Concepci??n'),(754,294,'San Rafael de Palo Alzado'),(755,294,'Uvencio Antonio Vel??squez'),(756,294,'San Jos?? de Saguaz'),(757,294,'Villa Rosa'),(758,295,'Tur??n'),(759,295,'Canelones'),(760,295,'Santa Cruz'),(761,295,'San Isidro Labrador'),(762,296,'Mari??o'),(763,296,'R??mulo Gallegos'),(764,297,'San Jos?? de Aerocuar'),(765,297,'Tavera Acosta'),(766,298,'R??o Caribe'),(767,298,'Antonio Jos?? de Sucre'),(768,298,'El Morro de Puerto Santo'),(769,298,'Puerto Santo'),(770,298,'San Juan de las Galdonas'),(771,299,'El Pilar'),(772,299,'El Rinc??n'),(773,299,'General Francisco Antonio V??quez'),(774,299,'Guara??nos'),(775,299,'Tunapuicito'),(776,299,'Uni??n'),(777,300,'Santa Catalina'),(778,300,'Santa Rosa'),(779,300,'Santa Teresa'),(780,300,'Bol??var'),(781,300,'Maracapana'),(782,302,'Libertad'),(783,302,'El Paujil'),(784,302,'Yaguaraparo'),(785,303,'Cruz Salmer??n Acosta'),(786,303,'Chacopata'),(787,303,'Manicuare'),(788,304,'Tunapuy'),(789,304,'Campo El??as'),(790,305,'Irapa'),(791,305,'Campo Claro'),(792,305,'Maraval'),(793,305,'San Antonio de Irapa'),(794,305,'Soro'),(795,306,'Mej??a'),(796,307,'Cumanacoa'),(797,307,'Arenas'),(798,307,'Aricagua'),(799,307,'Cogollar'),(800,307,'San Fernando'),(801,307,'San Lorenzo'),(802,308,'Villa Frontado (Muelle de Cariaco)'),(803,308,'Catuaro'),(804,308,'Rend??n'),(805,308,'San Cruz'),(806,308,'Santa Mar??a'),(807,309,'Altagracia'),(808,309,'Santa In??s'),(809,309,'Valent??n Valiente'),(810,309,'Ayacucho'),(811,309,'San Juan'),(812,309,'Ra??l Leoni'),(813,309,'Gran Mariscal'),(814,310,'Crist??bal Col??n'),(815,310,'Bideau'),(816,310,'Punta de Piedras'),(817,310,'G??iria'),(818,341,'Andr??s Bello'),(819,342,'Antonio R??mulo Costa'),(820,343,'Ayacucho'),(821,343,'Rivas Berti'),(822,343,'San Pedro del R??o'),(823,344,'Bol??var'),(824,344,'Palotal'),(825,344,'General Juan Vicente G??mez'),(826,344,'Isa??as Medina Angarita'),(827,345,'C??rdenas'),(828,345,'Amenodoro ??ngel Lamus'),(829,345,'La Florida'),(830,346,'C??rdoba'),(831,347,'Fern??ndez Feo'),(832,347,'Alberto Adriani'),(833,347,'Santo Domingo'),(834,348,'Francisco de Miranda'),(835,349,'Garc??a de Hevia'),(836,349,'Boca de Grita'),(837,349,'Jos?? Antonio P??ez'),(838,350,'Gu??simos'),(839,351,'Independencia'),(840,351,'Juan Germ??n Roscio'),(841,351,'Rom??n C??rdenas'),(842,352,'J??uregui'),(843,352,'Emilio Constantino Guerrero'),(844,352,'Monse??or Miguel Antonio Salas'),(845,353,'Jos?? Mar??a Vargas'),(846,354,'Jun??n'),(847,354,'La Petr??lea'),(848,354,'Quinimar??'),(849,354,'Bram??n'),(850,355,'Libertad'),(851,355,'Cipriano Castro'),(852,355,'Manuel Felipe Rugeles'),(853,356,'Libertador'),(854,356,'Doradas'),(855,356,'Emeterio Ochoa'),(856,356,'San Joaqu??n de Navay'),(857,357,'Lobatera'),(858,357,'Constituci??n'),(859,358,'Michelena'),(860,359,'Panamericano'),(861,359,'La Palmita'),(862,360,'Pedro Mar??a Ure??a'),(863,360,'Nueva Arcadia'),(864,361,'Delicias'),(865,361,'Pecaya'),(866,362,'Samuel Dar??o Maldonado'),(867,362,'Bocon??'),(868,362,'Hern??ndez'),(869,363,'La Concordia'),(870,363,'San Juan Bautista'),(871,363,'Pedro Mar??a Morantes'),(872,363,'San Sebasti??n'),(873,363,'Dr. Francisco Romero Lobo'),(874,364,'Seboruco'),(875,365,'Sim??n Rodr??guez'),(876,366,'Sucre'),(877,366,'Eleazar L??pez Contreras'),(878,366,'San Pablo'),(879,367,'Torbes'),(880,368,'Uribante'),(881,368,'C??rdenas'),(882,368,'Juan Pablo Pe??alosa'),(883,368,'Potos??'),(884,369,'San Judas Tadeo'),(885,370,'Araguaney'),(886,370,'El Jaguito'),(887,370,'La Esperanza'),(888,370,'Santa Isabel'),(889,371,'Bocon??'),(890,371,'El Carmen'),(891,371,'Mosquey'),(892,371,'Ayacucho'),(893,371,'Burbusay'),(894,371,'General Ribas'),(895,371,'Guaramacal'),(896,371,'Vega de Guaramacal'),(897,371,'Monse??or J??uregui'),(898,371,'Rafael Rangel'),(899,371,'San Miguel'),(900,371,'San Jos??'),(901,372,'Sabana Grande'),(902,372,'Chereg????'),(903,372,'Granados'),(904,373,'Arnoldo Gabald??n'),(905,373,'Bolivia'),(906,373,'Carrillo'),(907,373,'Cegarra'),(908,373,'Chejend??'),(909,373,'Manuel Salvador Ulloa'),(910,373,'San Jos??'),(911,374,'Carache'),(912,374,'La Concepci??n'),(913,374,'Cuicas'),(914,374,'Panamericana'),(915,374,'Santa Cruz'),(916,375,'Escuque'),(917,375,'La Uni??n'),(918,375,'Santa Rita'),(919,375,'Sabana Libre'),(920,376,'El Socorro'),(921,376,'Los Caprichos'),(922,376,'Antonio Jos?? de Sucre'),(923,377,'Campo El??as'),(924,377,'Arnoldo Gabald??n'),(925,378,'Santa Apolonia'),(926,378,'El Progreso'),(927,378,'La Ceiba'),(928,378,'Tres de Febrero'),(929,379,'El Dividive'),(930,379,'Agua Santa'),(931,379,'Agua Caliente'),(932,379,'El Cenizo'),(933,379,'Valerita'),(934,380,'Monte Carmelo'),(935,380,'Buena Vista'),(936,380,'Santa Mar??a del Horc??n'),(937,381,'Motat??n'),(938,381,'El Ba??o'),(939,381,'Jalisco'),(940,382,'Pamp??n'),(941,382,'Flor de Patria'),(942,382,'La Paz'),(943,382,'Santa Ana'),(944,383,'Pampanito'),(945,383,'La Concepci??n'),(946,383,'Pampanito II'),(947,384,'Betijoque'),(948,384,'Jos?? Gregorio Hern??ndez'),(949,384,'La Pueblita'),(950,384,'Los Cedros'),(951,385,'Carvajal'),(952,385,'Campo Alegre'),(953,385,'Antonio Nicol??s Brice??o'),(954,385,'Jos?? Leonardo Su??rez'),(955,386,'Sabana de Mendoza'),(956,386,'Jun??n'),(957,386,'Valmore Rodr??guez'),(958,386,'El Para??so'),(959,387,'Andr??s Linares'),(960,387,'Chiquinquir??'),(961,387,'Crist??bal Mendoza'),(962,387,'Cruz Carrillo'),(963,387,'Matriz'),(964,387,'Monse??or Carrillo'),(965,387,'Tres Esquinas'),(966,388,'Cabimb??'),(967,388,'Jaj??'),(968,388,'La Mesa de Esnujaque'),(969,388,'Santiago'),(970,388,'Tu??ame'),(971,388,'La Quebrada'),(972,389,'Juan Ignacio Montilla'),(973,389,'La Beatriz'),(974,389,'La Puerta'),(975,389,'Mendoza del Valle de Momboy'),(976,389,'Mercedes D??az'),(977,389,'San Luis'),(978,390,'Caraballeda'),(979,390,'Carayaca'),(980,390,'Carlos Soublette'),(981,390,'Caruao Chuspa'),(982,390,'Catia La Mar'),(983,390,'El Junko'),(984,390,'La Guaira'),(985,390,'Macuto'),(986,390,'Maiquet??a'),(987,390,'Naiguat??'),(988,390,'Urimare'),(989,391,'Ar??stides Bastidas'),(990,392,'Bol??var'),(991,407,'Chivacoa'),(992,407,'Campo El??as'),(993,408,'Cocorote'),(994,409,'Independencia'),(995,410,'Jos?? Antonio P??ez'),(996,411,'La Trinidad'),(997,412,'Manuel Monge'),(998,413,'Sal??m'),(999,413,'Temerla'),(1000,413,'Nirgua'),(1001,414,'San Andr??s'),(1002,414,'Yaritagua'),(1003,415,'San Javier'),(1004,415,'Albarico'),(1005,415,'San Felipe'),(1006,416,'Sucre'),(1007,417,'Urachiche'),(1008,418,'El Guayabo'),(1009,418,'Farriar'),(1010,441,'Isla de Toas'),(1011,441,'Monagas'),(1012,442,'San Timoteo'),(1013,442,'General Urdaneta'),(1014,442,'Libertador'),(1015,442,'Marcelino Brice??o'),(1016,442,'Pueblo Nuevo'),(1017,442,'Manuel Guanipa Matos'),(1018,443,'Ambrosio'),(1019,443,'Carmen Herrera'),(1020,443,'La Rosa'),(1021,443,'Germ??n R??os Linares'),(1022,443,'San Benito'),(1023,443,'R??mulo Betancourt'),(1024,443,'Jorge Hern??ndez'),(1025,443,'Punta Gorda'),(1026,443,'Ar??stides Calvani'),(1027,444,'Encontrados'),(1028,444,'Ud??n P??rez'),(1029,445,'Moralito'),(1030,445,'San Carlos del Zulia'),(1031,445,'Santa Cruz del Zulia'),(1032,445,'Santa B??rbara'),(1033,445,'Urribarr??'),(1034,446,'Carlos Quevedo'),(1035,446,'Francisco Javier Pulgar'),(1036,446,'Sim??n Rodr??guez'),(1037,446,'Guamo-Gavilanes'),(1038,448,'La Concepci??n'),(1039,448,'San Jos??'),(1040,448,'Mariano Parra Le??n'),(1041,448,'Jos?? Ram??n Y??pez'),(1042,449,'Jes??s Mar??a Sempr??n'),(1043,449,'Bar??'),(1044,450,'Concepci??n'),(1045,450,'Andr??s Bello'),(1046,450,'Chiquinquir??'),(1047,450,'El Carmelo'),(1048,450,'Potreritos'),(1049,451,'Libertad'),(1050,451,'Alonso de Ojeda'),(1051,451,'Venezuela'),(1052,451,'Eleazar L??pez Contreras'),(1053,451,'Campo Lara'),(1054,452,'Bartolom?? de las Casas'),(1055,452,'Libertad'),(1056,452,'R??o Negro'),(1057,452,'San Jos?? de Perij??'),(1058,453,'San Rafael'),(1059,453,'La Sierrita'),(1060,453,'Las Parcelas'),(1061,453,'Luis de Vicente'),(1062,453,'Monse??or Marcos Sergio Godoy'),(1063,453,'Ricaurte'),(1064,453,'Tamare'),(1065,454,'Antonio Borjas Romero'),(1066,454,'Bol??var'),(1067,454,'Cacique Mara'),(1068,454,'Carracciolo Parra P??rez'),(1069,454,'Cecilio Acosta'),(1070,454,'Cristo de Aranza'),(1071,454,'Coquivacoa'),(1072,454,'Chiquinquir??'),(1073,454,'Francisco Eugenio Bustamante'),(1074,454,'Idelfonzo V??squez'),(1075,454,'Juana de ??vila'),(1076,454,'Luis Hurtado Higuera'),(1077,454,'Manuel Dagnino'),(1078,454,'Olegario Villalobos'),(1079,454,'Ra??l Leoni'),(1080,454,'Santa Luc??a'),(1081,454,'Venancio Pulgar'),(1082,454,'San Isidro'),(1083,455,'Altagracia'),(1084,455,'Far??a'),(1085,455,'Ana Mar??a Campos'),(1086,455,'San Antonio'),(1087,455,'San Jos??'),(1088,456,'Donaldo Garc??a'),(1089,456,'El Rosario'),(1090,456,'Sixto Zambrano'),(1091,457,'San Francisco'),(1092,457,'El Bajo'),(1093,457,'Domitila Flores'),(1094,457,'Francisco Ochoa'),(1095,457,'Los Cortijos'),(1096,457,'Marcial Hern??ndez'),(1097,458,'Santa Rita'),(1098,458,'El Mene'),(1099,458,'Pedro Lucas Urribarr??'),(1100,458,'Jos?? Cenobio Urribarr??'),(1101,459,'Rafael Maria Baralt'),(1102,459,'Manuel Manrique'),(1103,459,'Rafael Urdaneta'),(1104,460,'Bobures'),(1105,460,'Gibraltar'),(1106,460,'Heras'),(1107,460,'Monse??or Arturo ??lvarez'),(1108,460,'R??mulo Gallegos'),(1109,460,'El Batey'),(1110,461,'Rafael Urdaneta'),(1111,461,'La Victoria'),(1112,461,'Ra??l Cuenca'),(1113,447,'Sinamaica'),(1114,447,'Alta Guajira'),(1115,447,'El??as S??nchez Rubio'),(1116,447,'Guajira'),(1117,462,'Altagracia'),(1118,462,'Ant??mano'),(1119,462,'Caricuao'),(1120,462,'Catedral'),(1121,462,'Coche'),(1122,462,'El Junquito'),(1123,462,'El Para??so'),(1124,462,'El Recreo'),(1125,462,'El Valle'),(1126,462,'La Candelaria'),(1127,462,'La Pastora'),(1128,462,'La Vega'),(1129,462,'Macarao'),(1130,462,'San Agust??n'),(1131,462,'San Bernardino'),(1132,462,'San Jos??'),(1133,462,'San Juan'),(1134,462,'San Pedro'),(1135,462,'Santa Rosal??a'),(1136,462,'Santa Teresa'),(1137,462,'Sucre (Catia)'),(1138,462,'23 de enero');
/*!40000 ALTER TABLE `parroquias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permisos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permiso` varchar(100) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preguntas_seguridad`
--

DROP TABLE IF EXISTS `preguntas_seguridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preguntas_seguridad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int(10) unsigned NOT NULL,
  `pregunta` varchar(255) NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_pregunta` (`id_usuario`),
  CONSTRAINT `usuario_pregunta` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preguntas_seguridad`
--

LOCK TABLES `preguntas_seguridad` WRITE;
/*!40000 ALTER TABLE `preguntas_seguridad` DISABLE KEYS */;
INSERT INTO `preguntas_seguridad` VALUES (28,44,'Perro','$2y$10$GuNaBD2ayNp2ssLajnTXteksxQZ8K0P753HliHDVyex7G9LIucuoe'),(29,44,'Perra','$2y$10$eU4GBoEHjoLB0N0aneMyC.8iOl7tYGZrZt5Cu7ur4F0nHCcxrolcG'),(30,44,'Madre','$2y$10$HC9TiIUwXx2MsmRvlxQw6ux7TuicZNp.o5EjdHICZjYmcA5Ebnw46'),(31,45,'Perro','$2y$10$5ZzjaWxOsLcQ6Ohg9wwjk.bgQWF8D36O9eq7g9.ezEnO1xpD/m2p2'),(32,45,'Perra','$2y$10$LW4oJnkdt4tszzN55/XmQ.IlDM/2AaW.fusmalxMPHa7O3mbFJfIe'),(33,45,'Padre','$2y$10$/JYRMYfw78B6PxjjPR/SzOWRe5/YysKBYAR5IlZyrLDsUHR5SygP6'),(34,46,'perro','$2y$10$9c/5SwS2prbzeE5povMzIOAAJyljZXbcKZBVoSBKYhlH8/cIdi8iq'),(35,46,'perro','$2y$10$m6lSY7OKJObwrL7NG9ePNef/IWvfTXjvejQZgvxkm1ik81ez22jAi'),(36,46,'perro','$2y$10$AN.PrMsqM5Xqr3rt937PUe481w1WWD4gJQ0Aa9MeSvdY7hvsBHhB6'),(37,47,'hola','$2y$10$e7vnZaq4KXg4Na3VLlqo.emWRP23zhaoMjs4qihZrb06vOeorra3O'),(38,47,'hola','$2y$10$hcLKTlRnKeYIkQsUAieE..OZQ4oD0xNVC3bmmsNKxWkRzCRAdAyIK'),(39,47,'hola','$2y$10$9qC2UBB3CjBBipx308O/PutLqe2iplf1lVmEnW8.Hn7k7Tw4.0fS2'),(40,48,'hola','$2y$10$XyYbUSiK0WeiuSg7wEmS9uawoJ2TPwntuIzs6WyjFdk/RgR5GPUVW'),(41,48,'hola','$2y$10$JebtmdmObTWEgavHCAoYN.cB/9BWjTD2MRSGO3B8/az6VuToOYfgO'),(42,48,'hola','$2y$10$hsVrpFEVxT4CZmn8vA78NO0LsWn1hpmAT4tMic6S/AC1RRLeT3pgC'),(43,49,'hola','$2y$10$lJowEXuLIuKNd.538kjqyukaH.7aU/UczsnzjmpPw6XvHCoCzu9dm'),(44,49,'hola','$2y$10$tClYU07QM0aS8P9l/McS5.lyTgbIWJY5yFvIrXiPymYUklrK/rI9.'),(45,49,'hola','$2y$10$wvv3SEIMmt.1qKCKCUEP0OZFWHqcJdzhib88vIWdAArLIsIm.km0S'),(46,50,'hola','$2y$10$TQK4YiWv8AWSf97Dz4HNp.kLahj1l1lrjKKtCm2q7YiHrCSw.u0X.'),(47,50,'hola','$2y$10$/2e0vhrg95WwwI4llMwj8O59TJl.YcWaf8/OMYlMMeSSV2UIjz5jS'),(48,50,'hola','$2y$10$a8Lcc4Sv7IXzh9H7V2nQwenYOy/yeHUZt4HqS9Y/uJMiCg23nZ2Qe'),(49,51,'hola','$2y$10$iDJuGXYHvxYtdwNC23dRn.aIVSJFplIYuKr2a5BhxjuOC0iehOiLa'),(50,51,'hola','$2y$10$GRWaCXjkb0yxbLfp4H8isOEvZvooed9Ywn6cCsn0RedsvHmQKSogO'),(51,51,'hola','$2y$10$e/xuOsSdXYqfuEd9.cYduODXE8JZH50m/BFLWkNRYSZJHotdOifZS'),(52,52,'hola','$2y$10$Ar6Ar1gem7CW.XLNFuR3kuzInXv23433aZzMBTUjs/LD2y9PSkxSu'),(53,52,'hola','$2y$10$gqmSRUSONWhYUpop8Re8AurlJpkjz7pf0hJaSwVzUL1MDSfHfgQrm'),(54,52,'hola','$2y$10$0/41/fAQ4EvxvZL0rYRoS.FcCBsQJSJQxqjwvExPuIUQe5QNU8bEu'),(55,53,'hola','$2y$10$B.ogi9XXlGbXKxS7zdrPMuv7PUZwa677yACotOR2ZdSrEZS7ixGA6'),(56,53,'hola','$2y$10$zTCnSf31Euuo1kJmfivrMeL7vkfOvu6bEdll8HAbshX3Djj39C9Rq'),(57,53,'hola','$2y$10$5tBdaG6GyyOMr99pzaXXBObd7eozjAT4IzqbwU3cYJprly2FmS8o2'),(58,54,'hola','$2y$10$Wq8ST3By0lYhVdm31rAzv.Kxw4kfOhGoR4m6UiugmYPBJx9zlqqve'),(59,54,'hola','$2y$10$RWia5gxNPCajd/VsTUuDfenLO7vXir/aa2Td/GoGCSkTqY96rJrda'),(60,54,'hola','$2y$10$ajKF0JE4jK6hp6DePNANi.jLouxAvyvQON8h0TpSK5JhH/DeEOAs.'),(61,55,'hola','$2y$10$icL5hVHammhoHZTJlqCq5.9bjHPp0KsRhHhpnD.N9j/KCrQpvdgny'),(62,55,'hola','$2y$10$H4S8GCn.fDvgZ5qC9scS1ePZ5UJ8DTPB/mjmVYUhewk/AisEi7Gu2'),(63,55,'hola','$2y$10$bsUWkxIpSmB4kWc52vSKBu056ESR2ufg.hO.3NL0CAKqTJVqiurJq');
/*!40000 ALTER TABLE `preguntas_seguridad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_permiso`
--

DROP TABLE IF EXISTS `rol_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol_permiso` (
  `id_rol` int(10) unsigned NOT NULL,
  `id_permiso` int(10) unsigned NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_rol`,`id_permiso`),
  KEY `id_permiso` (`id_permiso`),
  CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`),
  CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_permiso`
--

LOCK TABLES `rol_permiso` WRITE;
/*!40000 ALTER TABLE `rol_permiso` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_usuario`
--

DROP TABLE IF EXISTS `rol_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol_usuario` (
  `id_rol` int(10) unsigned NOT NULL,
  `id_usuario` int(10) unsigned NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_rol`,`id_usuario`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `rol_usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`),
  CONSTRAINT `rol_usuario_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_usuario`
--

LOCK TABLES `rol_usuario` WRITE;
/*!40000 ALTER TABLE `rol_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguimientos`
--

DROP TABLE IF EXISTS `seguimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguimientos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_envio` int(10) unsigned NOT NULL,
  `id_estatus` int(10) unsigned NOT NULL,
  `nota` varchar(254) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_envio` (`id_envio`),
  KEY `id_estatus` (`id_estatus`),
  CONSTRAINT `seguimientos_FK` FOREIGN KEY (`id_envio`) REFERENCES `envios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `seguimientos_ibfk_2` FOREIGN KEY (`id_estatus`) REFERENCES `estatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguimientos`
--

LOCK TABLES `seguimientos` WRITE;
/*!40000 ALTER TABLE `seguimientos` DISABLE KEYS */;
INSERT INTO `seguimientos` VALUES (1,1,1,NULL,'2022-04-29 01:42:17');
/*!40000 ALTER TABLE `seguimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportes`
--

DROP TABLE IF EXISTS `transportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transportes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `capacidad_peso` float NOT NULL,
  `capacidad_volumen` float NOT NULL,
  `capacidad_gasolina` float NOT NULL,
  `tarifa` float NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `velocidad_promedio` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportes`
--

LOCK TABLES `transportes` WRITE;
/*!40000 ALTER TABLE `transportes` DISABLE KEYS */;
INSERT INTO `transportes` VALUES (1,'Moto',30,200,20,0.15,'Motorizado',60),(2,'Furgo',200,5000,100,0.22,'Furgoneta',50),(3,'Camioneta',500,6000,120,0.25,'Camioneta HD',50);
/*!40000 ALTER TABLE `transportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicaciones`
--

DROP TABLE IF EXISTS `ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicaciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicaciones`
--

LOCK TABLES `ubicaciones` WRITE;
/*!40000 ALTER TABLE `ubicaciones` DISABLE KEYS */;
INSERT INTO `ubicaciones` VALUES (1,'Caracas',0,0),(2,'Maracay',10,10),(3,'Valencia',20,20),(4,'Puerto la Cruz',30,30),(5,'Puerto Cabello',40,40);
/*!40000 ALTER TABLE `ubicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `correo_electronico` varchar(254) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `cedula` varchar(10) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `telefono` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (44,'yhan.carlos2001@gmail.com','$2y$10$7daDMSq8M.EZQwWgRA7IHeU9YF/CRiiUuevXY9vfE5J7PuvjFzoaW','Yhan','Monta??o','V29784799','2001-12-20',1,'2022-04-22 18:44:23','04141327382'),(45,'orlanniaraujo@gmail.com','$2y$10$r1ANgGbTi2SJnLesYOzAGuKriCGsZqms865lLYVAswU4ZcaqR/Vwu','Orlanni','Araujo','V30030117','2002-06-24',1,'2022-04-22 18:47:36','04242034761'),(46,'calderon@gmail.com','$2y$10$EOkbgI2H6sLPPC/pnEmj2.UqjFxrHDG0nNnW1OR42iGRhU9U.w/g6','Javier','Calderon','V30030117','2022-04-01',1,'2022-04-22 21:13:17','04242034761'),(47,'juan.torres@gmail.com','$2y$10$XqSQqSOyVcGtRkFa3cqjYe4XZmqWmCPHbYc/Ioh3ZmcGajPHm.ECK','Juan','Torres','V12345678','1975-10-20',1,'2022-04-26 00:54:47','04241234567'),(48,'kurokuro1500@gmail.com','$2y$10$7JHRtq/WUfhbEQiTjg1HfeIfppwlOCwpAoVuAGHUHwB/XR8zkQZ7W','Reynaldo','Gonzalez','V12345678','2022-04-06',1,'2022-04-26 01:26:28','04241234567'),(49,'franchesco@gmail.com','$2y$10$nUmyxA214d2DICzjk1X1aOaLmIUAhbTIyU/bN45RWz7OL0lt7ylqa','Franchesco','Virgolini','V12345678','1951-04-11',1,'2022-04-27 00:34:09','04141327382'),(50,'maria@gmail.com','$2y$10$ZVC7kSDnwAzoyQygBw2xq.jsWT.XmWKB11ppn0UUzej7uBbBAByz.','Maria','Martins','v12345678','2022-04-30',1,'2022-04-28 20:59:26','04241234567'),(51,'andres@gmail.com','$2y$10$fy86zmn/JKvLdujOBjwboOg.VaO1d7ZzZ59Y7mehvIU8RYo0xvguq','Andres','Martinez','V12345678','2022-04-30',1,'2022-04-28 21:32:55','04141327382'),(52,'tania@gmail.com','$2y$10$4zYUdAkm1Jb5xTpNbQnEyOY4EnWqB8nQz3ZaEWpWdjrulpN.yWw2m','Tania','Monta??o','E84608132','2022-04-27',1,'2022-04-28 22:30:36','04141327400'),(53,'orlannimontes@gmail.com','$2y$10$UwbTVi3DjlblBO.TUrTpbOrTWEao3QtpZkfxM2IW8WBKX0dm6579K','Orlanni','Araujo','V30030117','2002-06-24',1,'2022-04-28 23:21:20','04242034761'),(54,'pedro@gmail.com','$2y$10$5cSQ2qq9pBIa2rO0laYiCetGZTsHVyKHLhXvS0BJox7hLEh7f6kB6','Pedro','Montalvo','V30030117','2022-03-31',1,'2022-04-28 23:37:59','04141327382'),(55,'juan@mail.com','$2y$10$TCsS.FDgL/crRem.w92D5ucLJoHIt0cQEyHNff2/wWHpyZsJRLohS','juan','caribe','V12345','2001-12-20',1,'2022-04-29 01:15:38','04141327382');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'inu_calc_envios'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-28 21:43:46
