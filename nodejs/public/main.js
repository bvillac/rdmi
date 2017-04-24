/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
// ......................................................
// ..................RTCMultiConnection Code.............
// ......................................................
var connection = new RTCMultiConnection();
// by default, socket.io server is assumed to be deployed on your own URL
//connection.socketURL = '/';
connection.socketURL = 'https://192.168.10.156:9001/';
//connection.socketURL = 'https://192.168.10.100:9001/';
// comment-out below line if you do not have your own socket.io server
connection.socketMessageEvent = 'audio-video-file-chat-demo';
connection.enableFileSharing = true; // by default, it is "false".
connection.session = {
    audio: true,
    video: true,
    data: true
};
connection.sdpConstraints.mandatory = {
    OfferToReceiveAudio: true,
    OfferToReceiveVideo: true
};


connection.videosContainer = document.getElementById('videos-container');
connection.onstream = function(event) {
    var width = parseInt(connection.videosContainer.clientWidth / 2) - 20;
    var mediaElement = getMediaElement(event.mediaElement, {
        title: event.userid,
        buttons: ['full-screen'],
        width: width,
        showOnMouseEnter: false
    });
    connection.videosContainer.appendChild(mediaElement);
    setTimeout(function() {
        mediaElement.media.play();
    }, 5000);
    mediaElement.id = event.streamid;
};
connection.onstreamended = function(event) {
    var mediaElement = document.getElementById(event.streamid);
    if(mediaElement) {
        mediaElement.parentNode.removeChild(mediaElement);
    }
};

// ......................................................
// ..................Custom Messages.....................
// ......................................................
// this line must be defined earlier before "getSocket"
// or before open/join/openOrJoin
// connection.socketCustomEvent = 'custom-socket-event';
// to make above line highly secure;
// so that only users in the same channel can receive/send custom messages!
//connection.socketCustomEvent = connection.channel;
// above line is optional,
// however if you define it; make sure that it is on top of below line.
// because below line will setup an event listener on server based on above value.
connection.connectSocket(function (socket) {
    // listen custom messages from server
    //socket.on(connection.socketCustomEvent, function (message) {
    //    alert(message.sender + ' shared custom message:\n\n' + message.customMessage);
    //});
    // send custom messages to server

    //var customMessage ='hola como estas??'+$('#txth_nombres').val();//$('#input-text-chat').val(); //prompt('Enter test message.');
    //socket.emit(connection.socketCustomEvent, {
    //    sender: connection.userid,
    //    customMessage: customMessage
    //});
    
});
// ......................................................

function showClockChat() {
    var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    var Digital = new Date();
    var hours = Digital.getHours();
    var minutes = Digital.getMinutes();
    var seconds = Digital.getSeconds();
    var month = monthNames[Digital.getMonth()];//objLang[monthNames[Digital.getMonth()]];
    var day = Digital.getDate();
    var year = Digital.getFullYear();
    var dn = "PM";
    if (hours < 12)
        dn = "AM";
    if (hours > 12)
        hours = hours - 12;
    if (hours == 0)
        hours = 12;
    if (minutes <= 9)
        minutes = "0" + minutes;
    if (seconds <= 9)
        seconds = "0" + seconds;
    if (day <= 9)
        day = "0" + day;    
    return day + " " + month + " " + hours + ":" + minutes + " " + dn
}


function appendDIV(event) {
    //var chatContainer = document.querySelector('.chat-output');
    var bandChat=false;
    var message = JSON.parse(event.data || event);
    //console.log(message);
    //var nombres=message.name;
    //var div = document.createElement('div');
    //div.innerHTML = event.data || event;
    //chatContainer.insertBefore(div, chatContainer.firstChild);
    //div.tabIndex = 0;
    //div.focus();
    
    //bandChat=1 >>>> Usuario Local Caso Contrario = >>> 0
    bandChat=(message.Ids == $('#txth_userweb').val()) ? true:false;
    var chatMs_arr = '';
    chatMs_arr += (bandChat)? '<div class="direct-chat-msg">':'<div class="direct-chat-msg right">';
        chatMs_arr += '<div class="direct-chat-info clearfix">';
            if(bandChat){
                chatMs_arr += '<span class="direct-chat-name pull-right">'+ message.name +'</span>';
                chatMs_arr += '<span class="direct-chat-timestamp pull-left">'+ showClockChat() +'</span>';
            }else{
                chatMs_arr += '<span class="direct-chat-name pull-left">'+ message.name +'</span>';
                chatMs_arr += '<span class="direct-chat-timestamp pull-right">'+ showClockChat() +'</span>';
            }
        chatMs_arr += '</div>';
        chatMs_arr += '<div class="direct-chat-text">';
            //chatMs_arr += event.data || event;
            chatMs_arr += message.message;
        chatMs_arr += '</div>';
    chatMs_arr += '</div>';
    $("#direct-chat-messages").prepend(chatMs_arr);//Al inicio
    //$("#direct-chat-messages").append(chatMs_arr);//Al final
    
    document.getElementById('input-text-chat').focus();
}

connection.onmessage = appendDIV;
connection.filesContainer = document.getElementById('file-container');

connection.onopen = function() {
    //document.getElementById('share-file').disabled = false;
    document.getElementById('input-text-chat').disabled = false;
    document.getElementById('btn-leave-room').disabled = false;    
    //document.querySelector('h3').innerHTML = 'Estás conectado con: ' + connection.getAllParticipants().join(', ');
    document.getElementById('infoVideo').innerHTML = 'Estás conectado con: ' + connection.getAllParticipants().join(', ');
};
connection.onclose = function() {
    if(connection.getAllParticipants().length) {
        //document.querySelector('h3').innerHTML = 'Todavía estás conectado con: ' + connection.getAllParticipants().join(', ');
        document.getElementById('infoVideo').innerHTML = 'Todavía estás conectado con: ' + connection.getAllParticipants().join(', ');
    }
    else {
        document.getElementById('infoVideo').innerHTML = 'Parece que la sesión ha sido cerrada o todos los participantes se han ido.';
        //document.querySelector('h3').innerHTML = 'Parece que la sesión ha sido cerrada o todos los participantes se han ido.';
    }
};
connection.onEntireSessionClosed = function(event) {
    //document.getElementById('share-file').disabled = true;
    document.getElementById('input-text-chat').disabled = true;
    document.getElementById('btn-leave-room').disabled = true;
    document.getElementById('open-or-join-room').disabled = false;
    document.getElementById('open-room').disabled = false;
    document.getElementById('join-room').disabled = false;
    //document.getElementById('room-id').disabled = false;
    connection.attachStreams.forEach(function(stream) {
        stream.stop();
    });
    // don't display alert for moderator
    if(connection.userid === event.userid) return;
    //document.querySelector('h3').innerHTML = 'Toda la sesión ha sido cerrada por el moderador: ' + event.userid;
    document.getElementById('infoVideo').innerHTML = 'Toda la sesión ha sido cerrada por el moderador: ' + event.userid;
};
connection.onUserIdAlreadyTaken = function(useridAlreadyTaken, yourNewUserId) {
    // seems room is already opened
    connection.join(useridAlreadyTaken);
};
function disableInputButtons() {
    //document.getElementById('open-or-join-room').disabled = true;
    //document.getElementById('open-room').disabled = true;
    //document.getElementById('join-room').disabled = true;
    //document.getElementById('room-id').disabled = true;
}
// ......................................................
// ......................Handling Room-ID................
// ......................................................
function showRoomURL(roomid) {
    //console.log('ingresa mostrar video');
    var roomHashURL = '#' + roomid;
    var roomQueryStringURL = '?roomid=' + roomid;
    var html = '<h2>Unique URL for your room:</h2><br>';
    html += 'Hash URL: <a href="' + roomHashURL + '" target="_blank">' + roomHashURL + '</a>';
    html += '<br>';
    html += 'QueryString URL: <a href="' + roomQueryStringURL + '" target="_blank">' + roomQueryStringURL + '</a>';
    var roomURLsDiv = document.getElementById('room-urls');
    roomURLsDiv.innerHTML = html;
    roomURLsDiv.style.display = 'block';
}
(function() {
    var params = {},
        r = /([^&=]+)=?([^&]*)/g;
    function d(s) {
        return decodeURIComponent(s.replace(/\+/g, ' '));
    }
    var match, search = window.location.search;
    while (match = r.exec(search.substring(1)))
        params[d(match[1])] = d(match[2]);
    window.params = params;
})();
var roomid = '';
if (localStorage.getItem(connection.socketMessageEvent)) {
    roomid = localStorage.getItem(connection.socketMessageEvent);
} else {
    roomid = connection.token();
}


var hashString = location.hash.replace('#', '');
if(hashString.length && hashString.indexOf('comment-') == 0) {
  hashString = '';
}
var roomid = params.roomid;
if(!roomid && hashString.length) {
    roomid = hashString;
}
if(roomid && roomid.length) {
    //document.getElementById('room-id').value = roomid;
    localStorage.setItem(connection.socketMessageEvent, roomid);
    // auto-join-room
    (function reCheckRoomPresence() {
        connection.checkPresence(roomid, function(isRoomExists) {
            if(isRoomExists) {
                connection.join(roomid);
                return;
            }
            setTimeout(reCheckRoomPresence, 5000);
        });
    })();
    disableInputButtons();
}
