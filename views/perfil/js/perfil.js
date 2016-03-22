
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
    
});