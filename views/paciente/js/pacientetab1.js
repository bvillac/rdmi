/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//https://www.nicklauschildrens.org/patients-and-families/planning-your-visit/appointments-and-medical-procedures-requests?lang=es-CO
//https://www.veris.com.ec/citas/

$(document).ready(function () {

    $('#cmb_estado').change(function () {
        actualizarGridCP();
    });
    $('#cmb_especialidadCita').change(function () {
        actualizarGridCP();
    });
    
     $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay'
        },
        defaultDate: '2016-09-12',
        locale: 'es',
        navLinks: true, // can click day/week names to navigate views
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        events: [
            {
                title: 'All Day Event',
                start: '2016-09-01'
            },
            {
                title: 'Long Event',
                start: '2016-09-07',
                end: '2016-09-10'
            },
            {
                id: 999,
                title: 'Repeating Event',
                start: '2016-09-09T16:00:00'
            },
            {
                id: 999,
                title: 'Repeating Event',
                start: '2016-09-16T16:00:00'
            },
            {
                title: 'Conference',
                start: '2016-09-11',
                end: '2016-09-13'
            },
            {
                title: 'Meeting',
                start: '2016-09-12T10:30:00',
                end: '2016-09-12T12:30:00'
            },
            {
                title: 'Lunch',
                start: '2016-09-12T12:00:00'
            },
            {
                title: 'Meeting',
                start: '2016-09-12T14:30:00'
            },
            {
                title: 'Happy Hour',
                start: '2016-09-12T17:30:00'
            },
            {
                title: 'Dinner',
                start: '2016-09-12T20:00:00'
            },
            {
                title: 'Birthday Party',
                start: '2016-09-13T07:00:00'
            },
            {
                title: 'Click for Google',
                url: 'http://google.com/',
                start: '2016-09-28'
            }
        ]
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

