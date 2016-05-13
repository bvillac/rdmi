/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    $('#btn_save').click(function () {
        guardarDatos('Create');
    });
    
    
});

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
    objDat.pai_id = 56;
    objDat.prov_id = $('#cmb_provincia option:selected').val();
    objDat.can_id = $('#cmb_ciudad option:selected').val();
    //objDat.dper_descripcion=
    objDat.dper_direccion = $('#txt_dper_direccion').val();
    objDat.dper_telefono = $('#txt_dper_telefono').val();
    objDat.dper_celular = $('#txt_dper_celular').val();
    objDat.dper_contacto = $('#txt_dper_contacto').val();
    objDat.dper_est_log = 1;
    //DATOS TAB ESPECIALIDAD
    objDat.especialidades = setEspecialidades('cmb_especialidad');
    objDat.emp_id = $('#cmb_empresa option:selected').val();
    objDat.med_colegiado='224';
    objDat.med_registro='22';
    
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
    sessionStorage.cmb_dataNacional = JSON.stringify(dat);
    return dat;
}

function guardarDatos(accion) {
    var ID = (accion == "Update") ? $('#txth_per_id').val() : 0;
    var link = $('#txth_base').val() + "/medico/savemedico";
    var arrParams = new Object();
    arrParams.DATA = dataPersona(ID);
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

