/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function autocompletarBuscarPersona(request, response, control, op) {
    var link = $('#txth_base').val() + "/medico/buscarpersonas";
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
                row.id = data[i]['Cedula'];
                row.label = data[i]['Nombres'] + ' - ' + data[i]['Cedula'];
                row.value = data[i]['Cedula'];//lo que se almacena en en la caja de texto
                $('#txt_per_nombre').val(data[i]['Nombres']);
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

