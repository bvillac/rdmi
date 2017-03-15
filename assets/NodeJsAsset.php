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
    public $sourcePath = '@nodejs/node_modules';
    public $baseUrl = '@web';
    public $css = [ 
        //'src/css/main.css', 
    ];
    public $js = [          
        'public/main.js', 
    ]; 
}
