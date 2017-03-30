<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\assets;
use yii\web\AssetBundle;

class WebRtcAsset extends AssetBundle{
    //public $sourcePath = '@vendor/webrtc';
    //public $sourcePath = '@bower/webrtc-adapter';
    public $sourcePath = '@bower/rtcmulticonnection';
    public $baseUrl = '@web';
    public $css = [ 
        //'src/css/main.css', //vendor/webrtc
    ];
    public $js = [          
        //'release/adapter.js', 
        //'src/js/adapter.js', //vendor/webrtc
        //'src/js/common.js',  //vendor/webrtc
        //'src/js/lib/ga.js',  //vendor/webrtc
        'dist/RTCMultiConnection.js',//bower/rtcmulticonnection
        //'dist/RTCMultiConnection.min.js',//bower/rtcmulticonnection
        'v2.2.2/dev/FileBufferReader.js',//bower/rtcmulticonnection        
    ]; 

}

