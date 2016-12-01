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


?>
<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Citas Pacientes") ?></h3>
</div>
<div id='calendar'></div>

<div class="row"></div>
