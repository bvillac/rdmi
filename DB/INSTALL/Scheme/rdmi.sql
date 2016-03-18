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
create  table if not exists  `persona` (
  `per_id` bigint(20) not null auto_increment ,
  `per_ced_ruc` varchar(15) null ,
  `per_nombre` varchar(100) null ,
  `per_apellido` varchar(100) null ,
  `per_genero` varchar(1) null ,
  `per_fecha_nacimiento` date null ,
  `per_estado_civil` varchar(2) null ,
  `per_correo` varchar(100) DEFAULT NULL,
  `per_factor_rh` varchar(5) null ,
  `per_tipo_sangre` varchar(5) null ,
  `per_foto` varchar(100) DEFAULT NULL,
  `per_estado_activo` varchar(1) NOT NULL,
  `per_est_log` varchar(1) null ,
  `per_fec_cre` timestamp null default current_timestamp ,
  `per_fec_mod` timestamp null ,
  primary key (`per_id`) )
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `data_persona`
-- -----------------------------------------------------
create  table if not exists  `data_persona` (
  `dper_id` bigint(20) not null auto_increment ,
  `per_id` bigint(20) not null ,
  `dper_descripcion` varchar(100) null ,
  `dper_direccion` varchar(100) null ,
  `dper_telefono` varchar(20) null ,
  `dper_celular` varchar(20) null ,
  `dper_contacto` varchar(60) null ,
  `dper_est_log` varchar(1) null ,
  `dper_fec_cre` timestamp null default current_timestamp ,
  `dper_fec_mod` timestamp null ,
  primary key (`dper_id`) ,
  constraint `fk_data_persona_persona`
    foreign key (`per_id` )
    references  `persona` (`per_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `usuario`
-- -----------------------------------------------------
create  table if not exists  `usuario` (
  `usu_id` bigint(20) not null auto_increment ,
  `per_id` bigint(20) not null ,
  `usu_username` varchar(45) default null,
  `usu_password` varchar(255) default null,
  `usu_sha` varchar(255),
  `usu_session` varchar(255) default null,
  `usu_last_login` timestamp null default null,
  `usu_link_activo` text null default null,
  `usu_estado_activo` varchar(1) not null,
  `usu_alias` varchar(60) null ,
  `usu_est_log` varchar(1) null ,
  `usu_fec_cre` timestamp null default current_timestamp ,
  `usu_fec_mod` timestamp null ,
  primary key (`usu_id`) ,
  constraint `fk_usuario_persona1`
    foreign key (`per_id` )
    references  `persona` (`per_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `log`
-- -----------------------------------------------------
create  table if not exists  `log` (
  `log_id` bigint(20) not null auto_increment ,
  `usu_id` bigint(20) not null ,
  `log_fecha` timestamp null default current_timestamp ,
  `log_accion` varchar(60) null ,
  primary key (`log_id`) ,
  constraint `fk_log_usuario1`
    foreign key (`usu_id` )
    references  `usuario` (`usu_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;


-- -----------------------------------------------------
-- table  `medico`
-- -----------------------------------------------------
create  table if not exists  `medico` (
  `med_id` bigint(20) not null auto_increment ,
  `per_id` bigint(20) not null ,
  `med_colegiado` varchar(100) null ,
  `med_registro` varchar(20) null ,
  `med_est_log` varchar(1) null ,
  `med_fec_cre` timestamp null default current_timestamp ,
  `med_fec_mod` timestamp null ,
  primary key (`med_id`) ,
  constraint `fk_medico_persona1`
    foreign key (`per_id` )
    references  `persona` (`per_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `especialidad`
-- -----------------------------------------------------
create  table if not exists  `especialidad` (
  `esp_id` bigint(20) not null auto_increment ,
  `esp_nombre` varchar(60) null ,
  `esp_nivel` int(5) null ,
  `esp_est_log` varchar(1) null ,
  `esp_fec_cre` timestamp null default current_timestamp ,
  `esp_fec_mod` timestamp null ,
  primary key (`esp_id`) )
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `especialidad_medico`
-- -----------------------------------------------------
create  table if not exists  `especialidad_medico` (
  `emed_id` bigint(20) not null auto_increment ,
  `esp_id` bigint(20) not null ,
  `med_id` bigint(20) not null ,
  `emed_nivel` int(5) null ,
  `emed_est_log` varchar(1) null ,
  `emed_fec_cre` timestamp null default current_timestamp ,
  `emed_fec_mod` timestamp null ,
  primary key (`emed_id`) ,
  constraint `fk_especialidad_medico_especialidad1`
    foreign key (`esp_id` )
    references  `especialidad` (`esp_id` )
    on delete no action
    on update no action,
  constraint `fk_especialidad_medico_medico1`
    foreign key (`med_id` )
    references  `medico` (`med_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `empresa`
-- -----------------------------------------------------
create  table if not exists  `empresa` (
  `emp_id` bigint(20) not null auto_increment ,
  `emp_nombre` varchar(50) null ,
  `emp_ruc` varchar(15) null ,
  `emp_descripcion` varchar(100) null ,
  `emp_direccion` varchar(100) null ,
  `emp_telefono` varchar(20) null ,
  `emp_est_log` varchar(1) null ,
  `emp_fec_cre` timestamp null default current_timestamp ,
  `emp_fec_mod` timestamp null ,
  primary key (`emp_id`) )
engine=innodb  default charset=utf8 auto_increment=1;


-- -----------------------------------------------------
-- table  `medico_empresa`
-- -----------------------------------------------------
create  table if not exists  `medico_empresa` (
  `memp_id` bigint(20) not null auto_increment ,
  `med_id` bigint(20) not null ,
  `emp_id` bigint(20) not null ,
  `memp_est_log` varchar(1) null ,
  `memp_fec_cre` timestamp null default current_timestamp ,
  `memp_fec_mod` timestamp null ,
  primary key (`memp_id`) ,
  constraint `fk_medico_empresa_medico1`
    foreign key (`med_id` )
    references  `medico` (`med_id` )
    on delete no action
    on update no action,
  constraint `fk_medico_empresa_empresa1`
    foreign key (`emp_id` )
    references  `empresa` (`emp_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `paciente`
-- -----------------------------------------------------
create  table if not exists  `paciente` (
  `pac_id` bigint(20) not null auto_increment ,
  `per_id` bigint(20) not null ,
  `pac_fecha_ingreso` timestamp null ,
  `pac_est_log` varchar(1) null ,
  `pac_fec_cre` timestamp null default current_timestamp ,
  `pac_fec_mod` timestamp null ,
  primary key (`pac_id`) ,
  constraint `fk_paciente_persona1`
    foreign key (`per_id` )
    references  `persona` (`per_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `cita_programada`
-- -----------------------------------------------------
create  table if not exists  `cita_programada` (
  `cprog_id` bigint(20) not null auto_increment ,
  `pac_id` bigint(20) not null ,
  `emed_id` bigint(20) not null ,
  `cprog_numero` int(10) null ,
  `cprog_observacion` blob null ,
  `cprog_est_log` varchar(1) null ,
  `cprog_fec_cre` timestamp null default current_timestamp ,
  `cprog_fec_mod` timestamp null ,
  primary key (`cprog_id`, `pac_id`) ,
  constraint `fk_cita_programada_paciente1`
    foreign key (`pac_id` )
    references  `paciente` (`pac_id` )
    on delete no action
    on update no action,
  constraint `fk_cita_programada_especialidad_medico1`
    foreign key (`emed_id` )
    references  `especialidad_medico` (`emed_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `agendar_cita`
-- -----------------------------------------------------
create  table if not exists  `agendar_cita` (
  `acit_id` bigint(20) not null auto_increment ,
  `cprog_id` bigint(20) not null ,
  `pac_id` bigint(20) not null ,
  `acit_motivo` blob null ,
  `acit_est_log` varchar(1) null ,
  `acit_fec_cre` timestamp null default current_timestamp ,
  `acit_fec_mod` timestamp null ,
  primary key (`acit_id`, `pac_id`, `cprog_id`) ,
  constraint `fk_agendar_cita_cita_programada1`
    foreign key (`cprog_id` , `pac_id` )
    references  `cita_programada` (`cprog_id` , `pac_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `fecha`
-- -----------------------------------------------------
create  table if not exists  `fecha` (
  `fecha_id` date not null ,
  `fecha_est_log` varchar(1) null ,
  `fecha_fec_cre` timestamp null default current_timestamp ,
  `fecha_fec_mod` timestamp null ,
  primary key (`fecha_id`) )
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `horario_medico`
-- -----------------------------------------------------
create  table if not exists  `horario_medico` (
  `hmed_id` bigint(20) not null auto_increment ,
  `emp_id` bigint(20) not null ,
  `emed_id` bigint(20) not null ,
  `hmed_dias` int(3) null ,
  `hmed_hora_inicio` time null ,
  `hmed_hora_fin` time null ,
  `hmed_fraccion_hora` time null ,
  `hmed_motivo` blob null ,
  `hmed_est_log` varchar(1) null ,
  `hmed_fec_cre` timestamp null default current_timestamp ,
  `hmed_fec_mod` timestamp null ,
  primary key (`hmed_id`) ,
  constraint `fk_horario_medico_empresa1`
    foreign key (`emp_id` )
    references  `empresa` (`emp_id` )
    on delete no action
    on update no action,
  constraint `fk_horario_medico_especialidad_medico1`
    foreign key (`emed_id` )
    references  `especialidad_medico` (`emed_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `centro_atencion`
-- -----------------------------------------------------
create  table if not exists  `centro_atencion` (
  `cate_id` bigint(20) not null auto_increment ,
  `emp_id` bigint(20) not null ,
  `cate_nombre` varchar(50) null ,
  `cate_direccion` varchar(100) null ,
  `cate_telefono` varchar(20) null ,
  `cate_correo` varchar(60) null ,
  `cate_hora_inicio` time null ,
  `cate_hora_fin` time null ,
  `cate_est_log` varchar(1) null ,
  `cate_fec_cre` timestamp null default current_timestamp ,
  `cate_fec_mod` timestamp null ,
  primary key (`cate_id`) ,
  constraint `fk_centro_atencion_empresa1`
    foreign key (`emp_id` )
    references  `empresa` (`emp_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `oficina`
-- -----------------------------------------------------
create  table if not exists  `oficina` (
  `ofi_id` bigint(20) not null auto_increment ,
  `ofi_nombre` varchar(50) null ,
  `ofi_est_log` varchar(1) null ,
  `ofi_fec_cre` timestamp null default current_timestamp ,
  `ofi_fec_mod` timestamp null ,
  primary key (`ofi_id`) )
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `consultorio`
-- -----------------------------------------------------
create  table if not exists  `consultorio` (
  `cons_id` bigint(20) not null auto_increment ,
  `cate_id` bigint(20) not null ,
  `esp_id` bigint(20) not null ,
  `ofi_id` bigint(20) not null ,
  `cons_nombre` varchar(50) null ,
  `cons_telefono` varchar(20) null ,
  `cons_correo` varchar(60) null ,
  `cons_hora_inicio` time null ,
  `cons_hora_fin` time null ,
  `cons_tiempo_consulta` time null ,
  `cons_est_log` varchar(1) null ,
  `cons_fec_cre` timestamp null default current_timestamp ,
  `cons_fec_mod` timestamp null ,
  primary key (`cons_id`) ,
  constraint `fk_consultorio_centro_atencion1`
    foreign key (`cate_id` )
    references  `centro_atencion` (`cate_id` )
    on delete no action
    on update no action,
  constraint `fk_consultorio_especialidad1`
    foreign key (`esp_id` )
    references  `especialidad` (`esp_id` )
    on delete no action
    on update no action,
  constraint `fk_consultorio_oficina1`
    foreign key (`ofi_id` )
    references  `oficina` (`ofi_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `horario`
-- -----------------------------------------------------
create  table if not exists  `horario` (
  `hora_id` time not null ,
  `fecha_id` date not null ,
  `cons_id` bigint(20) not null ,
  `hmed_id` bigint(20) not null ,
  `hora_inicio` time null ,
  `hora_fin` time null ,
  `hora_est_log` varchar(1) null ,
  `hora_fec_cre` timestamp null default current_timestamp ,
  `hora_fec_mod` timestamp null ,
  primary key (`hora_id`, `fecha_id`, `cons_id`) ,
  constraint `fk_horario_fecha1`
    foreign key (`fecha_id` )
    references  `fecha` (`fecha_id` )
    on delete no action
    on update no action,
  constraint `fk_horario_horario_medico1`
    foreign key (`hmed_id` )
    references  `horario_medico` (`hmed_id` )
    on delete no action
    on update no action,
  constraint `fk_horario_consultorio1`
    foreign key (`cons_id` )
    references  `consultorio` (`cons_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `turno`
-- -----------------------------------------------------
create  table if not exists  `turno` (
  `tur_id` bigint(20) not null auto_increment ,
  `tur_numero` int(5) not null ,
  `fecha_id` date not null ,
  `emed_id` bigint(20) not null ,
  `tur_nombre` varchar(60) null ,
  `tur_sobreturno` varchar(45) null default 'norma,entreturno,sobreturno' ,
  `tur_est_log` varchar(1) null ,
  `tur_fec_cre` timestamp null default current_timestamp ,
  `tur_fec_mod` timestamp null ,
  primary key (`tur_id`, `tur_numero`) ,
  constraint `fk_turno_fecha1`
    foreign key (`fecha_id` )
    references  `fecha` (`fecha_id` )
    on delete no action
    on update no action,
  constraint `fk_turno_especialidad_medico1`
    foreign key (`emed_id` )
    references  `especialidad_medico` (`emed_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `cita_medica`
-- -----------------------------------------------------
create  table if not exists  `cita_medica` (
  `cmde_id` bigint(20) not null auto_increment ,
  `acit_id` bigint(20) not null ,
  `pac_id` bigint(20) not null ,
  `cprog_id` bigint(20) not null ,
  `tcon_id` bigint(20) not null ,
  `hora_id` time not null ,
  `fecha_id` date not null ,
  `cons_id` bigint(20) not null ,
  `tur_id` bigint(20) not null ,
  `tur_numero` int(5) not null ,
  `cmde_motivo` blob null ,
  `cmde_observacion` blob null ,
  `cmde_estado_asistencia` varchar(1) null ,
  `cmde_est_log` varchar(1) null ,
  `cmde_fec_cre` timestamp null default current_timestamp ,
  `cmde_fec_mod` timestamp null ,
  primary key (`cmde_id`, `acit_id`, `pac_id`, `cprog_id`, `hora_id`, `fecha_id`, `cons_id`, `tur_id`, `tur_numero`) ,
  constraint `fk_cita_medica_agendar_cita1`
    foreign key (`acit_id` , `pac_id` , `cprog_id` )
    references  `agendar_cita` (`acit_id` , `pac_id` , `cprog_id` )
    on delete no action
    on update no action,
  constraint `fk_cita_medica_horario1`
    foreign key (`hora_id` , `fecha_id` , `cons_id` )
    references  `horario` (`hora_id` , `fecha_id` , `cons_id` )
    on delete no action
    on update no action,
  constraint `fk_cita_medica_turno1`
    foreign key (`tur_id` , `tur_numero` )
    references  `turno` (`tur_id` , `tur_numero` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

alter table `cita_medica`
add constraint `fk_cita_medica_001` foreign key (`tcon_id`) references `tipo_consulta`(`tcon_id`);


-- -----------------------------------------------------
-- table  `signos_vitales`
-- -----------------------------------------------------
create  table if not exists  `signos_vitales` (
  `svit_id` bigint(20) not null auto_increment ,
  `cmde_id` bigint(20) not null ,
  `svit_peso` decimal(5,2) null ,
  `svit_talla` decimal(5,2) null ,
  `svit_temperatura` decimal(5,2) null ,
  `svit_temperatura_axilar` decimal(5,2) null ,
  `svit_presion_arteriar` decimal(5,2) null ,
  `svit_frecuencia_respiratoria` decimal(5,2) null ,
  `svit_frecuencia_cardiaca` decimal(5,2) null ,
  `svit_observacion` blob null ,
  `svit_est_log` varchar(1) null ,
  `svit_fec_cre` timestamp null default current_timestamp ,
  `svit_fec_mod` timestamp null ,
  primary key (`svit_id`) ,
  constraint `fk_signos_vitales_cita_medica1`
    foreign key (`cmde_id` )
    references  `cita_medica` (`cmde_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `tipo_dicom`
-- -----------------------------------------------------
create  table if not exists  `tipo_dicom` (
  `tdic_id` bigint(20) not null auto_increment ,
  `tdic_nomenclatura` varchar(5) null ,
  `tdic_detalle` varchar(100) null ,
  `tdic_est_log` varchar(1) null ,
  `tdic_fec_cre` timestamp null default current_timestamp ,
  `tdic_fec_mod` timestamp null ,
  primary key (`tdic_id`) )
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `dicom`
-- -----------------------------------------------------
create  table if not exists  `dicom` (
  `dic_id` bigint(20) not null auto_increment ,
  `tdic_id` bigint(20) not null ,
  `dic_size` decimal(10,2) null ,
  `dic_ruta` varchar(80) null ,
  `dic_est_log` varchar(1) null ,
  `dic_fec_cre` timestamp null default current_timestamp ,
  `dic_fec_mod` timestamp null ,
  primary key (`dic_id`) ,
  constraint `fk_dicom_tipo_dicom1`
    foreign key (`tdic_id` )
    references  `tipo_dicom` (`tdic_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `session`
-- -----------------------------------------------------

create  table if not exists `session` (
  `id` varchar(40) not null ,
  `expire` bigint(20) null ,
  `data` blob null ,
  primary key (`id`) )
engine=innodb  default charset=utf8 auto_increment=1;


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
`upas_id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
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
create  table if not exists  `aplicacion` (
  `apl_id` bigint(20) not null auto_increment ,
  `apl_nombre` varchar(50) null ,
  `apl_tipo` varchar(45) null ,
  `apl_lang_file` varchar(100) null ,
  `apl_est_log` varchar(1) null ,
  `apl_fec_cre` timestamp null default current_timestamp ,
  `apl_fec_mod` timestamp null ,
  primary key (`apl_id`) )
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `modulo`
-- -----------------------------------------------------
create  table if not exists  `modulo` (
  `mod_id` bigint(20) not null auto_increment ,
  `apl_id` bigint(20) not null ,
  `mod_nombre` varchar(50) null ,  
  `mod_dir_imagen` varchar(100) DEFAULT NULL,
  `mod_url` varchar(100) null ,
  `mod_orden` bigint(2) default null,
  `mod_lang_file` varchar(60) default null,
  `mod_estado_activo` varchar(1) not null,
  `mod_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `mod_estado_logico` varchar(1) NOT NULL,
  primary key (`mod_id`) ,
  constraint `fk_modulo_aplicacion1`
    foreign key (`apl_id` )
    references  `aplicacion` (`apl_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `objeto_modulo`
-- -----------------------------------------------------
create  table if not exists  `objeto_modulo` (
  `omod_id` bigint(20) not null auto_increment ,
  `mod_id` bigint(20) not null ,
  `omod_padre_id` bigint(20) default null ,
  `omod_nombre` varchar(50) default null ,
  `omod_tipo` varchar(60) default null ,
  `omod_tipo_boton` varchar(1) default null ,
  `omod_accion` varchar(50) default null ,
  `omod_function` varchar(100) default null ,
  `omod_dir_imagen` varchar(100) DEFAULT NULL,
  `omod_entidad` varchar(100) default null ,
  `omod_orden` bigint(2) default null ,
  `omod_estado_visible` int(1) default null ,
  `omod_lang_file` varchar(60) default null ,
  `omod_estado_activo` varchar(1) not null,
  `omod_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `omod_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `omod_estado_logico` varchar(1) NOT NULL,
  primary key (`omod_id`) ,
  constraint `fk_objeto_modulo_modulo1`
    foreign key (`mod_id` )
    references  `modulo` (`mod_id` )
    on delete no action
    on update no action,
  constraint `fk_objeto_modulo_objeto_modulo1`
    foreign key (`omod_padre_id` )
    references  `objeto_modulo` (`omod_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `usuario_empresa`
-- -----------------------------------------------------
create  table if not exists  `usuario_empresa` (
  `uemp_id` bigint(20) not null auto_increment ,
  `usu_id` bigint(20) not null ,
  `rol_id` bigint(20) not null ,
  `emp_id` bigint(20) not null ,
  `uemp_est_log` varchar(1) null ,
  `uemp_fec_cre` timestamp null default current_timestamp ,
  `uemp_fec_mod` timestamp null ,
  primary key (`uemp_id`) ,
  constraint `fk_usuario_rol_usuario1`
    foreign key (`usu_id` )
    references  `usuario` (`usu_id` )
    on delete no action
    on update no action,
  constraint `fk_usuario_rol_rol1`
    foreign key (`rol_id` )
    references  `rol` (`rol_id` )
    on delete no action
    on update no action,
  constraint `fk_usuario_empresa_empresa1`
    foreign key (`emp_id` )
    references  `empresa` (`emp_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;

-- -----------------------------------------------------
-- table  `omodulo_rol`
-- -----------------------------------------------------
create  table if not exists  `omodulo_rol` (
  `omrol_id` bigint(20) not null auto_increment ,
  `omod_id` bigint(20) not null ,
  `rol_id` bigint(20) not null ,
  `omrol_est_log` varchar(1) null ,
  `omrol_fec_cre` timestamp null default current_timestamp ,
  `omrol_fec_mod` timestamp null ,
  primary key (`omrol_id`) ,
  constraint `fk_omodulo_rol_objeto_modulo1`
    foreign key (`omod_id` )
    references  `objeto_modulo` (`omod_id` )
    on delete no action
    on update no action,
  constraint `fk_omodulo_rol_rol1`
    foreign key (`rol_id` )
    references  `rol` (`rol_id` )
    on delete no action
    on update no action)
engine=innodb  default charset=utf8 auto_increment=1;




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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

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