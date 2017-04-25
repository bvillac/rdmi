/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var socket = io.connect('https://192.168.10.156:8890');

socket.on('notiByron', function (data) {
    //recibe el Mensaje.    
    var message = data;//JSON.parse(data);
    console.log(message);
    $("#notifications").prepend("<p><strong>" + message[0]['name'] + "</strong>: " + message[0]['message'] + "</p>");
});

