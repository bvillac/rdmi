/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*$( document ).ready(function() {
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
    

    $('#btn_sendFile').click(function () {
        socket.emit('byron', 'Hi server, how are you?');
        socket.emit('little_newbie', 'dorias');
    })
    
    socket.on('byron', function (data) {
        console.log(data);
    });
 
});*/


//var socket = io.connect('https://192.168.10.156:8890');
var socket = io.connect('https://192.168.10.100:8890');

socket.on('notiByron', function (data) {
    //recibe el Mensaje.    
    var message = data;//JSON.parse(data);
    console.log(message);
    $("#notifications").prepend("<p><strong>" + message[0]['name'] + "</strong>: " + message[0]['message'] + "</p>");
});


