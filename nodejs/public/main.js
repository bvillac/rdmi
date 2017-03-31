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
/*var socket = io.connect('https://192.168.10.100:8890');

socket.on('notiByron', function (data) {
    //recibe el Mensaje.    
    var message = data;//JSON.parse(data);
    //var message = JSON.parse(data);
    //var message=JSON.stringify(data)
    console.log(message);
    $("#notifications").prepend("<p><strong>" + message[0]['name'] + "</strong>: " + message[0]['message'] + "</p>");
});*/






// ......................................................
// .......................UI Code........................
// ......................................................
document.getElementById('open-room').onclick = function() {
    //this.disabled = true;
    connection.open(document.getElementById('room-id').value);
};
document.getElementById('join-room').onclick = function() {
    //this.disabled = true;
    connection.join(document.getElementById('room-id').value);
};
document.getElementById('open-or-join-room').onclick = function() {
    //this.disabled = true;
    connection.openOrJoin(document.getElementById('room-id').value);
};
// ......................................................
// ................FileSharing/TextChat Code.............
// ......................................................
document.getElementById('share-file').onclick = function() {
    var fileSelector = new FileSelector();
    fileSelector.selectSingleFile(function(file) {
        connection.send(file);
    });
};
document.getElementById('input-text-chat').onkeyup = function(e) {
    if(e.keyCode != 13) return;
    
    // removing trailing/leading whitespace
    this.value = this.value.replace(/^\s+|\s+$/g, '');
    if (!this.value.length) return;
    
    connection.send(this.value);
    appendDIV(this.value);
    this.value =  '';
};
var chatContainer = document.querySelector('.chat-output');
function appendDIV(event) {
    var div = document.createElement('div');
    div.innerHTML = event.data || event;
    chatContainer.insertBefore(div, chatContainer.firstChild);
    div.tabIndex = 0; div.focus();
    
    document.getElementById('input-text-chat').focus();
}



// ......................................................
// ..................RTCMultiConnection Code.............
// ......................................................
var connection = new RTCMultiConnection();  
//connection.socketURL = 'https://192.168.10.156:443/';
connection.socketURL = 'https://192.168.10.156:8543/';
//connection.socketURL = 'https://192.168.10.156:8890/';
connection.enableFileSharing = true; // by default, it is "false".
connection.session = {
    audio: true,
    video: true,
    data : true
};
connection.sdpConstraints.mandatory = {
    OfferToReceiveAudio: true,
    OfferToReceiveVideo: true
};
connection.onstream = function(event) {
    document.body.appendChild(event.mediaElement);
};
connection.onmessage = appendDIV;
connection.filesContainer = document.getElementById('file-container');
connection.onopen = function() {
    //document.getElementById('share-file').disabled      = false;
    //document.getElementById('input-text-chat').disabled = false;
};