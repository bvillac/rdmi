<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\assets;

use yii\web\AssetBundle;
/*
<link rel='stylesheet' href='fullcalendar/fullcalendar.css' />
<script src='lib/jquery.min.js'></script>
<script src='lib/moment.min.js'></script>
<script src='fullcalendar/fullcalendar.js'></script>


<script src='../lib/moment.min.js'></script>
<script src='../lib/jquery.min.js'></script>
<script src='../fullcalendar.min.js'></script>
 * */


class CalendarRdmiAsset extends AssetBundle{
    public $sourcePath = '@bower/fullcalendar';
    public $baseUrl = '@web';
    public $css = [ 
        'dist/fullcalendar.css', 
        //'dist/fullcalendar.print.css',
    ];
    public $js = [          
        'dist/moment.min.js', 
        'dist/fullcalendar.min.js',
        'dist/locale-all.js',
    ]; 

}

