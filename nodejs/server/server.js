/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * 
 * SSLCertificateFile /etc/pki/tls/certs/vs.server.crt
 * SSLCertificateKeyFile /etc/pki/tls/private/vs.server.pem

 * USO DE PUERTOS
 * 8890 SOCKET
 * 6379 REDIS
 */
var fs = require('fs');

/*var ssl_options = {
  key: fs.readFileSync('/etc/pki/tls/private/vs.server.pem'),//para que no pida Clave
  cert: fs.readFileSync('/etc/pki/tls/certs/vs.server.crt')
};*/

var ssl_options = {
  key: fs.readFileSync('/etc/pki/tls/private/prueba.utimpor.pem'),//para que no pida Clave
  cert: fs.readFileSync('/etc/pki/tls/certs/prueba.utimpor.crt')
};

var app = require('express')();
//var server = require('https').Server(app);//Uso Normal sin Certificado
var https = require('https').Server(ssl_options,app);//Configuracion con Certiciado
var io = require('socket.io')(https);


var Port=8890;//data port cs 

https.listen(Port, function() {  
    console.log('Servidor corriendo en https://localhost:'+Port+' Ruta'+__dirname);
});


io.on('connection', function (socket) {//coneccion para Uso Socket
    console.log("new client connected");
    
    socket.on('notiByron', function(message) {
        console.log(message);//Como llega al servidor
        socket.emit('notiByron', message);
        socket.broadcast.emit('notiByron', message);
    });
    
});
