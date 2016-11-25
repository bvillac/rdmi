<?php

use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
use yii\jui\AutoComplete;
use yii\web\JsExpression;
//use yii\grid\GridView;
use app\widgets\PbGridView\PbGridView;
use yii\data\ArrayDataProvider;


//$this->registerJsFile("/path/to/your/file/in/web/folder/script.js");
//$this->registerJsFile("/path/to/your/file/in/web/folder/script.js");
?>
<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Citas Pacientes") ?></h3>
</div>
<!--<div id='calendar'></div>-->
<!--<video id="gum-local" autoplay></video>-->

<video id="localVideo" autoplay></video>
<video id="remoteVideo" autoplay></video>

<div>
  <button id="startButton">Start</button>
  <button id="callButton">Call</button>
  <button id="hangupButton">Hang Up</button>
</div>

<div id="errorMsg"></div>

<div class="row"></div>
