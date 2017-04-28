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


<div class="row">
    <div class="col-md-12">
        <div id='calendar'></div>
    </div>
    
    <div class="col-md-3">
        <div class="box box-solid">
            <div class="box-header with-border bg-teal-active">
              <h3 class="box-title">Labels</h3>

              <div class="box-tools">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="box-body no-padding" style="display: block;">
              <ul class="nav nav-pills nav-stacked">
                <li><a href="#"><i class="fa fa-circle-o text-red"></i> Important</a></li>
                <li><a href="#"><i class="fa fa-circle-o text-yellow"></i> Promotions</a></li>
                <li><a href="#"><i class="fa fa-circle-o text-light-blue"></i> Social</a></li>
              </ul>
            </div>
           
            <!-- /.box-body -->
        </div>
        
        <select class="selectpicker form-control">
        <option>Mustard</option>
        <option>Ketchup</option>
        <option>Relish</option>
      </select>
        
        <div class="form-group">
<!--            <label for="cmb_provincia_uso" class="col-sm-3 control-label"><?= Yii::t("formulario", "Level National") ?></label>-->
            <div class="col-sm-12">
                <?= Html::dropDownList("cmb_provincia_uso", 25, ArrayHelper::map(app\models\Especialidad::getEspecialidadALL(), 'Ids', 'Nombre'), ["class" => "form-control multiselect", 'multiple' => 'multiple', "id" => "cmb_provincia_uso"])
                ?>
                <p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>
            </div>
        </div>
        
    </div>
    
</div>
