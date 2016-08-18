/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function autocompletarBuscarPaciente(request, response, control, op) {
    var link = $('#txth_base').val() + "/medico/buscarpacientes";
    $.ajax({
        type: 'POST',
        dataType: 'json',
        url:link,
        data:{
            valor: $('#' + control).val(),
            op: op
        },
        success:function(data){
            var arrayList =new Array;
            for(var i=0;i<data.length;i++){
                row=new Object();
                row.Cedula = data[i]['Cedula'];
                row.Nombres = data[i]['Nombres'];     
                // Campos Importandes relacionados con el  CJuiAutoComplete
                row.id = data[i]['Ids'];
                row.label = data[i]['Nombres'] + ' - ' + data[i]['Cedula'];
                row.value = data[i]['Nombres'];//lo que se almacena en en la caja de texto
                arrayList[i] = row;
            }
            sessionStorage.src_buscIndex = JSON.stringify(arrayList);
            response(arrayList);  
        }
    })
}
function clearGrid(){
    //Limpia la Caja de Texto y actualiza la Grid
    if($('#txt_buscarData').val()==''){
        $('#txth_ids').val('');
        $('#txt_per_nombre').val('');
        //actualizarGrid();
    }
}

function guardarDatosCitas(accion) {
    if (validarFormularioTab2()) {
        var link = $('#txth_base').val() + "/medico/savemedicocita";
        var arrayList = JSON.parse(sessionStorage.src_buscIndex);
        var pac_id=retornarIndLista(arrayList,'Nombres',$('#txt_buscarData').val(),'id');
        var arrParams = new Object();        
        arrParams.OBSERV = $('#txt_observacion').val();
        arrParams.PAC_ID = pac_id;
        arrParams.EMED_ID = $('#cmb_especialidadCita').val();
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

function validarFormularioTab2(){
    var valor=true;
    var texbox="";
    if($('#cmb_especialidadCita').val()==0){
        texbox="Ingresar Especialidad <br>";
    }
    if($('#txt_buscarData').val()==""){
        texbox+="Ingresar Nombre Paciente <br>";
    }
    if($('#txt_observacion').val()==""){
        texbox+="Ingresar Observaciòn o Detalle <br>";
    }
    if(texbox !=''){
       showAlert('NO_OK', 'error', {"wtmessage": texbox, "title":'Información'});
       valor=false; 
    }
    return valor;
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

function rechazarCitaProgramada(ids) {
    //$('#TbG_SOLICITUD').PbGridView('applyFilterData',{'ids':ids,'op':'Delete'});
    if (confirm("Está seguro de que desea continuar?") == true) {
        var link = $('#txth_base').val() + "/medico/rechazarcitaprogramada";
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




function actualizarGridTab2(){
    var estado=$('#cmb_estado option:selected').val();
    //var licencia=$('#cmb_usomarca option:selected').val();
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
        $('#TbG_DATOS').PbGridView('applyFilterData',{'estado':estado,'valor':valor,'op':'1'});
        setTimeout(hideLoadingPopup,2000);
    }
}

function clearTab2(){
    //Limpia la Caja de Texto y actualiza la Grid
    $('#txt_buscarData').val('');
    $('#txt_observacion').val('');
    $('#cmb_especialidadCita').val(0);
        //actualizarGrid();
}

