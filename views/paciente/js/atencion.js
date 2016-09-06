/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function obtenerMedicoEspecialidad() {
    var link = $('#txth_base').val() + "/paciente/atencion";
    var arrParams = new Object();
    arrParams.esp_id = $('#cmb_especialidad').val();
    arrParams.espcialidad = true;
    requestHttpAjax(link, arrParams, function (response) {
        if (response.status == "OK") {
            var data = response.message;
            setComboData(data.medicos, "cmb_medicos");
        }else{            
            $("#cmb_medicos").html("<option value='0'>No Existen Datos</option>");
        }
    }, true);
}

function eliminarAtencionMed(ids) {
    if (confirm("Está seguro de que desea continuar?") == true) {
        var link = $('#txth_base').val() + "/paciente/eliminaratencionmed";
        var arrParams = new Object();
        arrParams.ids = ids;
        //arrParams.ACCION = "Rechazar";
        requestHttpAjax(link, arrParams, function (response) {
            var data = response.message;
            if (response.status == "OK") {
                $('#TbG_DATOS').PbGridView('updatePAjax');
                //actualizarGridTab2();
            }
            //var message = {"wtmessage": data.info,"title": response.label};
            showAlert(response.status, response.type, {"wtmessage": data.info, "title": response.label});
        },true);
    }
}




function EnviarSolicitudAte(accion) {    
    if (validarFormSol()) {
        var link = $('#txth_base').val() + "/paciente/solicitudatencion";
        var arrParams = new Object();
        arrParams.DATA = obtenerMedicos('cmb_medicos');
        arrParams.ACCION = accion;
        requestHttpAjax(link, arrParams, function (response) {
            var message = response.message;
            if (response.status == "OK") {
                $('#TbG_DATOS').PbGridView('updatePAjax');
                showAlert(response.status, response.type, {"wtmessage": message.info, "title": response.label});
                
                //limpiarDatos();
            } else {
                showAlert(response.status, response.type, {"wtmessage": message.info, "title": response.label});
            }
        }, true);
    }
}

function validarFormSol(){
    var valor=true;
    var texbox="";
    if($('#cmb_especialidad').val()==0){
        texbox="Seleccionar Especialidades <br>";
    }
    //alert($("#cmb_medicos").val());
    if($("#cmb_medicos").val()==null){//Verifica que esten selecionado almenso 1
        texbox+="Selecionar Mèdico <br>";
    }
    if(texbox !=''){
       showAlert('NO_OK', 'error', {"wtmessage": texbox, "title":'Información'});
       valor=false; 
    }
    return valor;
}


function obtenerMedicos(elemento) {
    var dat = [];
    $('#' + elemento + ' :selected').each(function (i, selected) {
        dat[i] = $(selected).val();
    });
    sessionStorage.cmb_medicos = JSON.stringify(dat);
    return dat;
}





