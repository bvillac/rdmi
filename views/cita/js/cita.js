/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * Eventos de Botones
 */

$(document).ready(function () {
    //InicioFormulario();//Inicia Datos de Formulario
    //$('#cmb_provincia').change(function () {
    //    obtenerCanton();
    //});
    
    $('#btn_save').click(function () {
        guardarPerfil("Update");        
    });
    
});

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
