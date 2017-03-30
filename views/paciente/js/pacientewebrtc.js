/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * Change trace() call to console.log()
 * 
 * https://codelabs.developers.google.com/codelabs/webrtc-web/#4
 * https://www.html5rocks.com/en/tutorials/webrtc/infrastructure/
 * http://socket.io/
 * yum install npm
 */

'use strict';

/*
navigator.getUserMedia = navigator.getUserMedia ||
    navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

var constraints = {
  audio: true,
  video: true
};
var video = document.querySelector('video');

function successCallback(stream) {
  window.stream = stream; // stream available to console
  if (window.URL) {
    video.src = window.URL.createObjectURL(stream);
  } else {
    video.src = stream;
  }
}

function errorCallback(error) {
  console.log('navigator.getUserMedia error: ', error);
}

navigator.getUserMedia(constraints, successCallback, errorCallback);*/

/* inicio
'use strict';

var startButton = document.getElementById('startButton');
var callButton = document.getElementById('callButton');
var hangupButton = document.getElementById('hangupButton');
callButton.disabled = true;
hangupButton.disabled = true;
startButton.onclick = start;
callButton.onclick = call;
hangupButton.onclick = hangup;

var startTime;
var localVideo = document.getElementById('localVideo');
var remoteVideo = document.getElementById('remoteVideo');

localVideo.addEventListener('loadedmetadata', function() {
  console.log('Local video videoWidth: ' + this.videoWidth +
    'px,  videoHeight: ' + this.videoHeight + 'px');
    
});

remoteVideo.addEventListener('loadedmetadata', function() {
  console.log('Remote video videoWidth: ' + this.videoWidth +
    'px,  videoHeight: ' + this.videoHeight + 'px');
});

remoteVideo.onresize = function() {
  console.log('Remote video size changed to ' +
    remoteVideo.videoWidth + 'x' + remoteVideo.videoHeight);
  // We'll use the first onsize callback as an indication that video has started
  // playing out.
  if (startTime) {
    var elapsedTime = window.performance.now() - startTime;
    console.log('Setup time: ' + elapsedTime.toFixed(3) + 'ms');
    startTime = null;
  }
};

var localStream;
var pc1;
var pc2;
var offerOptions = {
  offerToReceiveAudio: 1,
  offerToReceiveVideo: 1
};

function getName(pc) {
  return (pc === pc1) ? 'pc1' : 'pc2';
}

function getOtherPc(pc) {
  return (pc === pc1) ? pc2 : pc1;
}

function gotStream(stream) {
  console.log('Received local stream');
  localVideo.srcObject = stream;
  localStream = stream;
  callButton.disabled = false;
}

//Iniciar la Video Local
function start() {
  console.log('Requesting local stream');
  startButton.disabled = true;
  navigator.mediaDevices.getUserMedia({
    audio: true,
    video: true
  })
  .then(gotStream)
  .catch(function(e) {
    alert('getUserMedia() error: ' + e.name);
  });
}

function call() {
  callButton.disabled = true;
  hangupButton.disabled = false;
  console.log('Starting call');
  startTime = window.performance.now();
  var videoTracks = localStream.getVideoTracks();
  var audioTracks = localStream.getAudioTracks();
  if (videoTracks.length > 0) {
    console.log('Using video device: ' + videoTracks[0].label);
  }
  if (audioTracks.length > 0) {
    console.log('Using audio device: ' + audioTracks[0].label);
  }
  
  var servers = null;
  pc1 = new RTCPeerConnection(servers);
  console.log('Created local peer connection object pc1');
  pc1.onicecandidate = function(e) {
    onIceCandidate(pc1, e);//Crea las Conexxiones
  };
  
  pc2 = new RTCPeerConnection(servers);
  console.log('Created remote peer connection object pc2');
  pc2.onicecandidate = function(e) {
    onIceCandidate(pc2, e);
  };
  
  pc1.oniceconnectionstatechange = function(e) {
    onIceStateChange(pc1, e);
  };
  pc2.oniceconnectionstatechange = function(e) {
    onIceStateChange(pc2, e);
  };
  pc2.onaddstream = gotRemoteStream;

  pc1.addStream(localStream);
  console.log('Added local stream to pc1');

  console.log('pc1 createOffer start');
  //Describe la seccion actual
  pc1.createOffer(
    offerOptions
  ).then(
    onCreateOfferSuccess,
    onCreateSessionDescriptionError
  );
}

function onCreateSessionDescriptionError(error) {
  console.log('Failed to create session description: ' + error.toString());
}

function onCreateOfferSuccess(desc) {
  console.log('Offer from pc1\n' + desc.sdp);
  console.log('pc1 setLocalDescription start');
  pc1.setLocalDescription(desc).then(
    function() {
      onSetLocalSuccess(pc1);
    },
    onSetSessionDescriptionError
  );
  console.log('pc2 setRemoteDescription start');
  pc2.setRemoteDescription(desc).then(
    function() {
      onSetRemoteSuccess(pc2);
    },
    onSetSessionDescriptionError
  );
  console.log('pc2 createAnswer start');
  // Since the 'remote' side has no media stream we need
  // to pass in the right constraints in order for it to
  // accept the incoming offer of audio and video.
  pc2.createAnswer().then(
    onCreateAnswerSuccess,
    onCreateSessionDescriptionError
  );
}

function onSetLocalSuccess(pc) {
  console.log(getName(pc) + ' setLocalDescription complete');
}

function onSetRemoteSuccess(pc) {
  console.log(getName(pc) + ' setRemoteDescription complete');
}

function onSetSessionDescriptionError(error) {
  console.log('Failed to set session description: ' + error.toString());
}

function gotRemoteStream(e) {
  remoteVideo.srcObject = e.stream;
  console.log('pc2 received remote stream');
}

function onCreateAnswerSuccess(desc) {
  console.log('Answer from pc2:\n' + desc.sdp);
  console.log('pc2 setLocalDescription start');
  pc2.setLocalDescription(desc).then(
    function() {
      onSetLocalSuccess(pc2);
    },
    onSetSessionDescriptionError
  );
  console.log('pc1 setRemoteDescription start');
  pc1.setRemoteDescription(desc).then(
    function() {
      onSetRemoteSuccess(pc1);
    },
    onSetSessionDescriptionError
  );
}

//Verifica que los candidatos de red esten disponibles
function onIceCandidate(pc, event) {
  if (event.candidate) {
    getOtherPc(pc).addIceCandidate(
      new RTCIceCandidate(event.candidate)
    ).then(
      function() {
        onAddIceCandidateSuccess(pc);
      },
      function(err) {
        onAddIceCandidateError(pc, err);
      }
    );
    console.log(getName(pc) + ' ICE candidate: \n' + event.candidate.candidate);
  }
}

function onAddIceCandidateSuccess(pc) {
  console.log(getName(pc) + ' addIceCandidate success');
}

function onAddIceCandidateError(pc, error) {
  console.log(getName(pc) + ' failed to add ICE Candidate: ' + error.toString());
}

function onIceStateChange(pc, event) {
  if (pc) {
    console.log(getName(pc) + ' ICE state: ' + pc.iceConnectionState);
    console.log('ICE state change event: ', event);
  }
}

function hangup() {
  console.log('Ending call');
  pc1.close();
  pc2.close();
  pc1 = null;
  pc2 = null;
  hangupButton.disabled = true;
  callButton.disabled = false;
}
fin*/


//DATA


//TRANFERENCIA DE DATOS

/*'use strict';

var localConnection;
var remoteConnection;
var sendChannel;
var receiveChannel;
var pcConstraint;
var bitrateDiv = document.querySelector('div#bitrate');
var fileInput = document.querySelector('input#fileInput');
var downloadAnchor = document.querySelector('a#download');
var sendProgress = document.querySelector('progress#sendProgress');
var receiveProgress = document.querySelector('progress#receiveProgress');
var statusMessage = document.querySelector('span#status');

var receiveBuffer = [];
var receivedSize = 0;

var bytesPrev = 0;
var timestampPrev = 0;
var timestampStart;
var statsInterval = null;
var bitrateMax = 0;

fileInput.addEventListener('change', handleFileInputChange, false);

function handleFileInputChange() {
  var file = fileInput.files[0];
  if (!file) {
    console.log('No file chosen');
  } else {
    createConnection();
  }
}

function createConnection() {
  var servers = null;
  pcConstraint = null;

  // Add localConnection to global scope to make it visible
  // from the browser console.
  window.localConnection = localConnection = new RTCPeerConnection(servers,
      pcConstraint);
  console.log('Created local peer connection object localConnection');

  sendChannel = localConnection.createDataChannel('sendDataChannel');
  sendChannel.binaryType = 'arraybuffer';
  console.log('Created send data channel');

  sendChannel.onopen = onSendChannelStateChange;
  sendChannel.onclose = onSendChannelStateChange;
  localConnection.onicecandidate = iceCallback1;

  localConnection.createOffer().then(
    gotDescription1,
    onCreateSessionDescriptionError
  );
  // Add remoteConnection to global scope to make it visible
  // from the browser console.
  window.remoteConnection = remoteConnection = new RTCPeerConnection(servers,
      pcConstraint);
  console.log('Created remote peer connection object remoteConnection');

  remoteConnection.onicecandidate = iceCallback2;
  remoteConnection.ondatachannel = receiveChannelCallback;

  fileInput.disabled = true;
}

function onCreateSessionDescriptionError(error) {
  console.log('Failed to create session description: ' + error.toString());
}

function sendData() {
  var file = fileInput.files[0];
  console.log('File is ' + [file.name, file.size, file.type,
      file.lastModifiedDate
  ].join(' '));

  // Handle 0 size files.
  statusMessage.textContent = '';
  downloadAnchor.textContent = '';
  if (file.size === 0) {
    bitrateDiv.innerHTML = '';
    statusMessage.textContent = 'File is empty, please select a non-empty file';
    closeDataChannels();
    return;
  }
  sendProgress.max = file.size;
  receiveProgress.max = file.size;
  var chunkSize = 16384;
  var sliceFile = function(offset) {
    var reader = new window.FileReader();
    reader.onload = (function() {
      return function(e) {
        sendChannel.send(e.target.result);
        if (file.size > offset + e.target.result.byteLength) {
          window.setTimeout(sliceFile, 0, offset + chunkSize);
        }
        sendProgress.value = offset + e.target.result.byteLength;
      };
    })(file);
    var slice = file.slice(offset, offset + chunkSize);
    reader.readAsArrayBuffer(slice);
  };
  sliceFile(0);
}

function closeDataChannels() {
  console.log('Closing data channels');
  sendChannel.close();
  console.log('Closed data channel with label: ' + sendChannel.label);
  if (receiveChannel) {
    receiveChannel.close();
    console.log('Closed data channel with label: ' + receiveChannel.label);
  }
  localConnection.close();
  remoteConnection.close();
  localConnection = null;
  remoteConnection = null;
  console.log('Closed peer connections');

  // re-enable the file select
  fileInput.disabled = false;
}

function gotDescription1(desc) {
  localConnection.setLocalDescription(desc);
  console.log('Offer from localConnection \n' + desc.sdp);
  remoteConnection.setRemoteDescription(desc);
  remoteConnection.createAnswer().then(
    gotDescription2,
    onCreateSessionDescriptionError
  );
}

function gotDescription2(desc) {
  remoteConnection.setLocalDescription(desc);
  console.log('Answer from remoteConnection \n' + desc.sdp);
  localConnection.setRemoteDescription(desc);
}

function iceCallback1(event) {
  console.log('local ice callback');
  if (event.candidate) {
    remoteConnection.addIceCandidate(
      event.candidate
    ).then(
      onAddIceCandidateSuccess,
      onAddIceCandidateError
    );
    console.log('Local ICE candidate: \n' + event.candidate.candidate);
  }
}

function iceCallback2(event) {
  console.log('remote ice callback');
  if (event.candidate) {
    localConnection.addIceCandidate(
      event.candidate
    ).then(
      onAddIceCandidateSuccess,
      onAddIceCandidateError
    );
    console.log('Remote ICE candidate: \n ' + event.candidate.candidate);
  }
}

function onAddIceCandidateSuccess() {
  console.log('AddIceCandidate success.');
}

function onAddIceCandidateError(error) {
  console.log('Failed to add Ice Candidate: ' + error.toString());
}

function receiveChannelCallback(event) {
  console.log('Receive Channel Callback');
  receiveChannel = event.channel;
  receiveChannel.binaryType = 'arraybuffer';
  receiveChannel.onmessage = onReceiveMessageCallback;
  receiveChannel.onopen = onReceiveChannelStateChange;
  receiveChannel.onclose = onReceiveChannelStateChange;

  receivedSize = 0;
  bitrateMax = 0;
  downloadAnchor.textContent = '';
  downloadAnchor.removeAttribute('download');
  if (downloadAnchor.href) {
    URL.revokeObjectURL(downloadAnchor.href);
    downloadAnchor.removeAttribute('href');
  }
}

function onReceiveMessageCallback(event) {
  // console.log('Received Message ' + event.data.byteLength);
  receiveBuffer.push(event.data);
  receivedSize += event.data.byteLength;

  receiveProgress.value = receivedSize;

  // we are assuming that our signaling protocol told
  // about the expected file size (and name, hash, etc).
  var file = fileInput.files[0];
  if (receivedSize === file.size) {
    var received = new window.Blob(receiveBuffer);
    receiveBuffer = [];

    downloadAnchor.href = URL.createObjectURL(received);
    downloadAnchor.download = file.name;
    downloadAnchor.textContent =
      'Click to download \'' + file.name + '\' (' + file.size + ' bytes)';
    downloadAnchor.style.display = 'block';

    var bitrate = Math.round(receivedSize * 8 /
        ((new Date()).getTime() - timestampStart));
    bitrateDiv.innerHTML = '<strong>Average Bitrate:</strong> ' +
        bitrate + ' kbits/sec (max: ' + bitrateMax + ' kbits/sec)';

    if (statsInterval) {
      window.clearInterval(statsInterval);
      statsInterval = null;
    }

    closeDataChannels();
  }
}

function onSendChannelStateChange() {
  var readyState = sendChannel.readyState;
  console.log('Send channel state is: ' + readyState);
  if (readyState === 'open') {
    sendData();
  }
}

function onReceiveChannelStateChange() {
  var readyState = receiveChannel.readyState;
  console.log('Receive channel state is: ' + readyState);
  if (readyState === 'open') {
    timestampStart = (new Date()).getTime();
    timestampPrev = timestampStart;
    statsInterval = window.setInterval(displayStats, 500);
    window.setTimeout(displayStats, 100);
    window.setTimeout(displayStats, 300);
  }
}

// display bitrate statistics.
function displayStats() {
  var display = function(bitrate) {
    bitrateDiv.innerHTML = '<strong>Current Bitrate:</strong> ' +
        bitrate + ' kbits/sec';
  };

  if (remoteConnection && remoteConnection.iceConnectionState === 'connected') {
    if (adapter.browserDetails.browser === 'chrome') {
      // TODO: once https://code.google.com/p/webrtc/issues/detail?id=4321
      // lands those stats should be preferrred over the connection stats.
      remoteConnection.getStats(null, function(stats) {
        for (var key in stats) {
          var res = stats[key];
          if (timestampPrev === res.timestamp) {
            return;
          }
          if (res.type === 'googCandidatePair' &&
              res.googActiveConnection === 'true') {
            // calculate current bitrate
            var bytesNow = res.bytesReceived;
            var bitrate = Math.round((bytesNow - bytesPrev) * 8 /
                (res.timestamp - timestampPrev));
            display(bitrate);
            timestampPrev = res.timestamp;
            bytesPrev = bytesNow;
            if (bitrate > bitrateMax) {
              bitrateMax = bitrate;
            }
          }
        }
      });
    } else {
      // Firefox currently does not have data channel stats. See
      // https://bugzilla.mozilla.org/show_bug.cgi?id=1136832
      // Instead, the bitrate is calculated based on the number of
      // bytes received.
      var bytesNow = receivedSize;
      var now = (new Date()).getTime();
      var bitrate = Math.round((bytesNow - bytesPrev) * 8 /
          (now - timestampPrev));
      display(bitrate);
      timestampPrev = now;
      bytesPrev = bytesNow;
      if (bitrate > bitrateMax) {
        bitrateMax = bitrate;
      }
    }
  }
}*/


/* INICIO
document.getElementById('open-room').onclick = function() {
    this.disabled = true;
    connection.open(document.getElementById('room-id').value);
};
document.getElementById('join-room').onclick = function() {
    this.disabled = true;
    connection.join(document.getElementById('room-id').value);
};
document.getElementById('open-or-join-room').onclick = function() {
    this.disabled = true;
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
alert('ingreso');
var connection = new RTCMultiConnection();
connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
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
    document.getElementById('share-file').disabled      = false;
    document.getElementById('input-text-chat').disabled = false;
};
FIN  */


//var socket = io.connect('https://192.168.10.156:8890');
//var socket = io.connect('https://192.168.10.100:8890');
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
//connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
//connection.socketURL = 'https://192.168.10.156:443/';
connection.socketURL = 'https://192.168.10.156:8890/';
//connection.socket=socket;
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
    document.getElementById('share-file').disabled      = false;
    document.getElementById('input-text-chat').disabled = false;
};