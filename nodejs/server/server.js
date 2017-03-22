/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * 
 * https://www.my-yii.com/learn/view-episode/yii-2-real-time-chat-app-with-nodejs-socketio-and-redisio
 * https://codelabs.developers.google.com/codelabs/webrtc-web/#5
 * 
 * SSLCertificateFile /etc/pki/tls/certs/vs.server.crt
 * SSLCertificateKeyFile /etc/pki/tls/private/vs.server.pem
 * 
 * key: fs.readFileSync('/etc/apache2/ssl/apache.key'),(EJEMPLO)
 *  cert: fs.readFileSync('/etc/apache2/ssl/apache.crt')(EJEMPLO)
 * USO DE PUERTOS
 * 8890 SOCKET
 * 6379 REDIS
 */

//CETIFICADO CREADO EN EL SERVIDOR 
//Configuracion para el uso de Certiciado
var fs = require('fs');
var ssl_options = {
  key: fs.readFileSync('/etc/pki/tls/private/vs.server.pem'),//para que no pida Clave
  cert: fs.readFileSync('/etc/pki/tls/certs/vs.server.crt')
};
//%%%%%%%%%%%%%%%%%%%%%%

var app = require('express')();
//var server = require('https').Server(app);//Uso Normal sin Certificado
var server = require('https').Server(ssl_options,app);//Configuracion con Certiciado
var io = require('socket.io')(server);
var redis = require('redis');

var Port=8890;//data port cs
server.listen(Port);

io.on('connection', function (socket) {

    console.log("new client connected");
    //De forma predeterminada, redis.createClient()utilizará 127.0.0.1y Port 6379
    //var client = redis.createClient(port, host);
    var redisClient = redis.createClient();

    redisClient.subscribe('notification');

    redisClient.on("message", function(channel, message) {
        console.log("New message: " + message + ". In channel: " + channel);
        socket.emit(channel, message);
    });

    socket.on('disconnect', function() {
        redisClient.quit();
    });

});

server.listen(Port, function() {  
    console.log('Servidor corriendo en https://localhost:'+Port+' Ruta'+__dirname);
    //logs.info('Servidor escuancha',port);
});
