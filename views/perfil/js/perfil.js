
function sentPassword(){
    var link = $('#txth_base').val() + "/perfil/save";
    var arrParams = new Object();
    arrParams.current = $("#frm_actual_clave").val();
    arrParams.new = $("#frm_nueva_clave").val();
    arrParams.confirm = $("#frm_nueva_clave_repeat").val();
    if(arrParams.new != arrParams.confirm){
        // error verificar 
        showAlert("NO_OK", "Error", {"wtmessage": "Contraseñas no coinciden. Ingrese correctamente la nueva contraseña.", "title":"Exito"});
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

function guardarPerfil(accion) {
    var ID = (accion == "Update") ? $('#txth_per_id').val() : 0;
    var link = $('#txth_base').val() + "/perfil/saveperfil";
    var arrParams = new Object();
    arrParams.DATA = dataPersona(ID);
    arrParams.ACCION = accion;
    var validation = validateForm();
    if (!validation) {
        requestHttpAjax(link, arrParams, function (response) {
            var message = response.message;
            if (response.status == "OK") {
                showAlert(response.status, response.type, {"wtmessage": message.info, "title":response.label});
                //limpiarDatos();
                //var renderurl = $('#txth_base').val() + "/mceformulariotemp/index";
                //window.location = renderurl;
            } else {
                showAlert(response.status, response.type, {"wtmessage": message.info, "title":response.label});
            }
        }, true);
    }
    //showAlert('NO_OK', 'error', {"wtmessage": 'Debe Aceptar los términos de la Declaración Jurada', "title":'Información'});
}

function dataPersona(ID) {
    var datArray = new Array();
    var objDat = new Object();
    objDat.per_id = ID;//Genero Automatico
    objDat.per_ced_ruc = $('#txt_per_ced_ruc').val();
    objDat.per_nombre = $('#txt_per_nombre').val();
    objDat.per_apellido = $('#txt_per_apellido').val();
    objDat.per_genero = $('#cmb_per_genero option:selected').val();
    objDat.per_fecha_nacimiento = $('#dtp_per_fecha_nacimiento').val();
    objDat.per_estado_civil = $('#cmb_per_estado_civil option:selected').val();
    objDat.per_correo = $('#txt_per_correo').val();
    //objDat.per_factor_rh = 
    objDat.per_tipo_sangre = $('#cmb_per_tipo_sangre option:selected').val();
    objDat.per_foto = '';
    //objDat.dper_id=
    objDat.pai_id=56;
    objDat.prov_id= $('#cmb_provincia option:selected').val();
    objDat.can_id= $('#cmb_ciudad option:selected').val();
    //objDat.dper_descripcion=
    objDat.dper_direccion= $('#txt_dper_direccion').val();
    objDat.dper_telefono= $('#txt_dper_telefono').val();
    objDat.dper_celular= $('#txt_dper_celular').val();
    objDat.dper_contacto= $('#txt_dper_contacto').val();
    objDat.dper_est_log= 1;
    datArray[0] = objDat;
    sessionStorage.dataPersona = JSON.stringify(datArray);
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
    $('#txth_per_id').val(varPer[0]['Ids']);
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
    $('#txt_dper_contacto').val((varPer[0]['Celular']!=null)?varPer[0]['Celular']:'');
    $('#txt_dper_celular').val((varPer[0]['Contacto']!=null)?varPer[0]['Contacto']:'');
    
    
}

function InicioFormulario() {
    loadDataUpdate();
    /*if (AccionTipo == "Update") {
        loadDataUpdate();
    } else if (AccionTipo == "Create") {
        loadDataCreate();
    }*/
}

/*
 * Eventos de Botones
 */

$(document).ready(function () {
    InicioFormulario();//Inicia Datos de Formulario
    $('#cmb_provincia').change(function () {
        obtenerCanton();
    });
    
    $('#btn_save').click(function () {
        guardarPerfil("Update");        
    });
    
});