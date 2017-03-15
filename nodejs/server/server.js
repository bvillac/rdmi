/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * 
 * https://www.my-yii.com/learn/view-episode/yii-2-real-time-chat-app-with-nodejs-socketio-and-redisio
 * https://codelabs.developers.google.com/codelabs/webrtc-web/#5
 * 
 */

var app = require('express')();
var server = require('http').Server(app);
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
    console.log('Servidor corriendo en http://localhost:'+Port+' Ruta'+__dirname);
    //logs.info('Servidor escuancha',port);
});
