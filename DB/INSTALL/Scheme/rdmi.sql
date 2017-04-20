-- phpMyAdmin SQL Dump
-- version 3.3.10
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 25-01-2015 a las 11:41:54
-- Versión del servidor: 5.5.33
-- Versión de PHP: 5.3.25

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `RDMI`
--
DROP DATABASE IF EXISTS `rdmi`;
CREATE DATABASE IF NOT EXISTS `rdmi` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON `rdmi`.* TO 'rdmiuser' IDENTIFIED BY 'rdmiuser2016';
GRANT ALL PRIVILEGES ON `rdmi`.* TO 'rdmiuser'@'localhost' IDENTIFIED BY 'rdmiuser2016';
USE `rdmi` ;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE IF NOT EXISTS `pais` (
  `pai_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `pai_nombre` varchar(50) DEFAULT NULL,
  `pai_descripcion` varchar(50) DEFAULT NULL,
  `pai_estado_activo` varchar(1) NOT NULL,
  `pai_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pai_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `pai_estado_logico` varchar(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Estructura de tabla para la tabla `provincia`
--

CREATE TABLE IF NOT EXISTS `provincia` (
  `prov_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `pai_id` bigint(20) NOT NULL,
  `prov_nombre` varchar(100) DEFAULT NULL,
  `prov_descripcion` varchar(100) DEFAULT NULL,
  `prov_estado_activo` varchar(1) NOT NULL,
  `prov_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prov_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `prov_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (pai_id) REFERENCES `pais`(pai_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Estructura de tabla para la tabla `canton`
--

CREATE TABLE IF NOT EXISTS `canton` (
  `can_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `prov_id` bigint(20) NOT NULL,
  `can_nombre` varchar(150) DEFAULT NULL,
  `can_descripcion` varchar(150) DEFAULT NULL,
  `can_estado_activo` varchar(1) NOT NULL,
  `can_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `can_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `can_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (prov_id) REFERENCES `provincia`(prov_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `tipo consulta`
--

CREATE TABLE IF NOT EXISTS `tipo_consulta` (
  `tcon_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tcon_nombre` varchar(50) DEFAULT NULL,
  `tcon_fec_cre` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tcon_fec_mod` timestamp NULL DEFAULT NULL,
  `tcon_est_log` varchar(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- -----------------------------------------------------
-- table `rdmi`.`persona`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `persona` (
  `per_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
  `per_fec_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `data_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `data_persona` (
  `dper_id` bigint(20) not null auto_increment primary key,
  `per_id` bigint(20) not null ,
  `pai_id` bigint(20) null ,
  `prov_id` bigint(20) null ,
  `can_id` bigint(20) null ,
  `dper_descripcion` varchar(100) null ,
  `dper_direccion` varchar(100) null ,
  `dper_telefono` varchar(20) null ,
  `dper_celular` varchar(20) null ,
  `dper_contacto` varchar(60) null ,
  `dper_est_log` varchar(1) null ,
  `dper_fec_cre` timestamp null default current_timestamp ,
  `dper_fec_mod` timestamp null ,
  FOREIGN KEY (per_id) REFERENCES `persona`(per_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario` (
  `usu_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
  FOREIGN KEY (per_id) REFERENCES `persona` (per_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `log` (
  `log_id` bigint(20) not null auto_increment primary key,
  `usu_id` bigint(20) not null ,
  `log_registro` bigint(20) not null ,  
  `log_accion` varchar(60) null ,
  `log_table` varchar(60) null ,
  `log_fecha` timestamp null default current_timestamp ,
  foreign key (usu_id) references  `usuario` (usu_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- table  `medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medico` (
  `med_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `per_id` bigint(20) NOT NULL,
  `med_colegiado` varchar(100) DEFAULT NULL,
  `med_registro` varchar(20) DEFAULT NULL,
  `med_est_log` varchar(1) DEFAULT NULL,
  `med_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `med_fec_mod` timestamp NULL DEFAULT NULL,
   FOREIGN KEY (per_id) REFERENCES `persona` (per_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `especialidad` (
  `esp_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `esp_nombre` varchar(60) DEFAULT NULL,
  `esp_nivel` int(5) DEFAULT NULL,
  `esp_est_log` varchar(1) DEFAULT NULL,
  `esp_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `esp_fec_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `especialidad_medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `especialidad_medico` (
  `emed_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `esp_id` bigint(20) NOT NULL,
  `med_id` bigint(20) NOT NULL,
  `emed_nivel` int(5) DEFAULT NULL,
  `emed_est_log` varchar(1) DEFAULT NULL,
  `emed_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `emed_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (esp_id) REFERENCES `especialidad` (esp_id),
  FOREIGN KEY (med_id) REFERENCES `medico` (med_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `empresa` (
  `emp_id` bigint(20) not null auto_increment primary key,
  `emp_nombre` varchar(50) null ,
  `emp_ruc` varchar(15) null ,
  `emp_descripcion` varchar(100) null ,
  `emp_direccion` varchar(100) null ,
  `emp_telefono` varchar(20) null ,
  `emp_est_log` varchar(1) null ,
  `emp_fec_cre` timestamp null default current_timestamp ,
  `emp_fec_mod` timestamp null 
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- table  `medico_empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medico_empresa` (
  `memp_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `med_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  `memp_est_log` varchar(1) DEFAULT NULL,
  `memp_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `memp_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (emp_id) REFERENCES `empresa` (emp_id),
  FOREIGN KEY (med_id) REFERENCES `medico` (med_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `paciente`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `paciente` (
  `pac_id` bigint(20) NOT NULL AUTO_INCREMENT  PRIMARY KEY,
  `per_id` bigint(20) NOT NULL,
  `pac_fecha_ingreso` timestamp NULL DEFAULT NULL,
  `pac_est_log` varchar(1) DEFAULT NULL,
  `pac_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pac_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (per_id) REFERENCES `persona` (per_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `cita_programada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cita_programada` (
  `cprog_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pac_id` bigint(20) NOT NULL,
  `emed_id` bigint(20) NOT NULL,
  `cprog_numero` int(10) DEFAULT NULL,
  `cprog_observacion` text,
  `cprog_est_log` varchar(1) DEFAULT NULL,
  `cprog_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cprog_fec_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (cprog_id,pac_id),
  FOREIGN KEY (emed_id) REFERENCES `especialidad_medico` (emed_id),
  FOREIGN KEY (pac_id) REFERENCES `paciente` (pac_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `centro_atencion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `centro_atencion` (
  `cate_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `emp_id` bigint(20) NOT NULL,
  `cate_nombre` varchar(50) DEFAULT NULL,
  `cate_direccion` varchar(100) DEFAULT NULL,
  `cate_telefono` varchar(20) DEFAULT NULL,
  `cate_correo` varchar(60) DEFAULT NULL,
  `cate_hora_inicio` time DEFAULT NULL,
  `cate_hora_fin` time DEFAULT NULL,
  `cate_est_log` varchar(1) DEFAULT NULL,
  `cate_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cate_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (emp_id) REFERENCES `empresa` (emp_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `oficina`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS  `oficina` (
  `ofi_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `ofi_nombre` varchar(50) DEFAULT NULL,
  `ofi_est_log` varchar(1) DEFAULT NULL,
  `ofi_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ofi_fec_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `consultorio`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `consultorio` (
  `cons_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
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
  FOREIGN KEY (`cate_id`) REFERENCES `centro_atencion` (`cate_id`) ,
  FOREIGN KEY (`esp_id`) REFERENCES `especialidad` (`esp_id`),
  FOREIGN KEY (`ofi_id`) REFERENCES `oficina` (`ofi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `horario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS  `horario` (
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
  FOREIGN KEY (`cons_id`) REFERENCES `consultorio` (`cons_id`) ,
  FOREIGN KEY (`med_id`) REFERENCES `medico` (`med_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `agendar_cita`
-- -----------------------------------------------------
-- CREATE  TABLE IF NOT EXISTS `agendar_cita` (
--   `acit_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
--   `cprog_id` BIGINT(20) NOT NULL ,
--   `pac_id` BIGINT(20) NOT NULL ,
--   `hora_id` BIGINT(20) NOT NULL ,
--   `fecha_cita` DATE NULL ,
--   `cons_id` BIGINT(20) NULL ,
--   `hora_inicio` TIME NULL ,
--   `acit_motivo` BLOB NULL DEFAULT NULL ,
--   `acit_est_log` VARCHAR(1) NULL DEFAULT NULL ,
--   `acit_fec_cre` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
--   `acit_fec_mod` TIMESTAMP NULL DEFAULT NULL ,
--   FOREIGN KEY (`cprog_id` , `pac_id` ) REFERENCES `cita_programada` (`cprog_id` , `pac_id` ),
--   FOREIGN KEY (`hora_id` , `fecha_cita` , `cons_id` , `hora_inicio` ) REFERENCES `horario` (`hora_id`,`fecha_cita`,`cons_id` , `hora_inicio`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `cita_medica`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cita_medica` (
  `cmde_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tur_numero` INT(5) NOT NULL ,
  `hora_id` BIGINT(20) NOT NULL ,
  `fecha_cita` DATE NOT NULL ,
  `cons_id` BIGINT(20) NOT NULL ,
  `hora_inicio` TIME NOT NULL ,
  `tcon_id` BIGINT(20) NOT NULL ,
  `pac_id` BIGINT(20) NOT NULL ,
  `cprog_id` BIGINT(20) NOT NULL ,
  `cmde_motivo` BLOB NULL DEFAULT NULL ,
  `cmde_observacion` BLOB NULL DEFAULT NULL ,
  `cmde_estado_asistencia` VARCHAR(1) NULL DEFAULT NULL ,
  `cmde_est_log` VARCHAR(1) NULL DEFAULT NULL ,
  `cmde_fec_cre` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  `cmde_fec_mod` TIMESTAMP NULL DEFAULT NULL ,
  FOREIGN KEY (`tcon_id` ) REFERENCES `tipo_consulta` (`tcon_id` ),
  FOREIGN KEY (`hora_id`,`fecha_cita` , `cons_id` , `hora_inicio` ) REFERENCES `horario` (`hora_id`,`fecha_cita`,`cons_id`,`hora_inicio`),
  FOREIGN KEY (`cprog_id` , `pac_id` ) REFERENCES `cita_programada` (`cprog_id` , `pac_id` )
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `signos_vitales`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `signos_vitales` (
  `svit_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `cmde_id` bigint(20) NOT NULL,
  `svit_peso` decimal(5,2) DEFAULT NULL,
  `svit_talla` decimal(5,2) DEFAULT NULL,
  `svit_temperatura` decimal(5,2) DEFAULT NULL,
  `svit_temperatura_axilar` decimal(5,2) DEFAULT NULL,
  `svit_presion_arteriar` decimal(5,2) DEFAULT NULL,
  `svit_frecuencia_respiratoria` decimal(5,2) DEFAULT NULL,
  `svit_frecuencia_cardiaca` decimal(5,2) DEFAULT NULL,
  `svit_observacion` text,
  `svit_est_log` varchar(1) DEFAULT NULL,
  `svit_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `svit_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (`cmde_id`) REFERENCES `cita_medica` (`cmde_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `tipo_dicom`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tipo_dicom` (
  `tdic_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tdic_nomenclatura` varchar(5) DEFAULT NULL,
  `tdic_detalle` varchar(100) DEFAULT NULL,
  `tdic_est_log` varchar(1) DEFAULT NULL,
  `tdic_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tdic_fec_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `dicom`
-- -----------------------------------------------------
-- CREATE  TABLE IF NOT EXISTS `dicom` (
--   `dic_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
--   `tdic_id` bigint(20) NOT NULL,
--   `dic_size` decimal(10,2) DEFAULT NULL,
--   `dic_ruta` varchar(80) DEFAULT NULL,
--   `dic_est_log` varchar(1) DEFAULT NULL,
--   `dic_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
--   `dic_fec_mod` timestamp NULL DEFAULT NULL,
--   FOREIGN KEY (`tdic_id`) REFERENCES `tipo_dicom` (`tdic_id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `session`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `session` (
  `id` varchar(40) NOT NULL PRIMARY KEY,
  `expire` bigint(20) DEFAULT NULL,
  `data` blob DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- estructura de tabla para la tabla `tipo_password`
--

create table if not exists `tipo_password` (
  `tpas_id` bigint(20) not null auto_increment primary key,
  `tpas_tipo` varchar(50) default null,
  `tpas_validacion` varchar(200) default null,
  `tpas_descripcion` varchar(300) default null,
  `tpas_estado_activo` varchar(1) not null,
  `tpas_fecha_creacion` timestamp not null default current_timestamp,
  `tpas_fecha_modificacion` timestamp null default null,
  `tpas_estado_logico` varchar(1) not null
) engine=innodb  default charset=utf8 auto_increment=1 ;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `user_passreset`
--
CREATE TABLE IF NOT EXISTS `user_passreset` (
`upas_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`usu_id` bigint(20) NOT NULL,
`upas_remote_ip_inactivo` varchar(20) DEFAULT NULL,
`upas_remote_ip_activo` varchar(20) DEFAULT NULL,
`upas_link` varchar(500) DEFAULT NULL,
`upas_fecha_inicio` timestamp NULL DEFAULT NULL,
`upas_fecha_fin` timestamp NULL DEFAULT NULL,
`upas_estado_activo` varchar(1) DEFAULT NULL,
`upas_fecha_creacion` timestamp NULL DEFAULT NULL,
`upas_fecha_modificacion` timestamp NULL DEFAULT NULL,
`upas_estado_logico` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- -----------------------------------------------------
-- table  `rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rol` (
  `rol_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `rol_nombre` varchar(50) DEFAULT NULL,
  `rol_descripcion` varchar(45) DEFAULT NULL,
  `rol_estado_activo` varchar(1) NOT NULL,
  `rol_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rol_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `rol_estado_logico` varchar(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE IF NOT EXISTS `grupo` (
  `gru_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tpas_id` bigint(20) NOT NULL,
  `gru_nombre` varchar(50) DEFAULT NULL,
  `gru_descripcion` varchar(200) DEFAULT NULL,
  `gru_estado_activo` varchar(1) NOT NULL,
  `gru_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gru_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `gru_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (tpas_id) REFERENCES `tipo_password`(tpas_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


--
-- Estructura de tabla para la tabla `grupo_rol`
--

CREATE TABLE IF NOT EXISTS `grupo_rol` (
  `grol_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `gru_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `usu_id` bigint(20) NOT NULL,
  `grol_estado_activo` varchar(1) NOT NULL,
  `grol_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `grol_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `grol_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (gru_id) REFERENCES `grupo`(gru_id),
  FOREIGN KEY (rol_id) REFERENCES `rol`(rol_id),
  FOREIGN KEY (usu_id) REFERENCES `usuario`(usu_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- -----------------------------------------------------
-- table  `aplicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacion` (
  `apl_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `apl_nombre` varchar(50) DEFAULT NULL,
  `apl_tipo` varchar(45) DEFAULT NULL,
  `apl_lang_file` varchar(100) DEFAULT NULL,
  `apl_est_log` varchar(1) DEFAULT NULL,
  `apl_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `apl_fec_mod` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modulo` (
  `mod_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
  FOREIGN KEY (`apl_id`) REFERENCES `aplicacion` (`apl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `objeto_modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `objeto_modulo` (
  `omod_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
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
  FOREIGN KEY (`mod_id`) REFERENCES `modulo` (`mod_id`) ,
  FOREIGN KEY (`omod_padre_id`) REFERENCES `objeto_modulo` (`omod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `usuario_empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario_empresa` (
  `uemp_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `usu_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `emp_id` bigint(20) NOT NULL,
  `uemp_est_log` varchar(1) DEFAULT NULL,
  `uemp_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `uemp_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (`emp_id`) REFERENCES `empresa` (`emp_id`) ,
  FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`) ,
  FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- table  `omodulo_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `omodulo_rol` (
  `omrol_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `omod_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `omrol_est_log` varchar(1) DEFAULT NULL,
  `omrol_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `omrol_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (`omod_id`) REFERENCES `objeto_modulo` (`omod_id`) ,
  FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`) 
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- estructura de tabla para la tabla `accion`
--

CREATE TABLE IF NOT EXISTS `accion` (
  `acc_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `acc_nombre` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `acc_url_accion` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `acc_tipo` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `acc_descripcion` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `acc_lang_file` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `acc_dir_imagen` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `acc_estado_activo` varchar(1) CHARACTER SET utf8 NOT NULL,
  `acc_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `acc_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `acc_estado_logico` varchar(1) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- estructura de tabla para la tabla `obmo_acci`
--

CREATE TABLE IF NOT EXISTS `obmo_acci` (
  `oacc_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `omod_id` bigint(20) NOT NULL,
  `acc_id` bigint(20) NOT NULL,
  `oacc_tipo_boton` varchar(1) DEFAULT NULL,
  `oacc_cont_accion` varchar(100) DEFAULT NULL,
  `oacc_function` varchar(100) DEFAULT NULL,
  `oacc_estado_activo` varchar(1) NOT NULL,
  `oacc_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oacc_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `oacc_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (omod_id) REFERENCES `objeto_modulo`(omod_id),
  FOREIGN KEY (acc_id) REFERENCES `accion`(acc_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE IF NOT EXISTS `eventos` (
  `eve_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `cmde_id` bigint(20) NOT NULL,
  `eve_usu_id` bigint(20) NOT NULL,
  `eve_nombre` varchar(50) DEFAULT NULL,
  `eve_observacion` text,
  `eve_fec_cre` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eve_fec_mod` timestamp NULL DEFAULT NULL,
  `eve_est_log` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Estructura de tabla para la tabla `imagenes`
--

CREATE TABLE IF NOT EXISTS `imagenes` (
  `ima_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `pac_id` BIGINT(20) NOT NULL ,
  `tdic_id` BIGINT(20) NOT NULL ,
  `eve_id` bigint(20) NOT NULL,
  `ima_titulo` varchar(60) DEFAULT NULL,
  `ima_nombre_archivo` varchar(60) DEFAULT NULL,
  `ima_extension_archivo` varchar(5) DEFAULT NULL,
  `ima_ruta_archivo` varchar(100) DEFAULT NULL,
  `ima_tamano` varchar(10) DEFAULT NULL,
  `ima_folio` varchar(20) DEFAULT NULL,
  `ima_observacion` text,
  `ima_fecha_publica` timestamp NULL DEFAULT NULL,
  `ima_fec_cre` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ima_fec_mod` timestamp NULL DEFAULT NULL,
  `ima_est_log` varchar(1) NOT NULL,
  FOREIGN KEY (`eve_id` )  REFERENCES `eventos` (`eve_id` ),
  FOREIGN KEY (`tdic_id` )  REFERENCES `tipo_dicom` (`tdic_id` ),
  FOREIGN KEY (`pac_id` )  REFERENCES `paciente` (`pac_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Estructura de tabla para la tabla `resultados`
--

CREATE  TABLE IF NOT EXISTS `resultados` (
  `resul_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `eve_id` BIGINT(20) NOT NULL ,
  `med_id` BIGINT(20) NOT NULL ,
  `usu_id` BIGINT(20) NULL ,
  `resul_observacion` TEXT NULL ,
  `resul_fec_cre` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `resul_fec_mod` TIMESTAMP NULL DEFAULT NULL ,
  `resul_est_log` VARCHAR(1) NOT NULL ,
  FOREIGN KEY (`eve_id` )  REFERENCES `eventos` (`eve_id` ),
  FOREIGN KEY (`med_id` )  REFERENCES `medico` (`med_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Estructura de tabla para la tabla `medico_atencion`
--

CREATE  TABLE IF NOT EXISTS `medico_atencion` (
  `mate_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `med_id` bigint(20) NOT NULL,
  `pac_id` bigint(20) NOT NULL,
  `mate_est_log` varchar(1) DEFAULT NULL,
  `mate_fec_cre` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `mate_fec_mod` timestamp NULL DEFAULT NULL,
  FOREIGN KEY (`med_id`) REFERENCES `medico` (`med_id`),
  FOREIGN KEY (`pac_id`) REFERENCES `paciente` (`pac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



