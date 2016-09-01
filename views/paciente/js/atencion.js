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


