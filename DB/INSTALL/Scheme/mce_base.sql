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
-- Base de datos: `MCE_BASE`
--
DROP DATABASE IF EXISTS `mce_base`;
CREATE DATABASE IF NOT EXISTS `mce_base` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON `mce_base`.* TO 'mceuser' IDENTIFIED BY 'mcesoft20234015';
GRANT ALL PRIVILEGES ON `mce_base`.* TO 'mceuser'@'localhost' IDENTIFIED BY 'mcesoft20234015';
USE `mce_base`;



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



-- --------------------------------------------------------

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



-- --------------------------------------------------------

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
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `per_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `per_nombres` varchar(100) DEFAULT NULL,
  `per_apellidos` varchar(100) DEFAULT NULL,
  `per_cedula` varchar(20) DEFAULT NULL,
  `per_ruc` varchar(20) DEFAULT NULL,
  `per_pasaporte` varchar(20) DEFAULT NULL,
  `per_fecha_nacimiento` date DEFAULT NULL,
  `per_direccion` varchar(45) DEFAULT NULL,
  `per_telefono` varchar(50) DEFAULT NULL,
  `pai_id` bigint(20) DEFAULT NULL,
  `prov_id` bigint(20) DEFAULT NULL,
  `can_id` bigint(20) DEFAULT NULL,
  `per_celular` varchar(50) DEFAULT NULL,
  `per_genero` varchar(45) DEFAULT NULL,
  `per_estado_civil` varchar(10) DEFAULT 'S',
  `per_correo` varchar(100) DEFAULT NULL,
  `per_foto` varchar(100) DEFAULT NULL,
  `per_estado_activo` varchar(1) NOT NULL,
  `per_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `per_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `per_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (pai_id) REFERENCES `pais`(`pai_id`),
  FOREIGN KEY (prov_id) REFERENCES `provincia`(`prov_id`),
  FOREIGN KEY (can_id) REFERENCES `canton`(`can_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE IF NOT EXISTS `configuracion` (
  `con_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `con_variable` varchar(200) DEFAULT NULL,
  `con_valor` varchar(200) DEFAULT NULL,
  `emp_estado_activo` varchar(1) DEFAULT NULL,
  `emp_fecha_creacion` timestamp NULL DEFAULT NULL,
  `emp_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `emp_estado_logico` varchar(1) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;




-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USUARIO`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `usu_id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `per_id` bigint(20) DEFAULT NULL,
  `usu_username` varchar(45) DEFAULT NULL,
  `usu_password` varchar(255) DEFAULT NULL,
  `usu_sha` varchar(255),
  `usu_session` varchar(255) DEFAULT NULL,
  `usu_last_login` timestamp NULL DEFAULT NULL,
  `usu_link_activo` text NULL DEFAULT NULL,
  `usu_estado_activo` varchar(1) NOT NULL,
  `usu_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usu_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `usu_estado_logico` varchar(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_password`
--

CREATE TABLE IF NOT EXISTS `tipo_password` (
  `tpas_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tpas_tipo` varchar(50) DEFAULT NULL,
  `tpas_validacion` varchar(200) DEFAULT NULL,
  `tpas_descripcion` varchar(300) DEFAULT NULL,
  `tpas_estado_activo` varchar(1) NOT NULL,
  `tpas_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tpas_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `tpas_estado_logico` varchar(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_cuenta`
--

CREATE TABLE IF NOT EXISTS `configuracion_cuenta` (
  `ccue_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `usu_id` bigint(20) NOT NULL,
  `idi_id` bigint(20) NOT NULL,
  `ccue_descripcion` varchar(200) DEFAULT NULL,
  `ccue_estado_activo` varchar(1) NOT NULL,
  `ccue_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ccue_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `ccue_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (usu_id) REFERENCES `usuario`(usu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `rol_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `rol_nombre` varchar(50) DEFAULT NULL,
  `rol_descripcion` varchar(45) DEFAULT NULL,
  `rol_estado_activo` varchar(1) NOT NULL,
  `rol_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rol_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `rol_estado_logico` varchar(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



-- --------------------------------------------------------

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


-- --------------------------------------------------------

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE IF NOT EXISTS `modulo` (
  `mod_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `mod_nombre` varchar(50) DEFAULT NULL,
  `mod_dir_imagen` varchar(100) DEFAULT NULL,
  `mod_url` varchar(100) DEFAULT NULL,
  `mod_orden` bigint(2) DEFAULT NULL,
  `mod_lang_file` varchar(60) DEFAULT NULL,
  `mod_estado_activo` varchar(1) NOT NULL,
  `mod_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `mod_estado_logico` varchar(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objeto_modulo`
--

CREATE TABLE IF NOT EXISTS `objeto_modulo` (
  `omod_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `mod_id` bigint(20) NOT NULL,
  `omod_padre_id` bigint(20) DEFAULT NULL,
  `omod_nombre` varchar(50) DEFAULT NULL,
  `omod_tipo` varchar(45) DEFAULT NULL,
  `omod_tipo_boton` varchar(1) DEFAULT NULL,
  `omod_accion` varchar(50) DEFAULT NULL,
  `omod_function` varchar(100) DEFAULT NULL,
  `omod_dir_imagen` varchar(100) DEFAULT NULL,
  `omod_entidad` varchar(45) DEFAULT NULL,
  `omod_orden` bigint(2) DEFAULT NULL,
  `omod_estado_visible` varchar(1) DEFAULT NULL,
  `omod_lang_file` varchar(60) DEFAULT NULL,
  `omod_estado_activo` varchar(1) NOT NULL,
  `omod_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `omod_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `omod_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (mod_id) REFERENCES `modulo`(mod_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accion`
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
-- Estructura de tabla para la tabla `obmo_acci`
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



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grup_obmo`
--

CREATE TABLE IF NOT EXISTS `grup_obmo` (
  `gmod_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `gru_id` bigint(20) NOT NULL,
  `omod_id` bigint(20) NOT NULL,
  `gmod_estado_activo` varchar(1) NOT NULL,
  `gmod_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmod_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `gmod_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (gru_id) REFERENCES `grupo`(gru_id), -- @TODO:  no estaba esta referencia
  FOREIGN KEY (omod_id) REFERENCES `objeto_modulo`(omod_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grup_obmo_grup_rol`
--

CREATE TABLE IF NOT EXISTS `grup_obmo_grup_rol` (
  `gogr_id` bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `grol_id` bigint(20) NOT NULL,
  `gmod_id` bigint(20) NOT NULL,
  `gogr_estado_activo` varchar(1) NOT NULL,
  `gogr_fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gogr_fecha_modificacion` timestamp NULL DEFAULT NULL,
  `gogr_estado_logico` varchar(1) NOT NULL,
  FOREIGN KEY (grol_id) REFERENCES `grupo_rol`(grol_id),
  FOREIGN KEY (gmod_id) REFERENCES `grup_obmo`(gmod_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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


CREATE TABLE session (
    `id` varchar(40) NOT NULL PRIMARY KEY,
    `expire` bigint(20),
    `data` BLOB
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE INDEX `idx_session_expire` ON `session` (`expire`);



-- Datos del modelo MCE

CREATE  TABLE IF NOT EXISTS `mce_registro` (
  `reg_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `usu_id` BIGINT(20) NOT NULL ,
  `reg_estado` INT(1) NOT NULL DEFAULT '1',
  `reg_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `reg_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL,
  `reg_estado_logico` INT(1) NOT NULL,
   FOREIGN KEY(usu_id) REFERENCES `usuario`(usu_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_objetivo` (
  `obj_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `obj_nombre` VARCHAR(60) NOT NULL ,
  `obj_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `obj_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL,
  `obj_estado_logico` INT(1) NOT NULL )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_sub_objetivo` (
  `sobj_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `obj_id` BIGINT(20) NOT NULL ,
  `sobj_nombre` VARCHAR(60) NULL ,
  `sobj_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `sobj_fecha_modificacion` TIMESTAMP NULL ,
  `sobj_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (obj_id) REFERENCES `mce_objetivo` (obj_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_uso_marca` (
  `umar_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `umar_nombre` VARCHAR(50) NOT NULL ,
  `umar_detalle` TEXT NOT NULL ,
  `umar_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `umar_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL,
  `umar_estado_logico` INT(1) NOT NULL )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_otros_usos` (
  `ous_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `ous_nombre` VARCHAR(50) NOT NULL ,
  `ous_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ous_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL,
  `ous_estado_logico` INT(1) NOT NULL )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_industria` (
  `ind_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `ind_giro` VARCHAR(50) NOT NULL ,
  `ind_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ind_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL,
  `ind_estado_logico` INT(1) NOT NULL  )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_formulario` (
  `form_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `usu_id` BIGINT(20) NOT NULL,
  `obj_id` BIGINT(20) NOT NULL,
  `can_id` BIGINT(20) NOT NULL ,
  `reg_id` BIGINT(20) NOT NULL ,
  `ind_id` BIGINT(20) NOT NULL ,
  `umar_id` BIGINT(20) NOT NULL ,
  `doc_numero` VARCHAR(10) NOT NULL ,
  `form_condiciones` INT(1) NULL ,
  `form_origen` INT(2) NULL ,
  `form_personeria` INT(2) NULL ,
  `form_nombre` VARCHAR(60) NULL ,
  `form_apellido` VARCHAR(60) NULL ,
  `form_cedula` VARCHAR(15) NULL ,
  `form_ruc` VARCHAR(15) NULL ,  
  `form_direccion` VARCHAR(60) NULL ,
  `form_sitio_web` VARCHAR(80) NULL ,
  `form_contacto` VARCHAR(100) NULL ,
  `form_cargo_persona` VARCHAR(60) NULL ,
  `form_contacto_cargo` VARCHAR(60) NULL ,
  `form_contacto_correo` VARCHAR(60) NULL ,
  `form_contacto_telefono` VARCHAR(15) NULL ,
  `pai_id_ext` BIGINT(20) NULL ,
  `form_ciudad_ext` VARCHAR(60) NULL ,
  `form_exporta_servicio` VARCHAR(1) NULL ,
  `form_definicion_sector` TEXT NULL ,
  `form_correo` VARCHAR(60) NULL ,
  `form_telefono` VARCHAR(15) NULL ,
  `form_genero` INT(1) NULL ,
  `form_raza_etnica` INT(1) NULL ,
  `form_tipo_pyme` INT(1) NULL ,
  `form_cedula_file` VARCHAR(100) NULL ,
  `form_ruc_file` VARCHAR(100) NULL ,
  `form_trayectoria` VARCHAR(3) NULL ,
  `form_cert_votacion_file` VARCHAR(100) NULL ,
  `form_trayectoria_file` VARCHAR(100) NULL ,
  `form_decl_jurada_file` VARCHAR(100) NULL ,
  `form_giroprincipal` TEXT NULL ,
  `form_vision` TEXT NULL ,
  `form_mision` TEXT NULL ,
  `form_referencia` TEXT NULL ,
  `form_detalle` TEXT NULL ,
  `form_registro_sanitario_file` VARCHAR(100) NULL ,
  `form_perm_func_mitur_file` VARCHAR(100) NULL ,
  `form_cert_super_compania_file` VARCHAR(100) NULL ,  
  `form_imp_renta_file` VARCHAR(100) NULL ,
  `form_cert_obligaciones_file` VARCHAR(100) NULL ,
  `form_razon_social` VARCHAR(60) NULL ,
  `form_estado` INT(1) NULL ,
  `form_fecha_envio` TIMESTAMP NULL ,
  `form_fecha_contrato` TIMESTAMP NULL DEFAULT NULL ,
  `form_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `form_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `form_estado_logico` INT(1) NOT NULL ,
  `ftem_id` BIGINT(20) NOT NULL,
  FOREIGN KEY(usu_id) REFERENCES `usuario`(usu_id),
  FOREIGN KEY(obj_id) REFERENCES `mce_objetivo`(obj_id),
  FOREIGN KEY(can_id) REFERENCES `canton`(can_id),
  FOREIGN KEY(reg_id) REFERENCES `mce_registro`(reg_id),
  FOREIGN KEY(umar_id) REFERENCES `mce_uso_marca`(umar_id),
  FOREIGN KEY(ind_id) REFERENCES `mce_industria`(ind_id) )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_mensajes` (
  `mens_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `form_id` BIGINT(20) NOT NULL ,
  `mens_mensaje` TEXT NULL ,
  `mens_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `mens_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `mens_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY(form_id) REFERENCES `mce_formulario`(form_id) )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_visita` (
  `visi_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `form_id` BIGINT(20) NOT NULL ,
  `visi_observacion` TEXT NULL ,
  `visi_entrevistado` VARCHAR(80) NULL ,
  `visi_telefono` VARCHAR(80) NULL ,
  `visi_foto1` VARCHAR(150) NULL ,
  `visi_foto2` VARCHAR(150) NULL ,
  `visi_foto3` VARCHAR(150) NULL ,
  `visi_foto4` VARCHAR(150) NULL ,
  `visi_foto5` VARCHAR(150) NULL ,
  `visi_fecha_visita` TIMESTAMP NULL DEFAULT NULL ,
  `visi_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `visi_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `visi_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (form_id) REFERENCES `mce_formulario` (form_id) )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_marca_lugar` (
  `mlu_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `form_id` BIGINT(20) NOT NULL ,
  `pai_id` BIGINT(20) NOT NULL ,
  `prov_id` BIGINT(20) NOT NULL ,
  `mlu_fecha` TIMESTAMP NULL ,
  `mlu_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `mlu_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `mlu_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (form_id) REFERENCES `mce_formulario` (form_id),
  FOREIGN KEY (pai_id) REFERENCES `pais` (pai_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_evento` (
  `eve_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `form_id` BIGINT(20) NOT NULL ,
  `eve_nombre` VARCHAR(50) NULL ,
  `eve_descripcion` TEXT NULL ,
  `eve_referencia` VARCHAR(60) NULL ,
  `eve_fecha` TIMESTAMP NULL ,
  `eve_lugar` VARCHAR(100) NULL ,
  `eve_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `eve_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `eve_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (form_id) REFERENCES `mce_formulario` (form_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_porcentaje` (
  `por_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `por_nombre` VARCHAR(50) NULL ,
  `por_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `por_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `por_estado_logico` INT(1) NOT NULL  )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_producto` (
  `pro_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `por_id` BIGINT(20) NOT NULL ,
  `form_id` BIGINT(20) NOT NULL ,
  `pro_nombre` VARCHAR(50) NULL ,
  `pro_foto` VARCHAR(60) NULL ,
  `pro_envase` VARCHAR(1) NULL,
  `pro_empaque` VARCHAR(1) NULL,
  `pro_etiqueta` VARCHAR(1) NULL,
  `pro_publicidad` VARCHAR(1) NULL,
  `pro_otros` VARCHAR(1) NULL,
  `pro_detalle_uso` TEXT NULL ,
  `pro_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `pro_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `pro_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (por_id) REFERENCES `mce_porcentaje` (por_id),
  FOREIGN KEY (form_id) REFERENCES `mce_formulario` (form_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_otros_usos_marca` (
  `ouma_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `ous_id` BIGINT(20) NOT NULL ,
  `form_id` BIGINT(20) NOT NULL ,
  `ouma_fecha_creacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  `ouma_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `ouma_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (ous_id) REFERENCES `mce_otros_usos` (ous_id),
  FOREIGN KEY (form_id) REFERENCES `mce_formulario` (form_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_formulario_temp` (
  `ftem_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `obj_id` BIGINT(20) NOT NULL ,
  `can_id` BIGINT(20) NOT NULL ,
  `reg_id` BIGINT(20) NOT NULL ,
  `ind_id` BIGINT(20) NOT NULL ,
  `umar_id` BIGINT(20) NOT NULL ,
  `doc_numero` VARCHAR(10) NOT NULL ,
  `ftem_condiciones` INT(1) NULL ,
  `ftem_origen` INT(2) NULL ,
  `ftem_personeria` INT(2) NULL ,
  `ftem_nombre` VARCHAR(60) NULL ,
  `ftem_apellido` VARCHAR(60) NULL ,
  `ftem_cedula` VARCHAR(15) NULL ,
  `ftem_ruc` VARCHAR(15) NULL ,
  `ftem_direccion` VARCHAR(60) NULL ,
  `ftem_sitio_web` VARCHAR(80) NULL ,
  `ftem_cargo_persona` VARCHAR(60) NULL ,
  `ftem_contacto` VARCHAR(100) NULL ,
  `ftem_contacto_cargo` VARCHAR(60) NULL ,
  `ftem_contacto_correo` VARCHAR(60) NULL ,
  `ftem_contacto_telefono` VARCHAR(15) NULL ,
  `pai_id_ext` BIGINT(20) NULL ,
  `ftem_ciudad_ext` VARCHAR(60) NULL ,
  `ftem_exporta_servicio` VARCHAR(2) NULL ,
  `ftem_definicion_sector` TEXT NULL ,
  `ftem_correo` VARCHAR(60) NULL ,
  `ftem_telefono` VARCHAR(15) NULL ,
  `ftem_genero` INT(1) NULL ,
  `ftem_raza_etnica` INT(1) NULL ,
  `ftem_tipo_pyme` INT(1) NULL ,
  `ftem_cedula_file` VARCHAR(100) NULL ,
  `ftem_ruc_file` VARCHAR(100) NULL ,
  `ftem_cert_file` VARCHAR(100) NULL ,
  `ftem_trayectoria` VARCHAR(3) NULL ,
  `ftem_decl_jurada_file` VARCHAR(100) NULL ,
  `ftem_trayectoria_file` VARCHAR(100) NULL ,
  `ftem_giroprincipal` TEXT NULL ,
  `ftem_vision` TEXT NULL ,
  `ftem_mision` TEXT NULL ,
  `ftem_referencia` TEXT NULL ,
  `ftem_detalle` TEXT NULL ,
  `ftem_registro_sanitario_file` VARCHAR(100) NULL ,
  `ftem_perm_func_mitur_file` VARCHAR(100) NULL ,
  `ftem_cert_super_compania_file` VARCHAR(100) NULL ,  
  `ftem_imp_renta_file` VARCHAR(100) NULL ,
  `ftem_cert_obligaciones_file` VARCHAR(100) NULL ,
  `ftem_razon_social` VARCHAR(60) NULL ,
  `ftem_estado` INT(1) NULL ,
  `ftem_fecha_envio` TIMESTAMP NULL ,
  `ftem_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,  
  `ftem_fecha_modificacion` TIMESTAMP NULL ,
  `ftem_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (obj_id) REFERENCES `mce_objetivo`(obj_id),
  FOREIGN KEY (can_id) REFERENCES `canton` (can_id),
  FOREIGN KEY (reg_id) REFERENCES `mce_registro` (reg_id),
  FOREIGN KEY(umar_id) REFERENCES `mce_uso_marca`(umar_id),
  FOREIGN KEY (ind_id) REFERENCES `mce_industria` (ind_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_marca_lugar_temp` (
  `mlte_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `pai_id` BIGINT(20) NOT NULL ,
  `ftem_id` BIGINT(20) NOT NULL ,
  `prov_id` BIGINT(20) NULL ,
  `mlte_fecha` TIMESTAMP NULL ,
  `mlte_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `mlte_fecha_modificacion` TIMESTAMP NULL ,
  `mlte_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (pai_id) REFERENCES `pais` (pai_id),
  FOREIGN KEY (ftem_id) REFERENCES `mce_formulario_temp` (ftem_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_evento_temp` (
  `etem_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY  ,
  `ftem_id` BIGINT(20) NOT NULL ,
  `etem_nombre` VARCHAR(50) NULL ,
  `etem_descripcion` TEXT NULL ,
  `etem_referencia` VARCHAR(60) NULL ,
  `etem_fecha` TIMESTAMP NULL ,
  `etem_lugar` VARCHAR(100) NULL ,
  `etem_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `etem_fecha_modificacion` TIMESTAMP NULL ,
  `etem_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (ftem_id) REFERENCES `mce_formulario_temp` (ftem_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_otros_usos_marca_temp` (
  `oumt_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `ftem_id` BIGINT(20) NOT NULL ,
  `ous_id` BIGINT(20) NOT NULL ,
  `oumt_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `oumt_fecha_modificacion` TIMESTAMP NULL ,
  `oumt_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (ous_id) REFERENCES `mce_otros_usos` (ous_id),
  FOREIGN KEY (ftem_id) REFERENCES `mce_formulario_temp` (ftem_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_producto_temp` (
  `ptem_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `por_id` BIGINT(20) NOT NULL ,
  `ftem_id` BIGINT(20) NOT NULL ,
  `ptem_nombre` VARCHAR(50) NULL ,
  `ptem_foto` VARCHAR(60) NULL ,
  `ptem_envase` VARCHAR(1) NULL ,
  `ptem_empaque` VARCHAR(1) NULL ,
  `ptem_etiqueta` VARCHAR(1) NULL ,
  `ptem_publicidad` VARCHAR(1) NULL ,
  `ptem_otros` VARCHAR(1) NULL ,
  `ptem_detalle_uso` TEXT NULL ,
  `ptem_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ptem_fecha_modificacion` TIMESTAMP NULL ,
  `ptem_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY (por_id) REFERENCES `mce_porcentaje` (por_id),
  FOREIGN KEY (ftem_id) REFERENCES `mce_formulario_temp` (ftem_id))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_correcion_temp` (
  `corr_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `usu_id` BIGINT(20) NOT NULL,
  `ftem_id` BIGINT(20) NOT NULL ,
  `corr_mensaje` TEXT NULL ,
  `corr_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `corr_fecha_modificacion` TIMESTAMP NULL DEFAULT NULL ,
  `corr_estado_logico` INT(1) NOT NULL ,
  FOREIGN KEY(usu_id) REFERENCES `usuario`(usu_id),
  FOREIGN KEY(ftem_id) REFERENCES `mce_formulario_temp`(ftem_id) )
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE  TABLE IF NOT EXISTS `mce_documento` (
  `doc_id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `doc_tipo` VARCHAR(3) NOT NULL ,
  `doc_numero` VARCHAR(10) NOT NULL ,
  `doc_nombre` TEXT NULL ,
  `doc_fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `doc_estado_logico` INT(1) NOT NULL)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
