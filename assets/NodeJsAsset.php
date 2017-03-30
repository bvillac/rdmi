<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of NodeJsAsset
 *
 * @author root
 */

namespace app\assets;
use yii\web\AssetBundle;

class NodeJsAsset  extends AssetBundle {
    //public $sourcePath = '@nodejs/node_modules';
    public $sourcePath = '@nodejs';
    public $baseUrl = '@web';
    public $css = [ 
        //'src/css/main.css', 
    ];
    public $js = [        
        //'//cdnjs.cloudflare.com/ajax/libs/socket.io/1.7.3/socket.io.min.js', 
        'node_modules/socket.io/node_modules/socket.io-client/dist/socket.io.js',
        'node_modules/rtcmulticonnection-v3/dist/RTCMultiConnection.js',
        //'node_modules/rtcmulticonnection-v3/dist/RTCMultiConnection.min.js',
        //'//cdn.webrtc-experiment.com/RTCMultiConnection.js',
        //'//cdn.webrtc-experiment.com/socket.io.js',
        'public/main.js', 
    ];
//    public $depends = [
//        'socket.io\socket.io.js',
//    ];
}
