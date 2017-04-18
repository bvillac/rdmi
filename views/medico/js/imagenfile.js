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
        //msgInvalidFileExtension: 'Invalid extension for file {name}. Only "{extensions} files are supported.',
        uploadAsync: true,
        //deleteExtraData: function (previewId, index) { return { key: index, pId: previewId, action: 'delete' }; },
        uploadExtraData: function (previewId, index) {
            //return {"numero":(AccionTipo=="Update")?$('#txt_ftem_cedula').val()+'_'+$('#txth_ftem_id').val():$('#txt_ftem_cedula').val(), "nombre": "cedula"};
            return {"numero":$('#txth_cedula').val(), "nombre": "cedula"};
        }
    });
    
    $('#txt_dicom_file').on('filebatchselected ', function (event) {
        $('#txth_dicom_file').val($('#txt_dicom_file').val())
        $('#txt_dicom_file').fileinput('upload');
    });
    $('#txt_dicom_file').on('fileuploaderror', function (event, data, previewId, index) { 
        $('#txth_dicom_file').val('');
        showAlert('NO_OK', 'error', {"wtmessage": $('#txth_errorFile').val(), "title":'Información'});
    });
    
    
}