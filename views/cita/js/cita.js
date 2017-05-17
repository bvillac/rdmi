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
    
    $('#cmd_buscarData').click(function () {
        actualizarGrid();
    });
    
    $('#btn_save').click(function () {
        guardarPerfil("Update");        
    });
    
});

/*
 * FILTRAR DATOS GRID
 */

function actualizarGrid(){
    var estado=$('#cmb_estado option:selected').val();
    var IdEsp=$('#cmb_especialidad option:selected').val();
    var IdCons=$('#cmb_consultorio option:selected').val();
    var f_cita =$('#dtp_fec_cita').val();
    //var f_fin =$('#dtp_f_fin').val();
    var valor='';//$('#txt_buscarData').val();
    
    //Codigo para AutoComplete
    //if(sessionStorage.src_buscIndex){
        //var arrayList = JSON.parse(sessionStorage.src_buscIndex);
        //Cedula=retornarIndLista(arrayList,'RazonSocial',$('#txt_buscarData').val(),'Cedula');
        //valor=$('#txth_ids').val();
    //} 
    
    //Buscar almenos una clase con el nombre para ejecutar
    if(!$(".blockUI").length){
        showLoadingPopup();
        $('#TbG_CITA').PbGridView('applyFilterData',{'estado':estado,'f_cita':f_cita,'IdEsp':IdEsp,'IdCons':IdCons,'valor':valor,'op':'1'});
        setTimeout(hideLoadingPopup,2000);
    }
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


//ANULAR CITA MEDICA
function anularCita(ids) {
    //$('#TbG_SOLICITUD').PbGridView('applyFilterData',{'ids':ids,'op':'Delete'});
    if (confirm("Está seguro de que desea continuar?") == true) {
        var link = $('#txth_base').val() + "/cita/anularcita";
        var arrParams = new Object();
        arrParams.ids = ids;
        //arrParams.ACCION = "Rechazar";
        requestHttpAjax(link, arrParams, function (response) {
            var data = response.message;
            if (response.status == "OK") {
                $('#TbG_CITA').PbGridView('updatePAjax');
                //actualizarGridTab2();
            }
            showAlert(response.status, response.type, {"wtmessage": data.info, "title": response.label});
        },true);
    }
}
