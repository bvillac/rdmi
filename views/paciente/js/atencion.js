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


function obtenerCentrosAtencion() {
    var link = $('#txth_base').val() + "/paciente/adminpaciente";
    var arrParams = new Object();
    arrParams.esp_id = $('#lstb_especialidad_cita').val();
    arrParams.centros = true;
    requestHttpAjax(link, arrParams, function (response) {
        if (response.status == "OK") {
            var data = response.message;
            //console.log('entro');
            if (data.centros.length > 0) {
                //console.log(data.centros);            
                setComboData(data.centros, "lstb_centro_ate");
            }else{
                $("#lstb_centro_ate").html("<option value='0'>No Existen Datos</option>");
            }
        }else{            
            $("#lstb_centro_ate").html("<option value='0'>No Existen Datos</option>");
        }
    }, false);
}

function obtenerHorariosAtencion() {
    var link = $('#txth_base').val() + "/paciente/adminpaciente";
    var arrParams = new Object();
    arrParams.cons_id = $('#lstb_centro_ate').val();
    arrParams.fecha_cita = $('#dtp_fec_cita').val();
    arrParams.horas = true;
    requestHttpAjax(link, arrParams, function (response) {
        if (response.status == "OK") {
            var data = response.message;
            if (data.horarios.length > 0) {
                //console.log(data.centros);            
                setComboData(data.horarios, "lstb_horas_ate");
            }else{
                $("#lstb_horas_ate").html("<option value='0'>No Existen Datos</option>");
            }
        }else{            
            $("#lstb_horas_ate").html("<option value='0'>No Existen Datos</option>");
        }
    }, false);
}


function guardarDatosCita(accion) {
    //var pacID = (accion == "Update") ? $('#txth_pac_id').val() : 0;
    //var perID = (accion == "Update") ? $('#txth_per_id').val() : 0;
    var link = $('#txth_base').val() + "/paciente/savecita";
    var arrParams = new Object();
    arrParams.DATA = dataCita();
    arrParams.ACCION = accion;
    //var validation = validateForm();
    //if (!validation) {
        requestHttpAjax(link, arrParams, function (response) {
            var message = response.message;
            if (response.status == "OK") {
                obtenerHorariosAtencion();                
                $('#TbG_CITA').PbGridView('updatePAjax');
                showAlert(response.status, response.type, {"wtmessage": message.info, "title": response.label});
                //limpiarDatos();
                //var renderurl = $('#txth_base').val() + "/mceformulariotemp/index";
                //window.location = renderurl;
            } else {
                showAlert(response.status, response.type, {"wtmessage": message.info, "title": response.label});
            }
        }, true);
    //}
    //showAlert('NO_OK', 'error', {"wtmessage": 'Debe Aceptar los términos de la Declaración Jurada', "title":'Información'});
}

function dataCita() {
    var datArray = new Array();
    var objDat = new Object();
    objDat.pac_id = 0;//Genero Automatico
    objDat.tur_numero = 0;
    objDat.hora_id = $('#lstb_horas_ate option:selected').val();
    objDat.fecha_cita = $('#dtp_fec_cita').val();
    objDat.cons_id = $('#lstb_centro_ate').val();
    objDat.hora_inicio =$('#lstb_horas_ate option:selected').text().substring(0,8);//str.substring(1, 4);  $('#txt_per_apellido').val();    
    objDat.tcon_id = $('#cmb_tipConsulta option:selected').val();
    objDat.cprog_id = 0;    
    objDat.cmde_motivo = $('#txt_motivo').val();
    objDat.cmde_estado_asistencia = 1;
    objDat.cmde_est_log = 1;

    datArray[0] = objDat;
    sessionStorage.dataCita = JSON.stringify(datArray);
    return datArray;
}



function anularCita(ids) {
    //$('#TbG_SOLICITUD').PbGridView('applyFilterData',{'ids':ids,'op':'Delete'});
    if (confirm("Está seguro de que desea continuar?") == true) {
        var link = $('#txth_base').val() + "/paciente/anularcita";
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



function actualizarGridCP(){
    var estado=$('#cmb_estado option:selected').val();
    var especi=$('#cmb_especialidadCita option:selected').val();
    //var f_ini =$('#dtp_f_inicio').val();
    //var f_fin =$('#dtp_f_fin').val();
    var valor='';//$('#txt_buscarData').val();
    //Codigo para AutoComplete
    /*if(sessionStorage.src_buscIndex){
        valor=$('#txth_ids').val();
    } */
    //Buscar almenos una clase con el nombre para ejecutar
    if(!$(".blockUI").length){
        showLoadingPopup();
        $('#TbG_DATOS').PbGridView('applyFilterData',{'estado':estado,'especi':especi,'valor':valor,'op':'1'});
        setTimeout(hideLoadingPopup,2000);
    }
}

function divComentario(data) {
    //$("#countMensaje").html(data.length);
    var option_arr = '';
    option_arr += '<div style="overflow-y: scroll;height:200px;">';
        option_arr += '<div class="post clearfix">';
            option_arr += '<div class="user-block">';
                option_arr += '<span>';
                    //option_arr += '<a href="#">'+(data[i]["Nombres"]).toUpperCase()+'</a>';
                    //option_arr += '<a onclick="deleteComentario(\'' + data[i]['Ids'] + '\')" class="pull-right btn-box-tool" href="#"><i class="fa fa-times"></i></a>';
                option_arr += '</span><br>';
                //option_arr += '<span>'+(data[i]["fecha"]).toUpperCase()+'</span>';
            option_arr += '</div>';
            option_arr += '<p>'+(data).toUpperCase()+'</p>';
        option_arr += '</div>';
    option_arr += '</div>';
    showAlert("OK", "info", {"wtmessage": option_arr, "title": "Observaciones"});
}








