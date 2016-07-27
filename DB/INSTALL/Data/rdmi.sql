USE `rdmi` ;

--
-- Volcar la base de datos para la tabla `accion`
--

INSERT INTO `accion` (`acc_id`, `acc_nombre`, `acc_url_accion`, `acc_tipo`, `acc_descripcion`, `acc_lang_file`, `acc_dir_imagen`, `acc_estado_activo`, `acc_fecha_creacion`, `acc_fecha_modificacion`, `acc_estado_logico`) VALUES
(1, 'Create', 'Create', 'General', 'Create', 'accion', 'glyphicon glyphicon-file', '1', '2012-09-19 21:21:35', NULL, '1'),
(2, 'Update', 'Update', 'General', 'Update', 'accion', 'glyphicon glyphicon-edit', '1', '2012-09-19 21:21:35', NULL, '1'),
(3, 'Delete', 'Delete', 'General', 'Delete', 'accion', 'glyphicon glyphicon-trash', '1', '2012-09-19 21:21:35', NULL, '1'),
(4, 'Save', 'Save', 'General', 'Save', 'accion', 'glyphicon glyphicon-floppy-disk', '1', '2012-09-19 21:21:35', NULL, '1'),
(5, 'Search', 'Search', 'General', 'Search', 'accion', 'glyphicon glyphicon-search', '1', '2012-09-19 21:21:35', NULL, '1'),
(6, 'Print', 'Print', 'General', 'Print', 'accion', 'glyphicon glyphicon-print', '1', '2012-09-19 21:21:35', NULL, '1'),
(7, 'Import', 'Import', 'General', 'Import', 'accion', 'glyphicon glyphicon-import', '1', '2012-09-19 21:21:35', NULL, '1'),
(8, 'Export', 'Export', 'General', 'Export', 'accion', 'glyphicon glyphicon-export', '1', '2012-09-19 21:21:35', NULL, '1'),
(9, 'Back', 'Back', 'General', 'Back', 'accion', 'glyphicon glyphicon-triangle-right', '1', '2012-09-19 21:21:35', NULL, '1'),
(10, 'Next', 'Next', 'General', 'Next', 'accion', 'glyphicon glyphicon-triangle-left', '1', '2012-09-19 21:21:35', NULL, '1'),
(11, 'Clear', 'Clear', 'General', 'Clear', 'accion', 'glyphicon glyphicon-leaf', '1', '2012-09-19 21:21:35', NULL, '1');



--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`emp_id`, `emp_nombre`, `emp_ruc`, `emp_descripcion`, `emp_direccion`, `emp_telefono`, `emp_est_log`, `emp_fec_cre`, `emp_fec_mod`) VALUES
(1, 'Medical', '1310328405001', 'Imagenes Digitales', NULL, 'Colon', '1', '2016-03-03 02:47:47', NULL);

--
-- Volcar la base de datos para la tabla `persona`
--
INSERT INTO `persona` (`per_id`,`per_ced_ruc`,`per_nombre`,`per_apellido`,`per_genero`,`per_fecha_nacimiento`,`per_estado_civil`,`per_correo`,`per_tipo_sangre`,`per_estado_activo`,`per_est_log`) VALUES 
(1,'1310328404','Byron','Villacreses','M','1981-07-19','S','admin@hotmail.com','O+',1,1),
(2,'1310328404','Byron','Villacreses','M','1981-07-19','S','byron_villacresesf@hotmail.com','O+',1,1),
(3,'0102042397','JOSE','CASTRO','M','2016-07-14','C','byron_vilacresesf@hotmail.com','B-',1,1),
(4,'1400302061','DORIS','CARVAJAL','F','2016-07-29','S','byron_villacresesf@hotmail.com','O+',1,1);

--
-- Volcar la base de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_id`, `per_id`, `usu_username`, `usu_password`, `usu_sha`, `usu_session`, `usu_last_login`, `usu_link_activo`, `usu_estado_activo`, `usu_alias`, `usu_est_log`, `usu_fec_cre`, `usu_fec_mod`) VALUES
(1, 1, 'admin', 'nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL', 'f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx', NULL, '2016-03-16 09:58:37', NULL, '1', NULL, '1', '2016-03-10 18:00:00', NULL),
(2, 2, 'byron_villacresesf@hotmail.com', 'nohr0F0OmOEkE4IeKV48szJkYmIzYmQ0ODcyYzA4YmNkZjI0MDA0MjkyYzUwNzUzNzYwNjI1YjEwOGQ0YTE0ZDc3ZjIwOWZkMTNhMTZlMjKTyTGdwC22RmZAyIBI8FHsbMpZ6WnqV1+kuuOTkujEWeN3cet3WJKFxBF/x/bte5sJNwLGJTcIK69llvULNtOL', 'f2gLBc7wsBasMjYYnzp5hAMmXOwQNkFx', NULL, '2016-03-16 09:56:04', '', '1', NULL, '1', '2016-03-16 03:54:51', '2016-03-16 03:54:51'),
(3,4,'byron_villacresesf@hotmail.com','Nsz9W8fjHsBVOV229KrqYmRkYmNlYjNjYTg1ODdkNGYzYzUwOTg4YTkxMzhmMDMyOGExNmM0ZGRjNjU1YmZlMGRiYWVlM2I3NjJiZTM1YTK80sJKMITy98WBBY4ymSLS0nxRVq5II2kDdAKIpEbfKTOOXtz4YEt/h3z2TZIUZa3S976ja2YO9zOwqOyrD97S','j7zxDqFoh1o0hdKPOg2o-ByqSGfY2zsf',NULL,NULL,'http://localhost/rdmi/site/activation?wg=KAhjvkvzHP77i6aO1d7VkvWkfGmYi6e','1',NULL,'1','2016-07-22 05:35:30',NULL);

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

INSERT INTO `rol` (`rol_id`, `rol_nombre`, `rol_descripcion`, `rol_estado_activo`, `rol_fecha_creacion`, `rol_fecha_modificacion`, `rol_estado_logico`) VALUES
(1, 'Administrador', 'Descripción', '1', '2012-09-03 15:00:00', NULL, '1'),
(2, 'Otros', 'Descripción', '1', '2012-09-03 15:00:00', NULL, '1');

--
-- Volcado de datos para la tabla `usuario_empresa`
--

INSERT INTO `usuario_empresa` (`uemp_id`, `usu_id`, `rol_id`, `emp_id`, `uemp_est_log`, `uemp_fec_cre`, `uemp_fec_mod`) VALUES
(1, 1, 1, 1, '1', '2016-03-03 02:50:58', NULL);

--
-- Volcado de datos para la tabla `aplicacion`
--

INSERT INTO `aplicacion` (`apl_id`, `apl_nombre`, `apl_tipo`, `apl_lang_file`, `apl_est_log`, `apl_fec_cre`, `apl_fec_mod`) VALUES
(1, 'Repositorio Digital', '1', NULL, '1', '2016-03-02 19:19:43', NULL);

--
-- Volcar la base de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`mod_id`, `apl_id`, `mod_nombre`, `mod_dir_imagen`, `mod_url`, `mod_orden`, `mod_lang_file`, `mod_estado_activo`, `mod_fecha_creacion`, `mod_fecha_modificacion`, `mod_estado_logico`) VALUES
(1, 1, 'Dashboard', 'fa fa-dashboard', 'site/index', 1, 'application', '1', '2012-08-26 06:47:23', NULL, '1'),
(2, 1, 'My Account', 'glyphicon glyphicon-user', 'perfil/index', 2, 'menu', '1', '2012-08-26 06:47:23', NULL, '1'),
(3, 1, 'My Forms', 'glyphicon glyphicon-list-alt', 'mceformulariotemp/index', 3, 'application', '1', '2012-08-26 06:47:23', NULL, '1'),
(4, 1, 'Processes', 'glyphicon glyphicon-th-large', 'perfil/index', 4, 'application', '1', '2012-08-26 06:47:23', NULL, '1'),
(5, 1, 'Images', 'glyphicon glyphicon-picture', 'site/index', 5, 'application', '1', '2016-03-18 05:09:10', NULL, '1'),
(6, 1, 'Maintenance', 'glyphicon glyphicon-wrench', 'site/index', 6, 'application', '1', '2016-03-18 05:31:11', NULL, '1');

--
-- Volcar la base de datos para la tabla `objeto_modulo`
--

INSERT INTO `objeto_modulo` (`omod_id`, `mod_id`, `omod_padre_id`, `omod_nombre`, `omod_tipo`, `omod_tipo_boton`, `omod_accion`, `omod_function`, `omod_dir_imagen`, `omod_entidad`, `omod_orden`, `omod_estado_visible`, `omod_lang_file`, `omod_estado_activo`, `omod_fecha_creacion`, `omod_fecha_modificacion`, `omod_estado_logico`) VALUES
(1,1,1,'Dashboard','P','0','Applications','','','site/index',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(2,2,1,'My Account','P','0','Applications','','','perfil/index',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(3,3,1,'My Forms','P','0','Applications','','','mceformulario/autorizar',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(4,4,1,'Processes','P','0','Applications','','','mceformulario/view',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(5,5,1,'Images','P','0','Applications','','','mceformulario/message',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(6,6,1,'Maintenance','P','0','Applications','','','mceformulario/deletemessage',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(7,2,2,'Profile','S','0','My Account','','','perfil/index',1,0,'perfil','1','2014-01-09 04:43:51',NULL,'1'),
(8,2,2,'Save Profile','A','0','My Account','','','perfil/save',1,0,'perfil','1','2014-01-09 04:43:51',NULL,'1'),
(9,2,2,'Change Password','S','0','Applications','','','perfil/password',2,0,'perfil','1','2014-01-09 04:43:51',NULL,'1'),
(10,4,4,'Book Appointment','S','0','Applications','','','mceseguimiento/create',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(11,4,4,'Quote address','S','0','Applications','','','mceseguimiento/update',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(12,6,6,'Patient','S','0','Applications','','','paciente/index',1,0,'perfil','1','2014-01-09 04:43:51',NULL,'1'),
(13,6,6,'Medico','S','0','Applications','','','medico/index',1,0,'perfil','1','2014-01-09 04:43:51',NULL,'1'),
(14,6,6,'Admin Medico','S','0','My Forms','','','medico/adminmedico',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(15,6,6,'Admin Paciente','S','0','My Forms','','','mceformulariotemp/view',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(16,3,14,'Create Form','A','0','My Forms','','','mceformulariotemp/create',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(17,3,14,'Update Form','A','0','My Forms','','','mceformulariotemp/update',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(18,3,14,'Save Form','A','0','My Forms','','','mceformulariotemp/save',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(19,3,14,'Brand Use','A','0','My Forms','','','mceformulariotemp/usomarca',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(20,3,14,'Upload File','A','0','My Forms','','','mceformulariotemp/uploadfile',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(21,3,14,'Download File','A','0','My Forms','','','mceformulariotemp/download',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(22,3,14,'View Message','A','0','My Forms','','','mceformulariotemp/viewmessage',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(23,3,14,'Pdf Application','A','0','My Forms','','','mceformulariotemp/solicitudpdf',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(24,1,1,'Search Application','A','0','Applications','','','mceformulario/buscarpersonas',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(25,1,1,'Pdf Application Sol','A','0','Applications','','','mceformulario/solicitudpdf',1,0,'application','1','2014-01-09 04:43:51',NULL,'1'),
(26,4,26,'Profile','S','0','My Account','','','perfil/index',1,0,'perfil','1','2014-01-09 04:43:51',NULL,'1'),
(27,4,26,'Save Profile','A','0','My Account','','','perfil/save',1,0,'perfil','1','2014-01-09 04:43:51',NULL,'1');

--
-- Volcado de datos para la tabla `omodulo_rol`
--

INSERT INTO `omodulo_rol` (`omrol_id`, `omod_id`, `rol_id`, `omrol_est_log`, `omrol_fec_cre`, `omrol_fec_mod`) VALUES
(1,1,1,'1','2016-03-03 15:37:33',NULL),
(2,2,1,'1','2016-03-18 09:41:00',NULL),
(3,3,1,'1','2016-03-18 09:41:00',NULL),
(4,4,1,'1','2016-03-18 10:03:29',NULL),
(5,5,1,'1','2016-03-18 10:37:00',NULL),
(6,6,1,'1','2016-03-18 10:37:00',NULL),
(7,7,1,'1','2016-03-18 10:47:02',NULL),
(8,8,1,'1','2016-03-18 10:47:02',NULL),
(9,9,1,'1','2016-03-18 10:47:02',NULL),
(10,10,1,'1','2016-03-18 10:47:02',NULL),
(11,11,1,'1','2016-03-18 10:47:02',NULL),
(12,12,1,'1','2016-03-18 10:47:02',NULL),
(13,13,1,'1','2016-03-18 10:47:02',NULL),
(14,14,1,'1','2016-07-22 06:38:34',NULL),
(15,15,1,'1','2016-07-22 06:38:34',NULL);


--
-- Volcar la base de datos para la tabla `obmo_acci`
--

INSERT INTO `obmo_acci` (`oacc_id`, `omod_id`, `acc_id`, `oacc_tipo_boton`, `oacc_cont_accion`, `oacc_function`, `oacc_estado_activo`, `oacc_fecha_creacion`, `oacc_fecha_modificacion`, `oacc_estado_logico`) VALUES
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

