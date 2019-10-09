-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: asistencia
-- ------------------------------------------------------
-- Server version	5.7.24

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
-- Table structure for table `ausencia`
--

DROP TABLE IF EXISTS `ausencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ausencia` (
  `au_id` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta_id` int(11) NOT NULL,
  `au_fecha` datetime NOT NULL,
  `au_motivo` text COLLATE utf8_spanish_ci NOT NULL,
  `au_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`au_id`,`cuenta_id`),
  KEY `fkcuenta_ausencia_idx` (`cuenta_id`),
  CONSTRAINT `fkcuenta_ausencia` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`cu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Aucencia de los asistentes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ausencia`
--

LOCK TABLES `ausencia` WRITE;
/*!40000 ALTER TABLE `ausencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `ausencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beca`
--

DROP TABLE IF EXISTS `beca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beca` (
  `be_id` int(10) NOT NULL AUTO_INCREMENT,
  `be_nombre` varchar(145) COLLATE utf8_spanish_ci NOT NULL,
  `be_porcentaje` int(10) NOT NULL,
  PRIMARY KEY (`be_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='cantidad de beca asignada a los asistentes estudiantiles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beca`
--

LOCK TABLES `beca` WRITE;
/*!40000 ALTER TABLE `beca` DISABLE KEYS */;
INSERT INTO `beca` VALUES (1,'full',100),(2,'medio',75);
/*!40000 ALTER TABLE `beca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuenta`
--

DROP TABLE IF EXISTS `cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuenta` (
  `cu_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `cu_usuario` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `cu_password` varchar(245) COLLATE utf8_spanish_ci NOT NULL,
  `cu_cambio` tinyint(1) NOT NULL,
  `cu_creado` datetime NOT NULL,
  PRIMARY KEY (`cu_id`,`id_perfil`),
  KEY `fkcuenta_perfil_idx` (`id_perfil`),
  CONSTRAINT `fkperfil_cuenta` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`pe_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuenta`
--

LOCK TABLES `cuenta` WRITE;
/*!40000 ALTER TABLE `cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extras`
--

DROP TABLE IF EXISTS `extras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extras` (
  `ex_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cuenta` int(11) NOT NULL,
  `ex_cantidad` int(11) NOT NULL,
  `ex_justificacion` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`ex_id`,`id_cuenta`),
  KEY `fkcuenta_extras_idx` (`id_cuenta`),
  CONSTRAINT `fkcuenta_extras` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`cu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='horas extras que el asistente trabaje';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extras`
--

LOCK TABLES `extras` WRITE;
/*!40000 ALTER TABLE `extras` DISABLE KEYS */;
/*!40000 ALTER TABLE `extras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horario` (
  `ho_id` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta_id` int(11) NOT NULL,
  `ho_dia` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `ho_nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `ho_inicio` time NOT NULL,
  `ho_final` time NOT NULL,
  PRIMARY KEY (`ho_id`,`cuenta_id`),
  KEY `fkcuenta_horario_idx` (`cuenta_id`),
  CONSTRAINT `fkcuenta_horario` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`cu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Horario asistentes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcado`
--

DROP TABLE IF EXISTS `marcado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcado` (
  `ma_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cuenta` int(11) NOT NULL,
  `ma_hora` time NOT NULL,
  `ma_fecha` date NOT NULL,
  `ma_indicador` char(2) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`ma_id`,`id_cuenta`),
  KEY `fkcuenta_marcado_idx` (`id_cuenta`),
  CONSTRAINT `fkcuenta_marcado` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`cu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Marcado de asistencia de los estudiantes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcado`
--

LOCK TABLES `marcado` WRITE;
/*!40000 ALTER TABLE `marcado` DISABLE KEYS */;
/*!40000 ALTER TABLE `marcado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `asistencia`.`marcado_BEFORE_UPDATE` BEFORE UPDATE ON `marcado` FOR EACH ROW
BEGIN
INSERT INTO asistencia.marcadolog (id_cuenta, ma_hora, ma_fecha, ma_indicador, accion, fecha) VALUES(null, new.ma_hora, new.ma_fecha, new.ma_indicador, 'BEFORE UPDATE', CURRENT_TIMESTAMP);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `asistencia`.`marcado_AFTER_UPDATE` AFTER UPDATE ON `marcado` FOR EACH ROW
BEGIN
INSERT INTO asistencia.marcadolog (id_cuenta, ma_hora, ma_fecha, ma_indicador, accion, fecha) VALUES(null, old.ma_hora, old.ma_fecha, old.ma_indicador,'AFTER UPDATE', CURRENT_TIMESTAMP);

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `asistencia`.`marcado_BEFORE_DELETE` BEFORE DELETE ON `marcado` FOR EACH ROW
BEGIN
INSERT INTO asistencia.marcadolog (id_cuenta, ma_hora, ma_fecha, ma_indicador, accion, fecha) VALUES(null, old.ma_hora, old.ma_fecha, old.ma_indicador, 'BEFORE DELETE', CURRENT_TIMESTAMP);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `marcadolog`
--

DROP TABLE IF EXISTS `marcadolog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcadolog` (
  `ma_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cuenta` int(11) NOT NULL,
  `ma_hora` time NOT NULL,
  `ma_fecha` date NOT NULL,
  `ma_indicador` char(2) COLLATE utf8_spanish_ci NOT NULL,
  `accion` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ma_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='log asistencia de los estudiantes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcadolog`
--

LOCK TABLES `marcadolog` WRITE;
/*!40000 ALTER TABLE `marcadolog` DISABLE KEYS */;
/*!40000 ALTER TABLE `marcadolog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perfil` (
  `pe_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sede` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_beca` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `pe_ocupacion` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `pe_area` varchar(95) COLLATE utf8_spanish_ci NOT NULL,
  `pe_estado` char(3) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`pe_id`,`id_sede`,`id_rol`,`id_beca`,`id_usuario`),
  KEY `fkrol_perfil_idx` (`id_rol`),
  KEY `fkbeca_perfil_idx` (`id_beca`),
  KEY `fkusuario_perfil_idx` (`id_usuario`),
  KEY `fksede_perfil` (`id_sede`),
  CONSTRAINT `fkbeca_perfil` FOREIGN KEY (`id_beca`) REFERENCES `beca` (`be_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkrol_perfil` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`rol_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fksede_perfil` FOREIGN KEY (`id_sede`) REFERENCES `sede` (`se_id`),
  CONSTRAINT `fkusuario_perfil` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`us_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Perfil. esta contiene adicionales de usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES (1,1,3,2,1,'Asistente estudiantil','CAJA','A');
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `rol_id` int(10) NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `rol_tipo` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `rol_sigla` char(2) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='roles de usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'USUARIO MAESTRO','USUARIO MAESTRO','U'),(2,'SUPERVISOR','supervisor','S'),(3,'ASISTENTE','ASISTENTE','A');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sede`
--

DROP TABLE IF EXISTS `sede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sede` (
  `se_id` int(11) NOT NULL AUTO_INCREMENT,
  `se_nombre` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`se_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='sede de la uip en caso de que quieran escalar el aplicativo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sede`
--

LOCK TABLES `sede` WRITE;
/*!40000 ALTER TABLE `sede` DISABLE KEYS */;
INSERT INTO `sede` VALUES (1,'SEDE '),(2,'VÍA BRASIL'),(3,'LA CHORRERA');
/*!40000 ALTER TABLE `sede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tardansas`
--

DROP TABLE IF EXISTS `tardansas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tardansas` (
  `ta_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cuenta` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `justificacion` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`ta_id`,`id_cuenta`),
  KEY `fkcuenta_pendiente_idx` (`id_cuenta`),
  CONSTRAINT `fkcuenta_tardansas` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`cu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Horas pendientes de los asistente.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tardansas`
--

LOCK TABLES `tardansas` WRITE;
/*!40000 ALTER TABLE `tardansas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tardansas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariolog`
--

DROP TABLE IF EXISTS `usuariolog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuariolog` (
  `us_id` int(11) NOT NULL AUTO_INCREMENT,
  `us_nombre` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `us_apellido` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `us_cedula` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_nacimiento` date NOT NULL,
  `us_correo` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_telefono` int(12) NOT NULL,
  `us_familiar` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_telefonofamiliar` int(12) NOT NULL,
  `us_color` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_foto` text COLLATE utf8_spanish_ci NOT NULL,
  `accion` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `id_perfil` int(11) NOT NULL,
  PRIMARY KEY (`us_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla log de usuarios.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariolog`
--

LOCK TABLES `usuariolog` WRITE;
/*!40000 ALTER TABLE `usuariolog` DISABLE KEYS */;
INSERT INTO `usuariolog` VALUES (2,'javier','batista','8-896-1622','2019-08-02','juanito@hotmail.com',64828442,'juannaw',654738292,'negro','ewertyuio765432.jpg','INSERT','2019-08-18 07:25:47',0),(3,'jonh ','dowson','7384952567','2019-08-13','juan@yahoo.es',2345678,'juanna',67395356,'negro','02003046886.jpg','Update','2019-08-18 07:33:27',0),(4,'javier','batista','8-896-1622','2019-08-02','juanito@hotmail.com',64828442,'juanna2',654738292,'negro','ewertyuio765432.jpg','Update','2019-08-18 07:36:47',0),(6,'javier','batista','8-896-1622','2019-08-02','juanito@hotmail.AR',64828442,'juanna2',654738292,'negro','ewertyuio765432.jpg','Update','2019-08-18 07:40:00',0),(7,'javier','batista','8-896-1622','2019-08-02','juanito@hotmail.com',64828442,'juanna2',654738292,'negro','ewertyuio765432.jpg','After Update','2019-08-18 07:40:00',0);
/*!40000 ALTER TABLE `usuariolog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `us_id` int(11) NOT NULL AUTO_INCREMENT,
  `us_nombre` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `us_apellido` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `us_cedula` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_nacimiento` date NOT NULL,
  `us_correo` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_telefono` int(12) NOT NULL,
  `us_familiar` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_telefonofamiliar` int(12) NOT NULL,
  `us_color` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_foto` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`us_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla de caracteristica de usuarios.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Javier','Balsas','8-896-1629','1995-08-18','javier9518@gmail.com',64828440,'giovanna',65473829,'negro','20049688708085996.jpg'),(2,'jonh ','dowson','7384952567','2019-08-13','juan@yahoo.es',2345678,'juanna',67395356,'negro','02003046886.jpg'),(3,'javier','batista','8-896-1622','2019-08-02','juanito@hotmail.AR',64828442,'juanna2',654738292,'negro','ewertyuio765432.jpg');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `asistencia`.`usuarios_BEFORE_INSERT` BEFORE INSERT ON `usuarios` FOR EACH ROW
begin
	INSERT INTO asistencia.usuariolog (us_nombre, us_apellido, us_cedula, us_nacimiento, us_correo, us_telefono, us_familiar, us_telefonofamiliar, us_color, us_foto, accion, fecha) 
								VALUES(new.us_nombre, new.us_apellido, new.us_cedula, new.us_nacimiento, new.us_correo, new.us_telefono, new.us_familiar, new.us_telefonofamiliar, new.us_color,new.us_foto, 'INSERT', now());

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `asistencia`.`usuarios_BEFORE_UPDATE` BEFORE UPDATE ON `usuarios` FOR EACH ROW
BEGIN
INSERT INTO asistencia.usuariolog (us_nombre, us_apellido, us_cedula, us_nacimiento, us_correo, us_telefono, us_familiar, us_telefonofamiliar, us_color, us_foto, accion, fecha) 
								VALUES(new.us_nombre, new.us_apellido, new.us_cedula, new.us_nacimiento, new.us_correo, new.us_telefono, new.us_familiar, new.us_telefonofamiliar, new.us_color,new.us_foto, 'Update', now());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_UPDATE` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
INSERT INTO asistencia.usuariolog (us_nombre, us_apellido, us_cedula, us_nacimiento, us_correo, us_telefono, us_familiar, us_telefonofamiliar, us_color, us_foto, accion, fecha) 
								VALUES(OLD.us_nombre, OLD.us_apellido, OLD.us_cedula, OLD.us_nacimiento, OLD.us_correo, OLD.us_telefono, OLD.us_familiar, OLD.us_telefonofamiliar,OLD.us_color,OLD.us_foto, 'After Update', now());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'asistencia'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-18 21:56:51
