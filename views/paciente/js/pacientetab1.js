/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {

    $('#cmb_estado').change(function () {
        actualizarGridCP();
    });
    $('#cmb_especialidadCita').change(function () {
        actualizarGridCP();
    });


});

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

