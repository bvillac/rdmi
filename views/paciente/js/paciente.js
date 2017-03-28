/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    InicioFormulario();//Inicia Datos de Formulario
    $('#cmb_provincia').change(function () {
        obtenerCanton();
    });
    
    $('#btn_saveCreate').click(function () {
        guardarDatos('Create');
    });
    $('#btn_saveUpdate').click(function () {
        guardarDatos('Update');
    });
    $('#btn_send').click(function () {
        EnviarSolicitudAte('Create');
    });
    
    $('#btn_sendmessage').click(function () {
        sendMessage();
    });
    
    $('#cmb_especialidad').change(function () {
        obtenerMedicoEspecialidad();
    });
    
});

function obtenerCanton() {
    var link = $('#txth_base').val() + "/paciente/create";
    var arrParams = new Object();
    arrParams.prov_id = $('#cmb_provincia').val();
    arrParams.getcantones = true;
    requestHttpAjax(link, arrParams, function (response) {
        if (response.status == "OK") {
            var data = response.message;
            setComboData(data.cantones, "cmb_ciudad");
        }
    }, true);
}


function dataPersona(pacID,perID) {
    var datArray = new Array();
    var objDat = new Object();
    objDat.pac_id = pacID;//Genero Automatico
    objDat.per_id = perID;
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
    objDat.pai_id = 56;
    objDat.prov_id = $('#cmb_provincia option:selected').val();
    objDat.can_id = $('#cmb_ciudad option:selected').val();
    //objDat.dper_descripcion=
    objDat.dper_direccion = $('#txt_dper_direccion').val();
    objDat.dper_telefono = $('#txt_dper_telefono').val();
    objDat.dper_celular = $('#txt_dper_celular').val();
    objDat.dper_contacto = $('#txt_dper_contacto').val();
    objDat.dper_est_log = 1;

    datArray[0] = objDat;
    sessionStorage.dataPersona = JSON.stringify(datArray);
    return datArray;
}

function setEspecialidades(elemento) {
    var dat = [];
    $('#' + elemento + ' :selected').each(function (i, selected) {
        //alert($(selected).text());
        dat[i] = $(selected).val();
    });
    sessionStorage.cmb_dataEspecialidad = JSON.stringify(dat);
    return dat;
}

function guardarDatos(accion) {
    var pacID = (accion == "Update") ? $('#txth_pac_id').val() : 0;
    var perID = (accion == "Update") ? $('#txth_per_id').val() : 0;
    var link = $('#txth_base').val() + "/paciente/save";
    var arrParams = new Object();
    arrParams.DATA = dataPersona(pacID,perID);
    arrParams.ACCION = accion;
    var validation = validateForm();
    if (!validation) {
        requestHttpAjax(link, arrParams, function (response) {
            var message = response.message;
            if (response.status == "OK") {
                showAlert(response.status, response.type, {"wtmessage": message.info, "title": response.label});
                //limpiarDatos();
                //var renderurl = $('#txth_base').val() + "/mceformulariotemp/index";
                //window.location = renderurl;
            } else {
                showAlert(response.status, response.type, {"wtmessage": message.info, "title": response.label});
            }
        }, true);
    }
    //showAlert('NO_OK', 'error', {"wtmessage": 'Debe Aceptar los términos de la Declaración Jurada', "title":'Información'});
}

function eliminarDatos(ids) {
    if (confirm("Está seguro de que desea continuar?") == true) {
        var link = $('#txth_base').val() + "/paciente/eliminar";
        var arrParams = new Object();
        arrParams.ids = ids;
        //arrParams.ACCION = "Rechazar";
        requestHttpAjax(link, arrParams, function (response) {
            var data = response.message;
            if (response.status == "OK") {
                //actualizarGrid();
                $('#TbG_PACIENTE').yiiGridView('applyFilter');
            }
            showAlert(response.status, response.type, {"wtmessage": data.info, "title": response.label});
        },true);
    }
}

function actualizarGrid(){
    var estado=$('#cmb_estado option:selected').val();
    var licencia=$('#cmb_usomarca option:selected').val();
    var f_ini =$('#dtp_f_inicio').val();
    var f_fin =$('#dtp_f_fin').val();
    var valor='';//$('#txt_buscarData').val();
    //Codigo para AutoComplete
    if(sessionStorage.src_buscIndex){
        valor=$('#txth_ids').val();
    } 
    //Buscar almenos una clase con el nombre para ejecutar
    if(!$(".blockUI").length){
        showLoadingPopup();
        $('#TbG_PACIENTE').PbGridView('applyFilterData',{'estado':estado,'f_ini':f_ini,'f_fin':f_fin,'licencia':licencia,'valor':valor,'op':'1'});
        setTimeout(hideLoadingPopup,2000);
    }
}

function loadDataUpdate() {
    mostrarDatos(varPerData);
}
function InicioFormulario() {
    if (AccionTipo == "Update") {
        loadDataUpdate();
    } else if (AccionTipo == "Create") {
        //loadDataCreate();
    }
}

function mostrarDatos(varPer) {
    //$('#txth_per_id').val(varPer[0]['Ids']);
    $('#txt_per_nombre').val(varPer[0]['Nombre']);
    $('#txt_per_apellido').val(varPer[0]['Apellido']);
    $('#txt_per_ced_ruc').val((varPer[0]['Cedula']!=null)?varPer[0]['Cedula']:'');
    $('#txt_per_correo').val((varPer[0]['Correo']!=null)?varPer[0]['Correo']:'');
    $('#cmb_per_genero').val((varPer[0]['Genero']!=null)?varPer[0]['Genero']:'M');//Masculino por defecto
    $('#cmb_per_estado_civil').val((varPer[0]['Est_Civ']!=null)?varPer[0]['Est_Civ']:'S');//Soltero Por Defecto
    $('#cmb_per_tipo_sangre').val((varPer[0]['Gru_San']!=null)?varPer[0]['Gru_San']:'A+');
    $('#dtp_per_fecha_nacimiento').val((varPer[0]['Fec_Nac']!=null)?varPer[0]['Fec_Nac']:'');
    $('#cmb_provincia').val((varPer[0]['Provincia']!=null)?varPer[0]['Provincia']:'1');
    $('#cmb_ciudad').val((varPer[0]['Canton']!=null)?varPer[0]['Canton']:'1');
    $('#txt_dper_direccion').val((varPer[0]['Direccion']!=null)?varPer[0]['Direccion']:'');
    $('#txt_dper_telefono').val((varPer[0]['Telefono']!=null)?varPer[0]['Telefono']:'');
    $('#txt_dper_contacto').val((varPer[0]['Contacto']!=null)?varPer[0]['Contacto']:'');
    $('#txt_dper_celular').val((varPer[0]['Celular']!=null)?varPer[0]['Celular']:'');
}



function sendMessage() {
    //Envia el Mensaje al Controlador
    /*var link = $('#txth_base').val() + "/paciente/sendmessage";
    var arrParams = new Object();
    arrParams.name = $('#txt_name').val();
    arrParams.message = $('#txt_message').val();
    requestHttpAjax(link, arrParams, function (response) {
        
    }, true);*/
    
    var datArray = new Array();
    var arrParams = new Object();
    arrParams.name = $('#txt_name').val();//JSON.stringify
    arrParams.message = $('#txt_message').val();//new Array()
    datArray[0] = arrParams;
    
    //socket.emit('notiByron', JSON.parse(datArray));
    socket.emit('notiByron', arrParams);
    
}
