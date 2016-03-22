
function sentPassword(){
    var link = $('#txth_base').val() + "/perfil/save";
    var arrParams = new Object();
    arrParams.current = $("#frm_actual_clave").val();
    arrParams.new = $("#frm_nueva_clave").val();
    arrParams.confirm = $("#frm_nueva_clave_repeat").val();
    if(arrParams.new != arrParams.confirm){
        // error verificar 
        showAlert("NOOK", "Error", {"wtmessage": "Contraseñas no coinciden. Ingrese correctamente la nueva contraseña.", "title":"Exito"});
    }else{
        requestHttpAjax(link, arrParams, function (response) {
                showAlert(response.status, response.label, response.message);
        }, true);
    }
}

function obtenerCanton() {
    var link = $('#txth_base').val() + "/perfil/index";
    var arrParams = new Object();
    arrParams.prov_id = $('#cmb_provincia').val();
    arrParams.getcantones = true;
    requestHttpAjax(link, arrParams, function (response) {
        if (response.status == "OK") {
            data = response.message;
            setComboData(data.cantones, "cmb_ciudad");
        }
    }, true);
}

/*
 * GUARDAR DATOS
 */

function guardarSolicitud(accion) {
    if ($("#chk_aceptar").prop("checked")) {
        var ID = (accion == "Update") ? $('#txth_ftem_id').val() : 0;
        var link = $('#txth_base').val() + "/mceformulariotemp/save";
        var arrParams = new Object();
        arrParams.DATA_1 = dataSolicitudPart1(ID);
        arrParams.DATA_2 = dataSolicitudPart2();
        arrParams.DATA_3 = dataSolicitudPart3();
        arrParams.ACCION = accion;
        //Subir Imagenes

        var validation = validateForm();
        if (!validation) {
            //subirDocumentos(1, true);
            //subirDocumentos(2, true);
            requestHttpAjax(link, arrParams, function (response) {
                var message = response.message;
                if (response.status == "OK") {
                    //var data =response.data;
                    //$('#txth_ftem_id').val(data.ids); 
                    //AccionTipo=data.accion;
                    menssajeModal(response.status, response.type, message.info, response.label, "", "", "1");
                    limpiarDatos();
                    var renderurl = $('#txth_base').val() + "/mceformulariotemp/index";
                    window.location = renderurl;
                }else{
                    menssajeModal(response.status, response.type, message.info, response.label, "", "", "1");
                }             
            }, true);
        }
    } else {
        //alert('Debe Aceptar los términos de la Declaración Jurada');
        showAlert('NO_OK', 'error', {"wtmessage": 'Debe Aceptar los términos de la Declaración Jurada', "title":'Información'});
    }
}

function dataSolicitudPart1(ID) {
    //imgSolicitudPart1();
    var datArray = new Array();
    var objDat = new Object();
    objDat.ftem_id = ID;//Genero Automatico
    objDat.can_id = $('#cmb_ciudad option:selected').val();
    objDat.reg_id = '1';//Ids de Registro
    objDat.ind_id = $('#cmb_ftem_giroprincipal option:selected').val();
    objDat.ftem_origen = $('#cmb_ftem_origen option:selected').val();
    objDat.ftem_personeria = $('#cmb_ftem_personeria option:selected').val();
    objDat.ftem_nombre = $('#txt_ftem_nombre').val();
    objDat.ftem_apellido = $('#txt_ftem_apellido').val();
    objDat.ftem_cedula = $('#txt_ftem_cedula').val();
    objDat.ftem_ruc = (objDat.ftem_personeria == 1) ? $('#txt_ftem_ruc_persona').val() : $('#txt_ftem_ruc_empresa').val();
    objDat.ftem_direccion = $('#txt_ftem_direccion').val();
    objDat.ftem_sitio_web = $('#txt_ftem_sitio_web').val();
    objDat.ftem_cargo_persona = $('#txt_ftem_cargo_persona').val();

    objDat.ftem_contacto = $('#txt_ftem_contacto').val();
    objDat.ftem_contacto_cargo = $('#txt_ftem_contacto_cargo').val();
    objDat.ftem_contacto_correo = $('#txt_ftem_contacto_correo').val();
    objDat.ftem_contacto_telefono = $('#txt_ftem_contacto_telefono').val();
    objDat.pai_id_ext = 56;//$('#cmb_ftem_personeria option:selected').val(); 
    objDat.ftem_ciudad_ext = '';//$('#txt_ftem_ciudad_ext').val();
    objDat.ftem_correo = $('#txt_ftem_correo').val();
    objDat.ftem_telefono = $('#txt_ftem_telefono').val();
    objDat.ftem_genero = $('#cmb_ftem_genero option:selected').val();
    objDat.ftem_raza_etnica = $('#cmb_ftem_raza_etnica option:selected').val();
    objDat.ftem_tipo_pyme = $('#cmb_ftem_tipo_pyme option:selected').val();
    objDat.ftem_razon_social = (objDat.ftem_personeria == 2) ? $('#txt_ftem_razon_social').val() : '';//Verifica si es juridica para la Razon Soclial
    objDat.ftem_cedula_file = ($('#txth_ftem_cedula_file').val() != '') ? 'cedula.' + getExtension($('#txth_ftem_cedula_file').val()) : '';
    objDat.ftem_ruc_file = ($('#txth_ftem_ruc_file').val() != '') ? 'ruc.' + getExtension($('#txth_ftem_ruc_file').val()) : '';
    objDat.ftem_cert_file = ($('#txth_ftem_cer_file').val() != '') ? 'certificado_votacion.' + getExtension($('#txth_ftem_cer_file').val()) : '';
    objDat.ftem_registro_sanitario_file = ($('#txth_ftem_registro_sanitario_file').val() != '') ? 'registro_sanitario.' + getExtension($('#txth_ftem_registro_sanitario_file').val()) : '';
    objDat.ftem_perm_func_mitur_file = ($('#txth_ftem_perm_func_mitur_file').val() != '') ? 'permiso_mintur.' + getExtension($('#txth_ftem_perm_func_mitur_file').val()) : '';
    objDat.ftem_cert_super_compania_file = ($('#txth_ftem_cert_super_compania_file').val() != '') ? 'super_compania.' + getExtension($('#txth_ftem_cert_super_compania_file').val()) : '';
    objDat.ftem_cert_obligaciones_file = '';//$('#ftem_cert_obligaciones_file').val();

    datArray[0] = objDat;
    sessionStorage.dataSolicitud_1 = JSON.stringify(datArray);
    //return JSON.stringify(datArray);
    return datArray;
}

/* 
 * CONSULTA DATOS DE PERFIL
 * Retorna sus datos
 */

function loadDataUpdate() {
    mostrarDatos(varPerData);
}

function mostrarDatos(varPer) {
    //$('#txth_ftem_id').val(varPer[0]['Ids']);
    $('#txt_per_nombre').val(varPer[0]['Nombre']);
    $('#txt_per_apellido').val(varPer[0]['Apellido']);
    $('#txt_per_ced_ruc').val((varPer[0]['Cedula']!=null)?varPer[0]['Cedula']:'');
    $('#txt_per_correo').val((varPer[0]['Correo']!=null)?varPer[0]['Correo']:'');
    $('#cmb_per_genero').val((varPer[0]['Genero']!=null)?varPer[0]['Genero']:'M');//Masculino por defecto
    $('#cmb_per_estado_civil').val((varPer[0]['Est_Civ']!=null)?varPer[0]['Est_Civ']:'S');//Soltero Por Defecto
    $('#cmb_per_tipo_sangre').val((varPer[0]['Gru_San']!=null)?varPer[0]['Gru_San']:'A+');
    $('#dtp_per_fecha_nacimiento').val((varPer[0]['Fec_Nac']!=null)?varPer[0]['Fec_Nac']:'');
    
    $('#cmb_provincia').val((varPer[0]['Provincia']!=null)?varPer[0]['Provincia']:'1');
    $('#cmb_ciudad').val((varPer[0]['Ciudad']!=null)?varPer[0]['Ciudad']:'1');
    
    $('#txt_dper_direccion').val((varPer[0]['Direccion']!=null)?varPer[0]['Direccion']:'');
    $('#txt_dper_telefono').val((varPer[0]['Telefono']!=null)?varPer[0]['Telefono']:'');
    $('#txt_dper_contacto').val((varPer[0]['Telefono']!=null)?varPer[0]['Celular']:'');
    $('#txt_dper_celular').val((varPer[0]['Telefono']!=null)?varPer[0]['Contacto']:'');
    
    
}

function InicioFormulario() {
    loadDataUpdate();
    /*if (AccionTipo == "Update") {
        loadDataUpdate();
    } else if (AccionTipo == "Create") {
        loadDataCreate();
    }*/
}

$(document).ready(function () {
    InicioFormulario();//Inicia Datos de Formulario
    
    $('#cmb_provincia').change(function () {
        obtenerCanton();
    });
    
    $('#paso3next').click(function () {
        dataSolicitudPart3();
        if(AccionTipo=='Update'){
           guardarSolicitud('Update');
        }else if(AccionTipo=='Create'){
           guardarSolicitud('Create'); 
        }
    });
    
});