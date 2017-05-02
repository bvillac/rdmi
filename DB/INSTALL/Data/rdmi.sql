USE `rdmi` ;

--
-- Volcar la base de datos para la tabla `accion`
--

INSERT INTO `accion` (`acc_id`, `acc_nombre`, `acc_url_accion`, `acc_tipo`, `acc_descripcion`, `acc_lang_file`, `acc_dir_imagen`, `acc_estado_activo`, `acc_fecha_creacion`, `acc_fecha_modificacion`, `acc_estado_logico`) VALUES
(1,'Create','Create','General','Create','accion','glyphicon glyphicon-file','1','2012-09-20 02:21:35',NULL,'1'),(2,'Update','Update','General','Update','accion','glyphicon glyphicon-edit','1','2012-09-20 02:21:35',NULL,'1'),(3,'Delete','Delete','General','Delete','accion','glyphicon glyphicon-trash','1','2012-09-20 02:21:35',NULL,'1'),(4,'Save','Save','General','Save','accion','glyphicon glyphicon-floppy-disk','1','2012-09-20 02:21:35',NULL,'1'),(5,'Search','Search','General','Search','accion','glyphicon glyphicon-search','1','2012-09-20 02:21:35',NULL,'1'),(6,'Print','Print','General','Print','accion','glyphicon glyphicon-print','1','2012-09-20 02:21:35',NULL,'1'),(7,'Import','Import','General','Import','accion','glyphicon glyphicon-import','1','2012-09-20 02:21:35',NULL,'1'),(8,'Export','Export','General','Export','accion','glyphicon glyphicon-export','1','2012-09-20 02:21:35',NULL,'1'),(9,'Back','Back','General','Back','accion','glyphicon glyphicon-triangle-right','1','2012-09-20 02:21:35',NULL,'1'),(10,'Next','Next','General','Next','accion','glyphicon glyphicon-triangle-left','1','2012-09-20 02:21:35',NULL,'1'),(11,'Clear','Clear','General','Clear','accion','glyphicon glyphicon-leaf','1','2012-09-20 02:21:35',NULL,'1');


--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` 
(`emp_id`, `emp_nombre`, `emp_ruc`, `emp_descripcion`, `emp_direccion`, `emp_telefono`, `emp_est_log`, `emp_fec_cre`, `emp_fec_mod`) VALUES
(1, 'Medical', '1310328405001', 'Imagenes Digitales', NULL, 'Colon', '1', '2016-03-03 02:47:47', NULL);

--
-- Volcar la base de datos para la tabla `persona`
--
INSERT INTO `persona` (`per_id`,`per_ced_ruc`,`per_nombre`,`per_apellido`,`per_genero`,`per_fecha_nacimiento`,`per_estado_civil`,`per_correo`,`per_tipo_sangre`,`per_foto`,`per_estado_activo`,`per_est_log`,`per_fec_cre`,`per_fec_mod`)VALUES 
(1,'1310328404','Byron','Villacreses','M','1981-07-19','S','admin@hotmail.com','O+',NULL,'1','1','2016-07-29 05:48:30',NULL),(2,'1310328404','Byron','Villacreses','M','1981-07-19','S','byron_villacresesf@hotmail.com','O+',NULL,'1','1','2016-07-29 05:48:30',NULL),(3,'0102042397','JOSE','MEDICO','M','2016-07-14','C','byron_vilacresesf@hotmail.com','B-',NULL,'1','1','2016-07-29 05:48:30',NULL),(4,'1400302061','DORIS','PACIENTE','F','2016-07-29','S','byron_villacresesf@hotmail.com','O+',NULL,'1','1','2016-07-29 05:48:30',NULL);

--
-- Volcar la base de datos para la tabla `usuario`
--

INSERT INTO `usuario`
(`usu_id`,`per_id`,`usu_username`,`usu_password`,`usu_sha`,`usu_session`,`usu_last_login`,`usu_link_activo`,
`usu_estado_activo`,`usu_alias`,`usu_est_log`,`usu_fec_cre`,`usu_fec_mod`)
VALUES
(1,1,'admin','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-08-24 03:21:04',NULL,'1',NULL,'1','2016-03-10 23:00:00',NULL),(2,2,'byron_villacresesf@hotmail.com','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-08-23 03:22:19','','1',NULL,'1','2016-03-16 08:54:51','2016-03-16 08:54:51'),(3,3,'byron_villa@hotmail.com','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-08-23 03:44:58','','1',NULL,'1','2016-07-22 10:35:30','0000-00-00 00:00:00'),(4,4,'byronvillacreses@gmail.com','nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL','f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx',NULL,'2016-08-24 04:44:36','','1',NULL,'1','2016-07-22 10:35:30',NULL);

--
-- Volcar la base de datos para la tabla `tipo_password`
--

INSERT INTO `tipo_password` (`tpas_id`, `tpas_tipo`, `tpas_validacion`, `tpas_descripcion`, `tpas_estado_activo`, `tpas_fecha_creacion`, `tpas_fecha_modificacion`, `tpas_estado_logico`) VALUES
(1, 'Simples', '/^(?=.*[a-z])(?=.*[A-Z]).{VAR,}$/', 'Las claves simples deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas).', '1', '2012-08-28 15:00:00', '2012-08-28 15:00:00', '1'),
(2, 'Semicomplejas', '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{VAR,}$/', 'Las claves semicomplejas deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas). ', '1', '2012-08-29 02:57:58', '2012-08-29 02:57:58', '1'),
(3, 'Complejas', '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\\,\\;#¿\\?\\}\\{\\]\\[\\-_¡!\\=&\\^:<>\\.\\+\\*\\/\\$\\(\\)]).{VAR,}$/', 'Las claves complejas deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas).\nSímbolos: @ ,  ; # ¿ ? }  {  ]  [ - _ ¡  ! = & ^ : < > . + * / ( )', '1', '2012-08-29 02:57:58', '2012-08-29 02:57:58', '1');

--
-- Volcar la base de datos para la tabla `rol`
--

INSERT INTO `rol`
(`rol_id`,`rol_nombre`,`rol_descripcion`,`rol_estado_activo`,`rol_fecha_creacion`,`rol_fecha_modificacion`,`rol_estado_logico`)VALUES
(1,'Administrador','Descripción','1','2012-09-03 20:00:00',NULL,'1'),
(2,'Usuario','Descripción','1','2012-09-03 20:00:00',NULL,'1'),
(3,'Medico','Descripción','1','2016-08-03 06:02:34',NULL,'1'),
(4,'Paciente','Descripción','1','2016-08-03 06:02:34',NULL,'1');

--
-- Volcado de datos para la tabla `usuario_empresa`
--

INSERT INTO `usuario_empresa`
(`uemp_id`,`usu_id`,`rol_id`,`emp_id`,`uemp_est_log`,`uemp_fec_cre`,`uemp_fec_mod`)VALUES
(1,1,1,1,'1','2016-03-03 07:50:58',NULL),
(2,3,3,1,'1','2016-08-03 06:07:30',NULL),
(3,4,4,1,'1','2016-08-03 06:07:30',NULL);

--
-- Volcado de datos para la tabla `aplicacion`
--

INSERT INTO `aplicacion` (`apl_id`, `apl_nombre`, `apl_tipo`, `apl_lang_file`, `apl_est_log`, `apl_fec_cre`, `apl_fec_mod`) VALUES
(1, 'Repositorio Digital', '1', NULL, '1', '2016-03-02 19:19:43', NULL);

--
-- Volcar la base de datos para la tabla `modulo`
--
INSERT INTO `modulo` (`mod_id`, `apl_id`, `mod_nombre`, `mod_dir_imagen`, `mod_url`, `mod_orden`, `mod_lang_file`, `mod_estado_activo`, `mod_fecha_creacion`, `mod_fecha_modificacion`, `mod_estado_logico`) VALUES
(1,1,'Dashboard','fa fa-dashboard','site/index',1,'application','1','2012-08-26 11:47:23',NULL,'1'),
(2,1,'My Account','glyphicon glyphicon-user','perfil/index',2,'menu','1','2012-08-26 11:47:23',NULL,'1'),
(3,1,'My Forms','glyphicon glyphicon-list-alt','mceformulariotemp/index',3,'application','1','2012-08-26 11:47:23',NULL,'1'),(4,1,'Processes','glyphicon glyphicon-th-large','perfil/index',4,'application','1','2012-08-26 11:47:23',NULL,'1'),
(5,1,'Images','glyphicon glyphicon-picture','site/index',5,'application','1','2016-03-18 10:09:10',NULL,'1'),
(6,1,'Maintenance','glyphicon glyphicon-wrench','site/index',6,'application','1','2016-03-18 10:31:11',NULL,'1');

--
-- Volcar la base de datos para la tabla `objeto_modulo`
--

INSERT INTO `objeto_modulo` (`omod_id`, `mod_id`, `omod_padre_id`, `omod_nombre`, `omod_tipo`, `omod_tipo_boton`, `omod_accion`, `omod_function`, `omod_dir_imagen`, `omod_entidad`, `omod_orden`, `omod_estado_visible`, `omod_lang_file`, `omod_estado_activo`, `omod_fecha_creacion`, `omod_fecha_modificacion`, `omod_estado_logico`) VALUES
(1,1,1,'Dashboard','P','0','Applications','','','site/index',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),
(2,2,1,'My Account','P','0','Applications','','','perfil/index',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),
(3,3,1,'My Forms','P','0','Applications','','','mceformulario/autorizar',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(4,4,1,'Processes','P','0','Applications','','','mceformulario/view',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(5,5,1,'Images','P','0','Applications','','','mceformulario/message',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(6,6,1,'Maintenance','P','0','Applications','','','mceformulario/deletemessage',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(7,2,2,'Profile','S','0','My Account','','','perfil/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),
(8,2,2,'Save Profile','A','0','My Account','','','perfil/save',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),
(9,2,2,'Change Password','S','0','Applications','','','perfil/password',2,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),
(10,4,4,'Book Appointment','S','0','Applications','','','mceseguimiento/create',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(11,4,4,'Quote address','S','0','Applications','','','mceseguimiento/update',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(12,6,6,'Patient','S','0','Applications','','','paciente/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),(13,6,6,'Medico','S','0','Applications','','','medico/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),
(14,6,6,'Admin Medico','S','0','My Forms','','','medico/adminmedico',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),
(15,6,6,'Admin Paciente','S','0','My Forms','','','paciente/adminpaciente',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(16,3,14,'Create Form','A','0','My Forms','','','mceformulariotemp/create',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(17,3,14,'Update Form','A','0','My Forms','','','mceformulariotemp/update',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),
(18,3,14,'Save Form','A','0','My Forms','','','mceformulariotemp/save',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),
(19,3,14,'Brand Use','A','0','My Forms','','','mceformulariotemp/usomarca',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(20,3,14,'Upload File','A','0','My Forms','','','mceformulariotemp/uploadfile',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(21,3,14,'Download File','A','0','My Forms','','','mceformulariotemp/download',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(22,3,14,'View Message','A','0','My Forms','','','mceformulariotemp/viewmessage',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(23,3,14,'Pdf Application','A','0','My Forms','','','mceformulariotemp/solicitudpdf',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(24,1,1,'Search Application','A','0','Applications','','','mceformulario/buscarpersonas',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(25,1,1,'Pdf Application Sol','A','0','Applications','','','mceformulario/solicitudpdf',1,0,'application','1','2014-01-09 09:43:51',NULL,'1'),(26,4,26,'Profile','S','0','My Account','','','perfil/index',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1'),
(27,4,26,'Save Profile','A','0','My Account','','','perfil/save',1,0,'perfil','1','2014-01-09 09:43:51',NULL,'1');

--
-- Volcado de datos para la tabla `omodulo_rol`
--

INSERT INTO `omodulo_rol` (`omrol_id`, `omod_id`, `rol_id`, `omrol_est_log`, `omrol_fec_cre`, `omrol_fec_mod`) VALUES
(1,1,1,'1','2016-03-03 20:37:33',NULL),
(2,2,1,'1','2016-03-18 14:41:00',NULL),
(3,3,1,'1','2016-03-18 14:41:00',NULL),
(4,4,1,'1','2016-03-18 15:03:29',NULL),
(5,5,1,'1','2016-03-18 15:37:00',NULL),
(6,6,1,'1','2016-03-18 15:37:00',NULL),
(7,7,1,'1','2016-03-18 15:47:02',NULL),
(8,8,1,'1','2016-03-18 15:47:02',NULL),
(9,9,1,'1','2016-03-18 15:47:02',NULL),
(10,10,1,'1','2016-03-18 15:47:02',NULL),
(11,11,1,'1','2016-03-18 15:47:02',NULL),
(12,12,1,'1','2016-03-18 15:47:02',NULL),
(13,13,1,'1','2016-03-18 15:47:02',NULL),
(14,14,1,'1','2016-07-22 11:38:34',NULL),
(15,15,1,'1','2016-07-22 11:38:34',NULL),
(16,13,3,'1','2016-08-03 06:20:37',NULL),
(17,14,3,'1','2016-08-03 06:20:37',NULL),
(18,12,4,'1','2016-08-23 03:03:22',NULL),
(19,15,4,'1','2016-08-23 03:03:22',NULL);


--
-- Volcar la base de datos para la tabla `obmo_acci`
--

INSERT INTO `obmo_acci` 
(`oacc_id`, `omod_id`, `acc_id`, `oacc_tipo_boton`, `oacc_cont_accion`, `oacc_function`, `oacc_estado_activo`, `oacc_fecha_creacion`, `oacc_fecha_modificacion`, `oacc_estado_logico`) VALUES
(1, 1, 1, '5', NULL, 'alert()', '1', '2014-06-12 07:43:33', NULL, '1');

--
-- Volcar la base de datos para la tabla `tipo_consulta`
--

INSERT INTO `tipo_consulta` (`tcon_id`, `tcon_nombre`, `tcon_fec_cre`, `tcon_fec_mod`, `tcon_est_log`) VALUES
(1, 'Consulta', '2016-03-18 16:29:45', NULL, '1'),
(2, 'Imagenes', '2016-03-18 16:29:45', NULL, '1');

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`esp_id`, `esp_nombre`, `esp_nivel`, `esp_est_log`, `esp_fec_cre`, `esp_fec_mod`) VALUES
(1, 'ANATOMÍA PATOLÓGICA', NULL, '1', '2016-05-12 06:58:48', NULL),
(2, 'ANESTESIOLOGÍA', NULL, '1', '2016-05-12 06:58:48', NULL),
(3, 'ALERGOLOGIA', NULL, '1', '2016-05-12 06:58:48', NULL),
(4, 'CARDIOLOGÍA', NULL, '1', '2016-05-12 06:58:48', NULL),
(5, 'CARDIOLOGO/ ECOGRAFISTA', NULL, '1', '2016-05-12 06:58:48', NULL),
(6, 'CARDIOLOGÍA  HEMODINÁMICA', NULL, '1', '2016-05-12 06:58:48', NULL),
(7, 'CARDIOLOGÍA INFANTIL', NULL, '1', '2016-05-12 06:58:48', NULL),
(8, 'CIRUGÍA GENERAL LAPAROSCÓPICA', NULL, '1', '2016-05-12 06:58:48', NULL),
(9, 'CIRUGIA GENERAL', NULL, '1', '2016-05-12 06:58:48', NULL),
(10, 'CIRUGÍA ONCOLÓGICA', NULL, '1', '2016-05-12 06:58:48', NULL),
(11, 'DERMATOLOGIA', NULL, '1', '2016-05-12 06:58:48', NULL),
(12, 'ELECTROMIOGRAFÍA', NULL, '1', '2016-05-12 06:58:48', NULL),
(13, 'ENDOSCOPÍA DIGESTIVA', NULL, '1', '2016-05-12 06:58:48', NULL),
(14, 'GASTROENTEROLOGÍA', NULL, '1', '2016-05-12 06:58:48', NULL),
(15, 'GINECOLOGIA', NULL, '1', '2016-05-12 06:58:48', NULL),
(16, 'LABORATORIO CLÍNICO ', NULL, '1', '2016-05-12 06:58:48', NULL),
(17, 'MAMOGRAFÍAS', NULL, '1', '2016-05-12 06:58:48', NULL),
(18, 'ODONTOLOGÍA', NULL, '1', '2016-05-12 06:58:49', NULL),
(19, 'OFTALMOLOGÍA', NULL, '1', '2016-05-12 06:58:49', NULL),
(20, 'OTORRINOLARINGOLOGÍA', NULL, '1', '2016-05-12 06:58:49', NULL),
(21, 'PEDIATRIA', NULL, '1', '2016-05-12 06:58:49', NULL),
(22, 'REUMATOLOGÍA', NULL, '1', '2016-05-12 06:58:49', NULL),
(23, 'UROLOGÍA', NULL, '1', '2016-05-12 06:58:49', NULL);


--
-- Dumping data for table `oficina`
--

INSERT INTO `oficina` VALUES 
(1,'N100','1','2016-07-22 05:45:40',NULL),
(2,'N101','1','2016-07-22 05:46:14',NULL),
(3,'N102','1','2016-07-22 05:46:14',NULL);

--
-- Dumping data for table `paciente`
--
INSERT INTO `paciente` VALUES 
(1,4,NULL,'1','2016-07-22 05:35:30',NULL);

--
-- Dumping data for table `medico`
--

INSERT INTO `medico` VALUES 
(1,3,'DATA','218121511','1','2016-07-22 05:30:22',NULL);

--
-- Dumping data for table `medico_empresa`
--

INSERT INTO `medico_empresa` VALUES 
(1,1,1,'1','2016-07-22 05:30:22',NULL);

--
-- Dumping data for table `especialidad_medico`
--
INSERT INTO `especialidad_medico` VALUES 
(1,2,1,5,'1','2016-07-22 05:30:22',NULL),
(2,5,1,5,'1','2016-07-22 05:30:22',NULL),
(3,12,1,5,'1','2016-07-22 05:30:22',NULL),
(4,17,1,5,'1','2016-07-22 05:30:22',NULL);

--
-- Dumping data for table `centro_atencion`
--
INSERT INTO `centro_atencion` VALUES 
(1,1,'Norte','Norte Ciudad','123456','norte@med.com','07:00:00','18:00:00','1','2016-07-22 05:54:31',NULL),
(2,1,'Centro','Centro Ciudad','123457','centro@med.com','07:00:00','18:00:00','1','2016-07-22 05:54:31',NULL),
(3,1,'Sur','Sur Ciudad','123458','sur@med.com','07:00:00','18:00:00','1','2016-07-22 05:54:31',NULL);

--
-- Dumping data for table `consultorio`
--
INSERT INTO `consultorio` VALUES 
(1,1,12,1,'Consultorio 1','1254541','con1@med.com','07:00:00','18:00:00','00:30:00','1','2016-07-22 06:05:15',NULL),
(2,1,17,2,'Consultorio 2','1254543','con2@med.com','07:00:00','18:00:00','00:30:00','1','2016-07-22 06:05:15',NULL),
(3,1,2,3,'Consultorio 3','5214119','con3@med.com','07:00:00','13:00:00','00:30:00','1','2016-07-22 06:05:15',NULL);

--
-- Dumping data for table `medico_atencion`
--
INSERT INTO `medico_atencion` (`med_id`, `pac_id`, `mate_est_log`) VALUES ('1', '1', '1');


-- Cambios Byron 18-04-2017

INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`, `tdic_est_log`) VALUES ('CR', 'Radiografía computarizada', '1');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`, `tdic_est_log`) VALUES ('CT', 'Tomografía computarizada', '1');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`, `tdic_est_log`) VALUES ('MR', 'Resonancia magnetica', '1');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`, `tdic_est_log`) VALUES ('MN', 'Medicina nuclear', '1');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`, `tdic_est_log`) VALUES ('US', 'Ultrasonido', '1');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`, `tdic_est_log`) VALUES ('RG', 'Imágenes radiográficas', '1');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`, `tdic_est_log`) VALUES ('ES', 'Endoscopia', '1');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`) VALUES ('DX', 'Radiografía Digital');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`) VALUES ('MG', 'Mamografía');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`) VALUES ('IO', 'Radiografía intra-oral');
INSERT INTO `rdmi`.`tipo_dicom` (`tdic_nomenclatura`, `tdic_detalle`) VALUES ('OT', 'Otros');


INSERT INTO `rdmi`.`objeto_modulo` (`mod_id`, `omod_padre_id`, `omod_nombre`, `omod_tipo`, `omod_tipo_boton`, `omod_accion`, `omod_entidad`, `omod_orden`, `omod_estado_visible`, `omod_lang_file`, `omod_estado_activo`, `omod_estado_logico`) VALUES ('6', '6', 'Video Chat', 'S', '0', 'Applications', 'medico/video', '1', '0', 'application', '1', '1');
INSERT INTO `rdmi`.`objeto_modulo` (`mod_id`, `omod_padre_id`, `omod_nombre`, `omod_tipo`, `omod_tipo_boton`, `omod_accion`, `omod_entidad`, `omod_orden`, `omod_estado_visible`, `omod_lang_file`, `omod_estado_activo`, `omod_estado_logico`) VALUES ('6', '6', 'Archivo Imagenes', 'S', '0', 'Applications', 'medico/file', '1', '0', 'application', '1', '1');

INSERT INTO `rdmi`.`omodulo_rol` (`omod_id`, `rol_id`, `omrol_est_log`) VALUES ('32', '3', '1');
INSERT INTO `rdmi`.`omodulo_rol` (`omod_id`, `rol_id`, `omrol_est_log`) VALUES ('33', '3', '1');

drop table `rdmi`.`dicom`;
drop table `rdmi`.`imagenes`;



--######################################################################
--######################################################################
--######################################################################

--crear cita medica - signos vitales -eventos - resultados - imagenes
-- crear signos vitales y eventos
drop table `rdmi`.`cita_medica`;
drop table `rdmi`.`signos_vitales`;
drop table `rdmi`.`imagenes`;
drop table `rdmi`.`resultados`;
drop table `rdmi`.`eventos`;

---AGREGAR

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


INSERT INTO `rdmi`.`cita_medica` (`tur_numero`, `hora_id`, `fecha_cita`, `cons_id`, `hora_inicio`, `tcon_id`, `pac_id`, `cprog_id`, `cmde_estado_asistencia`, `cmde_est_log`) VALUES ('1', '1', '2016-08-27', '3', '08:00:00', '2', '1', '1', '1', '1');

INSERT INTO `rdmi`.`eventos` (`cmde_id`, `eve_usu_id`, `eve_nombre`, `eve_est_log`) VALUES ('1', '1', 'Imagenes', '1');

ALTER TABLE `rdmi`.`imagenes` CHANGE COLUMN `ima_ruta_archivo` `ima_ruta_archivo` VARCHAR(100) NULL DEFAULT NULL  ;



ALTER TABLE `rdmi`.`centro_atencion` ADD COLUMN `can_id` BIGINT(20) NULL  AFTER `emp_id` ;
UPDATE `rdmi`.`centro_atencion` SET `can_id`='87' WHERE `cate_id`='1';
UPDATE `rdmi`.`centro_atencion` SET `can_id`='87' WHERE `cate_id`='2';
UPDATE `rdmi`.`centro_atencion` SET `can_id`='189' WHERE `cate_id`='3';


INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('IMÁGENES SENOS', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA CARDIOVASCULAR', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA DE TORAX', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('EMERGENCIAS RADIOLÓGICAS', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA GASTROINTESTINAL', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA GENITOURINARIA', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA DE CABEZA Y CUELLO', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA MUSCULOESQUELÉTICA', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('NURORADIOLOGÍA', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA PEDIÁTRICA', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA DE INTERVENCIÓN ', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIOLOGÍA NUCLEAR', '1');
INSERT INTO `rdmi`.`especialidad` (`esp_nombre`, `esp_est_log`) VALUES ('RADIONCOLOGÍA', '1');



