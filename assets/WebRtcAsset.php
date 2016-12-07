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
    public $sourcePath = '@bower/webrtc-adapter';
    public $baseUrl = '@web';
    public $css = [ 
        'src/css/main.css', 
    ];
    public $js = [          
        'release/adapter.js', 
        //'src/js/adapter.js', 
        //'src/js/common.js', 
        //'src/js/lib/ga.js', 
    ]; 

}

