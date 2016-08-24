/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


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

