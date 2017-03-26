/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$( document ).ready(function() {
    //Nota: Para el Uso de Certificado agregar HTTPS  y HTTP para hacerlo normal
    //var socket = io.connect('https://192.168.10.100:8890');
    var socket = io.connect('https://192.168.10.156:8890');
    //var socket = io.connect('http://localhost:8890');

    socket.on('notification', function (data) {
        //recibe el Mensaje.    
        var message = JSON.parse(data);
        console.log(message);

        $( "#notifications" ).prepend( "<p><strong>" + message.name + "</strong>: " + message.message + "</p>" );

    });
    
    //agregados.    
    //ENVIAR IMAGENES
    socket.on('addimage', function (msg,base64img) {
        $( "#messgeFile" ).append(
            $('<p>').append($('<b>').text(msg),'<a target="_blank" href="'+ base64img +'"> ')
            )
    });

    $("#fileImage").on('change',function(e){
      var file =e.originalEvent.target.files[0];
      var reader = new FileReader();
      reader.onload=function(evt){
          //Enviar la imagen
          socket.emit('user image',evt.target.result);
      };
      reader.readAsDataURL(file);
    });  
    
    
});


