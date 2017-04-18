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

class FileinputAsset  extends AssetBundle {
    public $sourcePath = '@vendor/kartik-v/bootstrap-fileinput';
    public $baseUrl = '@web';
    public $css = [ 
        //'css/mainVideo.css', 
    ];
    public $js = [        
        'js/fileinput.js',
    ];
//    public $depends = [
//        'socket.io\socket.io.js',
//    ];
}
