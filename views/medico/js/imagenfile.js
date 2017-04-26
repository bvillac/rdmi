/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * http://plugins.krajee.com/file-input#installation
 */


//Buscar Datos de Usuario
function iniciarUpload() {
    //console.log('logo inicio');
     $("#txt_dicom_file").fileinput({
        language: FileIdioma,
        //type: "POST",
        previewFileType: "any",
        showPreview: false,
        showUpload: false, // hide upload button
        showRemove: true, // hide remove button
        removeLabel:'Eliminar',
        uploadUrl: $('#txth_base').val() + "/medico/uploadfile",
        //deleteUrl: "/Message/AsyncRemoveAction",
        maxFileSize: FileSize,
        browseLabel: browseLabel,
        initialCaption: "Adjuntar Documento",
        allowedFileExtensions: FileExtensions,
        msgInvalidFileExtension: 'Invalid extension for file {name}. Only "{extensions} files are supported.',
        msgSizeTooLarge: "File {name} ({size} KB) exceeds maximum upload size of {maxSize} KB. Please Try again",
        msgFilesTooMany: "Number of Files selected for upload ({n}) exceeds maximum allowed limit of {m}",
        msgInvalidFileType: 'Invalid type for file "{name}". Only {types} files are supported.',
        msgUploadEnd:'Archivo Agregado',
        msgValidationError:'File Upload Error',
        //msgInvalidFileExtension: 'Invalid extension for file {name}. Only "{extensions} files are supported.',
        uploadAsync: true,
        //deleteExtraData: function (previewId, index) { return { key: index, pId: previewId, action: 'delete' }; },
        msgFileNotFound:function (previewId, index) {
            showAlert('NO_OK', 'error', {"wtmessage": $('#txth_errorFile').val(), "title":'Información'});
        },
        uploadExtraData: function (previewId, index) {
            //return {"numero":(AccionTipo=="Update")?$('#txt_ftem_cedula').val()+'_'+$('#txth_ftem_id').val():$('#txt_ftem_cedula').val(), "nombre": "cedula"};
              return {"numero":$('#txth_cedula').val(),"idsPac":$('#txth_ids').val(),"idstipo":$('#cmb_tipoDicom').val(), "nombre": 'imgRX'};           
        }
    });
    
    //Este evento se activa cuando se hace clic en el botón de exploración de archivos para abrir el 
    //cuadro de diálogo de selección de archivos. Ejemplo:
//    $('#txt_dicom_file').on('filebrowse', function (event) {
//        if(subirDocumentos()){
//            $('#txt_dicom_file').fileinput('upload');//Evento Cargar
//            //$('#txt_dicom_file').fileinput('refresh');
//        }
//    });
    //Este evento se activa después de seleccionar un lote de archivos y mostrarlos en la vista previa
    $('#txt_dicom_file').on('filebatchselected ', function (event) {
        if(subirDocumentos()){//Verofica que las opciones de subida se cumplan
            $('#txth_dicom_file').val($('#txt_dicom_file').val())
            //showLoadingPopup();
            $('#txt_dicom_file').fileinput('upload');            
            //setTimeout(hideLoadingPopup,2000);
            
            
        }
    });
    $('#txt_dicom_file').on('fileuploaded', function(event, data, previewId, index) {
        //var form = data.form, files = data.files, extra = data.extra,
        //    response = data.response, reader = data.reader;
        $('#TbG_DATOS').PbGridView('updatePAjax');
    });
    $('#txt_dicom_file').on('fileuploaderror', function (event, data, previewId, index) { 
        $('#txth_dicom_file').val('');
        showAlert('NO_OK', 'error', {"wtmessage": $('#txth_errorFile').val(), "title":'Información'});
        $('#txt_dicom_file').fileinput('clear');
    });
    
    
}

function subirDocumentos() {
    var estado = true;
    //Valores Obligatorios
    var mensaje = '';
    if ($('#txt_buscarData').val() == '') {//Verifico si tiene Datos
        mensaje += 'Ingresar datos del Paciente, <br>';
        estado = false;//Retorna Error
    }
    
    if ($('#cmb_tipoDicom').val() ==0) {//Verifico si tiene Datos
        mensaje += 'Selecionar Tipo de Imagen, <br>';
        estado = false;//Retorna Error
    }
    
    if (!estado) {//Muestra Mensaje en Caso de que Exista un error
        var message = {
            "wtmessage": mensaje,
            "title": "Información",
        };
        showAlert("NO_OK", "error", message);
    }
    return estado;
}

function downloadFile(ids) {
    if (confirm("Está seguro de que desea continuar?") == true) {
        var link = $('#txth_base').val() + "/medico/downloadfile";
        var arrParams = new Object();
        arrParams.ids = ids;
        requestHttpAjax(link, arrParams, function (response) {
            var data = response.message;
            if (response.status == "OK") {
                //$('#TbG_DATOS').PbGridView('updatePAjax');
                //actualizarGrid();
            }
            showAlert(response.status, response.type, {"wtmessage": data.info, "title": response.label});
        }, true);
    }
}


function deleteFile(ids) {
    if (confirm("Está seguro de que desea continuar?") == true) {
        var link = $('#txth_base').val() + "/medico/deletefile";
        var arrParams = new Object();
        arrParams.ids = ids;
        requestHttpAjax(link, arrParams, function (response) {
            var data = response.message;
            if (response.status == "OK") {
                $('#TbG_DATOS').PbGridView('updatePAjax');
                //actualizarGrid();
            }
            showAlert(response.status, response.type, {"wtmessage": data.info, "title": response.label});
        }, true);
    }
}


function actualizarGrid(){
//    var estado=$('#cmb_estado option:selected').val();
//    var licencia=$('#cmb_usomarca option:selected').val();
//    var f_ini =$('#dtp_f_inicio').val();
//    var f_fin =$('#dtp_f_fin').val();
//    var valor='';//$('#txt_buscarData').val();
//    //Codigo para AutoComplete
//    if(sessionStorage.src_buscIndex){
//        valor=$('#txth_ids').val();
//    } 
    //Buscar almenos una clase con el nombre para ejecutar
    if(!$(".blockUI").length){
        showLoadingPopup();
        //$('#TbG_DATOS').PbGridView('applyFilterData',{'estado':estado,'f_ini':f_ini,'f_fin':f_fin,'licencia':licencia,'valor':valor,'op':'1'});
        $('#TbG_DATOS').PbGridView('applyFilterData');
        setTimeout(hideLoadingPopup,2000);
    }
}