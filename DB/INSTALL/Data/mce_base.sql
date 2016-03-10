
USE `mce_base`;


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
-- Volcar la base de datos para la tabla `tipo_password`
--

INSERT INTO `tipo_password` (`tpas_id`, `tpas_tipo`, `tpas_validacion`, `tpas_descripcion`, `tpas_estado_activo`, `tpas_fecha_creacion`, `tpas_fecha_modificacion`, `tpas_estado_logico`) VALUES
(1, 'Simples', '/^(?=.*[a-z])(?=.*[A-Z]).{VAR,}$/', 'Las claves simples deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas).', '1', '2012-08-28 15:00:00', '2012-08-28 15:00:00', '1'),
(2, 'Semicomplejas', '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{VAR,}$/', 'Las claves semicomplejas deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas). ', '1', '2012-08-29 02:57:58', '2012-08-29 02:57:58', '1'),
(3, 'Complejas', '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\\,\\;#¿\\?\\}\\{\\]\\[\\-_¡!\\=&\\^:<>\\.\\+\\*\\/\\$\\(\\)]).{VAR,}$/', 'Las claves complejas deben cumplir con lo mínimo: Caracteres alfabéticos (Mayúsculas y minúsculas).\nSímbolos: @ ,  ; # ¿ ? }  {  ]  [ - _ ¡  ! = & ^ : < > . + * / ( )', '1', '2012-08-29 02:57:58', '2012-08-29 02:57:58', '1');


--
-- Volcar la base de datos para la tabla `usuario`
--

INSERT INTO `persona` (`per_id`, `per_nombres`, `per_apellidos`, `per_cedula`, `per_ruc`, `per_pasaporte`,`per_fecha_nacimiento`, `per_direccion`, `per_telefono`, `pai_id`, `prov_id`, `can_id`, `per_celular`, `per_genero`, `per_estado_civil`, `per_correo`, `per_foto`, `per_estado_activo`, `per_fecha_creacion`, `per_fecha_modificacion`, `per_estado_logico`) VALUES
(1, 'Admin', 'Admin', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'S', NULL, NULL, '1', CURRENT_TIMESTAMP, NULL, '1');
--
-- Volcar la base de datos para la tabla `usuario`
--

INSERT INTO `usuario`(`usu_id`, `per_id`, `usu_username`, `usu_password`, `usu_sha`, `usu_session`, `usu_last_login`, `usu_estado_activo`, `usu_fecha_creacion`, `usu_fecha_modificacion`, `usu_estado_logico`) VALUES
(1, 1, 'admin', 'Oe0XnfQV1rITyhra1D9NSTk2NzMyY2VhZDE2ZGY2NTM4NmM1ZGNkZmU2MTBjYjEyZjZkN2Q0ZWY0NjYxMmM5MGIwNDZjNjI1MzUxMzY5MWIXYpkgqqqFS/QKaxVARLLmArjJ7iD39CoAVhUhD69so1Aa/WoTy6Qvmatc2VKvXWc2b2npklLgwwBil3xKV8l1', 'gJzWo7FQ-zmMcuy4cpWrTrVDmTRCFJcs', NULL, NULL, '1', '2015-04-10 13:00:00', NULL, '1');

--
-- Volcar la base de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`gru_id`, `tpas_id`, `gru_nombre`, `gru_descripcion`, `gru_estado_activo`, `gru_fecha_creacion`, `gru_fecha_modificacion`, `gru_estado_logico`) VALUES
(1, 3, 'Super Admin', 'Grupo Super Admin', '1', '2012-09-03 15:00:00', NULL, '1'),
(2, 1, 'Licenciatario', 'Grupo Licenciatario', '1', '2012-09-03 15:00:00', NULL, '1');

--
-- Volcar la base de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `rol_nombre`, `rol_descripcion`, `rol_estado_activo`, `rol_fecha_creacion`, `rol_fecha_modificacion`, `rol_estado_logico`) VALUES
(1, 'Administrador', 'Descripción', '1', '2012-09-03 15:00:00', NULL, '1'),
(2, 'Licenciatario', 'Descripción', '1', '2012-09-03 15:00:00', NULL, '1');



--
-- Volcar la base de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`mod_id`, `mod_nombre`, `mod_dir_imagen`, `mod_url`, `mod_orden`, `mod_lang_file`, `mod_estado_activo`, `mod_fecha_creacion`, `mod_fecha_modificacion`, `mod_estado_logico`) VALUES
(1, 'Applications', 'glyphicon glyphicon-th-large', 'mceformulario/index', 1, 'application', '1', '2012-08-26 01:47:23', NULL, '1'),
(2, 'Tracing', 'glyphicon glyphicon-sort', 'mceformulariotemp/index', 2, 'application', '1', '2012-08-26 01:47:23', NULL, '0'),
(3, 'My Forms', 'glyphicon glyphicon-list-alt', 'mceformulariotemp/index', 1, 'application', '1', '2012-08-26 01:47:23', NULL, '1'),
(4, 'My Account', 'glyphicon glyphicon-user', 'perfil/index', 3, 'menu', '1', '2012-08-26 01:47:23', NULL, '1');


--
-- Volcar la base de datos para la tabla `objeto_modulo`
--

INSERT INTO `objeto_modulo` (`omod_id`, `mod_id`, `omod_padre_id`, `omod_nombre`, `omod_tipo`, `omod_tipo_boton`, `omod_accion`, `omod_function`, `omod_dir_imagen`, `omod_entidad`, `omod_orden`, `omod_estado_visible`, `omod_lang_file`, `omod_estado_activo`, `omod_fecha_creacion`, `omod_fecha_modificacion`, `omod_estado_logico`) VALUES
(1, 1, 1, 'Applications', 'P', '0', 'Applications', '', '', 'mceformulario/index', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(2, 1, 1, 'To Refuse', 'A', '0', 'Applications', '', '', 'mceformulario/rechazar', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(3, 1, 1, 'To Approve', 'A', '0', 'Applications', '', '', 'mceformulario/autorizar', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(4, 1, 1, 'To Correct', 'A', '0', 'Applications', '', '', 'mceformulario/view', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(5, 1, 1, 'Get Message', 'A', '0', 'Applications', '', '', 'mceformulario/message', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(6, 1, 1, 'Delete Message', 'A', '0', 'Applications', '', '', 'mceformulario/deletemessage', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(7, 1, 1, 'Export to Excel', 'A', '0', 'Applications', '', '', 'mceformulario/expexcel', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(8, 2, 1, 'Tracing', 'P', '0', 'Applications', '', '', 'mceseguimiento/index', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(9, 2, 1, 'View Tracing', 'S', '0', 'Applications', '', '', 'mceseguimiento/view', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(10, 2, 1, 'Create Tracing', 'S', '0', 'Applications', '', '', 'mceseguimiento/create', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(11, 2, 1, 'Update Tracing', 'S', '0', 'Applications', '', '', 'mceseguimiento/update', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(12, 2, 1, 'Delete Tracing', 'S', '0', 'Applications', '', '', 'mceseguimiento/delete', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(13, 2, 1, 'Save Tracing', 'S', '0', 'Applications', '', '', 'mceseguimiento/save', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(14, 3, 14, 'My Forms', 'P', '0', 'My Forms', '', '', 'mceformulariotemp/index', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(15, 3, 14, 'View Form', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/view', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(16, 3, 14, 'Create Form', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/create', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(17, 3, 14, 'Update Form', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/update', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(18, 3, 14, 'Save Form', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/save', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(19, 3, 14, 'Brand Use', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/usomarca', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(20, 3, 14, 'Upload File', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/uploadfile', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(21, 3, 14, 'Download File', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/download', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(22, 3, 14, 'View Message', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/viewmessage', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(23, 3, 14, 'Pdf Application', 'A', '0', 'My Forms', '', '', 'mceformulariotemp/solicitudpdf', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(24, 1, 1, 'Search Application', 'A', '0', 'Applications', '', '', 'mceformulario/buscarpersonas', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(25, 1, 1, 'Pdf Application Sol', 'A', '0', 'Applications', '', '', 'mceformulario/solicitudpdf', 1, '0', 'application', '1', '2014-01-08 13:43:51', NULL, '1'),
(26, 4, 26, 'Profile', 'P', '0', 'My Account', '', '', 'perfil/index', 1, '0', 'perfil', '1', '2014-01-08 13:43:51', NULL, '1'),
(27, 4, 26, 'Save Profile', 'A', '0', 'My Account', '', '', 'perfil/save', 1, '0', 'perfil', '1', '2014-01-08 13:43:51', NULL, '1');

--
-- Volcar la base de datos para la tabla `grup_obmo`
--

INSERT INTO `grup_obmo` (`gmod_id`, `gru_id`, `omod_id`, `gmod_estado_activo`, `gmod_fecha_creacion`, `gmod_fecha_modificacion`, `gmod_estado_logico`) VALUES
(1, 1, 1, '1', '2014-03-17 21:34:50', NULL, '1'),
(2, 1, 2, '1', '2014-03-17 21:34:50', NULL, '1'),
(3, 1, 3, '1', '2014-03-17 21:34:50', NULL, '1'),
(4, 1, 4, '1', '2014-03-17 21:34:50', NULL, '1'),
(5, 1, 5, '1', '2014-03-17 21:34:50', NULL, '1'),
(6, 1, 6, '1', '2014-03-17 21:34:50', NULL, '1'),
(7, 1, 7, '1', '2014-03-17 21:34:50', NULL, '1'),
(8, 1, 8, '1', '2014-03-17 21:34:50', NULL, '1'),
(9, 1, 9, '1', '2014-03-17 21:34:50', NULL, '1'),
(10, 1, 10, '1', '2014-03-17 21:34:50', NULL, '1'),
(11, 1, 11, '1', '2014-03-17 21:34:50', NULL, '1'),
(12, 1, 12, '1', '2014-03-17 21:34:50', NULL, '1'),
(13, 1, 13, '1', '2014-03-17 21:34:50', NULL, '1'),
(14, 2, 14, '1', '2014-03-17 21:34:50', NULL, '1'),
(15, 2, 15, '1', '2014-03-17 21:34:50', NULL, '1'),
(16, 2, 16, '1', '2014-03-17 21:34:50', NULL, '1'),
(17, 2, 17, '1', '2014-03-17 21:34:50', NULL, '1'),
(18, 2, 18, '1', '2014-03-17 21:34:50', NULL, '1'),
(19, 2, 19, '1', '2014-03-17 21:34:50', NULL, '1'),
(20, 2, 20, '1', '2014-03-17 21:34:50', NULL, '1'),
(21, 2, 21, '1', '2014-03-17 21:34:50', NULL, '1'),
(22, 2, 22, '1', '2014-03-17 21:34:50', NULL, '1'),
(23, 2, 23, '1', '2014-03-17 21:34:50', NULL, '1'),
(24, 2, 26, '1', '2014-03-17 21:34:50', NULL, '1'),
(25, 2, 27, '1', '2014-03-17 21:34:50', NULL, '1'),
(26, 1, 24, '1', '2014-03-17 21:34:50', NULL, '1'),
(27, 1, 25, '1', '2014-03-17 21:34:50', NULL, '1'),
(28, 1, 26, '1', '2014-03-17 21:34:50', NULL, '1'),
(29, 1, 27, '1', '2014-03-17 21:34:50', NULL, '1');

--
-- Volcar la base de datos para la tabla `grup_rol`
--

INSERT INTO `grupo_rol` (`grol_id`, `gru_id`, `rol_id`, `usu_id`, `grol_estado_activo`, `grol_fecha_creacion`, `grol_fecha_modificacion`, `grol_estado_logico`) VALUES
(1, 1, 1, 1, '1', '2012-09-03 20:00:00', NULL, '1');

--
-- Volcar la base de datos para la tabla `obmo_acci`
--

INSERT INTO `obmo_acci` (`oacc_id`, `omod_id`, `acc_id`, `oacc_tipo_boton`, `oacc_cont_accion`, `oacc_function`, `oacc_estado_activo`, `oacc_fecha_creacion`, `oacc_fecha_modificacion`, `oacc_estado_logico`) VALUES
(1, 1, 1, '5', NULL, 'alert()', '1', '2014-06-12 07:43:33', NULL, '1');

--
-- Volcar la base de datos para la tabla `grup_obmo_grup_rol`
--

INSERT INTO `grup_obmo_grup_rol` (`gogr_id`, `grol_id`, `gmod_id`, `gogr_estado_activo`, `gogr_fecha_creacion`, `gogr_fecha_modificacion`, `gogr_estado_logico`) VALUES
(1, 1, 1, '1', '2014-01-04 20:48:54', NULL, '1'),
(2, 1, 2, '1', '2014-01-04 20:48:54', NULL, '1'),
(3, 1, 3, '1', '2014-01-04 20:48:54', NULL, '1'),
(4, 1, 4, '1', '2014-01-04 20:48:54', NULL, '1'),
(5, 1, 5, '1', '2014-01-04 20:48:54', NULL, '1'),
(6, 1, 6, '1', '2014-01-04 20:48:54', NULL, '1'),
(7, 1, 7, '1', '2014-01-04 20:48:54', NULL, '1'),
(8, 1, 8, '1', '2014-01-04 20:48:54', NULL, '1'),
(9, 1, 9, '1', '2014-01-04 20:48:54', NULL, '1'),
(10, 1, 10, '1', '2014-01-04 20:48:54', NULL, '1'),
(11, 1, 11, '1', '2014-01-04 20:48:54', NULL, '1'),
(12, 1, 12, '1', '2014-01-04 20:48:54', NULL, '1'),
(13, 1, 13, '1', '2014-01-04 20:48:54', NULL, '1'),
(14, 1, 26, '1', '2014-01-04 20:48:54', NULL, '1'),
(15, 1, 27, '1', '2014-01-04 20:48:54', NULL, '1'),
(16, 1, 28, '1', '2014-01-04 20:48:54', NULL, '1'),
(17, 1, 29, '1', '2014-01-04 20:48:54', NULL, '1');


-- Datos de MCE

INSERT INTO `mce_uso_marca` (`umar_id`, `umar_nombre`, `umar_detalle`, `umar_fecha_creacion`, `umar_fecha_modificacion`, `umar_estado_logico`) VALUES
(1, 'Licencia de uso en servicios', 'En material institucional de empresas que brindan servicios, tales como: operadoras turísticas, hoteles, restaurantes, etc.', '2015-11-30 03:50:57', NULL, 1),
(2, 'Licencia de uso en Productos', 'En productos de comercialización en envases, etiquetas, empaques, publicidad. Deben tener al menos el 40% de componente nacional entre materia prima y/o mano de obra.', '2015-11-30 03:50:57', NULL, 1),
(3, 'Licencia de uso en Eventos', 'Nacionales e internacionales que promocionen la imagen país, tales como ferias, seminarios, talleres, festivales, conferencias, etc.', '2015-11-30 03:50:57', NULL, 1),
(4, 'Licencia de uso en Instituciones Públicas', 'Es el uso de la Marca País por parte de empresas del sector público.', '2015-11-30 03:50:57', NULL, 1);


INSERT INTO `mce_industria` (`ind_id`, `ind_giro`, `ind_fecha_creacion`, `ind_estado_logico`) VALUES
(1, 'Agroindustria', '2015-11-19 03:45:59', 1),
(2, 'Alimentos, bebidas y licores', '2015-11-19 03:45:59', 1),
(3, 'Artesanías y regalos', '2015-11-19 03:45:59', 1),
(4, 'Asociaciones, Gremios e instituciones', '2015-11-19 03:45:59', 1),
(5, 'Asesoría Jurídica', '2015-11-19 03:45:59', 1),
(6, 'Banca y Finanzas', '2015-11-19 03:45:59', 1),
(7, 'Café y Cacao', '2015-11-19 03:45:59', 1),
(8, 'Calzado', '2015-11-19 03:45:59', 1),
(9, 'Comunicaciones y Prensa', '2015-11-19 03:45:59', 1),
(10, 'Comercio Exterior', '2015-11-19 03:45:59', 1),
(11, 'Consultoría Empresarial', '2015-11-19 03:45:59', 1),
(12, 'Deporte, Cultura y Recreación', '2015-11-19 03:45:59', 1),
(13, 'Educación', '2015-11-19 03:45:59', 1),
(14, 'Electrodomésticos, muebles y enseres', '2015-11-19 03:45:59', 1),
(15, 'Hidrocarburos y electricidad', '2015-11-19 03:45:59', 1),
(16, 'Hotelería y turismo', '2015-11-19 03:45:59', 1),
(17, 'Imprentas y editoriales', '2015-11-19 03:45:59', 1),
(18, 'Indrustria Química', '2015-11-19 03:45:59', 1),
(19, 'Informática', '2015-11-19 03:45:59', 1),
(20, 'Ingeniería, minería y construcción', '2015-11-19 03:46:00', 1),
(21, 'Joyería', '2015-11-19 03:46:00', 1),
(22, 'Marketing y Publicidad', '2015-11-19 03:46:00', 1),
(23, 'Manufacturera Diversa', '2015-11-19 03:46:00', 1),
(24, 'Metal Mecánica', '2015-11-19 03:46:00', 1),
(25, 'Operadores logísticos', '2015-11-19 03:46:00', 1);


INSERT INTO `mce_objetivo` (`obj_id`, `obj_nombre`, `obj_fecha_creacion`, `obj_estado_logico`) VALUES
(1, 'Exportaciones', '2015-11-19 03:57:01', 1),
(2, 'Turismo', '2015-11-19 03:57:01', 1),
(3, 'Imagen País – Gastronomía', '2015-11-19 03:57:01', 1),
(4, 'Imagen País - Arte y Cultura', '2015-11-19 03:57:01', 1),
(5, 'Imagen País - Educación y Cultura', '2015-11-19 03:57:01', 1),
(6, 'Imagen País - Desarrollo de valores', '2015-11-19 03:57:01', 1),
(7, 'Imagen País - Deportes', '2015-11-19 03:57:01', 1),
(8, 'Imagen País - Educación', '2015-11-19 03:57:01', 1),
(9, 'Otros', '2015-11-19 03:57:01', 1);

INSERT INTO `mce_sub_objetivo` (`sobj_id`, `obj_id`, `sobj_nombre`, `sobj_fecha_creacion`, `sobj_fecha_modificacion`, `sobj_estado_logico`) VALUES
(1, 1, 'DATA 1', '2015-12-09 22:38:24', NULL, 1),
(2, 1, 'DATA 2', '2015-12-09 22:38:24', NULL, 1),
(3, 2, 'DATA 3', '2015-12-09 22:38:24', NULL, 1),
(4, 2, 'DATA 4', '2015-12-09 22:38:24', NULL, 1),
(5, 3, 'DATA 5', '2015-12-09 22:38:24', NULL, 1),
(6, 3, 'DATA 6', '2015-12-09 22:38:24', NULL, 1);

INSERT INTO `mce_otros_usos` (`ous_id`, `ous_nombre`, `ous_fecha_creacion`, `ous_estado_logico`) VALUES
(1, 'Papelería Hojas / Sobres / Carpetas', '2015-11-19 03:47:59', 1),
(2, 'Página Web / Redes Sociales', '2015-11-19 03:47:59', 1),
(3, 'Instalaciones / Local Comercial', '2015-11-19 03:47:59', 1),
(4, 'Material Promocional / Folletos / Trípticos / Catálogos, Etc', '2015-11-19 03:47:59', 1),
(5, 'Eventos Institucionales Ferias / Seminarios / Talleres / Etc', '2015-11-19 03:47:59', 1),
(6, 'Publicidad', '2015-11-19 03:47:59', 1);


INSERT INTO `mce_porcentaje` (`por_id`, `por_nombre`, `por_fecha_creacion`, `por_estado_logico`) VALUES
(1, 'Del 0% al 19%', '2015-11-19 03:36:53', 1),
(2, 'Del 20% al 39%', '2015-11-19 03:36:53', 1),
(3, 'Del 40% al 59%', '2015-11-19 03:36:53', 1),
(4, 'Del 60% al 79%', '2015-11-19 03:36:53', 1),
(5, 'Del 80% al 100%', '2015-11-19 03:36:53', 1);

INSERT INTO `mce_registro` (`usu_id`, `reg_estado`, `reg_estado_logico`) VALUES ('1', '1', '1');

INSERT INTO `mce_documento` (`doc_id`, `doc_tipo`,`doc_numero`, `doc_fecha_creacion`, `doc_estado_logico`) VALUES
(1, 'SOL','000000001', '2015-11-19 03:36:53', 1),
(2, 'CON','000000001', '2015-11-19 03:36:53', 1);

