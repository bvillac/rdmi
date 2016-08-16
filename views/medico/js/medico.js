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
    
    $('#cmb_empresa').change(function () {
        obtenerAdmCentro();
    });
    
    $('#cmb_especialidad').change(function () {
        obtenerAdmConsultorio();
    });
    
    $('#btn_saveCreate').click(function () {
        guardarDatos('Create');
    });
    $('#btn_saveUpdate').click(function () {
        guardarDatos('Update');
    });
    $('#cmd_generarHora').click(function () {
        obtenerHoraiosMedico();
    });
    $('#cmd_saveHora').click(function () {
        guardarDatosHoras('Create');
    });
});

function obtenerCanton() {
    var link = $('#txth_base').val() + "/medico/create";
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

function obtenerAdmCentro() {
    var link = $('#txth_base').val() + "/medico/adminmedico";
    var arrParams = new Object();
    arrParams.emp_id = $('#cmb_empresa').val();
    arrParams.getcentro = true;
    requestHttpAjax(link, arrParams, function (response) {
        if (response.status == "OK") {
            var data = response.message;
            setComboData(data.centroatencion, "cmb_centro");
        }
    }, true);
}

function obtenerAdmConsultorio() {
    var link = $('#txth_base').val() + "/medico/adminmedico";
    var arrParams = new Object();
    arrParams.esp_id = $('#cmb_especialidad').val();
    arrParams.cate_id = $('#cmb_centro').val();
    arrParams.getconsultorio = true;
    requestHttpAjax(link, arrParams, function (response) {
        if (response.status == "OK") {
            var data = response.message;
            setComboData(data.consultorio, "cmb_consultorio");
        }
    }, true);
}


function dataPersona(medID,perID) {
    var datArray = new Array();
    var objDat = new Object();
    objDat.med_id = medID;//Genero Automatico
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
    //DATOS TAB ESPECIALIDAD
    objDat.especialidades = setEspecialidades('cmb_especialidad');
    objDat.emp_id = $('#cmb_empresa option:selected').val();
    objDat.med_colegiado=$('#txt_med_colegiado').val();
    objDat.med_registro=$('#txt_med_registro').val();
    
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
    var medID = (accion == "Update") ? $('#txth_med_id').val() : 0;
    var perID = (accion == "Update") ? $('#txth_per_id').val() : 0;
    var link = $('#txth_base').val() + "/medico/savemedico";
    var arrParams = new Object();
    arrParams.DATA = dataPersona(medID,perID);
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
        var link = $('#txth_base').val() + "/medico/eliminar";
        var arrParams = new Object();
        arrParams.ids = ids;
        //arrParams.ACCION = "Rechazar";
        requestHttpAjax(link, arrParams, function (response) {
            var data = response.message;
            if (response.status == "OK") {
                //actualizarGrid();
                $('#TbG_MEDICO').yiiGridView('applyFilter');
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
        $('#TbG_SOLICITUD').PbGridView('applyFilterData',{'estado':estado,'f_ini':f_ini,'f_fin':f_fin,'licencia':licencia,'valor':valor,'op':'1'});
        setTimeout(hideLoadingPopup,2000);
    }
}

function loadDataUpdate() {
    mostrarDatos(varPerData);
    mostrarDatosMedico(varMedData,varEspData,varEmpData);
}
function InicioFormulario() {
    if (AccionTipo == "Update") {
        loadDataUpdate();
    } else if (AccionTipo == "Create") {
        //loadDataCreate();
    } else if (AccionTipo == "Admin") {
        //loadDataCreate();
    }
}
function mostrarDatosMedico(varMed,varEsp,varEmp) {
    $('#txt_med_colegiado').val(varMed[0]['med_colegiado']);
    $('#txt_med_registro').val(varMed[0]['med_registro']);
    $('#cmb_empresa').val((varEmp[0]['IdsEmp']!=null)?varEmp[0]['IdsEmp']:'1');
    for (var i = 0; i < varEsp.length; i++) {
        $("#cmb_especialidad option[value=" + varEsp[i]['IdsEsp'] + "]").attr("selected", true);
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


//GENERAR HORARIOS

function obtenerHoraiosMedico() {
    if (validarFormulario()) {
        var link = $('#txth_base').val() + "/medico/adminmedico";
        var arrParams = new Object();
        //arrParams.hora_id = $('#cmb_especialidad').val();
        arrParams.fecha_cita = $('#dtp_f_medHora').val();
        arrParams.cons_id = $('#cmb_consultorio').val();
        arrParams.cate_id = $('#cmb_centro').val();
        arrParams.esp_id = $('#cmb_especialidad').val();
        arrParams.med_id = $('#txth_med_id').val();
        arrParams.gethorio = true;
        requestHttpAjax(link, arrParams, function (response) {
            if (response.status == "OK") {
                $("#info-Horarios").empty();
                var data = response.message;//horarioCentro
                if (data.horarioMedico.length > 0) {
                    generarHorarios(data.horarioCentro);//Genera los HOrarios
                    recargarHorariosCheck(data.horarioMedico);//Recarga los Seleccionados
                } else {
                    if (data.horarioCentro.length > 0) {
                        generarHorarios(data.horarioCentro);
                    }
                }

            }
        }, true);
    }
}

function recargarHorariosCheck(data) {
    if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
            var ids=limpiarRutaSTR(data[i]['hora_inicio']);
            $("#"+ids).prop("checked", true);
        }
    }
}

function generarHorarios(data) {
    $("#lbl_cons_hora_inicio").text('HI: '+data[0]['cons_hora_inicio']); 
    $("#lbl_cons_hora_fin").text('HF: '+data[0]['cons_hora_fin']); 
    $("#lbl_cons_tiempo_consulta").text('PE: '+data[0]['cons_tiempo_consulta']); 
    var strData = "";
    var ids="";
    //var contador=1;
    var timeGenerado = data[0]['cons_hora_inicio'];
    strData += '<div class="form-group">';
    while (timeGenerado < data[0]['cons_hora_fin']) {
        ids=limpiarRutaSTR(timeGenerado);
        strData += '<div class="checkbox-inline">';
            strData += '<label>';
                strData += '<input type="checkbox" id="'+ids+'" value="'+timeGenerado+'" >';
                    strData += timeGenerado;
            strData += '</label>';
        strData += '</div>';
        //strData += ((contador%10)==0)?'</div><br>':'</div>';
        //contador++;
        timeGenerado = formatTime(timestrToSec(timeGenerado) + timestrToSec(data[0]['cons_tiempo_consulta']));
    }
    strData += '</div>';
    $("#info-Horarios").empty();
    $("#info-Horarios").append(strData);  
}

//Verificacion de Los Check Seleccionado en Horario
function obtenerHorariosCheck(){
    var datArray = new Array();
    var c=0;
    var rango =String($('#lbl_cons_tiempo_consulta').text()).replace('PE: ', '');
    $("input:checkbox:checked").each(function () {
        //cada elemento seleccionado
        var objDat=new Object();
        objDat.hora_id=$(this).val();
        objDat.hora_inicio=$(this).val();
        objDat.hora_fin=formatTime(timestrToSec($(this).val()) + timestrToSec(rango));;
        datArray[c] = objDat;
        sessionStorage.dataHorarios = JSON.stringify(datArray);
        c++;
    });
}

function guardarDatosHoras(accion) {
    if (validarFormulario()) {
        obtenerHorariosCheck();
        var link = $('#txth_base').val() + "/medico/savemedicohora";
        var medID = $('#txth_med_id').val();//(accion == "Update") ? $('#txth_med_id').val() : 0;
        //var perID = $('#txth_per_id').val();//(accion == "Update") ? $('#txth_per_id').val() : 0;
        var arrParams = new Object();
        arrParams.FECHA_CITA = $('#dtp_f_medHora').val();
        arrParams.CONS_ID = $('#cmb_consultorio').val();
        arrParams.MED_ID = medID;
        arrParams.DTS_HORARIOS = sessionStorage.dataHorarios;
        arrParams.ACCION = accion;
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
}

function validarFormulario(){
    var valor=true;
    var texbox="";
    if($('#cmb_consultorio').val()==0){
        texbox="Ingresar Consultorio <br>";
    }
    if($('#txth_med_id').val()==""){
        texbox+="Ingresar Mèdico <br>";
    }
    if($('#dtp_f_medHora').val()==""){
        texbox+="Ingresar la Fecha de Horarios <br>";
    }
    if(texbox !=''){
       showAlert('NO_OK', 'error', {"wtmessage": texbox, "title":'Información'});
       valor=false; 
    }
    return valor;
}






