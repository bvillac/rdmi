/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//var conn = new WebSocket('ws://localhost:8080');
/*var conn = new WebSocket('ws://192.168.10.100:8080');
conn.onmessage = function (e) {
    console.log('Response:' + e.data);
};
conn.onopen = function (e) {
    console.log("Connection established!");
    console.log('Hey!');
    conn.send('Hey!');
};*/


$( document ).ready(function() {

    var socket = io.connect('http://192.168.10.100:8890');

    socket.on('notification', function (data) {

        var message = JSON.parse(data);

        $( "#notifications" ).prepend( "<p><strong>" + message.name + "</strong>: " + message.message + "</p>" );

    });

});
