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

/*var ssl_options = {
  key: fs.readFileSync('/etc/pki/tls/private/prueba.utimpor.pem'),//para que no pida Clave
  cert: fs.readFileSync('/etc/pki/tls/certs/prueba.utimpor.crt')
};*/

//%%%%%%%%%%%%%%%%%%%%%%

var app = require('express')();
//var server = require('https').Server(app);//Uso Normal sin Certificado
var https = require('https').Server(ssl_options,app);//Configuracion con Certiciado
var io = require('socket.io')(https);
var redis = require('redis');

var Port=8890;//data port cs
//https.listen(Port);

io.on('connection', function (socket) {//coneccion para Uso Socket

    console.log("new client connected");
    
    //De forma predeterminada, redis.createClient()utilizará 127.0.0.1y Port 6379
    //var client = redis.createClient(port, host);
    var redisClient = redis.createClient();

    redisClient.subscribe('notification');

    redisClient.on("message", function(channel, message) {
        console.log("New message: " + message + ". In channel: " + channel);
        socket.emit(channel, message);
    });
    
    socket.on('user image',function(image){
        socket.emit('addimage','Imagen Compartida :',image);
    });
    
    socket.broadcast.emit('byron', 'Another client has just connected!');
    socket.on('byron', function (message) {
        console.log('A client is speaking to me! Theyre saying: ' + message);
        socket.emit('byron', 'bien gracias! como estas');
    }); 
    
    socket.on('little_newbie', function(username) {
        socket.username = username;
    });
    
    socket.on('notiByron', function(message) {
        console.log(message);//Como llega al servidor
        //message=JSON.stringify(message)
        //console.log(message.toSource());
        //message=JSON.parse(message);//Vlido
        
        //console.log("Entro  " + message[0]['name']);
        
        //console.log("New message: " + message );
        socket.emit('notiByron', message);
        socket.broadcast.emit('notiByron', message);
    });

    socket.on('disconnect', function() {
        redisClient.quit();
    });
    
    

});



https.listen(Port, function() {  
    console.log('Servidor corriendo en https://localhost:'+Port+' Ruta'+__dirname);
    //logs.info('Servidor escuancha',port);
});
